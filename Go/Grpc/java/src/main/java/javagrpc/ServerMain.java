
package javagrpc;

import io.grpc.Server;
import io.grpc.ServerBuilder;
import io.grpc.stub.StreamObserver;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.TimeUnit;
import javagrpc.ProductInfoGrpc.ProductInfoImplBase;
import javagrpc.ProductInfoPb.Product;
import javagrpc.ProductInfoPb.ProductId;

public class ServerMain {
    private Server server;
    public static Map<String, Product> productMap;
    private void start() throws IOException {
        int port = 50051;
        productMap = new LinkedHashMap<String, Product>();
        server = ServerBuilder.forPort(port)
                     .addService(new ProductInfoImpl()) // 这里可以添加多个模块
                     .build()
                     .start();
        System.out.println("[Java][Server] Server started, listening on :" + port);
        Runtime.getRuntime().addShutdownHook(new Thread() {
            @Override
            public void run() {
                System.err.println("[Java][Server] shutting down gRPC server since JVM is shutting down");
                try {
                    ServerMain.this.stop();
                } catch (InterruptedException e) {
                    e.printStackTrace(System.err);
                }
                System.err.println("[Java][Server] server shut down");
            }
        });
    }

    private void stop() throws InterruptedException {
        if (server != null) {
            server.shutdown().awaitTermination(30, TimeUnit.SECONDS);
        }
    }

    private void blockUntilShutdown() throws InterruptedException {
        if (server != null) {
            server.awaitTermination();
        }
    }

    public static void main(String[] args) throws IOException, InterruptedException {
        final ServerMain server = new ServerMain();
        server.start();
        server.blockUntilShutdown();
    }

    private static class ProductInfoImpl extends ProductInfoImplBase {
        @Override
        public void addProduct(Product request, StreamObserver<ProductId> responseObserver) {
            UUID uuid = UUID.randomUUID();
            Product info = Product.newBuilder()
                               .setId(uuid.toString())
                               .setName(request.getName())
                               .setDescription(request.getDescription())
                               .build();
            ServerMain.productMap.put(info.getId(), info);
            System.out.println("[Java][Server] AddProduct success . id:" + info.getId() + ", name:" + info.getName() + ", description:" + info.getDescription());
            ProductId id = ProductId.newBuilder().setValue(uuid.toString()).build();
            responseObserver.onNext(id);
            responseObserver.onCompleted();
        }

        @Override
        public void getProduct(ProductId request, StreamObserver<Product> responseObserver) {
            if (ServerMain.productMap == null) {
                ServerMain.productMap = new LinkedHashMap<String, Product>();
            }
            Product respon = ServerMain.productMap.get(request.getValue());
            System.out.println("[Java][Server] GetProduct success . id:" + request.getValue());
            responseObserver.onNext(respon);
            responseObserver.onCompleted();
        }
    }
}
