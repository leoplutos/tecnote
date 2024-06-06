using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Grpc.Core;
using GrpcDemo;

namespace netframeworkClient
{
    // 主类
    class ClientMain
    {
        private const int port = 50051;

        // 程序主入口
        public static async Task Main(string[] args)
        {
            // 创建gRPC客户端
            var channel = new Channel("127.0.0.1", port, ChannelCredentials.Insecure);
            ProductInfo.ProductInfoClient client = new ProductInfo.ProductInfoClient(channel);

            // 添加商品
            ProductId pid = AddProduct(client);

            // 取得商品
            await GetProductAsync(client, pid);

            // 关闭频道
            await channel.ShutdownAsync();
        }

        public static ProductId AddProduct(ProductInfo.ProductInfoClient client)
        {
            ProductId result = client.addProduct(new Product { Name = "Mac Book Air 2020", Description = "Add by .net Framework(C#)" });
            Console.WriteLine("[.net Framework(C#)][Client] Add product success. id = {0}", result.Value);
            return result;
        }

        public static async Task GetProductAsync(ProductInfo.ProductInfoClient client, ProductId pid)
        {
            Product result = await client.getProductAsync(pid);
            Console.WriteLine("[.net Framework(C#)][Client] GetProduct success");
            Console.WriteLine(result);
        }
    }
}
