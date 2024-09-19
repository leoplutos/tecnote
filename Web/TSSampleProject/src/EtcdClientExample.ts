import { Etcd3, Lease } from 'etcd3';
import { NoopPolicy, handleAll, retry } from 'cockatiel';
import { v4 as uuidv4 } from 'uuid';
import { getLogger } from './log/log.js';

// 日志
const log = getLogger();

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
async function sleepAsync(ms: number): Promise<void> {
	return new Promise(resolve => setTimeout(resolve, ms));
}

// 租约函数
async function leaseRegisterAsync(prefix: string) {
	// 创建租约
	const leaseKey: string = prefix + "/LsKey1";
	const leaseValue: string = "此Key会自动被删除";
	const ttl: number = 5;
	const lease: Lease = client.lease(ttl);
	const leaseId: string = await lease.grant();
	log.info(`创建租约(Lease)成功    leaseId=${leaseId}`);
	// 将租约附加到一个Key上
	await lease.put(leaseKey).value(leaseValue);
	log.info(`添加租约Key成功    key=${leaseKey}    value=${leaseValue}    leaseId=${leaseId}`);
	// 监视租约
	// lease.on('lost', async () => {
	// 	// 当租约到期时（被删除）会在此通知
	// 	log.info(`[lease on lost]租约  key=${leaseId} 到期，续租`);
	// 	await leaseRegister(prefix);
	// });
	// 释放（停止维持心跳，让租约自动到期），如果想马上释放需要调用revoke()
	lease.release();
	//await lease.revoke();
}

// 监听函数
async function watchServiceAsync(prefix: string) {
	const watchKey: string = prefix + "/LsKey1";
	//const watcher = await client.watch().prefix(`/services/${serviceName}`).create();
	const watcher = await client.watch().key(watchKey).create();
	watcher.on('delete', async event => {
		log.info(`租约  key=${event.key.toString()} 到期，续租`);
		await leaseRegisterAsync(prefix);
	});
}

// 异步开始函数
async function startEtcdAsync(): Promise<void> {

	try {
		await client.maintenance.status();
		log.info(`Etcd连接成功`);
	} catch (error) {
		log.error(`Etcd连接失败: ${error}`);
		throw error;
	}

	// 设定Key
	const prefix: string = '/TSKey';
	const key1: string = prefix + "/Key1";
	const key2: string = prefix + "/Key2";
	const setValue1: string = '使用Node客户端添加_' + uuidv4();
	const setValue2: string = '使用Node客户端添加_' + uuidv4();
	await client.put(key1).value(setValue1);
	log.info(`添加Key成功    key=${key1}    value=${setValue1}`);
	await client.put(key2).value(setValue2);
	log.info(`添加Key成功    key=${key2}    value=${setValue2}`);

	// 取得Key
	const getValue: string = await client.get(key1).string() ?? "值不存在";
	log.info(`取得Key成功    key=${key1}    value=${getValue}`);

	// 取得Key（前缀机制）
	// 前缀查询
	const list = await client.getAll().prefix(prefix).strings();
	log.info(`取得前缀成功    prefix=${prefix}`);
	// 使用 Object.entries() 遍历对象的键值对
	Object.entries(list).forEach(([key, value]) => {
		log.info(`key=${key}    value=${value}`);
	});

	// 分布式锁
	const lockKey: string = prefix + "/lock";
	// 加锁
	await client.lock(lockKey).do(async () => {
		log.info(`[加锁]分布式锁成功    lockKey=${lockKey}`);
		log.info(`5秒后解锁,	etcd3是用lease实现的锁,所以 [etcdctl lock /TSKey/lock] 命令无效`);
		return await sleepAsync(5000);
	}).then((_result) => {
		log.info(`[解锁]分布式锁成功    lockKey=${lockKey}`);
	}).catch((_error) => {
		log.info(`[加锁]分布式锁失败    lockKey=${lockKey}`);
	});

	// 调用租约函数
	await leaseRegisterAsync(prefix);

	// 调用监听函数
	await watchServiceAsync(prefix);

	// 为了测试监听
	await sleepAsync(50000);

	//关闭连接
	client.close();
	log.info("已断开Etcd连接");
}

// 主函数
(async function main() {
	try {
		await startEtcdAsync();
	} catch (e) {
		log.error(e);
	} finally {
		// 因为是异步日志，所以要在最后刷新
		log.flush();
		// 结束
		process.exit(0);
	}
})();
