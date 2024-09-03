using Grpc.Net.Client.Balancer;
using netcoreClient.Common;
using Microsoft.Extensions.Configuration;

namespace netcoreClient.Resolvers;

// Etcd服务发现工厂
class EtcdResolverFactory : ResolverFactory
{
	// appsettings.json 和 环境变量
	private readonly IConfiguration _config;

	public EtcdResolverFactory(IConfiguration config)
	{
		_config = config;
	}

	// 初建一个etcd的服务发现
	// etcd:///service/grpc
	public override string Name => Const.ETCD_SCHEME;

	public override Resolver Create(ResolverOptions options)
	{
		return new EtcdResolver(options.Address, options.DefaultPort, options.LoggerFactory, _config);
	}
}
