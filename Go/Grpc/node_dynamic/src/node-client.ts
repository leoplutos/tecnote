import { resolve } from 'path';
import { credentials } from '@grpc/grpc-js';
import { Options } from "@grpc/proto-loader";
import { ServiceClientConstructor, ServiceClient } from '@grpc/grpc-js/build/src/make-client';
import { getProtoClient, Product, ProductId } from './common';

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

//调用common.ts取得客户端构造器
const ProductInfoClient: ServiceClientConstructor = getProtoClient({
	path: proto_path,
	option: proto_option,
	package: "grpc_demo",
	service: "ProductInfo"
});

//创建客户端
const createClient = (): ServiceClient => {
	const host: string = "localhost";
	const port: number = 50051;
	return new ProductInfoClient(
		`${host}:${port}`,
		credentials.createInsecure(),
	);
}

//调用添加商品
const addProductRequest = async (client: ServiceClient): Promise<ProductId> => {
	const request: Product = { id: "", name: "Mac Book Pro 2024", description: "Add by Node-Typescript-Dynamic" };
	const response: ProductId = await new Promise<ProductId>((resolve, reject) => {
		client.addProduct(request, (error: any, response: ProductId) => {
			if (error) {
				console.error("[Node-Typescript-Dynamic][Client] Error : ", error);
				reject(error);
			}
			resolve(response);
		});
	});
	console.log(`[Node-Typescript-Dynamic][Client] Add product success. id = ${response.value}`);
	return response;
};

//调用取得商品
const getProductRequest = async (client: ServiceClient, productId: ProductId): Promise<Product> => {
	const response: Product = await new Promise<Product>((resolve, reject) => {
		client.getProduct(productId, (error: any, response: Product) => {
			if (error) {
				console.error("[Node-Typescript-Dynamic][Client] Error : ", error);
				reject(error);
			}
			resolve(response);
		});
	});
	console.log(`[Node-Typescript-Dynamic][Client] Get product success. { id=${response.id} name=${response.name} description=${response.description} }`);
	return response;
};

//主函数
(async () => {
	const client: ServiceClient = createClient();
	let productId: ProductId = await addProductRequest(client);
	await getProductRequest(client, productId);
	await client.close();
})().catch(console.error)
