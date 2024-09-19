import { createClient, RedisClientType } from 'redis';
import { v4 as uuidv4 } from 'uuid';
import { getLogger } from './log/log.js';

// 日志
const log = getLogger();

// 异步开始函数
async function startRedisAsync(): Promise<void> {

	// 连接参数
	//const client: RedisClientType = await createClient();
	const client: RedisClientType = await createClient({
		socket: {
			host: 'localhost',
			port: 6379,
			connectTimeout: 1000,
			reconnectStrategy: retries => false,
		}
	});

	// 建立连接
	client.on('error', err => {
		log.error('Redis连接失败');
		log.error(err);
		throw err;
	}).connect();

	// 设定Key
	const key: string = 'TSKey';
	const uuid: string = uuidv4();
	const setValue: string = '使用Node客户端添加_' + uuid;
	await client.set(key, setValue);
	//console.log(`添加Key成功    key=${key}    value=${setValue}`);
	log.info(`添加Key成功    key=${key}    value=${setValue}`);

	// 取得Key
	const getValue: string = await client.get(key) || '';
	log.info(`取得Key成功    key=${key}    value=${getValue}`);

	// 判断Key是否存在
	let isExists: number = await client.exists(key);
	log.info(`Key[${key}]是否存在    ${isExists}`);
	const notExistkey: string = 'abcde';
	isExists = await client.exists(notExistkey);
	log.info(`Key[${notExistkey}]是否存在    ${isExists}`);

	// 为Key设置过期时间(秒)
	const expireSeconds: number = 10;
	await client.expire(key, expireSeconds);
	log.info(`设定Key[${key}]的过期时间为：${expireSeconds}秒`);

	//await client.quit();
	await client.disconnect();
	log.info("已断开Redis连接");
}

// 主函数
(async function main() {
	try {
		await startRedisAsync();
	} catch (e) {
		log.error(e);
	} finally {
		// 因为是异步日志，所以要在最后刷新
		log.flush();
		// 结束
		process.exit(0);
	}
})();
