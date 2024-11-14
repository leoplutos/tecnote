package javagrpc.opentelemetry;

import java.time.Duration;
import java.util.concurrent.TimeUnit;
import javagrpc.util.Config;
import io.grpc.opentelemetry.GrpcOpenTelemetry;
import io.opentelemetry.api.OpenTelemetry;
import io.opentelemetry.api.trace.Span;
import io.opentelemetry.api.trace.SpanContext;
import io.opentelemetry.api.trace.TraceFlags;
import io.opentelemetry.api.trace.TraceState;
import io.opentelemetry.api.trace.Tracer;
import io.opentelemetry.exporter.otlp.metrics.OtlpGrpcMetricExporter;
import io.opentelemetry.exporter.otlp.trace.OtlpGrpcSpanExporter;
import io.opentelemetry.sdk.OpenTelemetrySdk;
import io.opentelemetry.sdk.metrics.SdkMeterProvider;
import io.opentelemetry.sdk.metrics.export.PeriodicMetricReader;
import io.opentelemetry.sdk.resources.Resource;
import io.opentelemetry.sdk.trace.SdkTracerProvider;
import io.opentelemetry.sdk.trace.export.BatchSpanProcessor;
import io.opentelemetry.semconv.ServiceAttributes;
import org.apache.commons.configuration2.Configuration;
import org.apache.commons.configuration2.ex.ConfigurationException;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

// OpenTelemetry提供类
public final class OpentelemetryUtil {

	// log4j2日志
	protected static final Logger log = LogManager.getLogger();

	protected static final String DEFAULT_ENDPOINT_URL = "http://localhost:4317";

	// 初始化 OpenTelemetry
	public static OpenTelemetry initOpenTelemetry(String serviceNm) {

		// 读取 properties 和 环境变量
		// 默认值 gRPC: "http://localhost:4317" HTTP:"http://localhost:4318"
		String endpoint = null;
		try {
			Configuration config = Config.getInstance();
			// 读取环境变量[OTEL_EXPORTER_OTLP_ENDPOINT]的设定值
			endpoint = config.getString("OTEL_EXPORTER_OTLP_ENDPOINT", DEFAULT_ENDPOINT_URL);
		} catch (ConfigurationException e) {
			endpoint = DEFAULT_ENDPOINT_URL;
			log.error(e);
		}
		log.info("OpenTelemetry Collector EndPoint : {}", endpoint);

		// 创建资源信息
		Resource resource = Resource.getDefault()
				.merge(Resource.builder().put(ServiceAttributes.SERVICE_NAME, serviceNm).build());

		// [Trace] 创建 OTel Collector 的 gRPC span导出器
		OtlpGrpcSpanExporter otlpSpanExporter = OtlpGrpcSpanExporter.builder()
				.setTimeout(2, TimeUnit.SECONDS)
				.setEndpoint(endpoint)
				.build();

		// [Trace] 创建Trace提供器并设置导出器
		SdkTracerProvider tracerProvider = SdkTracerProvider.builder()
				.setResource(resource)
				.addSpanProcessor(
						BatchSpanProcessor.builder(otlpSpanExporter).setScheduleDelay(100, TimeUnit.MILLISECONDS)
								.build())
				.build();

		// [Metric] 创建 OTel Collector 的 gRPC cSpan导出器
		OtlpGrpcMetricExporter otlpMetricExporter = OtlpGrpcMetricExporter.builder()
				.setTimeout(2, TimeUnit.SECONDS)
				.setEndpoint(endpoint)
				.build();

		// [Metric] 创建Metric提供器并设置导出器
		SdkMeterProvider meterProvider = SdkMeterProvider.builder()
				.setResource(resource)
				.registerMetricReader(
						PeriodicMetricReader.builder(otlpMetricExporter).setInterval(Duration.ofMillis(1000)).build())
				.build();

		// 设置全局跟踪提供器
		OpenTelemetrySdk openTelemetrySdk = OpenTelemetrySdk.builder()
				.setTracerProvider(tracerProvider)
				.setMeterProvider(meterProvider)
				.buildAndRegisterGlobal();

		// 初始化 gRPC OpenTelemetry.
		// 默认情况下，以下客户端指标处于启用状态 :
		// 1. grpc.client.attempt.started
		// 2. grpc.client.attempt.sent_total_compressed_message_size
		// 3. grpc.client.attempt.rcvd_total_compressed_message_size
		// 4. grpc.client.attempt.duration
		// 5. grpc.client.call.duration
		// 默认情况下，以下服务端指标处于启用状态 :
		// 1. grpc.server.call.started
		// 2. grpc.server.call.sent_total_compressed_message_size
		// 3. grpc.server.call.rcvd_total_compressed_message_size
		// 4. grpc.server.call.duration
		GrpcOpenTelemetry grpcOpenTelmetry = GrpcOpenTelemetry.newBuilder()
				.sdk(openTelemetrySdk)
				.build();
		// 全局注册gRPC OpenTelemetry
		grpcOpenTelmetry.registerGlobal();

		// JVM停止时运行的钩子
		Runtime.getRuntime().addShutdownHook(new Thread(openTelemetrySdk::close));

		return openTelemetrySdk;
	}

	// [Trace] 创建一个新的 Trace 和 Span
	public static Span getNewSpan(OpenTelemetry openTelemetry, String traceNm, String spanNm) {
		// 生成全局Trace
		Tracer tracer = openTelemetry.getTracer(traceNm);
		Span startSpan = tracer.spanBuilder(spanNm).startSpan();
		return startSpan;
	}

	// [Trace] 在一个已存的 Trace 下创建新的 Span
	public static Span getRemoteSpan(OpenTelemetry openTelemetry, String traceId, String traceNm, String spanId,
			String spanNm) {
		// 生成Trace
		Tracer tracer = openTelemetry.getTracer(traceNm);
		// 在客户端传递过来的 TraceId 和 SpanId 基础上 创建新的 Span
		SpanContext remoteContext = SpanContext.createFromRemoteParent(traceId, spanId, TraceFlags.getSampled(),
				TraceState.getDefault());
		// 创建新的 Span
		Span newSpan = tracer.spanBuilder(spanNm)
				.setParent(io.opentelemetry.context.Context.current().with(Span.wrap(remoteContext)))
				.startSpan();
		return newSpan;
	}
}
