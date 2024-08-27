import { createClient, RedisClientType } from 'redis';
import { v4 as uuidv4 } from 'uuid';
import pino from 'pino';

// 日志
const logger = pino({
	transport: {
		targets: [
			// {
			// 	target: 'pino/file',
			// 	options: { destination: `${__dirname}/app.log` },
			// },
			{
				target: 'pino-pretty',
			},
		],
		options: {
			colorize: true,
			//messageFormat: '{levelLabel} - {pid} - url:{req.url}',
			ignore: 'hostname',
			//customColors: 'err:red,info:blue',
		},
	},
});

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
	logger.error('Redis连接失败');
	logger.error(err);
}).connect();

// 设定Key
const key: string = 'TSKey';
const uuid: string = uuidv4();
const setValue: string = '使用Node客户端添加_' + uuid;
await client.set(key, setValue);
//console.log(`添加Key成功    key=${key}    value=${setValue}`);
logger.info(`添加Key成功    key=${key}    value=${setValue}`);

// 取得Key
const getValue: string = await client.get(key) || '';
logger.info(`取得Key成功    key=${key}    value=${getValue}`);

// 判断Key是否存在
let isExists: number = await client.exists(key);
logger.info(`Key[${key}]是否存在    ${isExists}`);
const notExistkey: string = 'abcde';
isExists = await client.exists(notExistkey);
logger.info(`Key[${notExistkey}]是否存在    ${isExists}`);

// 为Key设置过期时间(秒)
const expireSeconds: number = 10;
await client.expire(key, expireSeconds);
logger.info(`设定Key[${key}]的过期时间为：${expireSeconds}秒`);

//await client.quit();
await client.disconnect();
logger.info("已断开Redis连接");

// 结束
process.exit(0);
