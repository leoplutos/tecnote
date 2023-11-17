export default class SubComp1 {
	name: string;

	constructor(name: string) {
		this.name = name;
	}

	//定义一个箭头函数
	showName = (args: number = 1): string => {
		let resultStr: string = `SubComp1 - 你初始化的name为: ${this.name} `;
		if (args == 1) {
			return "SubComp1 - 你没有传递参数";
		} else {
			return resultStr;
		}
	};
}
