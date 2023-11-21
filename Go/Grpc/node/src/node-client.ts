import { credentials } from '@grpc/grpc-js';
import { ProductInfoClient } from "./ProductInfo_grpc_pb";
import { Product, ProductId } from "./ProductInfo_pb";

//创建客户端
const createClient = () => {
	const host: string = "localhost";
	const port: number = 50051;
	return new ProductInfoClient(
		`${host}:${port}`,
		credentials.createInsecure(),
	);
}

//调用添加商品
const addProductRequest = async (client: ProductInfoClient): Promise<ProductId> => {
	const request: Product = new Product();
	request.setName("Mac Book Pro 2023");
	request.setDescription("Add by Node-Typescript");
	const response: ProductId = await new Promise<ProductId>((resolve, reject) => {
		client.addProduct(request, (error: any, response: ProductId) => {
			if (error) {
				console.error("[Node-Typescript][Client] Error : ", error);
				reject(error);
			}
			resolve(response);
		});
	});
	console.log(`[Node-Typescript][Client] Add product success. id = ${response.getValue()}`);
	return response;
};

//调用取得商品
const getProductRequest = async (client: ProductInfoClient, productId: ProductId): Promise<Product> => {
	const response: Product = await new Promise<Product>((resolve, reject) => {
		client.getProduct(productId, (error: any, response: Product) => {
			if (error) {
				console.error("[Node-Typescript][Client] Error : ", error);
				reject(error);
			}
			resolve(response);
		});
	});
	console.log(`[Node-Typescript][Client] Get product success. { id=${response.getId()} name=${response.getName()} description=${response.getDescription()} }`);
	return response;
};

//主函数
(async () => {
	const client: ProductInfoClient = createClient();
	let productId: ProductId = await addProductRequest(client);
	await getProductRequest(client, productId);
	//await client.close();
})().catch(console.error)
