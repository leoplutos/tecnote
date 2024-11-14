package javagrpc.grpc.interceptor;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import io.grpc.Metadata;
import io.grpc.ServerCall;
import io.grpc.ServerCallHandler;
import io.grpc.ServerInterceptor;
import javagrpc.common.Const;

/**
 * 用于处理元数据的拦截器
 */
public class OtelTraceInterceptor implements ServerInterceptor {

	// log4j2日志
	protected static final Logger log = LogManager.getLogger();

	// 拦截器
	@Override
	public <ReqT, RespT> ServerCall.Listener<ReqT> interceptCall(
			ServerCall<ReqT, RespT> call,
			final Metadata metadata,
			ServerCallHandler<ReqT, RespT> next) {
		// log.info("[Java][Server] OtelTraceInterceptor. 从客户端接收到的元数据: {}", metadata);
		String traceId = metadata.get(Const.METADATA_KEY_TRACE_ID);
		String spanId = metadata.get(Const.METADATA_KEY_SPAN_ID);
		if (traceId == null || traceId.isBlank() || spanId == null || spanId.isBlank()) {
			log.warn("元数据中没有 TraceId 或者 SpanId");
			return next.startCall(call, metadata);
		} else {
			// 将 traceId 和 spanId 设定到当前上下文
			io.grpc.Context context = io.grpc.Context.current()
					// traceId
					.withValue(Const.CONTEXT_KEY_TRACE_ID, traceId)
					// spanId
					.withValue(Const.CONTEXT_KEY_SPAN_ID, spanId);
			return io.grpc.Contexts.interceptCall(context, call, metadata, next);
		}
	}
}
