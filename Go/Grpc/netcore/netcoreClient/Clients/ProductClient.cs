using Serilog;
using Grpc.Health.V1;
using static Grpc.Health.V1.HealthCheckResponse.Types;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Configuration;
using Grpc.Core;
using Grpc.Net.Client;
using Grpc.Net.Client.Balancer;
using Grpc.Net.Client.Configuration;
using GrpcDemo;
using netcoreClient.Common;
using netcoreClient.Resolvers;

namespace netcoreClient.Clients;

class ProductClient
{
	// appsettings.json 和 环境变量
	private readonly IConfiguration _config;

	public ProductClient(IConfiguration config)
	{
		_config = config;
	}

	public void SyncClient(bool isWithEtcd)
	{
		Log.Information("SyncClient 开始");

		// 建立连接
		// var channel = GrpcChannel.ForAddress("http://localhost:50051");

		//是否启用Etcd服务注册
		GrpcChannel channel;
		if (isWithEtcd)
		{
			Log.Information("Etcd服务发现方式");

			// 配置 gRPC 重试策略（当Etcd上的服务节点下线时需要此策略）
			var defaultMethodConfig = new MethodConfig
			{
				Names = { MethodName.Default },
				RetryPolicy = new RetryPolicy
				{
					MaxAttempts = 5,
					InitialBackoff = TimeSpan.FromSeconds(1),
					MaxBackoff = TimeSpan.FromSeconds(5),
					BackoffMultiplier = 1.5,
					RetryableStatusCodes = { StatusCode.Unavailable }
				}
			};
			//  Etcd服务发现
			var services = new ServiceCollection();
			// 依赖注入配置对象
			services.AddSingleton<IConfiguration>(_config);
			// 依赖注入Etcd服务发现工厂
			services.AddSingleton<ResolverFactory, EtcdResolverFactory>();
			channel = GrpcChannel.ForAddress(Const.CHANNEL_TARGET,
			new GrpcChannelOptions
			{
				Credentials = ChannelCredentials.Insecure,
				ServiceProvider = services.BuildServiceProvider(),
				ServiceConfig = new ServiceConfig
				{
					LoadBalancingConfigs = { new RoundRobinConfig() },
					MethodConfigs = { defaultMethodConfig },
				}
			});
		}
		else
		{
			Log.Information("静态解析方式");
			// 静态解析方式（适用于应用已经知道它调用的地址的情况）
			var staticfactory = new StaticResolverFactory(addr => new[]
			{
				new BalancerAddress("localhost", 50051),
				new BalancerAddress("localhost", 50052),
				new BalancerAddress("localhost", 50053),
				new BalancerAddress("localhost", 50054),
			});
			var services = new ServiceCollection();
			services.AddSingleton<ResolverFactory>(staticfactory);
			channel = GrpcChannel.ForAddress("static:///my-example-host",
			new GrpcChannelOptions
			{
				Credentials = ChannelCredentials.Insecure,
				ServiceProvider = services.BuildServiceProvider(),
				ServiceConfig = new ServiceConfig { LoadBalancingConfigs = { new RoundRobinConfig() } }
			});
		}

		// 业务请求客户端
		var client = new ProductInfo.ProductInfoClient(channel);
		// HealthCheck客户端
		var healthClient = new Health.HealthClient(channel);

		for (int i = 0; i < 500; i++)
		{
			// 添加商品
			ProductId pid = AddProduct(client);

			// 取得商品
			//GetProduct(client, pid);
		}

		// 检查服务状态
		_ = HealthCheck(healthClient);

		// 关闭频道
		var task = channel.ShutdownAsync();
		task.GetAwaiter().GetResult();

		Log.Information("SyncClient 结束");
	}

	// 添加商品
	private static ProductId AddProduct(ProductInfo.ProductInfoClient client)
	{
		// 参数可以传递给一个一个调用，也可以组合。使用流畅的语法转换为 CallOptions。
		var callOptions = new CallOptions()
			//.WithCancellationToken(CancellationToken.None)
			//.WithDeadline(DateTime.UtcNow.AddMinutes(2))
			//.WithHeaders(Metadata.Empty)
			.WithWaitForReady(true);

		ProductId result = client.addProduct(new Product { Name = "Chrome Book 2024", Description = "Add by .NET Core(C#)" }, callOptions);
		Log.Information("[.NET Core(C#)][Client] Add product success. id={id}", result.Value);
		return result;
	}

	// 取得商品
	private static void GetProduct(ProductInfo.ProductInfoClient client, ProductId pid)
	{
		// 参数可以传递给一个一个调用，也可以组合。使用流畅的语法转换为 CallOptions。
		var callOptions = new CallOptions()
			//.WithCancellationToken(CancellationToken.None)
			//.WithDeadline(DateTime.UtcNow.AddMinutes(2))
			//.WithHeaders(Metadata.Empty)
			.WithWaitForReady(true);

		Product result = client.getProduct(pid, callOptions);
		Log.Information("[.NET Core(C#)][Client] GetProduct success.");
		Log.Information("result={result}", result);
	}

	//健康检查
	private static ServingStatus HealthCheck(Health.HealthClient client)
	{
		// HealthCheck检查的服务名为空
		HealthCheckResponse response = client.Check(new HealthCheckRequest { Service = "" });
		Log.Information("[.NET Core(C#)][Client] Health Checking... gRPC Server status:[{Status}]", response.Status);
		return response.Status;
	}
}
