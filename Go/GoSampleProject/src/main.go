package main

import (
	"fmt"
	"my.sample/GoSampleProject/src/etcd"
	"my.sample/GoSampleProject/src/log"
	"my.sample/GoSampleProject/src/redis"
	"my.sample/GoSampleProject/src/sub"
	"os"
)

func main() {
	// 初始化log
	log.InitLog()

	// 参数1为程序名
	if len(os.Args) == 1 {
		log.Logger.Info().Msg("没有命令行参数,运行 Hello World")
		var testStr = "中文.English.日本語"
		// fmt.Println(testStr)
		log.Logger.Info().Msgf("日志格式化 %s 结果", testStr)
		var param = 123
		var ret = sub.Sub1(param)
		log.Logger.Info().Msgf("调用函数的返回值为：%d ", ret)
		os.Exit(0)
	}

	firstArgument := os.Args[1]
	if firstArgument == "Redis" {
		// 调用Redis
		redis.RedisClient()
	} else if firstArgument == "Etcd" {
		// 调用Etcd
		etcd.EtcdClient()
	} else {
		fmt.Println("无法识别此参数")
		os.Exit(1)
	}
	os.Exit(0)
}
