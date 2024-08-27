import { FastifyInstance, FastifyPluginOptions, FastifyRequest, FastifyReply } from 'fastify';
import LokiDbService from '../../db/lokiDbService.js';
import { succes, Result } from '../../type/result.js';

// 取得TodoList
export default async function routes(fastify: FastifyInstance, _options: FastifyPluginOptions, next: () => void) {
	fastify.log.info("[TodoList]路由插件注册开始");
	fastify.post('/todo/getAll', async (request: FastifyRequest, _reply: FastifyReply) => {
		request.log.info("取得TodoList开始");
		let todoList: Array<any> = LokiDbService.getInstance().findTodoAll();
		let result: Result = succes(todoList);
		request.log.info("取得TodoList结束");
		return result;
	});
	fastify.log.info("[TodoList]路由插件注册结束");
	next();
}

// 重新url前缀（不加上会变成/controller/todo/getAll）
export const prefixOverride = '/';
