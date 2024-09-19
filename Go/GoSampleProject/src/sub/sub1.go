package sub

import (
	"my.sample/GoSampleProject/src/log"
	"sync"
	"time"
)

// 定义枚举（Go里面没有枚举）
type OddEven int

const (
	// iota是一个预声明的标识符，用于生成唯一的常量值
	// 奇数
	Odd OddEven = iota
	// 偶数
	Even
)

// 定义计数器
var waitgroup sync.WaitGroup

func Sub1(param int) int {
	log.Logger.Info().Msgf("传入的参数为: %d", param)

	var b, c int = 1, 2
	//log.Logger.Info().Msgf("b: %d   c: %d", b, c)

	//	计算
	ret := (param + b) * c
	log.Logger.Info().Msgf("计算结果为: %d", ret)

	log.Logger.Info().Msgf("Goroutine开始")

	// 定义无缓冲 channel
	channel := make(chan OddEven)

	for i := 0; i < 5; i++ {
		// 计数器+1
		waitgroup.Add(1)
		// Goroutine 调用
		go judgeOddEven(i, channel)
	}

	for i := 0; i < 5; i++ {
		// 从 channel 接收数据
		oe := <-channel
		if oe == Even {
			log.Logger.Info().Msgf("偶数")
		} else {
			log.Logger.Info().Msgf("奇数")
		}
	}

	// 等待所以协程执行完毕
	waitgroup.Wait() // 当计数器为0时, 不再阻塞

	log.Logger.Info().Msgf("Goroutine结束")

	return ret
}

// 求奇偶的函数
func judgeOddEven(num int, channel chan OddEven) {
	// 计数器 - 1
	defer waitgroup.Done()
	if num%2 == 0 {
		// 向 channel 发送数据（偶数）
		channel <- Even
	} else {
		// 向 channel 发送数据（奇数）
		channel <- Odd
	}
	// log.Logger.Info().Msgf("%d", num)
	time.Sleep(1000 * time.Millisecond)
}
