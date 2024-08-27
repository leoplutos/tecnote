import { FastifyInstance, FastifyPluginOptions } from 'fastify';
import fastifyJwt from '@fastify/jwt';

// [JWT]验证插件
export default async function plugin(fastify: FastifyInstance, _options: FastifyPluginOptions, next: () => void) {
	fastify.log.info("[JWT]验证插件注册开始");

	// @fastify/jwt注册
	fastify.register(fastifyJwt, {
		secret: 'supersecret123456',
		// extractToken自定义检查请求头中的内容：检查是否有[token]
		verify: { extractToken: (request: any) => request.headers.token },
	});

	// 装饰器,名字为[authenticate]
	// fastify.decorate("authenticate", async function (request: FastifyRequest, reply: FastifyReply) {
	// 	try {
	// 		request.log.info(`装饰器[authenticate]运行开始`);
	// 		await request.jwtVerify();
	// 		request.log.info(`装饰器[authenticate]运行结束`);
	// 	} catch (err) {
	// 		reply.send(err);
	// 	}
	// });

	fastify.log.info("[JWT]验证插件注册结束");
	next();
}
