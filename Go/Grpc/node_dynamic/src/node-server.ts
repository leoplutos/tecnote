import { resolve } from 'path';
import { Server, ServerCredentials, ServerUnaryCall, sendUnaryData } from '@grpc/grpc-js';
import { Options } from "@grpc/proto-loader";
import { ServiceDefinition } from '@grpc/grpc-js/build/src/make-client';
import { v4 } from 'uuid';
import { getProtoService, Product, ProductId } from './common';

//取得IDL文件路径
const proto_path: string = resolve(__dirname, '../../ProductInfo.proto');
const proto_option: Options = {
	keepCase: true,
	longs: String,
	enums: String,
	defaults: true,
	oneofs: true
};
//console.log(proto_path);

//调用common.ts取得服务
const productInfoService: ServiceDefinition = getProtoService({
	path: proto_path,
	option: proto_option,
	package: "grpc_demo",
	service: "ProductInfo"
});

//全局变量，储存商品信息
var productDict: Map<string, Product> = new Map([]);

//实现添加商品
const addProductImpl = (call: ServerUnaryCall<Product, ProductId>, callback: sendUnaryData<ProductId>): void => {
	//取得uuid
	let uuidv4: string = v4();
	//设定到请求的对象中
	call.request.id = uuidv4;
	//将商品信息添加到全局变量
	productDict.set(uuidv4, call.request);

	//创建返回对应
	const productId: ProductId = { value: uuidv4 };

	callback(null, productId);
	console.log(`[Node-Typescript-Dynamic][Server][start] AddProduct success. { id=${uuidv4} name=${call.request.name} description=${call.request.description} }`);
}

//实现取得商品
const getProductImpl = (call: ServerUnaryCall<ProductId, Product>, callback: sendUnaryData<Product>): void => {
	//最后加一个感叹号意思为告诉 TS 引擎此元素存在
	let productInfo: Product = productDict.get(call.request.value)!;
	callback(null, productInfo);
	console.log(`[Node-Typescript-Dynamic][Server][start] GetProduct success. id = ${productInfo.id}`);
}

//开启gPRC服务端
const startServer = (): void => {
	const port: number = 50051;
	const server: Server = new Server();
	server.addService(
		productInfoService,
		{
			addProduct: addProductImpl,
			getProduct: getProductImpl
		}
	);
	server.bindAsync(
		`0.0.0.0:${port}`,
		ServerCredentials.createInsecure(),
		(error, port) => {
			if (error) {
				console.error("[Node-Typescript-Dynamic][Server] Error : ", error);
				return;
			}
			server.start();
			console.log(`[Node-Typescript-Dynamic][Server] gRPC 服务端已开启，端口为:${port}`);
		}
	)
}

startServer();
