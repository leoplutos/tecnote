package javagrpc.common;

import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;

public class Const {
	// UTF8编码
	public static final Charset UTF_8 = StandardCharsets.UTF_8;
	// gPRC服务发现协议
	public static final String ETCD_SCHEME = "etcd";
	public static final String ETCD_SERVICENAME = "/service/grpc";
	public static final String CHANNEL_TARGET = ETCD_SCHEME + "://" + ETCD_SERVICENAME;
	// config.properties
	public static final String CONFIG_PROPERTIES = "config.properties";

}
