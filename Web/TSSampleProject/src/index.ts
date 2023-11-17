import SubComp1 from "./components/SubComp1";
import subComp2Event from "./components/SubComp2";

let strMsg1: string = "这是一个TypeScript的示例";
let strMsg2: string = `o0O 8g&@ == != ilI|
ABCDEFGHIHJLNMOPQRSTUVWXYZ
abcdefghihjlnmopqrstuvwxyz
1234567890 !@#$%^&*()__+
Hello!こんにちは!你好!안녕하세요!
这是一段中文
これは日本語テストです。`;
console.log(strMsg1);
console.log(strMsg2);

//调用SubComp1
let sub1: SubComp1 = new SubComp1("蓝山咖啡");
let sub1Ret: string = sub1.showName(2);
console.log(sub1Ret);

//一个回调函数
let main_callback = (): void => {
	console.log("main_callback - 回调函数已执行");
};
//调用SubComp2
let sub2Ret: number = subComp2Event({ id: 333, name: "意式拿铁", callbackFun: main_callback });
console.log(sub2Ret);
