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

func InitLog() {
	zerolog.ErrorStackMarshaler = pkgerrors.MarshalStack
	output := zerolog.ConsoleWriter{Out: os.Stdout, TimeFormat: CustTimeFormat}
	Logger = zerolog.New(output).Level(zerolog.TraceLevel).With().Timestamp().Caller().Int("gid", runtime.NumGoroutine()).Logger()
}
