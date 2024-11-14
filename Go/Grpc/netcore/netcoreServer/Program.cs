using Serilog;
using Serilog.Events;
using Microsoft.Extensions.Diagnostics.HealthChecks;
using netcoreServer.Services;
using netcoreServer.Register;
using OpenTelemetry.Resources;
using OpenTelemetry.Trace;
using OpenTelemetry.Metrics;

//######################################
// gRPC服务启动主入口
//######################################

try
{
	// gPRC应用对象
	var builder = WebApplication.CreateBuilder(args);

	// 获取当前环境
	var env = builder.Environment;
	if (env.IsDevelopment())
	{
		Console.WriteLine("当前环境是 Development 采用漂亮打印");
		// 采用漂亮打印
		SerilogLoader.InitPrettyConsole();
	}
	else if (env.EnvironmentName.Equals("Docker"))
	{
		Console.WriteLine($"当前环境是 Docker 采用Json日志");
		// 采用Json日志
		SerilogLoader.InitJsonConsole();
	}
	else
	{
		Console.WriteLine($"当前环境是 {env.EnvironmentName} 采用漂亮打印");
		// 采用漂亮打印
		SerilogLoader.InitPrettyConsole();
	}
	Log.Information("开始启动gRPC服务");

	// 注册日志
	builder.Services.AddSerilog();
	// 注册gPRC服务
	builder.Services.AddGrpc();
	// 注册gPRC健康检查
	builder.Services.AddGrpcHealthChecks()
	.AddAsyncCheck("", () =>
	{
		// var result = Random.Shared.Next() % 5 == 0
		//     ? HealthCheckResult.Unhealthy()
		//     : HealthCheckResult.Healthy();
		var result = HealthCheckResult.Healthy();
		return Task.FromResult(result);
	}, Array.Empty<string>());
	builder.Services.Configure<HealthCheckPublisherOptions>(options =>
	{
		options.Delay = TimeSpan.Zero;
		options.Period = TimeSpan.FromSeconds(5);
	});
	// 单例模式注册Configuration
	var configuration = builder.Configuration;
	builder.Services.AddSingleton<IConfiguration>(configuration);
	// 读取环境变量
	// 获取绑定的port
	var http_ports = configuration["http_ports"];
	//var http_ports = configuration["ASPNETCORE_HTTP_PORTS"];
	if (string.IsNullOrEmpty(http_ports))
	{
		http_ports = "unknownport";
	}
	Log.Information("[.NET Core(C#)][Server] 环境变量设定端口: {http_ports}", http_ports);
	// 获取OpenTelemetry Collector的URL
	// 默认值 gRPC: "http://localhost:4317" HTTP:"http://localhost:4318"
	var otlp_endpoint = configuration["OTEL_EXPORTER_OTLP_ENDPOINT"];
	if (string.IsNullOrEmpty(otlp_endpoint))
	{
		otlp_endpoint = "http://localhost:4317";
	}
	Log.Information("[.NET Core(C#)][Server] OpenTelemetry Collector EndPoint : {otlp_endpoint}", otlp_endpoint);
	// 判断是否启用Otel检测
	string? otel = configuration["GRPC_SERVER_OTEL"];
	bool isWithOtel = false;
	if (!string.IsNullOrEmpty(otel))
	{
		if (otel.Equals("true"))
		{
			isWithOtel = true;
		}
	}
	Log.Information("[.NET Core(C#)][Server] 是否启用Otel检测: {isWithOtel}", isWithOtel);
	// 需要 dotnet add package OpenTelemetry.Extensions.Hosting
	builder.Services.AddOpenTelemetry()
		.ConfigureResource(resource => resource.AddService(serviceName: "NetcoreGrpc:" + http_ports))
		.WithTracing(tracing =>
		{
			// 对于 gRPC 服务端: 需要 OpenTelemetry.Instrumentation.AspNetCore 插桩
			//  https://github.com/open-telemetry/opentelemetry-dotnet-contrib/blob/main/src/OpenTelemetry.Instrumentation.AspNetCore/README.md
			// 对于 gRPC 客户端: 需要 OpenTelemetry.Instrumentation.GrpcNetClient 和 OpenTelemetry.Instrumentation.Http 插桩
			//  https://github.com/open-telemetry/opentelemetry-dotnet-contrib/blob/main/src/OpenTelemetry.Instrumentation.GrpcNetClient/README.md
			//   dotnet add package --prerelease OpenTelemetry.Instrumentation.GrpcNetClient

			// [Trace] 启用 gPRC 服务端插桩
			tracing.AddAspNetCoreInstrumentation();
			// [Trace] 启用 gRPC 客户端插桩
			//tracing.AddGrpcClientInstrumentation();
			//tracing.AddHttpClientInstrumentation();
			// [Trace] 添加 Tracer
			// 在 .NET 中，“ActivitySource”是 Tracer 的实现，而 Activity 则是“Span”的实现
			tracing.AddSource(GlobalData.ProductServiceActivitySource.Name);
			if (isWithOtel)
			{
				// OTLP导出器
				tracing.AddOtlpExporter(otlpOptions =>
				{
					otlpOptions.Protocol = OpenTelemetry.Exporter.OtlpExportProtocol.Grpc;
					otlpOptions.Endpoint = new Uri(otlp_endpoint);
				});
			}
			else
			{
				// 控制台导出器
				tracing.AddConsoleExporter();
			}
		})
		.WithMetrics(metrics =>
		{
			// 对于 gRPC 服务端: 需要 OpenTelemetry.Instrumentation.AspNetCore 插桩
			//  https://github.com/open-telemetry/opentelemetry-dotnet-contrib/blob/main/src/OpenTelemetry.Instrumentation.AspNetCore/README.md
			// 对于 gRPC 客户端: 需要 OpenTelemetry.Instrumentation.GrpcNetClient 和 OpenTelemetry.Instrumentation.Http 插桩
			//  https://github.com/open-telemetry/opentelemetry-dotnet-contrib/blob/main/src/OpenTelemetry.Instrumentation.GrpcNetClient/README.md
			//   dotnet add package --prerelease OpenTelemetry.Instrumentation.GrpcNetClient

			// [Metrics] 启用 gPRC 服务端插桩
			metrics.AddAspNetCoreInstrumentation();
			// [Metrics] 添加Meter 在 .NET 中
			metrics.AddMeter(GlobalData.ProductServiceMeter.Name);
			if (isWithOtel)
			{
				// OTLP导出器
				metrics.AddOtlpExporter(otlpOptions =>
				{
					otlpOptions.Protocol = OpenTelemetry.Exporter.OtlpExportProtocol.Grpc;
					otlpOptions.Endpoint = new Uri(otlp_endpoint);
				});
			}
			else
			{
				// 控制台导出器
				metrics.AddConsoleExporter();
			}
		});

	var app = builder.Build();

	// 注册请求日志
	app.UseSerilogRequestLogging();

	// 注册gPRC服务ProductService
	app.MapGrpcService<ProductService>();
	Log.Information("已加载gPRC服务:ProductService");
	app.MapGrpcService<TransferOutService>();
	Log.Information("已加载gPRC服务:TransferOutService");
	// 注册gPRC健康检查
	app.MapGrpcHealthChecksService();
	Log.Information("已加载gPRC健康检查");
	app.MapGet("/", () => "Communication with gRPC endpoints must be made through a gRPC client. To learn how to create a client, visit: https://go.microsoft.com/fwlink/?linkid=2086909");

	// 读取环境变量
	// 判断是否启用Etcd服务注册
	string? resolve = configuration["GRPC_SERVER_RESOLVE"];
	bool isWithEtcd = false;
	if (!string.IsNullOrEmpty(resolve))
	{
		if (resolve.Equals("true"))
		{
			isWithEtcd = true;
		}
	}
	Log.Information("[.NET Core(C#)][Server] 是否启用Etcd服务发现: {isWithEtcd}", isWithEtcd);
	if (isWithEtcd)
	{
		using var scope = app.Services.CreateScope();
		var services = scope.ServiceProvider;
		// Etcd服务注册
		new EtcdRegister(configuration).Regist(services);
	}

	// 启动gPRC服务
	app.Run();
}
catch (Exception ex)
{
	Log.Fatal(ex, "gRPC服务意外终止");
}
finally
{
	Log.Information("gRPC服务停止");
	// 刷新异步日志
	Log.CloseAndFlush();
}


