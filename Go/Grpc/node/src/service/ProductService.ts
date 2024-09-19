import { v4 } from 'uuid';
import { ServerUnaryCall, sendUnaryData, UntypedHandleCall } from '@grpc/grpc-js';
import { Product, ProductId, ProductInfoServer } from '../stub/ProductInfo.js';

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
		// 取得uuid
		const uuidv4: string = v4();
		const port = this.getPort();
		const pid: string = `${uuidv4} | ServerPort: ${port}`;
		//设定到请求的对象中
		call.request.id = pid;
		//将商品信息添加到全局变量
		productDict.set(pid, call.request);

		//创建返回对应
		const productId: ProductId = { value: pid };

		callback(null, productId);
		console.log(`[Node-TS][Server] AddProduct success. id=${pid} name=${call.request.name} description=${call.request.description}`);
	}

	// 实现获取商品
	getProduct(call: ServerUnaryCall<ProductId, Product>, callback: sendUnaryData<Product>): void {
		//最后加一个感叹号意思为告诉 TS 引擎此元素存在
		const productInfo: Product = productDict.get(call.request.value)!;
		callback(null, productInfo);
		console.log(`[Node-TS][Server] GetProduct success. id=${productInfo.id}`);
	}
}

// 公开 ProductServiceImpl
export { ProductServiceImpl };
