using Grpc.Core;
using GrpcDemo;
using Serilog;
using System.Diagnostics;
using System.Diagnostics.Metrics;

namespace netcoreServer.Services;

public class ProductService : ProductInfo.ProductInfoBase
{
	// appsettings.json 配置文件
	private readonly IConfiguration _configuration;
	private readonly bool _isWithOtel;

	public ProductService(IConfiguration configuration)
	{
		_configuration = configuration;
		// 读取环境变量
		// 判断是否启用Otel检测
		string? otel = _configuration["GRPC_SERVER_OTEL"];
		_isWithOtel = false;
		if (!string.IsNullOrEmpty(otel))
		{
			if (otel.Equals("true"))
			{
				_isWithOtel = true;
			}
		}
	}

	// 添加商品
	public override Task<ProductId> addProduct(Product request, ServerCallContext context)
	{
		// 取得端口
		var httpContext = context.GetHttpContext();
		int port = httpContext.Connection.LocalPort;
		// Log.Information("当前监听端口为: {Port}", port);

		if (_isWithOtel)
		{
			// 获取元数据
			var metadata = context.RequestHeaders;
			string? traceId = metadata.GetValue("trace_id");
			string? spanId = metadata.GetValue("span_id");
			// W3C traceParent 格式： 00-trace_id-span_id-trace_flag
			// 例子：00-cd1f21834fb5b0c7271c9a89f09f94b8-51ef9c893beb9272-01
			string traceParent = $"00-{traceId}-{spanId}-01";
			// 在 .NET 中，“ActivitySource”是 Tracer 的实现，而 Activity 则是“Span”的实现
			if (TryParseActivityContext(traceParent, "", isRemote: true, out ActivityContext activityContext))
			{
				using (var span = GlobalData.ProductServiceActivitySource.StartActivity("addProduct", ActivityKind.Internal, activityContext))
				{
					// [Metric]计数器
					Counter<long> counter = GlobalData.ProductServiceMeter.CreateCounter<long>(name: "netcoregrpc_otel_addproduct_call",description: "Counts the call of addProduct");
					//Log.Information("[.NET Core(C#)][Server] AddProduct start. traceParent={traceParent}", traceParent);
					ProductId productId = addProductLogic(request, port);
					// [Metric]计数器+1
					counter.Add(1);
					return Task.FromResult(productId);
				}
			}
			else
			{
				ProductId productId = addProductLogic(request, port);
				return Task.FromResult(productId);
			}
		}
		else
		{
			ProductId productId = addProductLogic(request, port);
			return Task.FromResult(productId);
		}
	}

	// 添加商品实际逻辑
	private ProductId addProductLogic(Product request, int port)
	{
		string pid = Guid.NewGuid().ToString() + " | ServerPort: " + port.ToString();
		request.Id = pid;
		// 使用读写锁写入全局Product的词典
		GlobalData.WriteProductMap(request.Id, request);

		// 延迟2秒（1800毫秒）
		//Task.Delay(1800);
		Thread.Sleep(1800);

		Log.Information("[.NET Core(C#)][Server] AddProduct success. id={id}, name={name}, description={description}", request.Id, request.Name, request.Description);
		return new ProductId { Value = request.Id };
	}

	// 获取商品
	public override Task<Product> getProduct(ProductId request, ServerCallContext context)
	{
		if (_isWithOtel)
		{
			// 获取元数据
			var metadata = context.RequestHeaders;
			string? traceId = metadata.GetValue("trace_id");
			string? spanId = metadata.GetValue("span_id");
			// W3C traceParent 格式： 00-trace_id-span_id-trace_flag
			// 例子：00-cd1f21834fb5b0c7271c9a89f09f94b8-51ef9c893beb9272-01
			string traceParent = $"00-{traceId}-{spanId}-01";
			// 在 .NET 中，“ActivitySource”是 Tracer 的实现，而 Activity 则是“Span”的实现
			if (TryParseActivityContext(traceParent, "", isRemote: true, out ActivityContext activityContext))
			{
				using (var span = GlobalData.ProductServiceActivitySource.StartActivity("getProduct", ActivityKind.Internal, activityContext))
				{
					//Log.Information("[.NET Core(C#)][Server] GetProduct start. traceParent={traceParent}", traceParent);
					Product product = getProductLogic(request.Value);
					return Task.FromResult(product);
				}
			}
			else
			{
				Product product = getProductLogic(request.Value);
				return Task.FromResult(product);
			}
		}
		else
		{
			Product product = getProductLogic(request.Value);
			return Task.FromResult(product);
		}
	}

	// 获取商品实际逻辑
	private Product getProductLogic(string pid)
	{
		// 使用读写锁读取全局Product的词典
		Product? product;
		if (GlobalData.ReadProductMap().TryGetValue(pid, out var _))
		{
			product = GlobalData.ReadProductMap()[pid];
		}
		else
		{
			product = new Product() { Id = "None ID", Name = "None Name", Description = ".NET Core(C#) gRPC Server" };
		}
		// 延迟2秒（2300毫秒）
		//Task.Delay(2300);
		Thread.Sleep(2300);
		Log.Information("[.NET Core(C#)][Server] GetProduct success. id={id}", product.Id);
		return product;
	}

	// 根据 traceParent 取得 ActivityContext（在一个已存的 Trace 下创建新的 Span）
	public static bool TryParseActivityContext(string? traceParent, string? traceState, bool isRemote, out ActivityContext context)
	{
		if (ActivityContext.TryParse(traceParent, traceState, out context))
		{
			context = new ActivityContext(context.TraceId, context.SpanId, context.TraceFlags, context.TraceState, isRemote);
			return true;
		}
		return false;
	}
}
