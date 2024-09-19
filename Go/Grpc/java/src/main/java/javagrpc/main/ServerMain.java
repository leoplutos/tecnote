package javagrpc.main;

import io.etcd.jetcd.ByteSequence;
import io.etcd.jetcd.Client;
import io.etcd.jetcd.KV;
import io.etcd.jetcd.Lease;
import io.etcd.jetcd.lease.LeaseKeepAliveResponse;
import io.etcd.jetcd.options.PutOption;
import io.grpc.Grpc;
import io.grpc.InsecureServerCredentials;
import io.grpc.Server;
import io.grpc.protobuf.services.HealthStatusManager;
import io.grpc.stub.StreamObserver;
import io.opentelemetry.api.OpenTelemetry;
import javagrpc.common.Const;
import javagrpc.grpc.stub.ProductInfoPb.Product;
import javagrpc.grpc.stub.StopServiceGrpc.StopServiceImplBase;
import javagrpc.opentelemetry.OpentelemetryConfig;
import javagrpc.util.Config;
import javagrpc.service.ProductServiceImpl;
import java.net.InetAddress;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import org.apache.commons.configuration2.Configuration;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import com.google.protobuf.Empty;
import com.google.protobuf.Int32Value;

// 主类
public class ServerMain {

	// log4j2日志
	protected static final Logger log = LogManager.getLogger();

	// gRPC服务
	private Server server;
	// HealthCheckService
	private HealthStatusManager health;
	// 虚拟线程的执行器
	private ExecutorService executorService;
	// Etcd客户端
	private Client etcd;

	// 储存Product的词典
	public static Map<String, Product> productMap;

	// 启动gRPC服务
	private void start(int port, boolean isWithEtcd) throws Exception {

		productMap = new ConcurrentHashMap<String, Product>();
		health = new HealthStatusManager();
		// 虚拟线程的执行器，这个执行器在每次提交一个新任务时，都会为这个任务创建一个新的虚拟线程来执行它
		// 虚拟线程属于非常轻量级的资源，因此，用时创建，用完就扔，不要池化虚拟线程
		executorService = Executors.newVirtualThreadPerTaskExecutor();
		// OpenTelemetry监测的拦截器
		OpenTelemetry openTelemetry = OpentelemetryConfig.initializeOpenTelemetry();
		// gRPC服务
		server = Grpc.newServerBuilderForPort(port, InsecureServerCredentials.create())
				.addService(OpentelemetryConfig.configureServerInterceptor(openTelemetry, new ProductServiceImpl(port))) // 添加业务服务和otel拦截器
				.addService(new StopServiceImpl())// 添加业务服务
				.addService(health.getHealthService())// 添加HealthCheck服务
				.executor(executorService)
				.build()
				.start();

		log.info("[Java][Server] gRPC 服务端已开启，端口为 : {}", port);

		// Etcd的服务注册
		if (isWithEtcd) {
			// 建立Etcd连接
			// 读取 properties 和 环境变量
			Configuration config = Config.getInstance();
			String etcdEndpoints = config.getString("etcd.endpoints.uri", "");
			log.info("Etcd Endpoints: {}", etcdEndpoints);
			etcd = Client.builder()
					.endpoints(etcdEndpoints)
					.build();

			// 注册的IP地址，如果[etcd.regist.host=]未设定，则取得本地IP
			String localIPaddr = InetAddress.getLocalHost().getHostAddress();
			// 读取etcd.regist.host]的设定值
			String registIPaddr = config.getString("etcd.regist.host", localIPaddr);
			// 创建租约
			Lease lease = etcd.getLeaseClient();
			long ttl = 5;
			long leaseId = lease.grant(ttl).get().getID();
			// /service/grpc/uuid
			String leaseKey = String.format("%s/%s", Const.ETCD_SERVICENAME, UUID.randomUUID().toString());
			// http://192.128.0.1:50051
			String leaseValue = String.format("http://%s:%d", registIPaddr, port);
			// 写入key-value值时绑定一个租约，租约到期后，key会被删除
			KV kv = etcd.getKVClient();
			PutOption option = PutOption.builder().withLeaseId(leaseId).build();
			kv.put(ByteSequence.from(leaseKey, Const.UTF_8), ByteSequence.from(leaseValue, Const.UTF_8),
					option).get();
			log.info("[Java][Server] Etcd注册成功  Key:{}  Value:{}", leaseKey, leaseValue);
			// 持续续约，在租约的三分之一时间时，就会自动向etcd续约。相当于租约到期前会执行三次keepAliveOnce()
			lease.keepAlive(leaseId, new StreamObserver<LeaseKeepAliveResponse>() {
				@Override
				public void onCompleted() {
				}

				@Override
				public void onError(Throwable throwable) {
				}

				@Override
				public void onNext(LeaseKeepAliveResponse response) {
					log.trace("续租: {}", response.getID());
				}
			});
		}

		// JVM停止时运行的钩子
		Runtime.getRuntime().addShutdownHook(new Thread() {
			@Override
			public void run() {
				try {
					ServerMain.this.stop();
				} catch (InterruptedException e) {
					e.printStackTrace(System.err);
				}
				log.info("[Java][Server] shutting down gRPC server since JVM is shutting down");
				// 因为使用了异步日志，要在这里关闭
				LogManager.shutdown();
			}
		});
	}

