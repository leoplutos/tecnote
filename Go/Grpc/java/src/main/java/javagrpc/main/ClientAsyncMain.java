package javagrpc.main;

import io.grpc.Grpc;
import io.grpc.InsecureChannelCredentials;
import io.grpc.ManagedChannel;
import io.grpc.ManagedChannelBuilder;
import io.grpc.NameResolver;
import io.grpc.NameResolverRegistry;
import io.grpc.health.v1.HealthCheckRequest;
import io.grpc.health.v1.HealthCheckResponse;
import io.grpc.health.v1.HealthGrpc;
import io.grpc.stub.StreamObserver;
import javagrpc.common.Const;
import javagrpc.grpc.lb.EtcdNameResolverProvider;
import javagrpc.grpc.lb.MultiAddressNameResolverFactory;
import javagrpc.grpc.stub.ProductInfoGrpc;
import javagrpc.grpc.stub.ProductInfoPb;
import javagrpc.grpc.stub.ProductInfoPb.Product;
import javagrpc.grpc.stub.ProductInfoPb.ProductId;
import javagrpc.util.Config;
import java.net.InetSocketAddress;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import org.apache.commons.configuration2.Configuration;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class ClientAsyncMain {

	// log4j2日志
	protected static final Logger log = LogManager.getLogger();

	// 远程连接管理器,管理连接的生命周期
	private final ManagedChannel channel;
	// 非阻塞异步存根（结果以回调的方式通知）
	private final ProductInfoGrpc.ProductInfoStub productStub;
	// 虚拟线程的执行器
	private ExecutorService executorService;
	// HealthCheck客户端
	private final HealthGrpc.HealthStub healthStub;
	private final HealthCheckRequest healthRequest;

	static {
		// 设定vertx的默认日志
		// System.setProperty("vertx.logger-delegate-factory-class-name",
		// "io.vertx.core.logging.Log4j2LogDelegateFactory");
		// 禁用vertx缓存目录，不然在Maven运行结束时会报错
		// https://github.com/vert-x3/issues/issues/288
		System.setProperty("vertx.disableFileCPResolving", "true");
		System.setProperty("vertx.disableFileCaching", "true");
	}

	@SuppressWarnings("deprecation")
	public ClientAsyncMain(boolean isWithEtcd) {
		// OpenTelemetry监测的拦截器
		// OpenTelemetry openTelemetry = OpentelemetryConfig.initializeOpenTelemetry();
		// ClientInterceptor otelClientInterceptor =
		// OpentelemetryConfig.getClientInterceptor(openTelemetry);
		// 虚拟线程的执行器，这个执行器在每次提交一个新任务时，都会为这个任务创建一个新的虚拟线程来执行它
		// 虚拟线程属于非常轻量级的资源，因此，用时创建，用完就扔，不要池化虚拟线程
		executorService = Executors.newVirtualThreadPerTaskExecutor();

		if (isWithEtcd) {
			// 使用Etcd的服务注册

			// 注册Etcd服务发现
			NameResolverRegistry.getDefaultRegistry().register(new EtcdNameResolverProvider());
			// 服务发现URI
			String channelTarget = Const.CHANNEL_TARGET;
			log.info("[Java][Client] gRPC channelTarget: {}", channelTarget);

			// 连接频道
			channel = Grpc.newChannelBuilder(channelTarget, InsecureChannelCredentials.create())
					.defaultLoadBalancingPolicy("round_robin")
					.defaultServiceConfig(generateHealthConfig("")) // HealthCheck检查的服务名为空
					// .intercept(otelClientInterceptor) // 添加otel拦截器
					.executor(executorService)
					// .usePlaintext()
					.build();
		} else {
			// 使用固定IP
			NameResolver.Factory nameResolverFactory = new MultiAddressNameResolverFactory(
					new InetSocketAddress("127.0.0.1", 50051),
					new InetSocketAddress("127.0.0.1", 50052),
					new InetSocketAddress("127.0.0.1", 50053),
					new InetSocketAddress("127.0.0.1", 50054));
			channel = ManagedChannelBuilder.forTarget("")
					.nameResolverFactory(nameResolverFactory) // 此方法已废弃
					.defaultLoadBalancingPolicy("round_robin")
					.defaultServiceConfig(generateHealthConfig("")) // HealthCheck检查的服务名为空
					// .intercept(otelClientInterceptor) // 添加otel拦截器
					.executor(executorService)
					.usePlaintext()
					.build();
		}

		// HealthCheck服务的请求
		healthRequest = HealthCheckRequest.getDefaultInstance();

		// 业务请求客户端
		// 此处添加的withWaitForReady()为服务未启动的话，不发生错误，一直等待到服务端启动为止，还可以在此基础上设置等待时间Deadline
		productStub = ProductInfoGrpc.newStub(channel).withWaitForReady();
		// HealthCheck客户端
		healthStub = HealthGrpc.newStub(channel).withWaitForReady();
	}

	public void shutdown() throws InterruptedException {
		// 关闭连接
		channel.shutdown().awaitTermination(5, TimeUnit.SECONDS);

		// 关闭执行器
		if (executorService != null) {
			executorService.shutdown();
			executorService.awaitTermination(5, TimeUnit.SECONDS);
		}
	}

	// 异步调用gRPC服务
	public CompletableFuture<ProductId> addProductAsync(String name, String description) {
		// 构造服务调用参数对象
		Product request = Product.newBuilder().setName(name).setDescription(description).build();
		// 调用远程服务方法，StreamObserver为回调函数
		CompletableFuture<ProductId> task = new CompletableFuture<>();
		productStub.addProduct(request, new StreamObserver<ProductInfoPb.ProductId>() {
			@Override
			public void onCompleted() {
				// 可以在这里添加逻辑，如关闭channel等
			}

			@Override
			public void onError(Throwable throwable) {
				task.completeExceptionally(throwable);
			}

			@Override
			public void onNext(ProductId productId) {
				task.complete(productId);
				// String addId = productId.getValue();
				// log.info("[Java][Client] Add product success. id: {}", addId);
			}
		});
		return task;
	}

	// 异步调用gRPC服务
	public CompletableFuture<Product> getProductAsync(String id) {
		// 构造服务调用参数对象
		ProductId request = ProductId.newBuilder().setValue(id).build();
		// 调用远程服务方法，StreamObserver为回调函数
		CompletableFuture<Product> task = new CompletableFuture<>();
		productStub.getProduct(request, new StreamObserver<ProductInfoPb.Product>() {
			@Override
			public void onCompleted() {
				// 可以在这里添加逻辑，如关闭channel等
			}

			@Override
			public void onError(Throwable throwable) {
				task.completeExceptionally(throwable);
			}

			@Override
			public void onNext(Product product) {
				task.complete(product);
				log.info("[Java][Client] Get product success. id: {}, name: {}, description: {}", product.getId(),
						product.getName(), product.getDescription());
			}
		});
		return task;
	}

	public static void main(String[] args) throws Exception {
		try {
			log.info("ClientMainAsync 开始");

			// 读取 properties 和 环境变量
			Configuration config = Config.getInstance();
			// 读取环境变量[GRPC_SERVER_RESOLVE]的设定值
			String resolve = config.getString("GRPC_SERVER_RESOLVE", "false");
			boolean isWithEtcd = false;
			if ("true".equals(resolve)) {
				isWithEtcd = true;
			}
			log.info("[Java][Client] 是否启用Etcd服务发现: {}", isWithEtcd);

			ClientAsyncMain clientAsync = new ClientAsyncMain(isWithEtcd);

			// 不堵塞，不等待结果直接继续运行（多次循环调用）
			// List<CompletableFuture<?>> taskList = new
			// CopyOnWriteArrayList<CompletableFuture<?>>();

			// for (int i = 0; i < 500; i++) {
			// // 异步服务调用
			// CompletableFuture<ProductId> task1 = clientAsync.addProductAsync("Mac Book
			// Pro 2021", "Add by Java");
			// taskList.add(task1);

			// // 异步服务调用
			// CompletableFuture<Product> task2 = clientAsync.getProductAsync("123");
			// taskList.add(task2);
			// }

			// // 检查服务状态
			// CompletableFuture<HealthCheckResponse> healthTask =
			// clientAsync.checkHealthAsync();
			// taskList.add(healthTask);

			// log.info("ClientMainAsync 结束");

			// // 有多个task时使用allOf(completableFutures).join()来等待所有子线程结束
			// CompletableFuture.allOf(taskList.toArray(CompletableFuture[]::new))
			// // .whenComplete((v, th) -> {System.out.println("所有子任务执行完成!!!");})
			// .join();

			for (int i = 0; i < 500; i++) {
				// 异步服务调用
				ProductId pid = clientAsync.addProductAsync("Mac Book Pro 2021", "Add by Java").get();
				log.info("[Java][Client] Add product success. id: {}", pid.getValue());
			}
			// 检查服务状态
			clientAsync.checkHealthAsync().get();

			// 关闭连接
			clientAsync.shutdown();
		} catch (Exception e) {
			log.error(e);
		} finally {
			// 因为使用了异步日志，要在这里关闭
			LogManager.shutdown();
		}
	}

	// 执行HealthCheck检查
	private CompletableFuture<HealthCheckResponse> checkHealthAsync() {
		CompletableFuture<HealthCheckResponse> task = new CompletableFuture<>();
		healthStub.check(healthRequest, new StreamObserver<HealthCheckResponse>() {
			@Override
			public void onCompleted() {
				// 可以在这里添加逻辑，如关闭channel等
			}

			@Override
			public void onError(Throwable throwable) {
				task.completeExceptionally(throwable);
			}

			@Override
			public void onNext(HealthCheckResponse response) {
				task.complete(response);
				log.info("[Java][Client] Health Checking... gRPC Server status: [{}]", response.getStatus().toString());
			}
		});
		return task;
	}

	private static Map<String, Object> generateHealthConfig(String serviceName) {
		Map<String, Object> config = new ConcurrentHashMap<>();
		Map<String, Object> serviceMap = new ConcurrentHashMap<>();

		config.put("healthCheckConfig", serviceMap);
		serviceMap.put("serviceName", serviceName);
		return config;
	}
}
