import Fastify, { FastifyInstance } from 'fastify';
// import { Server, IncomingMessage, ServerResponse } from 'http';
import autoLoad from '@fastify/autoload';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';
import LokiDbService from './db/lokiDbService.js';

// Pino日志设定
let loggerConfig = {};
if (process.env.NODE_ENV === "production") {
	loggerConfig = {};
} else {
	loggerConfig = {
		transport: {
			target: 'pino-pretty',
			options: {
				colorize: true
			}
		}
	};
}
// 初始化Fastify
const server: FastifyInstance = Fastify({
	logger: loggerConfig
});

// 使用[@fastify/autoload]插件自动扫描注册plugins文件夹内的内容
const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
server.register(autoLoad, {
	dir: join(__dirname, 'plugins'),
	autoHooks: true, // 应用同目录内的autohooks.ts文件
	encapsulate: false,//每个加载的插件都使用 fastify-plugin 包装。这允许您在需要时在插件和父上下文之间共享上下文
});

// 初始化内存数据库
LokiDbService.getInstance();

// 开启服务
const start = async () => {
	try {
		const host: string = "0.0.0.0";
		const port: number = 9501;
		await server.listen({ host: host, port: port });

		server.log.info(`后端服务Fastify已开启    host:${host}     port:${port}`);
	} catch (err) {
		server.log.error(err);
		process.exit(1);
	}
};
start();
