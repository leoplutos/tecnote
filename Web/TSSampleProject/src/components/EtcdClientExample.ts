import { Etcd3, Lease } from 'etcd3';
import { NoopPolicy, handleAll, retry } from 'cockatiel';
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

// 建立连接
const client = new Etcd3({
	hosts: "http://localhost:2379",
	// auth: {
	//     username: 'root',
	//     password: 'guang'
	// }
	faultHandling: {
		global: retry(handleAll, { maxAttempts: 0 }),
		host: () => new NoopPolicy(),
	},
});

// 睡眠函数
async function sleep(ms: number): Promise<void> {
	return new Promise(resolve => setTimeout(resolve, ms));
}

// 租约函数
async function leaseRegister(prefix: string) {
	// 创建租约
	const leaseKey: string = prefix + "/LsKey1";
	const leaseValue: string = "此Key会自动被删除";
	const ttl: number = 5;
	const lease: Lease = client.lease(ttl);
	const leaseId: string = await lease.grant();
	logger.info(`创建租约(Lease)成功    leaseId=${leaseId}`);
	// 将租约附加到一个Key上
	await lease.put(leaseKey).value(leaseValue);
	logger.info(`添加租约Key成功    key=${leaseKey}    value=${leaseValue}    leaseId=${leaseId}`);
	// 监视租约
	// lease.on('lost', async () => {
	// 	// 当租约到期时（被删除）会在此通知
	// 	logger.info(`[lease on lost]租约  key=${leaseId} 到期，续租`);
	// 	await leaseRegister(prefix);
	// });
	// 释放（停止维持心跳，让租约自动到期），如果想马上释放需要调用revoke()
	lease.release();
	//await lease.revoke();
}

// 监听函数
async function watchService(prefix: string) {
	const watchKey: string = prefix + "/LsKey1";
	//const watcher = await client.watch().prefix(`/services/${serviceName}`).create();
	const watcher = await client.watch().key(watchKey).create();
	watcher.on('delete', async event => {
		logger.info(`租约  key=${event.key.toString()} 到期，续租`);
		await leaseRegister(prefix);
	});
}


// 主函数
(async function main() {

	try {
		await client.maintenance.status();
		logger.info(`Etcd连接成功`);
	} catch (error) {
		logger.error(`Etcd连接失败: ${error}`);
		// 结束
		process.exit(0);
	}

	// 设定Key
	const prefix: string = '/TSKey';
	const key1: string = prefix + "/Key1";
	const key2: string = prefix + "/Key2";
	const setValue1: string = '使用Node客户端添加_' + uuidv4();
	const setValue2: string = '使用Node客户端添加_' + uuidv4();
	await client.put(key1).value(setValue1);
	logger.info(`添加Key成功    key=${key1}    value=${setValue1}`);
	await client.put(key2).value(setValue2);
	logger.info(`添加Key成功    key=${key2}    value=${setValue2}`);

	// 取得Key
	const getValue: string = await client.get(key1).string() ?? "值不存在";
	logger.info(`取得Key成功    key=${key1}    value=${getValue}`);

	// 取得Key（前缀机制）
	// 前缀查询
	const list = await client.getAll().prefix(prefix).strings();
	logger.info(`取得前缀成功    prefix=${prefix}`);
	// 使用 Object.entries() 遍历对象的键值对
	Object.entries(list).forEach(([key, value]) => {
		logger.info(`key=${key}    value=${value}`);
	});

	// 分布式锁
	const lockKey: string = prefix + "/lock";
	// 加锁
	await client.lock(lockKey).do(async () => {
		logger.info(`[加锁]分布式锁成功    lockKey=${lockKey}`);
		logger.info(`5秒后解锁,	etcd3是用lease实现的锁,所以 [etcdctl lock /TSKey/lock] 命令无效`);
		return await sleep(5000);;
	}).then((_result) => {
		logger.info(`[解锁]分布式锁成功    lockKey=${lockKey}`);
	}).catch((_error) => {
		logger.info(`[加锁]分布式锁失败    lockKey=${lockKey}`);
	});

	// 调用租约函数
	await leaseRegister(prefix);

	// 调用监听函数
	await watchService(prefix);

	// 为了测试监听
	await sleep(50000);

	//关闭连接
	client.close();
	logger.info("已断开Etcd连接");

	// 结束
	process.exit(0);

})();


