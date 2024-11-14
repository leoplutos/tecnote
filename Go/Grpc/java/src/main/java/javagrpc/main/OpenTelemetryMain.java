package javagrpc.main;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import io.grpc.Grpc;
import io.grpc.InsecureChannelCredentials;
import io.grpc.ManagedChannel;
import io.grpc.Metadata;
import io.grpc.stub.MetadataUtils;
import io.opentelemetry.api.OpenTelemetry;
import io.opentelemetry.api.common.Attributes;
import io.opentelemetry.api.metrics.LongCounter;
import io.opentelemetry.api.metrics.LongHistogram;
import io.opentelemetry.api.metrics.Meter;
import io.opentelemetry.api.trace.Span;
import io.opentelemetry.context.Context;
import io.opentelemetry.context.Scope;
import javagrpc.common.Const;
import javagrpc.grpc.stub.ProductInfoGrpc;
import javagrpc.grpc.stub.ProductInfoPb.Product;
import javagrpc.grpc.stub.ProductInfoPb.ProductId;
import javagrpc.opentelemetry.OpentelemetryUtil;

// 使用 OpenTelemetry 的示例
public class OpenTelemetryMain {

	// log4j2日志
	protected static final Logger log = LogManager.getLogger();

	// OpenTelemetry 示例开始
	private void startOpenTelemetry() throws Exception {
		log.info("startOpenTelemetry 开始");
		// 初始化OpenTelemetry
		OpenTelemetry openTelemetry = OpentelemetryUtil.initOpenTelemetry("OtelTraceClientMain");
		// 创建一个新的 Trace 和 Span
		String traceNm = "OtelStartTrace";
		String spanNm = "start";
		String meterNm = "OtelStartMeter";
		Span startSpan = OpentelemetryUtil.getNewSpan(openTelemetry, traceNm, spanNm);
		// 生成全局 Metric
		Meter meter = openTelemetry.getMeterProvider().meterBuilder(meterNm).build();
		// [Metric]计数器
		LongCounter counter = meter.counterBuilder("javagrpc_otel_client_call").build();
		// [Metric]直方图
		LongHistogram histogram = meter.histogramBuilder("javagrpc_otel_client_total_time").ofLongs().setUnit("ms")
				.build();
		// 取得上下文
		Context startContext = Context.current().with(startSpan);
		try (Scope scope = startContext.makeCurrent()) {
			// 从上下文中获取 TraceId
			String traceId = startSpan.getSpanContext().getTraceId();
			String spanId = startSpan.getSpanContext().getSpanId();
			log.info("Trace ID: {},   Span ID: {}", traceId, spanId);
			// 开始时间
			long startTime = System.currentTimeMillis();

			// 业务逻辑
			// gRPC元数据
			Metadata metadata = new Metadata();
			// 将Tracing设置在元数据中
			metadata.put(Const.METADATA_KEY_TRACE_ID, traceId);
			metadata.put(Const.METADATA_KEY_SPAN_ID, spanId);

			// 调用链1：添加商品（Java服务端）
			String target1 = "localhost:50051";
			// 连接频道
			ManagedChannel channel1 = Grpc.newChannelBuilder(target1, InsecureChannelCredentials.create()).build();
			// 取得存根
			ProductInfoGrpc.ProductInfoBlockingStub productBlockingStub1 = ProductInfoGrpc.newBlockingStub(channel1)
					.withWaitForReady();
			// 设置gRPC元数据并且进行gRPC调用
			int count = 1;
			ProductId result1 = null;
			for (int i = 0; i < count; i++) {
				Product request = Product.newBuilder().setName("Otel_Span_1_Name").setDescription("Otel_Span_1_Desc")
						.build();
				result1 = productBlockingStub1
						.withInterceptors(MetadataUtils.newAttachHeadersInterceptor(metadata))
						.addProduct(request);
				log.info("result1: {}", result1);
				// [Metric]计数器+1
				counter.add(1);
			}

			// 调用链2：取得商品（Dotnet服务端）
			String target2 = "localhost:50052";
			// 连接频道
			ManagedChannel channel2 = Grpc.newChannelBuilder(target2, InsecureChannelCredentials.create()).build();
			// 取得存根
			ProductInfoGrpc.ProductInfoBlockingStub productBlockingStub2 = ProductInfoGrpc.newBlockingStub(channel2)
					.withWaitForReady();
			// 设置gRPC元数据并且进行gRPC调用
			Product result2 = productBlockingStub2
					.withInterceptors(MetadataUtils.newAttachHeadersInterceptor(metadata))
					.getProduct(result1);
			log.info("result2: {}", result2);
			// [Metric]计数器+1
			counter.add(1);

			// 调用链3：取得商品（Java服务端）
			// 设置gRPC元数据并且进行gRPC调用
			Product result3 = productBlockingStub1
					.withInterceptors(MetadataUtils.newAttachHeadersInterceptor(metadata))
					.getProduct(result1);
			log.info("result3: {}", result3);
			// [Metric]计数器+1
			counter.add(1);

			// 调用链4：添加商品（Dotnet服务端）
			// 设置gRPC元数据并且进行gRPC调用
			Product request4 = Product.newBuilder().setName("Otel_Span_4_Name").setDescription("Otel_Span_4_Desc")
					.build();
			ProductId result4 = productBlockingStub2
					.withInterceptors(MetadataUtils.newAttachHeadersInterceptor(metadata))
					.addProduct(request4);
			log.info("result4: {}", result4);
			// [Metric]计数器+1
			counter.add(1);

			// [Metric]直方图打桩
			histogram.record(System.currentTimeMillis() - startTime, Attributes.empty(), startContext);
		} finally {
			startSpan.end();
		}
		// 等待2秒，以便OpenTelemetry抓取好数据
		Thread.sleep(2000);
		log.info("startOpenTelemetry 结束");
	}

	public static void main(String[] args) throws Exception {
		try {
			log.info("OtelTraceMain 开始");
			OpenTelemetryMain main = new OpenTelemetryMain();
			main.startOpenTelemetry();
			log.info("OtelTraceMain 结束");
		} catch (Exception e) {
			log.error(e);
		} finally {
			// 因为使用了异步日志，要在这里关闭
			LogManager.shutdown();
		}
	}
}
