
package javagrpc;

import io.grpc.ManagedChannel;
import io.grpc.ManagedChannelBuilder;
import java.util.concurrent.TimeUnit;
import javagrpc.ProductInfoPb.Product;
import javagrpc.ProductInfoPb.ProductId;

public class ClientMain {
    // 远程连接管理器,管理连接的生命周期
    private final ManagedChannel channel;
    private final ProductInfoGrpc.ProductInfoBlockingStub blockingStub;

    public ClientMain(String host, int port) {
        // 初始化连接
        channel = ManagedChannelBuilder.forAddress(host, port)
                      .usePlaintext()
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
        ClientMain client = new ClientMain("127.0.0.1", 50051);
        // 服务调用
        String addId = client.addProduct("Mac Book Pro 2021", "Add by Java");
        // 打印调用结果
        System.out.println("[Java][Client] Add product success, id=" + addId);
        Product product = client.getProduct(addId);
        System.out.println("[Java][Client] Get product success, id:" + product.getId() + ", name:" + product.getName() + ", description:" + product.getDescription());
        // 关闭连接
        client.shutdown();
    }
}
