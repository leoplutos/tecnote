package javagrpc.main;

import io.grpc.Grpc;
import io.grpc.InsecureServerCredentials;
import io.grpc.Server;
import io.grpc.protobuf.services.HealthStatusManager;
import io.grpc.stub.StreamObserver;
import io.opentelemetry.api.OpenTelemetry;
import javagrpc.grpc.stub.ProductInfoPb.Product;
import javagrpc.grpc.stub.StopServiceGrpc.StopServiceImplBase;
import javagrpc.opentelemetry.OpentelemetryConfig;
import javagrpc.util.ConfigLoader;
import javagrpc.service.ProductServiceImpl;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import org.apache.commons.configuration2.Configuration;
import org.apache.commons.configuration2.ex.ConfigurationException;
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
	// 线程池
	// private ExecutorService executorService;

	// 储存Product的词典
	public static Map<String, Product> productMap;

	// 启动gRPC服务
	private void start(int port) throws IOException {

		productMap = new LinkedHashMap<String, Product>();
		health = new HealthStatusManager();
		// 线程池
		// gPRC默认使用的线程是无限制的CachedThreadPool，如果想用线程池限制个数的话可以使用newFixedThreadPool
		// executorService = Executors.newFixedThreadPool(10);
		// OpenTelemetry监测的拦截器
		OpenTelemetry openTelemetry = OpentelemetryConfig.initializeOpenTelemetry();
		// gRPC服务
		server = Grpc.newServerBuilderForPort(port, InsecureServerCredentials.create())
				.addService(OpentelemetryConfig.configureServerInterceptor(openTelemetry, new ProductServiceImpl())) // 添加业务服务和otel拦截器
				.addService(new StopServiceImpl())// 添加业务服务
				.addService(health.getHealthService())// 添加HealthCheck服务
				// .executor(executorService)
				.build()
				.start();

		// Calendar cl = Calendar.getInstance();
		// SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		// String dtStr = sdf.format(cl.getTime());
		// MessageFormat mFormat = new MessageFormat(
		// "[{0}][Java][Server] Server started, listening on : {1}");
		// String[] params = { dtStr, port + "" };
		// System.out.println(mFormat.format(params));

		log.info("[Java][Server] Server started, listening on : {}", port);

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
			}
		});
	}

	private void stop() throws InterruptedException {
		if (server != null) {
			// shutdown方法：平滑的关闭ExecutorService，当此方法被调用时，ExecutorService停止接收新的任务并且等待已经提交的任务（包含提交正在执行和提交未执行）执行完成。
			// 当所有提交任务执行完毕，线程池即被关闭。
			server.shutdown().awaitTermination(30, TimeUnit.SECONDS);
		}

		// 关闭线程池
		// if (executorService != null) {
		// executorService.shutdown();
		// executorService.awaitTermination(5, TimeUnit.SECONDS);
		// }
	}

	private void blockUntilShutdown() throws InterruptedException {
		if (server != null) {
			// awaitTermination方法：接收timeout和TimeUnit两个参数，用于设定超时时间及单位。
			// 当等待超过设定时间时，会监测ExecutorService是否已经关闭，若关闭则返回true，否则返回false。一般情况下会和shutdown方法组合使用。
			server.awaitTermination();
		}
	}

	// 程序主入口
	public static void main(String[] args) throws IOException, InterruptedException, ConfigurationException {

		// 读取config.properties内容(会在classpath内寻找)
		Configuration config = ConfigLoader.getInstance("config.properties");
		int port = config.getInt("grpc.server.default.port");
		log.info("[Java][Server] server default port: {}", port);
		// 服务端口，如果参数传入则使用，默认为设定文件定义
		if (args.length > 0) {
			try {
				port = Integer.parseInt(args[0]);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		final ServerMain server = new ServerMain();
		// 启动gRPC服务
		server.start(port);
		server.blockUntilShutdown();
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
