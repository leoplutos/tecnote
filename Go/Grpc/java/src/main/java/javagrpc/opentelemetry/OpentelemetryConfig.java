package javagrpc.opentelemetry;

import io.grpc.BindableService;
import io.grpc.ClientInterceptor;
import io.grpc.ServerInterceptors;
import io.grpc.ServerServiceDefinition;
import io.opentelemetry.api.GlobalOpenTelemetry;
import io.opentelemetry.api.OpenTelemetry;
import io.opentelemetry.instrumentation.grpc.v1_6.GrpcTelemetry;

// 初始化 OpenTelemetry，以提供监测功能
public final class OpentelemetryConfig {

	// Name of the service
	// private static final String SERVICE_NAME = "myExampleService";

	/**
	 * Zero-code instrumentation with Java uses a Java agent JAR attached to any
	 * Java 8+ application
	 */
	public static OpenTelemetry initializeOpenTelemetry() {
		// OpenTelemetry openTelemetry =
		// AutoConfiguredOpenTelemetrySdk.initialize().getOpenTelemetrySdk();
		return GlobalOpenTelemetry.get();
	}

	// static OpenTelemetry initializeOpenTelemetry(String ip, int port) {
	// String endpoint = String.format("http://%s:%s/api/v2/spans", ip, port);
	// ZipkinSpanExporter zipkinExporter =
	// ZipkinSpanExporter.builder().setEndpoint(endpoint).build();

	// Resource serviceNameResource =
	// Resource.create(Attributes.of(ResourceAttributes.SERVICE_NAME,
	// SERVICE_NAME));

	// SdkTracerProvider tracerProvider = SdkTracerProvider.builder()
	// .addSpanProcessor(SimpleSpanProcessor.create(zipkinExporter))
	// .setResource(Resource.getDefault().merge(serviceNameResource))
	// .build();
	// OpenTelemetrySdk openTelemetry =
	// OpenTelemetrySdk.builder().setTracerProvider(tracerProvider)
	// .buildAndRegisterGlobal();

	// Runtime.getRuntime().addShutdownHook(new Thread(tracerProvider::close));

	// return openTelemetry;
	// }

	// 为gRPC服务端的服务添加OpenTelemetry监测用的拦截器
	public static ServerServiceDefinition configureServerInterceptor(OpenTelemetry openTelemetry,
			BindableService bindableService) {
		GrpcTelemetry grpcTelemetry = GrpcTelemetry.create(openTelemetry);
		return ServerInterceptors.intercept(bindableService, grpcTelemetry.newServerInterceptor());
	}

	// 为gRPC客户端添加OpenTelemetry监测用的拦截器
	public static ClientInterceptor getClientInterceptor(OpenTelemetry openTelemetry) {
		GrpcTelemetry grpcTelemetry = GrpcTelemetry.create(openTelemetry);
		return grpcTelemetry.newClientInterceptor();
	}
}
