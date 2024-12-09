package main

import (
	"my.sample/GoSampleProject/src/config"
	"my.sample/GoSampleProject/src/etcd"
	"my.sample/GoSampleProject/src/log"
	postgre "my.sample/GoSampleProject/src/postgre"
	"my.sample/GoSampleProject/src/redis"
	"my.sample/GoSampleProject/src/sub"
	"os"
	//"time"
)

func main() {
	// 初始化log
	// log.InitLog()

	// 参数1为程序名
	if len(os.Args) == 1 {
		log.Logger.Info().Msg("请输入一个参数[Redis|Etcd|Postgre]")
		log.Logger.Info().Msg("本次运行没有命令行参数,运行 Hello World")

		// 从config.yaml读取内容
		log.Logger.Info().Msg("读取config和环境变量开始")
		hacker := config.Viper.GetBool("hacker")
		log.Logger.Info().Msgf("hacker: %t", hacker)
		name := config.Viper.GetString("name")
		log.Logger.Info().Msgf("name: %s", name)
		age := config.Viper.GetInt("age")
		log.Logger.Info().Msgf("age: %d", age)
		// 读取数组
		hobbies := config.Viper.GetStringSlice("hobbies")
		for index, value := range hobbies {
			log.Logger.Info().Msgf("hobbies[%d]: %v", index, value)
		}
		// 读取Map
		clothing := config.Viper.GetStringMap("clothing")
		for key, value := range clothing {
			log.Logger.Info().Msgf("clothing  %v: %v", key, value)
		}
		// 读取复杂结构
		allSettings := config.Viper.AllSettings()
		skillsList, ok := allSettings["skills"].([]interface{})
		if !ok {
			panic("skills is not a list")
		}
		for _, skillItem := range skillsList {
			skillMap, ok := skillItem.(map[string]interface{})
			if !ok {
				panic("skill item is not a map")
			}
			// 从map中提取lang和level
			lang, _ := skillMap["lang"].(string)
			level, _ := skillMap["level"].(string)
			log.Logger.Info().Msgf("skills.lang:%s  skills.level:%s", lang, level)
		}
		// 读取嵌套字段
		main := config.Viper.GetString("food.breakfast.main")
		log.Logger.Info().Msgf("food.breakfast.main: %v", main)
		drink := config.Viper.GetString("food.breakfast.drink")
		log.Logger.Info().Msgf("food.breakfast.drink: %v", drink)
		// 从config.{env.GO_ENVIRONMENT}.yaml读取内容
		env := config.Viper.GetString("env")
		log.Logger.Info().Msgf("env: %s", env)
		// 从环境变量读取内容
		gopath := config.Viper.GetString("GOPATH")
		log.Logger.Info().Msgf("GOPATH: %s", gopath)
		log.Logger.Info().Msg("读取config和环境变量结束")

		// 调用函数
		var ret = sub.Sub1(age)
		log.Logger.Info().Msgf("调用函数的返回值为：%d ", ret)

		// 等待30秒
		// time.Sleep(30 * time.Second)

		os.Exit(0)
	}

	firstArgument := os.Args[1]
	switch firstArgument {
	case "Redis":
		// 调用Redis
		redis.RedisClient()
	case "Etcd":
		// 调用Etcd
		etcd.EtcdClient()
	case "Postgre":
		// 调用Postgre
		postgre.PostgreBase()
		postgre.PostgreOrm()
	default:
		log.Logger.Warn().Msg("无法识别此参数")
		os.Exit(1)
	}
	os.Exit(0)
}
