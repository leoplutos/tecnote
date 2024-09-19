package log

import (
	"fmt"
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/pkgerrors"
	"gopkg.in/natefinch/lumberjack.v2"
	"io"
	"my.sample/GoSampleProject/src/config"
	"os"
	"path/filepath"
	"runtime"
	"strconv"
)

const (
	CustTimeFormat = "2006-01-02 15:04:05"
)

// 定义一个全局的Logger实例
var Logger zerolog.Logger

// 当这个包被导入时，init函数会自动执行
func init() {

	// 从config.{env.GO_ENVIRONMENT}.yaml读取内容
	// 写入日志级别
	minLevel := config.Viper.GetString("zerolog.min_level")
	logLevel := zerolog.DebugLevel
	switch minLevel {
	case "trace":
		logLevel = zerolog.TraceLevel
	case "debug":
		logLevel = zerolog.DebugLevel
	case "info":
		logLevel = zerolog.InfoLevel
	case "warn":
		logLevel = zerolog.WarnLevel
	case "error":
		logLevel = zerolog.ErrorLevel
	case "fatal":
		logLevel = zerolog.FatalLevel
	case "panic":
		logLevel = zerolog.PanicLevel
	case "disabled":
		logLevel = zerolog.Disabled
	case "nolevel":
		logLevel = zerolog.NoLevel
	}
	fmt.Printf("日志级别: %v\n", logLevel)

	// 使用 Stacktrace 进行错误日志记录
	zerolog.ErrorStackMarshaler = pkgerrors.MarshalStack

	output := config.Viper.GetString("zerolog.output")
	var logWriter io.Writer
	if output == "console" {
		// 控制台输出
		logWriter = zerolog.ConsoleWriter{Out: os.Stdout, TimeFormat: CustTimeFormat}
		fmt.Printf("控制台输出\n")
	} else {
		// 文件输出
		filename := config.Viper.GetString("lumberjack.filename")
		maxsize := config.Viper.GetInt("lumberjack.maxsize")
		maxbackups := config.Viper.GetInt("lumberjack.maxbackups")
		maxage := config.Viper.GetInt("lumberjack.maxage")
		compress := config.Viper.GetBool("lumberjack.compress")
		fmt.Printf("文件输出\n")
		fmt.Printf("Filename:%s  MaxSize:%d  MaxBackups:%d  MaxAge:%d  Compress:%t\n", filename, maxsize, maxbackups, maxage, compress)
		// 创建lumberjack日志滚动配置
		logWriter = &lumberjack.Logger{
			Filename:   filename,   // 日志文件的位置
			MaxSize:    maxsize,    // 每个日志文件保存的最大尺寸 单位：MB
			MaxBackups: maxbackups, // 日志文件最多保存多少个备份
			MaxAge:     maxage,     // 文件最多保存多少天
			Compress:   compress,   // 是否压缩/归档旧文件
		}
		zerolog.TimeFieldFormat = CustTimeFormat
		zerolog.CallerMarshalFunc = func(pc uintptr, file string, line int) string {
			return filepath.Base(file) + ":" + strconv.Itoa(line)
		}
	}
	Logger = zerolog.New(logWriter).Level(logLevel).With().Timestamp().Caller().Int("gid", runtime.NumGoroutine()).Logger()
}
