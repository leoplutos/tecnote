interface SubComp2Param {
	id: number;
	name: string;
	callbackFun: Function;
}

function subComp2Event(param: SubComp2Param): number {
	console.log(`SubComp2 - Parameter id: ${param.id}`);
	console.log(`SubComp2 - Parameter name: ${param.name}`);
	console.log("SubComp2 - 调用回调函数开始");
	param.callbackFun();
	console.log("SubComp2 - 调用回调函数结束");
	return 0;
}

export default subComp2Event;
