import { getLogger } from '../log/log.js';

// 日志
const log = getLogger();

export default class SubComp1 {
	private name: string;

	constructor(name: string) {
		this.name = name;
	}

	//定义一个箭头异步函数
	showNameAsync = async (age: number = 1): Promise<string> => {
		log.info(`SubComp1:showNameAsync()  name=${this.name} age=${age}`);
		let ret: string = "";
		if (age === 1) {
			ret = "SubComp1 - 你没有传递参数";
		} else {
			ret = `你好, ${this.name} 你的年龄是 ${age} 岁`;
		}
		return ret;
	};
}
