using Serilog;
using Microsoft.Extensions.Configuration;
using dotnet_console_sample.Async;
using dotnet_console_sample.Redis;
using dotnet_console_sample.Etcd;

namespace dotnet_console_sample;

class App
{
	static async Task<int> Main(string[] args)
	{
		// 参数判断
		if (args.Length == 0)
		{
			Console.WriteLine("请输入一个参数[Async|Redis|Etcd]");
			Console.WriteLine("比如: dotnet run --project dotnet-console-sample -- Async");
			return 1;
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

			string firstArgument = args[0];
			if (firstArgument.Equals("Async"))
			{
				Log.Information("开始运行AsyncExample");
				// 异步例子
				AsyncExample async = new(config);
				await async.AsyncExampleStart();
			}
			else if (firstArgument.Equals("Redis"))
			{
				// Redis例子
				RedisClientExample redis = new(config);
				redis.RedisClient();
			}
			else if (firstArgument.Equals("Etcd"))
			{
				// Etcd例子
				EtcdClientExample etcd = new(config);
				etcd.EtcdClient();
			}
			else
			{
				Console.WriteLine("无法识别此参数");
				return 1;
			}
		}
		catch (Exception ex)
		{
			Log.Error(ex, "客户端意外终止");
			return 1;
		}
		finally
		{
			Log.Information("客户端停止");
			// 刷新异步日志
			Log.CloseAndFlush();
		}
		return 0;
	}
}
