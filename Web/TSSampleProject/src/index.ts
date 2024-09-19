import config from 'config';
import { getLogger } from './log/log.js';
import SubComp1 from "./components/SubComp1.js";
import calcAsync from "./components/SubComp2.js";

// 日志
const log = getLogger();

// 异步开始函数
async function startAsync(): Promise<void> {

	// 从 config 文件夹 和 环境变量 读取内容
	log.debug("读取config和环境变量开始");
	const hacker = config.get<boolean>('hacker');
	log.info(`hacker = ${hacker}`);
	const name = config.get<string>('name');
	log.info(`name = ${name}`);
	const age = config.get<number>('age');
	log.info(`env = ${age}`);
	// 读取数组
	const hobbies: string[] = config.get<string[]>('hobbies');
	log.info(`hobbies = ${hobbies}`);
	// 读取Map
	const jacket = config.get<string>('clothing.jacket');
	log.info(`jacket = ${jacket}`);
	const trousers = config.get<string>('clothing.trousers');
	log.info(`trousers = ${trousers}`);
	const main = config.get<string>('food.breakfast.main');
	log.info(`main = ${main}`);
	const drink = config.get<string>('food.breakfast.drink');
	log.info(`drink = ${drink}`);
	// 从环境变量读取内容
	const node_env = config.util.getEnv('NODE_ENV');
	log.info(`环境变量 NODE_ENV = ${node_env}`);
	log.debug("读取config和环境变量结束");

	// 堵塞调用SubComp1
	const sub1: SubComp1 = new SubComp1(name);
	const sub1Ret: string = await sub1.showNameAsync(age);
	log.info(`sub1Ret = ${sub1Ret}`);

	//一个回调函数
	const mainCallback = (): void => {
		log.info("回调函数已执行");
	};
	//调用SubComp2
	const sub2Ret: number = await calcAsync({ id: 9527, name: "意式拿铁", callbackFun: mainCallback });
	log.info(`sub2Ret = ${sub2Ret}`);
}

// 主函数
(async function main() {
	try {
		await startAsync();
	} catch (e) {
		log.error(e);
	} finally {
		// 因为是异步日志，所以要在最后刷新
		log.flush();
	}
})();
