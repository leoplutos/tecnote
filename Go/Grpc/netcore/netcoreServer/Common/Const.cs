namespace netcoreServer.Common;

public class Const
{
	// gPRC服务发现协议
	public static readonly string ETCD_SCHEME = "etcd";
	public static readonly string ETCD_SERVICENAME = "/service/grpc";
	public static readonly string CHANNEL_TARGET = ETCD_SCHEME + "://" + ETCD_SERVICENAME;
}
