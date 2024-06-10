
package javagrpc;

import io.grpc.ManagedChannel;
import io.grpc.ManagedChannelBuilder;
import io.grpc.NameResolverRegistry;
import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.concurrent.TimeUnit;
import javagrpc.ProductInfoPb.Product;
import javagrpc.ProductInfoPb.ProductId;

public class ClientMain {
    // 远程连接管理器,管理连接的生命周期
    private final ManagedChannel channel;
    private final ProductInfoGrpc.ProductInfoBlockingStub blockingStub;

    public ClientMain() {

        // 没有负载均衡器的例子
        // String host = "127.0.0.1";
        // int port = 50051;
        // channel = ManagedChannelBuilder.forAddress(host,
        // port).usePlaintext().build();
        // 使用负责均衡器的例子(nameResolverFactory官方已弃用)
        // NameResolver.Factory nameResolverFactory = new
        // MultiAddressNameResolverFactory(
        // new InetSocketAddress("127.0.0.1", 50051),
        // new InetSocketAddress("127.0.0.1", 50052),
        // new InetSocketAddress("127.0.0.1", 50053),
        // new InetSocketAddress("127.0.0.1", 50054));
        // channel = ManagedChannelBuilder.forTarget("service")
        // .nameResolverFactory(nameResolverFactory)
        // .defaultLoadBalancingPolicy("round_robin")
        // .usePlaintext()
        // .build();
        // 使用负责均衡器的例子
        NameResolverRegistry.getDefaultRegistry().register(new MultiAddressNameResolverProvider());
        String target = String.format("%s:///%s", MultiAddressNameResolverProvider.MultiAddressScheme,
                MultiAddressNameResolverProvider.MultiAddressServiceName);
        channel = ManagedChannelBuilder.forTarget(target).defaultLoadBalancingPolicy("round_robin").usePlaintext()
                .build();
        // 初始化远程服务Stub
        blockingStub = ProductInfoGrpc.newBlockingStub(channel);
    }

    public void shutdown() throws InterruptedException {
        // 关闭连接
        channel.shutdown().awaitTermination(5, TimeUnit.SECONDS);
    }

    public String addProduct(String name, String description) {
        // 构造服务调用参数对象
        Product request = Product.newBuilder().setName(name).setDescription(description).build();
        // 调用远程服务方法
        ProductId response = blockingStub.addProduct(request);
        // 返回值
        return response.getValue();
    }

    public Product getProduct(String id) {
        // 构造服务调用参数对象
        ProductId request = ProductId.newBuilder().setValue(id).build();
        // 调用远程服务方法
        Product response = blockingStub.getProduct(request);
        // 返回值
        return response;
    }

    public static void main(String[] args) throws InterruptedException {
        ClientMain client = new ClientMain();

        for (int i = 0; i < 5; i++) {
            // 服务调用
            String addId = client.addProduct("Mac Book Pro 2021", "Add by Java");
            // 打印调用结果
            Calendar cl = Calendar.getInstance();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            String dtStr = sdf.format(cl.getTime());
            MessageFormat mFormat = new MessageFormat(
                    "[{0}][Java][Client] Add product success, id = {1}");
            String[] params = { dtStr, addId };
            System.out.println(mFormat.format(params));

            Thread.sleep(1000);

            Product product = client.getProduct(addId);
            cl = Calendar.getInstance();
            sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            dtStr = sdf.format(cl.getTime());
            mFormat = new MessageFormat(
                    "[{0}][Java][Client] Get product success, id = {1}, name = {2}, description = {3}");
            String[] params2 = { dtStr, product.getId(), product.getName(), product.getDescription() };
            System.out.println(mFormat.format(params2));

            Thread.sleep(1000);
        }
        // 关闭连接
        client.shutdown();
    }
}