import { credentials, type ServiceError } from '@grpc/grpc-js';
import { Product, ProductId, ProductInfoClient } from './stub/ProductInfo.js';


// 调用添加商品
const addProductAsync = async (client: ProductInfoClient): Promise<ProductId> => {
	const request: Product = { id: "", name: "Mac Book Pro 2023", description: "Add by Node-Typescript" };
	const response: ProductId = await new Promise<ProductId>((resolve, reject) => {
		client.addProduct(request, (error: ServiceError | null, response: ProductId) => {
			if (error) {
				console.error("[Node-TS][Client] Error : ", error);
				reject(error);
			}
			resolve(response);
		});
	});
	console.log(`[Node-TS][Client] Add product success. id=${response.value}`);
	return response;
};

// 调用取得商品
const getProductAsync = async (client: ProductInfoClient, productId: ProductId): Promise<Product> => {
	const response: Product = await new Promise<Product>((resolve, reject) => {
		client.getProduct(productId, (error: ServiceError | null, response: Product) => {
			if (error) {
				console.error("[Node-TS][Client] Error : ", error);
				reject(error);
			}
			resolve(response);
		});
	});
	console.log(`[Node-TS][Client] Get product success. id=${response.id} name=${response.name} description=${response.description}`);
	return response;
};


// 异步开始函数
async function startClientAsync(): Promise<void> {
	// 连接地址
	const host: string = "localhost";
	const port: number = 50051;
	const address: string = `${host}:${port}`;
	// 创建客户端
	const client = new ProductInfoClient(address, credentials.createInsecure());
	// 调用添加商品
	const productId: ProductId = await addProductAsync(client);
	// 调用取得商品
	const product: Product = await getProductAsync(client, productId);
	// 关闭客户端
	client.close();
}

// 主函数
(async function main() {
	try {
		await startClientAsync();
	} catch (e) {
		console.error(e);
	} finally {
	}
})();