public class SerilogLoader
{
	// 采用漂亮打印
	public static void InitPrettyConsole()
	{
		// 初始化Serilog日志
		Log.Logger = new LoggerConfiguration()
			.Enrich.WithThreadId()
			.MinimumLevel.Information()
			// 对其他日志进行重写
			.MinimumLevel.Override("Microsoft.AspNetCore.Hosting", LogEventLevel.Warning)
			.MinimumLevel.Override("Microsoft.AspNetCore.Mvc", LogEventLevel.Warning)
			.MinimumLevel.Override("Microsoft.AspNetCore.Routing", LogEventLevel.Warning)
			//.WriteTo.Console(outputTemplate: "[{Timestamp:yyyy-MM-dd HH:mm:ss.fff}] {Level:u5} [{ThreadId}][{TraceId}][{SpanId}] - {Message:lj}{NewLine}{Exception}")
			//.WriteTo.File("D:/logs/myapp.txt", rollingInterval: RollingInterval.Day)
			.WriteTo.Async(a => a.Console(outputTemplate: "[{Timestamp:yyyy-MM-dd HH:mm:ss.fff}] {Level:u5} [{ThreadId}][{TraceId}][{SpanId}] - {Message:lj}{NewLine}{Exception}"))
			//.WriteTo.Async(a => a.File("D:/logs/myapp.log", outputTemplate: "[{Timestamp:yyyy-MM-dd HH:mm:ss.fff}] {Level:u5} [{ThreadId}][{TraceId}][{SpanId}] - {Message:lj}{NewLine}{Exception}", rollingInterval: RollingInterval.Day))
			.CreateLogger();
	}

	// 采用Json日志
	public static void InitJsonConsole()
	{
		// 初始化Serilog日志
		Log.Logger = new LoggerConfiguration()
			.Enrich.WithThreadId()
			// 添加自定义字段
			.Enrich.WithProperty("service_name", "NETCoreGrpcService")
			.MinimumLevel.Information()
			// 对其他日志进行重写
			.MinimumLevel.Override("Microsoft.AspNetCore.Hosting", LogEventLevel.Warning)
			.MinimumLevel.Override("Microsoft.AspNetCore.Mvc", LogEventLevel.Warning)
			.MinimumLevel.Override("Microsoft.AspNetCore.Routing", LogEventLevel.Warning)
			//.WriteTo.Console(new Serilog.Formatting.Json.JsonFormatter())
			//.WriteTo.File("D:/logs/myapp.txt", rollingInterval: RollingInterval.Day)
			.WriteTo.Async(a => a.Console(new Serilog.Templates.ExpressionTemplate("{ {time: @t, message: @mt, trace_id: @tr, span_id: @sp, level: @l, Exception: @x, ..@p} }\n")))
			//.WriteTo.Async(a => a.File("D:/logs/myapp.log", outputTemplate: "[{Timestamp:yyyy-MM-dd HH:mm:ss.fff}] {Level:u5} [{ThreadId}] - {Message:lj}{NewLine}{Exception}", rollingInterval: RollingInterval.Day))
			.CreateLogger();
	}
}
