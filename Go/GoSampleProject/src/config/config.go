package config

import (
	"fmt"
	"github.com/fsnotify/fsnotify"
	"github.com/spf13/viper"
)

// 创建一个包级Viper实例
var Viper *viper.Viper

// 当这个包被导入时，init函数会自动执行
func init() {
	// 初始化Viper实例
	Viper = viper.New()

	// 配置多来源
	// 1.config.yaml
	// 2.config.{env.GO_ENVIRONMENT}.yaml
	// 3.OS的环境变量

	// 来源3.读取所有的OS环境变量
	Viper.AutomaticEnv()

	goEnv := Viper.GetString("GO_ENVIRONMENT")
	if goEnv == "" {
		goEnv = "dev"
	}
	fmt.Printf("环境变量 GO_ENVIRONMENT 的设定值为: %s\n", goEnv)

	// 来源1.config.yaml
	// 设置配置文件类型，支持的格式有 "json", "toml", "yaml", "yml", "properties", "props", "env", "envfile", "ini" 等
	Viper.SetConfigType("yaml")
	// 设置配置文件名称，不包含扩展名
	Viper.SetConfigName("config")
	// 设置配置文件的路径（可以是多个路径），点的含义为在当前路径下（GoSampleProject工程根目录下）
	Viper.AddConfigPath(".")
	// 尝试读取配置文件
	if err := Viper.ReadInConfig(); err != nil {
		panic(err)
	}
	// 监视文件被修改
	Viper.OnConfigChange(func(e fsnotify.Event) {
		fmt.Printf("配置文件已被修改: %s\n", e.Name)
	})
	Viper.WatchConfig()

	// 来源2.config.{env.GO_ENVIRONMENT}.yaml
	fileName := fmt.Sprintf("config.%s", goEnv)
	Viper.SetConfigType("yaml")
	Viper.SetConfigName(fileName)
	Viper.AddConfigPath(".")
	if err := Viper.MergeInConfig(); err != nil {
		panic(err)
	}
	// 监视文件被修改
	Viper.OnConfigChange(func(e fsnotify.Event) {
		fmt.Printf("配置文件已被修改: %s\n", e.Name)
	})
	Viper.WatchConfig()
}
