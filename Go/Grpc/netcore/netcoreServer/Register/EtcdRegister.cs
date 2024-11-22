using dotnet_etcd;
using Etcdserverpb;
using Google.Protobuf;
using Grpc.Core;
using netcoreServer.Common;
using Serilog;
using UUIDNext;

namespace netcoreServer.Register;

// Etcd服务注册
public class EtcdRegister
{
	// appsettings.json 配置文件
	private readonly IConfiguration _configuration;

	public EtcdRegister(IConfiguration configuration)
	{
		_configuration = configuration;
	}

	// 在 [Program.cs] 调用
	public void Regist(IServiceProvider serviceProvider)
	{
		Log.Information("[.NET Core(C#)][Server] Etcd服务注册开始");

		// 从 appsettings.json 中读取内容
		string? connectHost = _configuration["EtcdConectSettings:Host"];
		string? connectHPort = _configuration["EtcdConectSettings:Port"];

		// 建立连接
		string endPoints = "http://" + connectHost + ":" + connectHPort;
		Log.Information("Etcd   EndPoints:{EndPoints}", endPoints);

		EtcdClient client = new EtcdClient(endPoints, configureChannelOptions: (options =>
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

		// 注册的IP地址，如果[appsettings.json]未设定，则取得本地IP
		// string localIPaddr;
		// using (Socket socket = new Socket(AddressFamily.InterNetwork, SocketType.Dgram, 0))
		// {
		// 	try
		// 	{
		// 		socket.Connect("8.8.8.8", 65530);
		// 		IPEndPoint? endPoint = socket.LocalEndPoint as IPEndPoint;
		// 		localIPaddr = endPoint!.Address.ToString();
		// 	}
		// 	catch (System.Exception)
		// 	{
		// 		localIPaddr = "127.0.0.1";
		// 	}
		// }
		// 读取[appsettings.json]的设定值
		string? registIPaddr = _configuration["EtcdRegistSettings:Host"];
		if (string.IsNullOrEmpty(registIPaddr))
		{
			registIPaddr = "127.0.0.1";
		}
		// 读取环境变量（在docker中运行时设定）
		string? registPort = _configuration["ASPNETCORE_HTTP_PORTS"];
		if (string.IsNullOrEmpty(registPort))
		{
			registPort = "50051";
		}

		// 创建租约
		long ttl = 5;
		long leaseId = client.LeaseGrant(new LeaseGrantRequest
		{
			TTL = ttl
		}).ID;
		// /service/grpc/uuid
		string uuidv7 = Uuid.NewDatabaseFriendly(Database.PostgreSql).ToString();
		string leaseKey = $"{Const.ETCD_SERVICENAME}/{uuidv7}";
		// http://192.128.0.1:50051
		string leaseValue = "http://" + registIPaddr + ":" + registPort;
		client.Put(new PutRequest
		{
			Key = ByteString.CopyFromUtf8(leaseKey),
			Value = ByteString.CopyFromUtf8(leaseValue),
			Lease = leaseId
		});
		Log.Information("[.NET Core(C#)][Server] Etcd注册成功  Key:{leaseKey}  Value:{leaseValue}", leaseKey, leaseValue);
		// 续租，在租约过期之前续租
		var _ = client.LeaseKeepAlive(leaseId, new CancellationToken());

		Log.Information("[.NET Core(C#)][Server] Etcd服务注册结束");
	}
}
