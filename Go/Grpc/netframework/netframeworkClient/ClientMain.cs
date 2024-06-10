using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
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

            // 没有负载均衡器的例子
            // var channel = new Channel("127.0.0.1", port, ChannelCredentials.Insecure);
            // 使用负责均衡器的例子
            // https://github.com/grpc/grpc/blob/master/doc/service_config.md
            var channelOptions = new List<ChannelOption>();
            channelOptions.Add(new ChannelOption("grpc.lb_policy_name", "round_robin"));
            channelOptions.Add(new ChannelOption("grpc.service_config", "{\"serviceConfig\":{\"loadBalancingConfig\":{ \"round_robin\": {} },\"waitForReady\":true}}"));
            // 因为是基于C-Core的实现，所以可以用如下写法 ipv4:address[:port][,address[:port],...
            // https://github.com/grpc/grpc/blob/master/doc/naming.md
            // 下面这个设定使用了本地的 [50051 - 50054] 4个端口，轮询调用
            var channel = new Channel("ipv4:127.0.0.1:50051,127.0.0.1:50052,127.0.0.1:50053,127.0.0.1:50054", ChannelCredentials.Insecure, channelOptions);

            ProductInfo.ProductInfoClient client = new ProductInfo.ProductInfoClient(channel);

            for (int i = 0; i < 5; i++)
            {
                // 添加商品
                ProductId pid = AddProduct(client);

                Thread.Sleep(1000);

                // 取得商品
                //GetProduct(client, pid);
                await GetProductAsync(client, pid);

                Thread.Sleep(1000);
            }

            // 关闭频道
            await channel.ShutdownAsync();
        }

        public static ProductId AddProduct(ProductInfo.ProductInfoClient client)
        {
            ProductId result = client.addProduct(new Product { Name = "Mac Book Air 2020", Description = "Add by .net Framework(C#)" });
            DateTime dtNow = DateTime.Now;
            string dtStr = dtNow.ToString("yyyy/MM/dd HH:mm:ss");
            Console.WriteLine("[{0}][.net Framework(C#)][Client] Add product success. id = {1}", dtStr, result.Value);
            return result;
        }


        public static void GetProduct(ProductInfo.ProductInfoClient client, ProductId pid)
        {
            Product result = client.getProduct(pid);
            DateTime dtNow = DateTime.Now;
            string dtStr = dtNow.ToString("yyyy/MM/dd HH:mm:ss");
            Console.WriteLine("[{0}][.net Framework(C#)][Client] GetProduct success", dtNow);
            Console.WriteLine(result);
        }

        public static async Task GetProductAsync(ProductInfo.ProductInfoClient client, ProductId pid)
        {
            Product result = await client.getProductAsync(pid);
            DateTime dtNow = DateTime.Now;
            string dtStr = dtNow.ToString("yyyy/MM/dd HH:mm:ss");
            Console.WriteLine("[{0}][.net Framework(C#)][Client] GetProduct success", dtNow);
            Console.WriteLine(result);
        }
    }
}
