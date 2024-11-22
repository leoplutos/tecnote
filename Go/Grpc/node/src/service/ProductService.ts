import { v7 as UUIDv7 } from 'uuid';
import { ServerUnaryCall, sendUnaryData, UntypedHandleCall } from '@grpc/grpc-js';
import { Product, ProductId, ProductInfoServer } from '../stub/ProductInfo.js';
import { getLogger } from '../log/log.js';

// 日志
const log = getLogger();

//全局变量，储存商品信息
var productDict: Map<string, Product> = new Map([]);

// ######################################
// Product服务的业务实现
// ######################################
class ProductServiceImpl implements ProductInfoServer {
	// 索引签名
	[name: string]: UntypedHandleCall;

	// 构造函数
	constructor(port: number) {
		// 通过索引签名来设置port属性
		(this as any)['port'] = port;
	}

	// 取得端口号
	getPort() {
		return (this as any)['port'];
	}

	// 实现添加商品
	addProduct(call: ServerUnaryCall<Product, ProductId>, callback: sendUnaryData<ProductId>): void {
		// 对数据库友好的 UUID v7
		const uuidv7: string = UUIDv7();
		const port = this.getPort();
		const pid: string = `${uuidv7} | ServerPort: ${port}`;
		//设定到请求的对象中
		call.request.id = pid;
		//将商品信息添加到全局变量
		productDict.set(pid, call.request);

		//创建返回对应
		const productId: ProductId = { value: pid };

		callback(null, productId);
		log.info(`[Node-TS][Server] AddProduct success. id=${pid} name=${call.request.name} description=${call.request.description}`);
	}

	// 实现获取商品
	getProduct(call: ServerUnaryCall<ProductId, Product>, callback: sendUnaryData<Product>): void {
		// 取得不到时的默认值
		const noneProduct: Product = { id: "None Id", name: "None Name", description: "Node-TS gRPC Server" };
		// 使用??为当取得不到时，会返回默认值
		const productInfo: Product = productDict.get(call.request.value) ?? noneProduct;
		callback(null, productInfo);
		log.info(`[Node-TS][Server] GetProduct success. id=${productInfo.id}`);
	}
}

// 公开 ProductServiceImpl
export { ProductServiceImpl };
