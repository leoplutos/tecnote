import * as grpc from '@grpc/grpc-js';
import { Server, ServerCredentials, ServerUnaryCall, sendUnaryData } from '@grpc/grpc-js';
import { ProductInfoService, IProductInfoService, IProductInfoServer } from './ProductInfo_grpc_pb';
import { Product, ProductId } from "./ProductInfo_pb";
import { v4 } from 'uuid';

//全局变量，储存商品信息
var productDict: Map<string, Product> = new Map([]);

//实现添加商品
const addProduct: IProductInfoServer['addProduct'] = (call: ServerUnaryCall<Product, ProductId>, callback: sendUnaryData<ProductId>) => {
	//取得uuid
	let uuidv4: string = v4();
	//设定到请求的对象中
	call.request.setId(uuidv4);
	//将商品信息添加到全局变量
	productDict.set(uuidv4, call.request);

	//创建返回对应
	const productId: ProductId = new ProductId();
	productId.setValue(uuidv4);

	callback(null, productId);
	console.log(`[Node-Typescript][Server][start] AddProduct success. { id=${uuidv4} name=${call.request.getName()} description=${call.request.getDescription()} }`);
}

//实现取得商品
const getProduct: IProductInfoServer['getProduct'] = (call: ServerUnaryCall<ProductId, Product>, callback: sendUnaryData<Product>) => {
	//最后加一个感叹号意思为告诉 TS 引擎此元素存在
	let productInfo: Product = productDict.get(call.request.getValue())!;
	callback(null, productInfo);
	console.log(`[Node-Typescript][Server][start] GetProduct success. id = ${productInfo.getId()}`);
}

//实现服务
class ServerImplement implements IProductInfoService {
	[name: string]: grpc.UntypedHandleCall;
	constructor(
		public addProduct: IProductInfoServer['addProduct'],
		public getProduct: IProductInfoServer['getProduct'],
	) { }
}

//开启gPRC服务端
const startServer = () => {
	const port: number = 50051;
	const server: Server = new Server();
	server.addService(
		ProductInfoService as any,
		new ServerImplement(addProduct, getProduct),
	);
	server.bindAsync(
		`0.0.0.0:${port}`,
		ServerCredentials.createInsecure(),
		(error, port) => {
			if (error) {
				console.error("[Node-Typescript][Server] Error : ", error);
				return;
			}
			server.start();
			console.log(`[Node-Typescript][Server] gRPC 服务端已开启，端口为:${port}`);
		}
	)
}

startServer();
