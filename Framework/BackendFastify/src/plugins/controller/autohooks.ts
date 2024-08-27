import { FastifyInstance, FastifyPluginOptions, FastifyRequest, FastifyReply } from 'fastify';
import { Result, fail } from '../../type/result.js';

// controller文件夹内的自动钩子[autohooks]
export default async function hooks(fastify: FastifyInstance, _options: FastifyPluginOptions, next: () => void) {
	fastify.log.info("[controller]文件夹内的自动钩子[autohooks]注册开始");

	fastify.addHook('onRequest', async (request: FastifyRequest, reply: FastifyReply) => {
		try {
			await request.jwtVerify();
		} catch (err) {
			fastify.log.info(err);
			let result: Result = fail(401, "token不正确,请重新登录!");
			reply.code(401).send(result);
		}
	});

	fastify.log.info("[controller]文件夹内的自动钩子[autohooks]注册结束");
	next();
}
