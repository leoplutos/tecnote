using Serilog;
using dotnet_etcd;
using Etcdserverpb;
using Google.Protobuf;
using V3Lockpb;
using Grpc.Core;
using Microsoft.Extensions.Configuration;

namespace dotnet_console_sample.Etcd
{
	class EtcdClientExample
	{
		// appsettings.json 和 环境变量
		private readonly IConfiguration _config;
		private EtcdClient client;
		private readonly string prefix = "/CSharpKey";

		public EtcdClientExample(IConfiguration config)
		{
			_config = config;
		}

		public void EtcdClient()
		{
			// 从 appsettings.json 中读取内容
			string? host = _config["EtcdSettings:Host"];
			string? portStr = _config["EtcdSettings:Port"];
			//Log.Information("Etcd   Host:{host} Port:{portStr}", host, portStr);

			// 建立连接
			string endPoints = "http://" + host + ":" + portStr;
			Log.Information("Etcd   EndPoints:{EndPoints}", endPoints);
			// .Net Framework 用法
			//EtcdClient etcdClient = new EtcdClient("https://localhost:23790,https://localhost:23791,https://localhost:23792");
			// client = new EtcdClient("http://localhost:2379");
			// .Net Core 用法
			client = new EtcdClient(endPoints, configureChannelOptions: (options =>
			{
				options.Credentials = ChannelCredentials.Insecure;
			}));
			try
			{
				client.Status(new StatusRequest { });
				Log.Information("Etcd连接成功");
			}
			catch (Exception e)
			{
				Log.Error(e, "Etcd连接失败");
				return;
			}

			// 设定Key
			string key1 = prefix + "/Key1";
			string key2 = prefix + "/Key2";
			string setValue1 = "使用C#客户端添加_" + Guid.NewGuid().ToString();
			string setValue2 = "使用C#客户端添加_" + Guid.NewGuid().ToString();
			// await client.PutAsync("foo/bar", "barfoo");
			client.Put(key1, setValue1);
			//Console.WriteLine($"添加Key成功    key={key1}    value={setValue1}");
			Log.Information("添加Key成功    key={key}    value={value}", key1, setValue1);
			client.Put(key2, setValue2);
			Log.Information("添加Key成功    key={key}    value={value}", key2, setValue2);

			// 取得Key
			// await client.GetValAsync("foo/bar");
			string getValue = client.GetVal(key1);
			Log.Information("取得Key成功    key={key}    value={value}", key1, getValue);

			// 取得Key（前缀机制）
			// 前缀查询
			// await client.GetRangeAsync("foo/");
			RangeResponse list = client.GetRange(prefix);
			Log.Information("取得前缀成功    prefix={prefix}", prefix);
			for (int i = 0; i < list.Count; i++)
			{
				string key = list.Kvs[i].Key.ToStringUtf8().Trim();
				string value = list.Kvs[i].Value.ToStringUtf8().Trim();
				Log.Information("key[{i}]={key}    value[{i}]={value}", i, key, i, value);
			}

			// 分布式锁
			string lockKey = prefix + "/lock";
			// 加锁
			LockResponse lockResponse = client.Lock(lockKey);
			string lockResKey = lockResponse.Key.ToStringUtf8().Trim();
			Log.Information("[加锁]分布式锁成功    lockKey={lockKey}    lockResKey={lockResKey}", lockKey, lockResKey);
			Log.Information("5秒后解锁,此期间运行 [etcdctl lock /CSharpKey/lock] 会一直等待");
			Thread.Sleep(5000);
			// 解锁（参数为加锁的返回值）
			_ = client.Unlock(lockResKey);
			Log.Information("[解锁]分布式锁成功    lockResKey={lockResKey}", lockResKey);

			// 调用租约函数
			LeaseRegister();

			// 释放Etcd资源
			client.Dispose();

			// Console.WriteLine("按任意键继续");
			// Console.ReadKey();
		}

		// 租约函数
		private void LeaseRegister()
		{
			// 创建租约
			string leaseKey = this.prefix + "/LsKey1";
			string leaseValue = "此Key会自动被删除";
			long ttl = 5;
			long leaseId = this.client.LeaseGrant(new LeaseGrantRequest
			{
				TTL = ttl
			}).ID;
			Log.Information("创建租约(Lease)成功    leaseId={leaseId}", leaseId);
			// 将租约附加到一个Key上
			client.Put(new PutRequest
			{
				Key = ByteString.CopyFromUtf8(leaseKey),
				Value = ByteString.CopyFromUtf8(leaseValue),
				Lease = leaseId
			});
			Log.Information("添加租约Key成功    key={leaseKey}    value={leaseValue}    leaseId={leaseId}", leaseKey, leaseValue, leaseId);

			// 续租，在租约过期之前续租
			//var kaTask = client.LeaseKeepAlive(leaseId, new System.Threading.CancellationToken());
			// 因为是在同步方法中调用异步方法，所以需要在这里等待才会堵塞线程
			// kaTask.GetAwaiter().GetResult();

			// 监视租约
			WatchRequest request = new WatchRequest()
			{
				CreateRequest = new WatchCreateRequest()
				{
					Key = ByteString.CopyFromUtf8(leaseKey)
				}
			};
			// .Net Framework 用法
			// var wTask = client.Watch(request, PrintWatch);
			// .Net Core 用法
			var wTask = client.WatchAsync(request, PrintWatch);
			// 因为是在同步方法中调用异步方法，所以需要在这里等待才会堵塞线程
			wTask.GetAwaiter().GetResult();
		}

		// 监听函数
		private void PrintWatch(WatchEvent[] response)
		{
			foreach (WatchEvent wEvent in response)
			{
				// 当租约到期时（被删除）会在此通知
				if (wEvent.Type == Mvccpb.Event.Types.EventType.Delete)
				{
					Log.Information("租约  key={key} 到期，续租", wEvent.Key);
					this.LeaseRegister();
				}
			}
		}
	}
}