	private void stop() throws InterruptedException {
		if (server != null) {
			// shutdown方法：平滑的关闭ExecutorService，当此方法被调用时，ExecutorService停止接收新的任务并且等待已经提交的任务（包含提交正在执行和提交未执行）执行完成。
			// 当所有提交任务执行完毕，线程池即被关闭。
			server.shutdown().awaitTermination(30, TimeUnit.SECONDS);
		}
		if (etcd != null) {
			etcd.close();
		}
		// 关闭执行器
		if (executorService != null) {
			executorService.shutdown();
			executorService.awaitTermination(5, TimeUnit.SECONDS);
		}
	}

	private void blockUntilShutdown() throws InterruptedException {
		if (server != null) {
			// awaitTermination方法：接收timeout和TimeUnit两个参数，用于设定超时时间及单位。
			// 当等待超过设定时间时，会监测ExecutorService是否已经关闭，若关闭则返回true，否则返回false。一般情况下会和shutdown方法组合使用。
			server.awaitTermination();
		}
	}

	// 程序主入口
	public static void main(String[] args) throws Exception {
		try {
			// 读取 properties 和 环境变量
			Configuration config = Config.getInstance();
			int defaultPort = config.getInt("grpc.server.default.port", 50051);
			log.info("[Java][Server] 默认端口: {}", defaultPort);
			// 读取环境变量[GRPC_SERVER_HTTP_PORTS]的设定值
			int port = config.getInt("GRPC_SERVER_HTTP_PORTS", defaultPort);
			log.info("[Java][Server] 环境变量[GRPC_SERVER_HTTP_PORTS]设定端口: {}", port);
			// 读取环境变量[GRPC_SERVER_RESOLVE]的设定值
			String resolve = config.getString("GRPC_SERVER_RESOLVE", "false");
			boolean isWithEtcd = false;
			if ("true".equals(resolve)) {
				isWithEtcd = true;
			}
			log.info("[Java][Server] 是否启用Etcd服务发现: {}", isWithEtcd);

			final ServerMain server = new ServerMain();
			// 启动gRPC服务
			server.start(port, isWithEtcd);
			server.blockUntilShutdown();
		} catch (Exception e) {
			log.error(e);
		} finally {
			// 因为使用了异步日志，要在这里关闭
			LogManager.shutdown();
		}
	}

	private class StopServiceImpl extends StopServiceImplBase {

		@Override
		public void stop(Int32Value request, StreamObserver<Empty> responseObserver) {

			int reqValue = request.getValue();
			log.info("[Java][Server] Server will stop. request: {}", reqValue);
			try {
				ServerMain.this.stop();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}

			responseObserver.onNext(null);
			responseObserver.onCompleted();
		}
	}
}
