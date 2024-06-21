package javagrpc.service;

import java.util.LinkedHashMap;
import java.util.UUID;

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

		log.info("[Java][Server] AddProduct success. id: {}, name: {}, description: {}", info.getId(),
				info.getName(), info.getDescription());

		ProductId id = ProductId.newBuilder().setValue(uuid.toString()).build();
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

		log.info("[Java][Server] GetProduct success. id: {}", respon.getId());

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
