using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Grpc.Core;
using GrpcDemo;

namespace netframeworkServer
{
    // 主类
    class ServerMain
    {
        private const string host = "0.0.0.0";
        private const int port = 50051;

        // 程序主入口
        public static async Task Main(string[] args)
        {
            // 启动gRPC服务
            Server server = new Server
            {
                Services = { ProductInfo.BindService(new ProductServiceImpl()) },
                Ports = { { host, port, ServerCredentials.Insecure } }
            };
            server.Start();


            Console.WriteLine("[.net Framework(C#)][Server] gRPC 服务端已开启，端口为:{0}:{1}", host, port);
            Console.WriteLine("[.net Framework(C#)][Server] 按任意键结束gRPC 服务端...");
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
            Console.WriteLine("[.net Framework(C#)][Server] AddProduct success. id = {0}", request.Id);
            Console.WriteLine(request);
            return Task.FromResult(new ProductId { Value = request.Id });
        }

        // 取得Product
        public override Task<Product> getProduct(ProductId request, ServerCallContext context)
        {
            Product info = productDict[request.Value];
            Console.WriteLine("[.net Framework(C#)][Server] GetProduct success. id = {0}", request.Value);
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
