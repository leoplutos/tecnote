package javagrpc.main;

import io.grpc.ClientInterceptor;
import io.grpc.Grpc;
import io.grpc.InsecureChannelCredentials;
import io.grpc.ManagedChannel;
import io.grpc.NameResolverRegistry;
import io.grpc.health.v1.HealthCheckRequest;
import io.grpc.health.v1.HealthCheckResponse;
import io.grpc.health.v1.HealthGrpc;
import io.grpc.stub.StreamObserver;
import io.opentelemetry.api.OpenTelemetry;
import javagrpc.grpc.lb.MultiAddressNameResolverProvider;
import javagrpc.grpc.stub.ProductInfoGrpc;
import javagrpc.grpc.stub.ProductInfoPb;
import javagrpc.grpc.stub.ProductInfoPb.Product;
import javagrpc.grpc.stub.ProductInfoPb.ProductId;
import javagrpc.opentelemetry.OpentelemetryConfig;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class ClientAsyncMain {

	// log4j2日志
	protected static final Logger log = LogManager.getLogger();

	// 远程连接管理器,管理连接的生命周期
	private final ManagedChannel channel;
	// 非阻塞异步存根（结果以回调的方式通知）
	private final ProductInfoGrpc.ProductInfoStub productStub;
	// 线程池
	private ExecutorService executorService;
	// HealthCheck客户端
	private final HealthGrpc.HealthStub healthStub;
	private final HealthCheckRequest healthRequest;

	public ClientAsyncMain() {

		// 使用负责均衡器的例子
		NameResolverRegistry.getDefaultRegistry().register(new MultiAddressNameResolverProvider());
		String target = String.format("%s:///%s", MultiAddressNameResolverProvider.MultiAddressScheme,
				MultiAddressNameResolverProvider.MultiAddressServiceName);
		// 对于回调，gRPC 使用缓存线程池，该线程池根据需要创建新线程，但在以前构建的线程可用时会重用它们。如果需要，可以将线程池作为
		executorService = Executors.newFixedThreadPool(10);
		// OpenTelemetry监测的拦截器
		OpenTelemetry openTelemetry = OpentelemetryConfig.initializeOpenTelemetry();
		ClientInterceptor otelClientInterceptor = OpentelemetryConfig.getClientInterceptor(openTelemetry);
		// 建立gRPC通道
		channel = Grpc.newChannelBuilder(target, InsecureChannelCredentials.create())
				.defaultLoadBalancingPolicy("round_robin")
				.defaultServiceConfig(generateHealthConfig("")) // HealthCheck检查的服务名为空
				.executor(executorService)
				// .usePlaintext()
				.intercept(otelClientInterceptor) // 添加otel拦截器
				.build();

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

		// 关闭线程池
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
				String addId = productId.getValue();
				log.info("[Java][Client] Add product success. id: {}", addId);
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

	public static void main(String[] args) throws InterruptedException {
		log.info("ClientMainAsync Start");

		ClientAsyncMain clientAsync = new ClientAsyncMain();

		// 不堵塞，不等待结果直接继续运行（多次循环调用）
		List<CompletableFuture<?>> taskList = new ArrayList<CompletableFuture<?>>();

		for (int i = 0; i < 5; i++) {
			// 异步服务调用
			CompletableFuture<ProductId> task1 = clientAsync.addProductAsync("Mac Book Pro 2021", "Add by Java");
			taskList.add(task1);
			// 异步服务调用
			CompletableFuture<Product> task2 = clientAsync.getProductAsync("123");
			taskList.add(task2);
		}

		// 检查服务状态
		CompletableFuture<HealthCheckResponse> healthTask = clientAsync.checkHealthAsync();
		taskList.add(healthTask);

		log.info("ClientMainAsync End");

		// 有多个task时使用allOf(completableFutures).join()来等待所有子线程结束
		CompletableFuture.allOf(taskList.toArray(CompletableFuture[]::new))
				// .whenComplete((v, th) -> {System.out.println("所有子任务执行完成!!!");})
				.join();

		// 关闭连接
		clientAsync.shutdown();
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
		Map<String, Object> config = new HashMap<>();
		Map<String, Object> serviceMap = new HashMap<>();

		config.put("healthCheckConfig", serviceMap);
		serviceMap.put("serviceName", serviceName);
		return config;
	}
}
