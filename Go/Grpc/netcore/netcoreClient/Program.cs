using Serilog;
using Microsoft.Extensions.Configuration;
using netcoreClient.Clients;

// 参数判断
// args是隐式地通过编译器生成的Main方法传递给程序的命令行参数
if (args.Length == 0)
{
	Console.WriteLine("请输入一个参数[Sync|Async|Dtm]");
	Console.WriteLine("比如: dotnet run --project netcoreClient -- Async");
	Environment.Exit(1);
}

// 初始化Serilog日志
Log.Logger = new LoggerConfiguration()
	.Enrich.WithThreadId()
	.MinimumLevel.Debug()
	//.WriteTo.Console(outputTemplate: "[{Timestamp:yyyy-MM-dd HH:mm:ss.fff}] {Level:u5} [{ThreadId}][{SourceContext:l}] - {Message:lj}{NewLine}{Exception}")
	//.WriteTo.File("D:/logs/myapp.txt", rollingInterval: RollingInterval.Day)
	.WriteTo.Async(a => a.Console(outputTemplate: "[{Timestamp:yyyy-MM-dd HH:mm:ss.fff}] {Level:u5} [{ThreadId}] - {Message:lj}{NewLine}{Exception}"))
	//.WriteTo.Async(a => a.File("D:/logs/myapp.log", outputTemplate: "[{Timestamp:yyyy-MM-dd HH:mm:ss.fff}] {Level:u5} [{ThreadId}] - {Message:lj}{NewLine}{Exception}", rollingInterval: RollingInterval.Day))
	.CreateLogger();

try
{
	// 读取配置文件和环境变量
	string? environment = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT");
	if (string.IsNullOrEmpty(environment))
	{
		environment = "Development";
	}
	// 创建ConfigurationBuilder实例
	IConfiguration config = new ConfigurationBuilder()
		//.SetBasePath(Directory.GetCurrentDirectory())
		// 读取Json文件
		.AddJsonFile($"appsettings.{environment}.json", optional: true, reloadOnChange: true)
		.AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
		// 读取环境变量
		.AddEnvironmentVariables()
		.Build();

	// 读取环境变量
	// 判断是否启用Etcd服务注册
	string? resolve = config["GRPC_SERVER_RESOLVE"];
	bool isWithEtcd = false;
	if (!string.IsNullOrEmpty(resolve))
	{
		if (resolve.Equals("true"))
		{
			isWithEtcd = true;
		}
	}
	Log.Information("[.NET Core(C#)][Client] 是否启用Etcd服务发现: {isWithEtcd}", isWithEtcd);

	string firstArgument = args[0];
	if (firstArgument.Equals("Async"))
	{
		Log.Information("异步例子开始");
		// 异步例子
		ProductClientAsync clientAsync = new(config);
		await clientAsync.AsyncClient(isWithEtcd);
		Log.Information("异步例子结束");
	}
	else if (firstArgument.Equals("Sync"))
	{
		Log.Information("同步例子开始");
		// 同步例子
		ProductClient client = new(config);
		client.SyncClient(isWithEtcd);
		Log.Information("同步例子结束");
	}
	else if (firstArgument.Equals("Dtm"))
	{
		Log.Information("Dtm例子开始");
		// 同步例子
		DtmClientAsync clientAsync = new(config);
		await clientAsync.DtmClient();
		Log.Information("Dtm例子结束");
	}
	else
	{
		Console.WriteLine("无法识别此参数");
		Environment.Exit(1);
	}
}
catch (Exception ex)
{
	Log.Error(ex, "客户端意外终止");
}
finally
{
	Log.Information("客户端停止");
	// 刷新异步日志
	Log.CloseAndFlush();
}
