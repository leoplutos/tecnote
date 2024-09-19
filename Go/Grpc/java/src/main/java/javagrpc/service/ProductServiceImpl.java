package javagrpc.service;

import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import io.grpc.stub.StreamObserver;
import javagrpc.grpc.stub.ProductInfoGrpc.ProductInfoImplBase;
import javagrpc.grpc.stub.ProductInfoPb.Product;
import javagrpc.grpc.stub.ProductInfoPb.ProductId;
import javagrpc.main.ServerMain;

// 实现业务逻辑
public class ProductServiceImpl extends ProductInfoImplBase {

	// log4j2日志
	protected static final Logger log = LogManager.getLogger();
	// 服务器启动的端口
	private final int port;

	// 带服务端端口号的构造函数
	public ProductServiceImpl(int port) {
		this.port = port;
	}

	// 添加Product
	@Override
	public void addProduct(Product request, StreamObserver<ProductId> responseObserver) {
		boolean isVirtual = Thread.currentThread().isVirtual();
		UUID uuid = UUID.randomUUID();
		String pid = uuid.toString() + " | ServerPort: " + String.valueOf(this.port);
		Product info = Product.newBuilder()
				.setId(pid)
				.setName(request.getName())
				.setDescription(request.getDescription())
				.build();
		ServerMain.productMap.put(info.getId(), info);

		log.info("[Java][Server] AddProduct success. id: {}, name: {}, description: {}. 是否虚拟线程: {}", info.getId(),
				info.getName(), info.getDescription(), isVirtual);

		ProductId id = ProductId.newBuilder().setValue(pid).build();
		try {
			// 模拟长时间运行的任务，例如网络请求或数据库查询
			Thread.sleep(2000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		responseObserver.onNext(id);
		responseObserver.onCompleted();
	}

	// 取得Product
	@Override
	public void getProduct(ProductId request, StreamObserver<Product> responseObserver) {
		boolean isVirtual = Thread.currentThread().isVirtual();
		if (ServerMain.productMap == null) {
			ServerMain.productMap = new ConcurrentHashMap<String, Product>();
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

		log.info("[Java][Server] GetProduct success. id: {}. 是否虚拟线程: {}", respon.getId(), isVirtual);

		try {
			// 模拟长时间运行的任务，例如网络请求或数据库查询
			Thread.sleep(2000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		responseObserver.onNext(respon);
		responseObserver.onCompleted();
	}
}
