using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Grpc.Core;
using Grpc.Health.V1;
using GrpcDemo;
using static Grpc.Health.V1.Health;
using static Grpc.Health.V1.HealthCheckResponse.Types;

namespace netframeworkClientAsync
{
	class ClientMainAsync
	{
		// 程序主入口
		public static async Task Main(string[] args)
		{
			if (args.Length == 0)
			{
			}
			// 创建gRPC客户端
			// 没有负载均衡器的例子
			// var channel = new Channel("127.0.0.1", port, ChannelCredentials.Insecure);
			// 使用负责均衡器的例子
			// https://github.com/grpc/grpc/blob/master/doc/service_config.md
			var channelOptions = new List<ChannelOption>
			{
				new ChannelOption("grpc.lb_policy_name", "round_robin"),
				new ChannelOption("grpc.service_config", "{\"serviceConfig\":{\"loadBalancingConfig\":{ \"round_robin\": {} },\"waitForReady\":true}}")
			};
			// 因为是基于C-Core的实现，所以可以用如下写法 ipv4:address[:port][,address[:port],...
			// https://github.com/grpc/grpc/blob/master/doc/naming.md
			// 下面这个设定使用了本地的 [50051 - 50054] 4个端口，轮询调用
			var channel = new Channel("ipv4:127.0.0.1:50051,127.0.0.1:50052,127.0.0.1:50053,127.0.0.1:50054", ChannelCredentials.Insecure, channelOptions);

			// 业务请求客户端
			ProductInfo.ProductInfoClient client = new ProductInfo.ProductInfoClient(channel);
			// HealthCheck客户端
			HealthClient healthClient = new Grpc.Health.V1.Health.HealthClient(channel);

			for (int i = 0; i < 5; i++)
			{
				// 添加商品
				AddProductAsync(client);

				// 取得商品
				GetProductAsync(client, "123");
			}

			// 检查服务状态
			HealthCheckAsync(healthClient);

			// 关闭频道
			await channel.ShutdownAsync();
		}


		// 添加商品（非阻塞异步方式）
		public static void AddProductAsync(ProductInfo.ProductInfoClient client)
		{
			// 参数可以传递给一个一个调用，也可以组合。使用流畅的语法转换为 CallOptions。
			var callOptions = new CallOptions()
				//.WithCancellationToken(CancellationToken.None)
				//.WithDeadline(DateTime.UtcNow.AddMinutes(2))
				//.WithHeaders(Metadata.Empty)
				.WithWaitForReady(true);

			// 异步服务调用
			AsyncUnaryCall<ProductId> call = client.addProductAsync(new Product { Name = "Mac Book Air 2020", Description = "Add by .net Framework(C#)" }, callOptions);
			// 设定回调函数
			var awaiter = call.GetAwaiter();
			awaiter.OnCompleted(() =>
			{
				ProductId result = call.ResponseAsync.Result;
				DateTime dtNow = DateTime.Now;
				string dtStr = dtNow.ToString("yyyy/MM/dd HH:mm:ss");
				Console.WriteLine("[{0}][.net Framework(C#)][Client] Add product success. id = {1}", dtStr, result.Value);
			});
		}

		// 取得商品（非阻塞异步方式）
		public static void GetProductAsync(ProductInfo.ProductInfoClient client, String pidStr)
		{
			// 参数可以传递给一个一个调用，也可以组合。使用流畅的语法转换为 CallOptions。
			var callOptions = new CallOptions()
				//.WithCancellationToken(CancellationToken.None)
				//.WithDeadline(DateTime.UtcNow.AddMinutes(2))
				//.WithHeaders(Metadata.Empty)
				.WithWaitForReady(true);

			ProductId pid = new ProductId { Value = pidStr };
			// 异步服务调用
			AsyncUnaryCall<Product> call = client.getProductAsync(pid, callOptions);
			// 设定回调函数
			var awaiter = call.GetAwaiter();
			awaiter.OnCompleted(() =>
			{
				Product result = call.ResponseAsync.Result;
				DateTime dtNow = DateTime.Now;
				string dtStr = dtNow.ToString("yyyy/MM/dd HH:mm:ss");
				Console.WriteLine("[{0}][.net Framework(C#)][Client] GetProduct success", dtStr);
				Console.WriteLine(result);
			});
		}

		//健康检查（非阻塞异步方式）
		public static void HealthCheckAsync(HealthClient client)
		{
			// HealthCheck检查的服务名为空
			AsyncUnaryCall<HealthCheckResponse> call = client.CheckAsync(new HealthCheckRequest { Service = "" });
			// 设定回调函数
			var awaiter = call.GetAwaiter();
			awaiter.OnCompleted(() =>
			{
				HealthCheckResponse result = call.ResponseAsync.Result;
				DateTime dtNow = DateTime.Now;
				string dtStr = dtNow.ToString("yyyy/MM/dd HH:mm:ss");
				Console.WriteLine("[{0}][.net Framework(C#)][Client] Health Checking... gRPC Server status: [{1}]", dtStr, result.Status);
			});
		}
	}
}
