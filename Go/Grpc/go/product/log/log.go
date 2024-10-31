package log

import (
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/pkgerrors"
	"os"
	"runtime"
)

const (
	CustTimeFormat = "2006-01-02 15:04:05"
)

// 定义一个全局的Logger实例
var Logger zerolog.Logger

// 当这个包被导入时，init函数会自动执行
func init() {

	// 使用 Stacktrace 进行错误日志记录
	zerolog.ErrorStackMarshaler = pkgerrors.MarshalStack
	// 设定日期格式
	zerolog.TimeFieldFormat = CustTimeFormat

	// 读取环境变量
	envVar := os.Getenv("GO_ENVIRONMENT")
	switch envVar {
	case "docker":
		// Docker环境，采用json结构打印
		jsonConsole()
	default:
		// 其他，采用漂亮打印
		prettyConsole()
	}
}

// 采用漂亮打印
func prettyConsole() {
	// ConsoleWriter为使用漂亮打印
	logWriter := zerolog.ConsoleWriter{Out: os.Stdout, TimeFormat: CustTimeFormat}
	Logger = zerolog.New(logWriter).Level(zerolog.DebugLevel).With().Timestamp().Caller().Int("gid", runtime.NumGoroutine()).Logger()
}

// 采用Json日志
func jsonConsole() {
	Logger = zerolog.New(os.Stdout).Level(zerolog.DebugLevel).With().Timestamp().Caller().Int("gid", runtime.NumGoroutine()).Str("service_name", "GoGrpcService").Logger()
}
