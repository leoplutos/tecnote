import { FastifyInstance, FastifyPluginOptions, FastifyRequest, FastifyReply, FastifyTypeProvider, FastifySchema, HookHandlerDoneFunction } from 'fastify';
import { Type } from '@sinclair/typebox';
import { TypeBoxTypeProvider } from '@fastify/type-provider-typebox';
import LokiDbService from '../../db/lokiDbService.js';
import { succes, fail } from '../../type/result.js';

// 定义 FastifyRequestInferred 以允许 request.body 类型推断
export type FastifyRequestInferred<Provider extends FastifyTypeProvider, Schema extends FastifySchema> = FastifyRequest<{}, any, any, Schema, Provider>;

// 路由选项
const Schema = {
	body: Type.Object({
		userId: Type.String(),
		password: Type.String(),
	}),
	// response: {
	// 	200: Type.String({
	// 		code: Type.String(),
	// 		message: Type.String(),
	// 		data: Type.Unknown(),
	// 	})
	// }
};

// function InferredHandler(request: FastifyRequestInferred<TypeBoxTypeProvider, typeof Schema>, reply: FastifyReply, done: HookHandlerDoneFunction) {
// 	const { userId, password } = request.body;  // allowed
// }

// Login路由注册
export default async function routes(fastify: FastifyInstance, _options: FastifyPluginOptions, next: HookHandlerDoneFunction) {
	fastify.log.info("[Login]路由插件注册开始");
	fastify.withTypeProvider<TypeBoxTypeProvider>().post(
		'/login',
		{ schema: Schema },
		async (request: FastifyRequestInferred<TypeBoxTypeProvider, typeof Schema>, reply: FastifyReply) => {
			request.log.info("Login开始");
			const { userId, password } = request.body;
			if (userId === "") {
				reply.code(401).send(fail(401, "账号不能为空"));
				return reply;
			}
			if (password === "") {
				reply.code(401).send(fail(401, "密码不能为空"));
				return reply;
			}
			// 检查用户密码
			let userInfo: Array<any> = LokiDbService.getInstance().findUserByUserIdAndPassword(userId, password);
			if (userInfo.length === 0) {
				reply.code(401).send(fail(401, "用户名或密码错误!"));
				return reply;
			}
			// 生成token
			const token = fastify.jwt.sign({ userId: userId, password: password });
			reply.send(succes(token));
			request.log.info("Login结束");
			return reply;
		});
	fastify.log.info("[Login]路由插件注册结束");
	next();
}

// 重新url前缀（不加上会变成/controller/todo/getAll）
export const prefixOverride = '/';
