import 'fastify';

// fastify类型扩展
declare module 'fastify' {

	export interface FastifyRequest {
		token: string;
	}

	export interface FastifyInstance {
		authenticate: any;
		// authenticate: () => Promise<any>;
	}
}
