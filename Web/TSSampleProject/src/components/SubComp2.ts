import { getLogger } from '../log/log.js';

// 日志
const log = getLogger();

interface SubComp2Option {
	id: number;
	name: string;
	callbackFun: Function;
}

// 异步函数
async function calcAsync(option: SubComp2Option): Promise<number> {
	log.info(`SubComp2:calcAsync()  id=${option.id} name=${option.name}`);
	// 调用回调函数
	option.callbackFun();
	//	计算
	const b: number = 1;
	const c: number = 2;
	const ret: number = (option.id + b) * c;
	return ret;
}

export default calcAsync;
