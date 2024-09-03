using Grpc.Core;
using GrpcDemo;
using Serilog;

namespace netcoreServer.Services;

public class ProductService : ProductInfo.ProductInfoBase
{
	// appsettings.json 配置文件
	private readonly IConfiguration _configuration;

	public ProductService(IConfiguration configuration)
	{
		_configuration = configuration;
	}

	// 添加商品
	public override Task<ProductId> addProduct(Product request, ServerCallContext context)
	{
		// 取得端口
		var httpContext = context.GetHttpContext();
		int port = httpContext.Connection.LocalPort;
		// Log.Information("当前监听端口为: {Port}", port);

		string pid = Guid.NewGuid().ToString() + " | ServerPort: " + port.ToString();
		request.Id = pid;
		GlobalData.GlobalDictionary.TryAdd(request.Id, request);

		// 延迟2秒（2000毫秒）
		//Task.Delay(2000);
		Thread.Sleep(2000);

		Log.Information("[.NET Core(C#)][Server] AddProduct success. id={id}, name={name}, description={description}", request.Id, request.Name, request.Description);
		Log.Information("request={request}", request);
		return Task.FromResult(new ProductId { Value = request.Id });
	}

	// 获取商品
	public override Task<Product> getProduct(ProductId request, ServerCallContext context)
	{
		Product? info;
		if (GlobalData.GlobalDictionary.TryGetValue(request.Value, out var _))
		{
			info = GlobalData.GlobalDictionary[request.Value];
		}
		else
		{
			info = new Product() { Id = "None ID", Name = "None Name", Description = ".NET Core(C#) gRPC Server" };
		}

		// 延迟2秒（2000毫秒）
		//Task.Delay(2000);
		Thread.Sleep(2000);

		Log.Information("[.NET Core(C#)][Server] GetProduct success. id={id}", request.Value);
		Log.Information("Product={Product}", info);
		return Task.FromResult(info);
	}
}
