package sub

import (
	"my.sample/GoSampleProject/src/log"
)

func Sub1(param int) int {
	var a string = "这是一个测试字符串"
	log.Logger.Info().Msg(a)

	var b, c int = 1, 2
	log.Logger.Info().Msgf("b=%d  c=%d", b, c)

	return param
}
