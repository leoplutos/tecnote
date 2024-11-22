package javagrpc.service;

import com.fasterxml.uuid.Generators;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import io.grpc.stub.StreamObserver;
import io.opentelemetry.api.OpenTelemetry;
import io.opentelemetry.api.trace.Span;
import io.opentelemetry.context.Scope;
import javagrpc.common.Const;
import javagrpc.grpc.stub.ProductInfoGrpc.ProductInfoImplBase;
import javagrpc.grpc.stub.ProductInfoPb.Product;
import javagrpc.grpc.stub.ProductInfoPb.ProductId;
import javagrpc.opentelemetry.OpentelemetryUtil;

// 实现业务逻辑
public class ProductServiceImpl extends ProductInfoImplBase {

	// log4j2日志
	protected static final Logger log = LogManager.getLogger();
	// 服务器启动的端口
	private final int port;
	// 是否启用Otel检测
	private final boolean isWithOtel;
	// Otel检测
	private final OpenTelemetry openTelemetry;

	// 带服务端端口号的构造函数
	public ProductServiceImpl(int port, boolean isWithOtel, OpenTelemetry openTelemetry) {
		this.port = port;
		this.isWithOtel = isWithOtel;
		this.openTelemetry = openTelemetry;
	}

	// 添加Product
	@Override
	public void addProduct(Product request, StreamObserver<ProductId> responseObserver) {
		if (isWithOtel) {
			// 取得拦截器设定的traceId 和 spanId
			String traceId = Const.CONTEXT_KEY_TRACE_ID.get();
			String spanId = Const.CONTEXT_KEY_SPAN_ID.get();
			// 在一个已存的 Trace 下创建新的 Span
			Span newSpan = OpentelemetryUtil.getRemoteSpan(openTelemetry, traceId, "ProductServiceImpl", spanId,
					"addProduct");
			try (Scope scope = newSpan.makeCurrent()) {
				// 调用实际处理业务
				ProductId productId = this.addProductLogic(request.getName(), request.getDescription());
				responseObserver.onNext(productId);
				responseObserver.onCompleted();
			} finally {
				newSpan.end();
			}
		} else {
			// 调用实际处理业务
			ProductId productId = this.addProductLogic(request.getName(), request.getDescription());
			responseObserver.onNext(productId);
			responseObserver.onCompleted();
		}
	}

	// 添加商品实际处理
	private ProductId addProductLogic(String name, String description) {
		boolean isVirtual = Thread.currentThread().isVirtual();
		String uuidv7 = Generators.timeBasedEpochGenerator().generate().toString();
		String pid = String.format("%s | ServerPort: %d", uuidv7, this.port);
		Product product = Product.newBuilder()
				.setId(pid)
				.setName(name)
				.setDescription(description)
				.build();
		// 使用读写锁写入全局Product的词典
		GlobalData.writeProductMap(product.getId(), product);

		log.info("[Java][Server] AddProduct success. id: {}, name: {}, description: {}. 是否虚拟线程: {}", product.getId(),
				product.getName(), product.getDescription(), isVirtual);

		ProductId productId = ProductId.newBuilder().setValue(pid).build();
		try {
			// 模拟长时间运行的任务，例如网络请求或数据库查询
			Thread.sleep(2000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		return productId;
	}

	// 取得Product
	@Override
	public void getProduct(ProductId request, StreamObserver<Product> responseObserver) {
		if (isWithOtel) {
			// 取得拦截器设定的traceId 和 spanId
			String traceId = Const.CONTEXT_KEY_TRACE_ID.get();
			String spanId = Const.CONTEXT_KEY_SPAN_ID.get();
			// 在一个已存的 Trace 下创建新的 Span
			Span newSpan = OpentelemetryUtil.getRemoteSpan(openTelemetry, traceId, "ProductServiceImpl", spanId,
					"getProduct");
			try (Scope scope = newSpan.makeCurrent()) {
				// 调用实际处理业务
				Product product = this.getProductLogic(request.getValue());
				responseObserver.onNext(product);
				responseObserver.onCompleted();
			} finally {
				newSpan.end();
			}
		} else {
			// 调用实际处理业务
			Product product = this.getProductLogic(request.getValue());
			responseObserver.onNext(product);
			responseObserver.onCompleted();
		}
	}

	// 添加商品实际处理
	private Product getProductLogic(String pid) {
		boolean isVirtual = Thread.currentThread().isVirtual();
		// 使用读写锁读取全局Product的词典
		Product product = GlobalData.readProductMap().get(pid);
		if (product == null) {
			// 没有取到时
			product = Product.newBuilder()
					.setId("None Id")
					.setName("None Name")
					.setDescription("Java gRPC Server")
					.build();
		}
		log.info("[Java][Server] GetProduct success. id: {}. 是否虚拟线程: {}", product.getId(), isVirtual);
		try {
			// 模拟长时间运行的任务，例如网络请求或数据库查询
			Thread.sleep(2100);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		return product;
	}
}
