using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using AspWebapi.Common;
using AspWebapi.Models;
using AspWebapi.Services;
using Serilog;
using Serilog.Events;

//######################################
// Web服务启动主入口
//######################################

// 初始化Serilog日志
Log.Logger = new LoggerConfiguration()
	.Enrich.WithThreadId()
	.MinimumLevel.Information()
	// 对其他日志进行重写
	.MinimumLevel.Override("Microsoft.AspNetCore.Hosting", LogEventLevel.Warning)
	.MinimumLevel.Override("Microsoft.AspNetCore.Mvc", LogEventLevel.Warning)
	.MinimumLevel.Override("Microsoft.AspNetCore.Routing", LogEventLevel.Warning)
	//.WriteTo.Console(outputTemplate: "[{Timestamp:yyyy-MM-dd HH:mm:ss.fff}] {Level:u5} [{ThreadId}][{SourceContext:l}] - {Message:lj}{NewLine}{Exception}")
	//.WriteTo.File("D:/logs/myapp.txt", rollingInterval: RollingInterval.Day)
	.WriteTo.Async(a => a.Console(outputTemplate: "[{Timestamp:yyyy-MM-dd HH:mm:ss.fff}] {Level:u5} [{ThreadId}] - {Message:lj}{NewLine}{Exception}"))
	//.WriteTo.Async(a => a.File("D:/logs/myapp.log", outputTemplate: "[{Timestamp:yyyy-MM-dd HH:mm:ss.fff}] {Level:u5} [{ThreadId}] - {Message:lj}{NewLine}{Exception}", rollingInterval: RollingInterval.Day))
	.CreateLogger();

try
{
	Log.Information("开始启动Web服务");

	// Web应用对象
	var builder = WebApplication.CreateBuilder(args);

	// 密钥将保存到 %LOCALAPPDATA%\ASP.NET\DataProtection-Keys 文件夹中
	// 更多: https://learn.microsoft.com/zh-cn/aspnet/core/security/data-protection/configuration/default-settings?view=aspnetcore-8.0

	// 配置
	var configuration = builder.Configuration;
	// 判断是否启用Postgre数据库
	string? usePostgre = configuration["ASPNETCORE_IS_USE_POSTGRE"];
	bool isUsePostgre = false;
	if (!string.IsNullOrEmpty(usePostgre))
	{
		if (usePostgre.Equals("true"))
		{
			isUsePostgre = true;
		}
	}
	Log.Information("是否启用Postgre数据库连接: {isUsePostgre}", isUsePostgre);

	// 注册日志
	builder.Services.AddSerilog();
	// 注册控制器
	builder.Services.AddControllers();
	// 注册WebApi
	builder.Services.AddEndpointsApiExplorer();
	// 注册In-Memory数据库
	builder.Services.AddDbContext<TodoDbContext>(options => options.UseInMemoryDatabase(databaseName: "todo"));
	// 注册Sqlite数据库
	// string? connectionString = builder.Configuration.GetConnectionString("todo") ?? "Data Source=todo.db";
	// builder.Services.AddSqlite<TodoDbContext>(connectionString);
	if (isUsePostgre)
	{
		// 注册Postgre数据库(EF Core)
		var postgreConStr = configuration["DataSource:Postgre:ConnectionString"];
		// 这里使用了明文报错数据库信息, 如果为了安全请参考官方文档
		// https://learn.microsoft.com/zh-cn/aspnet/core/security/app-secrets?view=aspnetcore-8.0&tabs=windows
		Log.Information("Postgre连接URL: {connString}", postgreConStr);
		builder.Services.AddDbContextPool<PostgreDbContext>(options => options.UseNpgsql(postgreConStr)
		//	,
		// option => option
		// 	.SetPostgresVersion(17, 0)
		// 	.UseNodaTime()
		// 	.MapEnum<Mood>("mood"));
		);
		Log.Information("Postgre数据库池化结束");
	}

	// 开启跨域支持
	var allowOrigins = "_allowOrigins";
	builder.Services.AddCors(options =>
	{
		options.AddPolicy(name: allowOrigins,
							policy =>
							{
								// policy.WithOrigins("http://example.com",
								// 					"http://www.contoso.com");
								policy.WithOrigins("*");
							});
	});

	// 注册Swagger
	// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
	builder.Services.AddSwaggerGen();

	// 注册Service层
	// https://learn.microsoft.com/zh-cn/aspnet/core/fundamentals/dependency-injection?view=aspnetcore-8.0
	builder.Services.AddScoped<ITodoListService, TodoListService>();
	builder.Services.AddScoped<ILoginService, LoginService>();
	if (isUsePostgre)
	{
		builder.Services.AddScoped<IEmployeeService, EmployeeService>();
	}

	//注册Jwt服务
	_ = builder.Services.AddAuthentication(options =>
	{
		options.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
	})
	.AddJwtBearer(options =>
	{
		options.Events = new JwtBearerEvents()
		{
			// 重要：自定义Token获取方式
			OnMessageReceived = context =>
			{
				// 自定义从请求头内的[token]取得授权
				context.Token = context.Request.Headers["token"];
				return Task.CompletedTask;
			}
		};
		options.TokenValidationParameters = new TokenValidationParameters()
		{
			ValidateIssuer = true, //是否验证Issuer
			ValidIssuer = configuration["Jwt:Issuer"], //发行人Issuer
			ValidateAudience = true, //是否验证Audience
			ValidAudience = configuration["Jwt:Audience"], //订阅人Audience
			ValidateIssuerSigningKey = true, //是否验证SecurityKey
			IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(configuration["Jwt:SecretKey"] ?? "")), //SecurityKey
			ValidateLifetime = true, //是否验证失效时间
			ClockSkew = TimeSpan.FromSeconds(30), //过期时间容错值，解决服务器端时间不同步问题（秒）
			RequireExpirationTime = true,
		};
	});
	// 将 JwtHelper 注册为单例模式
	builder.Services.AddSingleton(new JwtHelper(configuration));

	// 添加NewtonsoftJson支持
	builder.Services.AddControllers().AddNewtonsoftJson();

	var app = builder.Build();

	// Configure the HTTP request pipeline.
	if (app.Environment.IsDevelopment())
	{
		// 只在开发环境开放Swagger
		app.UseSwagger();
		app.UseSwaggerUI();
	}

	// 注册请求日志
	app.UseSerilogRequestLogging();

	// 禁用HTTPS（生产环境要打开）
	// app.UseHttpsRedirection();

	// 开启跨域
	app.UseCors(allowOrigins);

	// 注册 UseAuthentication（认证） 必须在前面调用
	app.UseAuthentication();
	// 注册 UseAuthorization（授权）
	app.UseAuthorization();

	// 注册控制器到Endpoint
	app.MapControllers();

	// 内存数据库初始化数据
	using (var scope = app.Services.CreateScope())
	{
		var services = scope.ServiceProvider;
		var context = services.GetRequiredService<TodoDbContext>();
		// 在Initialize函数初始化
		DBDataGenerator.Initialize(services);
	}

	// 启动Web服务
	app.Run();
}
catch (Exception ex)
{
	Log.Error(ex, "Web服务意外终止");
}
finally
{
	Log.Information("Web服务停止");
	// 刷新异步日志
	Log.CloseAndFlush();
}
