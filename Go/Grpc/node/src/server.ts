import { Server, ServerCredentials, } from "@grpc/grpc-js";
import { ProductServiceImpl } from "./service/ProductService.js";
import { ProductInfoService } from './stub/ProductInfo.js';


// 异步开始函数
async function startServerAsync(): Promise<void> {
	// 监听地址
	const host: string = "0.0.0.0";
	// 监听端口
	const port: number = 50051;
	const address: string = `${host}:${port}`;
	// 定义 gRPC服务端
	const server: Server = new Server();
	// 绑定业务逻辑
	server.addService(ProductInfoService, new ProductServiceImpl(port));
	// 绑定端口并启动服务
	server.bindAsync(address, ServerCredentials.createInsecure(),
		(error, port) => {
			if (error) {
				console.error("[Node-TS][Server] gRPC 服务端启动失败: ", error);
				return;
			}
			console.log(`[Node-TS][Server] gRPC 服务端已开启，端口为:${port}`);
		}
	);
}

// 主函数
(async function main() {
	try {
		await startServerAsync();
	} catch (e) {
		console.error(e);
	} finally {
	}
})();
