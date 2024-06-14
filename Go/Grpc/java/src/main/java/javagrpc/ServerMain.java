
package javagrpc;

import io.grpc.Grpc;
import io.grpc.InsecureServerCredentials;
import io.grpc.Server;
import io.grpc.protobuf.services.HealthStatusManager;
import io.grpc.stub.StreamObserver;
import java.io.IOException;
import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.TimeUnit;
import javagrpc.ProductInfoGrpc.ProductInfoImplBase;
import javagrpc.ProductInfoPb.Product;
import javagrpc.ProductInfoPb.ProductId;

// 主类
public class ServerMain {

    // gRPC服务
    private Server server;
    // HealthCheckService
    private HealthStatusManager health;

    // 储存Product的词典
    public static Map<String, Product> productMap;

    // 启动gRPC服务
    private void start(int port) throws IOException {

        productMap = new LinkedHashMap<String, Product>();
        health = new HealthStatusManager();
        server = Grpc.newServerBuilderForPort(port, InsecureServerCredentials.create())
                .addService(new ProductServiceImpl())// 添加业务服务
                .addService(health.getHealthService())// 添加HealthCheck服务
                .build()
                .start();

        Calendar cl = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        String dtStr = sdf.format(cl.getTime());
        MessageFormat mFormat = new MessageFormat(
                "[{0}][Java][Server] Server started, listening on : {1}");
        String[] params = { dtStr, port + "" };
        System.err.println(mFormat.format(params));

        // JVM停止时运行的钩子
        Runtime.getRuntime().addShutdownHook(new Thread() {
            @Override
            public void run() {
                Calendar cl = Calendar.getInstance();
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                String dtStr = sdf.format(cl.getTime());
                MessageFormat mFormat = new MessageFormat(
                        "[{0}][Java][Server] shutting down gRPC server since JVM is shutting down");
                String[] params = { dtStr };
                System.err.println(mFormat.format(params));
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

    // 程序主入口
    public static void main(String[] args) throws IOException, InterruptedException {
        // 服务端口，如果参数传入则使用，默认50051
        int port = 50051;
        if (args.length > 0) {
            try {
                port = Integer.parseInt(args[0]);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        final ServerMain server = new ServerMain();
        // 启动gRPC服务
        server.start(port);
        server.blockUntilShutdown();
    }

    // 实现业务逻辑
    private static class ProductServiceImpl extends ProductInfoImplBase {

        // 添加Product
        @Override
        public void addProduct(Product request, StreamObserver<ProductId> responseObserver) {
            UUID uuid = UUID.randomUUID();
            Product info = Product.newBuilder()
                    .setId(uuid.toString())
                    .setName(request.getName())
                    .setDescription(request.getDescription())
                    .build();
            ServerMain.productMap.put(info.getId(), info);

            Calendar cl = Calendar.getInstance();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            String dtStr = sdf.format(cl.getTime());
            MessageFormat mFormat = new MessageFormat(
                    "[{0}][Java][Server] AddProduct success . id: {1}, name: {2}, description: {3}");
            String[] params = { dtStr, info.getId(), info.getName(), info.getDescription() };
            System.err.println(mFormat.format(params));

            ProductId id = ProductId.newBuilder().setValue(uuid.toString()).build();
            responseObserver.onNext(id);
            responseObserver.onCompleted();
        }

        // 取得Product
        @Override
        public void getProduct(ProductId request, StreamObserver<Product> responseObserver) {
            if (ServerMain.productMap == null) {
                ServerMain.productMap = new LinkedHashMap<String, Product>();
            }
            Product respon = ServerMain.productMap.get(request.getValue());
            if (respon == null) {
                // 没有取到时
                respon = Product.newBuilder()
                        .setId("None Id")
                        .setName("None Name")
                        .setDescription("Java gRPC Server")
                        .build();
            }

            Calendar cl = Calendar.getInstance();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            String dtStr = sdf.format(cl.getTime());
            MessageFormat mFormat = new MessageFormat(
                    "[{0}][Java][Server] GetProduct success . id: {1}");
            String[] params = { dtStr, respon.getId() };
            System.err.println(mFormat.format(params));

            responseObserver.onNext(respon);
            responseObserver.onCompleted();
        }
    }
}