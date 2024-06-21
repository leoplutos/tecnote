using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Grpc.Core;
using Grpc.HealthCheck;
using GrpcDemo;
using static Grpc.Health.V1.HealthCheckResponse.Types;

namespace netframeworkServer
{
	// 主类
	class ServerMain
	{
		private const string host = "0.0.0.0";

		// 程序主入口
		public static async Task Main(string[] args)
		{
			int port = 50051;
			if (args.Length > 0)
			{
				try
				{
					port = int.Parse(args[0]);
				}
				catch (Exception e)
				{
					Console.WriteLine(e.Message);
				}
			}

			// 启动gRPC服务
			Server server = new Server(new[] { new ChannelOption(ChannelOptions.SoReuseport, 0) })
			{
				Services = { },
				Ports = { { host, port, ServerCredentials.Insecure } }
			};
			// 添加业务服务
			server.Services.Add(ProductInfo.BindService(new ProductServiceImpl()));
			// 添加HealthCheck服务
			var serviceImpl = new HealthServiceImpl();
			// HealthCheck检查的服务名为空,返回内容为SERVING
			serviceImpl.SetStatus("", ServingStatus.Serving);
			server.Services.Add(Grpc.Health.V1.Health.BindService(serviceImpl));

			// 启动gRPC
			server.Start();

			DateTime dtNow = DateTime.Now;
			string dtStr = dtNow.ToString("yyyy/MM/dd HH:mm:ss");
			Console.WriteLine("[{0}][.net Framework(C#)][Server] gRPC 服务端已开启，端口为:{1}:{2}", dtStr, host, port);
			Console.WriteLine("[{0}][.net Framework(C#)][Server] 按任意键结束gRPC 服务端...", dtStr);
			Console.ReadKey();

			await server.ShutdownAsync();
		}
	}

	// 实现业务逻辑
	public class ProductServiceImpl : ProductInfo.ProductInfoBase
	{
		// 储存Product的词典
		private Dictionary<string, Product> productDict = new Dictionary<string, Product>();

		// 添加Product
		public override Task<ProductId> addProduct(Product request, ServerCallContext context)
		{
			request.Id = Guid.NewGuid().ToString();
			productDict.Add(request.Id, request);

			// 延迟2秒（2000毫秒）
			Thread.Sleep(2000);

			DateTime dtNow = DateTime.Now;
			string dtStr = dtNow.ToString("yyyy/MM/dd HH:mm:ss");
			Console.WriteLine("[{0}][.net Framework(C#)][Server] AddProduct success. id = {1}, name: {2}, description: {3}", dtStr, request.Id, request.Name, request.Description);
			Console.WriteLine(request);
			return Task.FromResult(new ProductId { Value = request.Id });
		}

		// 取得Product
		public override Task<Product> getProduct(ProductId request, ServerCallContext context)
		{
			Product info;
			if (productDict.ContainsKey(request.Value))
			{
				info = productDict[request.Value];
			}
			else
			{
				info = new Product() { Id = "None ID", Name = "None Name", Description = ".net Framework(C#) gRPC Server" };
			}

			// 延迟2秒（2000毫秒）
			Task.Delay(2000);

			DateTime dtNow = DateTime.Now;
			string dtStr = dtNow.ToString("yyyy/MM/dd HH:mm:ss");
			Console.WriteLine("[{0}][.net Framework(C#)][Server] GetProduct success. id = {0}", dtStr, request.Value);
			Console.WriteLine(info);
			return Task.FromResult(info);
		}

		// 访问器
		public Dictionary<string, Product> ProductDict
		{
			get { return productDict; }
			set { productDict = value; }
		}
	}
}
