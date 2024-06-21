
package javagrpc.main;

import io.grpc.ClientInterceptor;
import io.grpc.Grpc;
import io.grpc.InsecureChannelCredentials;
import io.grpc.ManagedChannel;
import io.grpc.NameResolverRegistry;
import io.grpc.health.v1.HealthCheckRequest;
import io.grpc.health.v1.HealthCheckResponse;
import io.grpc.health.v1.HealthCheckResponse.ServingStatus;
import io.grpc.health.v1.HealthGrpc;
import io.opentelemetry.api.OpenTelemetry;
import javagrpc.grpc.lb.MultiAddressNameResolverProvider;
import javagrpc.grpc.stub.ProductInfoGrpc;
import javagrpc.grpc.stub.ProductInfoPb.Product;
import javagrpc.grpc.stub.ProductInfoPb.ProductId;
import javagrpc.opentelemetry.OpentelemetryConfig;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class ClientMain {

	// log4j2日志
	protected static final Logger log = LogManager.getLogger();

	// 远程连接管理器,管理连接的生命周期
	private final ManagedChannel channel;
	// 业务请求客户端(阻塞同步存根)
	private final ProductInfoGrpc.ProductInfoBlockingStub blockingStub;
	// HealthCheck客户端
	private final HealthGrpc.HealthBlockingStub healthBlockingStub;
	private final HealthCheckRequest healthRequest;

	public ClientMain() {

		// 没有负载均衡器的例子
		// String host = "127.0.0.1";
		// int port = 50051;
		// channel = ManagedChannelBuilder.forAddress(host,
		// port).usePlaintext().build();
		// 使用负责均衡器的例子(nameResolverFactory官方已弃用)
		// NameResolver.Factory nameResolverFactory = new
		// MultiAddressNameResolverFactory(
		// new InetSocketAddress("127.0.0.1", 50051),
		// new InetSocketAddress("127.0.0.1", 50052),
		// new InetSocketAddress("127.0.0.1", 50053),
		// new InetSocketAddress("127.0.0.1", 50054));
		// channel = ManagedChannelBuilder.forTarget("service")
		// .nameResolverFactory(nameResolverFactory)
		// .defaultLoadBalancingPolicy("round_robin")
		// .usePlaintext()
		// .build();
		// 使用负责均衡器的例子
		NameResolverRegistry.getDefaultRegistry().register(new MultiAddressNameResolverProvider());
		String target = String.format("%s:///%s", MultiAddressNameResolverProvider.MultiAddressScheme,
				MultiAddressNameResolverProvider.MultiAddressServiceName);
		// OpenTelemetry监测的拦截器
		OpenTelemetry openTelemetry = OpentelemetryConfig.initializeOpenTelemetry();
		ClientInterceptor otelClientInterceptor = OpentelemetryConfig.getClientInterceptor(openTelemetry);
		// channel =
		// ManagedChannelBuilder.forTarget(target).defaultLoadBalancingPolicy("round_robin").usePlaintext()
		// .build();
		channel = Grpc.newChannelBuilder(target, InsecureChannelCredentials.create())
				.defaultLoadBalancingPolicy("round_robin")
				.defaultServiceConfig(generateHealthConfig("")) // HealthCheck检查的服务名为空
				// .usePlaintext()
				.intercept(otelClientInterceptor) // 添加otel拦截器
				.build();

		// HealthCheck服务的请求
		healthRequest = HealthCheckRequest.getDefaultInstance();

		// 业务请求客户端
		// 此处添加的withWaitForReady()为服务未启动的话，不发生错误，一直等待到服务端启动为止，还可以在此基础上设置等待时间Deadline
		blockingStub = ProductInfoGrpc.newBlockingStub(channel).withWaitForReady();
		// HealthCheck客户端
		healthBlockingStub = HealthGrpc.newBlockingStub(channel).withWaitForReady();
		// blockingStub = ProductInfoGrpc.newBlockingStub(channel);
		// healthBlockingStub = HealthGrpc.newBlockingStub(channel);
	}

	public void shutdown() throws InterruptedException {
		// 关闭连接
		channel.shutdown().awaitTermination(5, TimeUnit.SECONDS);
	}

	public String addProduct(String name, String description) {
		// 构造服务调用参数对象
		Product request = Product.newBuilder().setName(name).setDescription(description).build();
		// 调用远程服务方法
		ProductId response = blockingStub.addProduct(request);
		// 返回值
		return response.getValue();
	}

	public Product getProduct(String id) {
		// 构造服务调用参数对象
		ProductId request = ProductId.newBuilder().setValue(id).build();
		// 调用远程服务方法
		Product response = blockingStub.getProduct(request);
		// 返回值
		return response;
	}

	public static void main(String[] args) throws InterruptedException {
		log.info("ClientMain Start");

		ClientMain client = new ClientMain();

		for (int i = 0; i < 5; i++) {
			// 添加商品
			String addId = client.addProduct("Mac Book Pro 2021", "Add by Java");
			log.info("[Java][Client] Add product success. id: {}", addId);

			// 取得商品
			Product product = client.getProduct(addId);
			log.info("[Java][Client] Get product success. id: {}, name: {}, description: {}", product.getId(),
					product.getName(), product.getDescription());
		}

		// 检查服务状态
		client.checkHealth();

		log.info("ClientMain End");

		// 关闭连接
		client.shutdown();
	}

	// 执行HealthCheck检查
	private ServingStatus checkHealth() {
		HealthCheckResponse response = healthBlockingStub.check(healthRequest);
		log.info("[Java][Client] Health Checking... gRPC Server status: [{}]", response.getStatus().toString());
		return response.getStatus();
	}

	private static Map<String, Object> generateHealthConfig(String serviceName) {
		Map<String, Object> config = new HashMap<>();
		Map<String, Object> serviceMap = new HashMap<>();

		config.put("healthCheckConfig", serviceMap);
		serviceMap.put("serviceName", serviceName);
		return config;
	}
}
