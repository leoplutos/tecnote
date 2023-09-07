package main

import (
	"fmt"
	"my.sample/GoSampleProject/src/sub"
)

func main() {
	var int1 = 123
	//var str2 = "这是一个测试字符串"
	fmt.Println("Hello World")
	var ret = sub.Sub1(int1)
	fmt.Println("调用函数的返回值为：", ret)
}
