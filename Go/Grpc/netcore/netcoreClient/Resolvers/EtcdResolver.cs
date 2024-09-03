using Serilog;
using dotnet_etcd;
using Grpc.Core;
using Grpc.Net.Client.Balancer;
using Etcdserverpb;
using System.Collections.Concurrent;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Configuration;

namespace netcoreClient.Resolvers;

// Etcd服务发现
class EtcdResolver : PollingResolver
{
	// appsettings.json 和 环境变量
	private readonly IConfiguration _config;
	// Etcd客户端
	private readonly EtcdClient _etcd;
	// Key前缀（例：/service/grpc/ProductInfo）
	private readonly string _prefixKey;
	// 储存发现的服务节点
	private readonly ConcurrentDictionary<string, BalancerAddress>? _serviceUriMap;

	public EtcdResolver(Uri address, int defaultPort, ILoggerFactory loggerFactory, IConfiguration config)
		: base(loggerFactory)
	{
		// address:服务发现的URI，比如：etcd:///service/grpc
		Log.Information("[.NET Core(C#)][Client] EtcdResolver 开始  address:{address}  port:{port}", address, defaultPort);
		_config = config;
		// 服务发现的Endpoint，并且还是Etcd的Key前缀
		_prefixKey = address.AbsolutePath;
		Log.Information("prefixKey:{prefixKey}", _prefixKey);
		_serviceUriMap = new ConcurrentDictionary<string, BalancerAddress>();
		// 建立Etcd连接
		string? host = _config["EtcdSettings:Host"];
		string? portStr = _config["EtcdSettings:Port"];
		string endPoints = "http://" + host + ":" + portStr;
		_etcd = new EtcdClient(endPoints, configureChannelOptions: (options =>
		{
			options.Credentials = ChannelCredentials.Insecure;
		}));
		try
		{
			_etcd.Status(new StatusRequest { });
			Log.Information("Etcd连接成功  EndPoints:{EndPoints}", endPoints);
		}
		catch (Exception e)
		{
			Log.Error(e, "Etcd连接失败");
		}

		// 使用前缀查询当前Etcd可用的服务节点
		RangeResponse list = _etcd.GetRange(_prefixKey);
		for (int i = 0; i < list.Count; i++)
		{
			string key = list.Kvs[i].Key.ToStringUtf8().Trim();
			string value = list.Kvs[i].Value.ToStringUtf8().Trim();
			Log.Information("取得Key成功.  key={key}  value={value}", key, value);
			var uri = new Uri(value);
			// 将键值对储存
			_serviceUriMap.TryAdd(key, new BalancerAddress(uri.Host, uri.Port));
		}

		// 监听Etcd
		//WatchRequest request = new()
		//{
		//CreateRequest = new WatchCreateRequest()
		//{
		// Key = ByteString.CopyFromUtf8(_prefixKey),
		// range_end 是要观察的范围 [key, range_end) 的终点。
		// 如果 range_end 没有设置，则只有参数 key 被观察。
		// 如果 range_end 等同于 '\0'， 则大于等于参数 key 的所有 key 都将被观察
		// 如果 range_end 比给定 key 大1， 则所有以给定 key 为前缀的 key 都将被观察
		//RangeEnd = ByteString.CopyFromUtf8(_prefixKey + "x0")
		// RangeEnd = ByteString.CopyFromUtf8(EtcdClient.GetRangeEnd(_prefixKey))
		//}
		//};
		// _etcd.WatchAsync(request, async (events) =>
		// {
		// 	foreach (WatchEvent wEvent in events)
		// 	{
		// 		// 当租约到期时（被删除）会在此通知
		// 		if (wEvent.Type == Mvccpb.Event.Types.EventType.Delete)
		// 		{
		// 			// 当KEY被删除触发
		// 			Log.Information("服务节点下线:  Key={Key}  URI={URI}", wEvent.Key, wEvent.Value);
		// 			_serviceUriMap.TryRemove(wEvent.Key, out _);
		// 		}
		// 		else if (wEvent.Type == Mvccpb.Event.Types.EventType.Put)
		// 		{
		// 			Log.Information("服务节点上线:  Key={Key}  URI={URI}", wEvent.Key, wEvent.Value);
		// 			var uri = new Uri(wEvent.Value);
		// 			_serviceUriMap.TryAdd(wEvent.Key, new BalancerAddress(uri.Host, uri.Port));
		// 		}
		// 		else
		// 		{
		// 		}
		// 		// 更新Listener
		// 		await ResolveAsync(new CancellationToken());
		// 	}
		// });
		_etcd.WatchRangeAsync(_prefixKey, async (events) =>
		{
			foreach (WatchEvent wEvent in events)
			{
				// 当租约到期时（被删除）会在此通知
				if (wEvent.Type == Mvccpb.Event.Types.EventType.Delete)
				{
					// 当KEY被删除触发
					Log.Information("服务节点下线:  Key={Key}  URI={URI}", wEvent.Key, wEvent.Value);
					_serviceUriMap.TryRemove(wEvent.Key, out _);
				}
				else if (wEvent.Type == Mvccpb.Event.Types.EventType.Put)
				{
					Log.Information("服务节点上线:  Key={Key}  URI={URI}", wEvent.Key, wEvent.Value);
					var uri = new Uri(wEvent.Value);
					_serviceUriMap.TryAdd(wEvent.Key, new BalancerAddress(uri.Host, uri.Port));
				}
				else
				{
				}
				// 更新Listener
				await ResolveAsync(CancellationToken.None);
			}
		});
		Log.Information("[.NET Core(C#)][Client] Etcd 监听 Key:{Key} 开始", _prefixKey);
		Log.Information("[.NET Core(C#)][Client] EtcdResolver 结束");
	}

	protected override Task ResolveAsync(CancellationToken cancellationToken)
	{
		Log.Information("更新服务Endpoints列表");
		List<BalancerAddress> balancerAddresses = new();
		foreach (var kvp in _serviceUriMap!)
		{
			Log.Information("服务节点在线:  Key={Key}  URI={URI}", kvp.Key, kvp.Value);
			balancerAddresses.Add(kvp.Value);
		}
		if (balancerAddresses.Count == 0)
		{
			Log.Error("没有服务节点在线 prefix={prefix}", _prefixKey);
		}
		else
		{
			// 将实例列表传递给 LoadBalancer，完成服务解析
			Listener(ResolverResult.ForResult(balancerAddresses.AsReadOnly()));
		}
		return Task.CompletedTask;
	}

	protected override void Dispose(bool disposing)
	{
		// 调用父类的释放资源
		base.Dispose();
		// 释放Etcd资源
		_etcd.Dispose();
	}
}
