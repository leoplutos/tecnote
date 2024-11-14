package javagrpc.common;

import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import io.grpc.Context;
import io.grpc.Metadata;

public class Const {
	// UTF8编码
	public static final Charset UTF_8 = StandardCharsets.UTF_8;
	// gPRC服务发现协议
	public static final String ETCD_SCHEME = "etcd";
	public static final String ETCD_SERVICENAME = "/service/grpc";
	public static final String CHANNEL_TARGET = ETCD_SCHEME + "://" + ETCD_SERVICENAME;
	// config.properties
	public static final String CONFIG_PROPERTIES = "config.properties";

	// 元数据:trace_id
	public static final Metadata.Key<String> METADATA_KEY_TRACE_ID = Metadata.Key.of("trace_id",
			Metadata.ASCII_STRING_MARSHALLER);
	// 元数据:span_id
	public static final Metadata.Key<String> METADATA_KEY_SPAN_ID = Metadata.Key.of("span_id",
			Metadata.ASCII_STRING_MARSHALLER);
	// 上下文:trace_id
	public static final Context.Key<String> CONTEXT_KEY_TRACE_ID = Context.key("trace_id");
	// 上下文:span_id
	public static final Context.Key<String> CONTEXT_KEY_SPAN_ID = Context.key("span_id");
}
