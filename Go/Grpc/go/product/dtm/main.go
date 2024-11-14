package main

import (
	dtmgrpc "github.com/dtm-labs/client/dtmgrpc"
	"github.com/google/uuid"
	"gogrpc/product/log"
	stub "gogrpc/stub"
)

// 汇款业务
func remittance(amount int64, transOutResult string, transInResult string) {
	log.Logger.Info().Msgf("remittance 开始")

	// dtm服务URL（前面不能加http://）
	dtmGprcUrl := "localhost:36790"

	// dtm 的 Global ID
	gid := uuid.NewString()
	log.Logger.Info().Msgf("Dtm 汇款 开始, gid: %v", gid)
	log.Logger.Info().Msgf("amount: %v, transOutResult: %v, transInResult: %v", amount, transOutResult, transInResult)

	// 汇款金额
	request := &stub.DisTransReq{Amount: amount, TransOutResult: transOutResult, TransInResult: transInResult}

	// 当 svc 以 http 或 https 开头时，DTM 服务器将向 svc 发送 HTTP 请求, 比如 [http://localhost:50051]
	// 当 svc 不以 http 或 https 开头时，DTM 服务器会向 svc 发送 gRPC 请求, 比如 [localhost:50051]
	// 因为 dtm 和 各个微服务都在容器内运行，这里设定宿主机地址
	transferOutSvc := "host.docker.internal:50051"
	transferInSvc := "host.docker.internal:50052"

	// sage 模式
	saga := dtmgrpc.NewSagaGrpc(dtmGprcUrl, gid).
		// 添加 saga子事务
		Add(
			// 正常操作URL
			transferOutSvc+"/dtm_demo.DisTrans/transferOut",
			// 回滚操作URL
			transferOutSvc+"/dtm_demo.DisTrans/transferOutRollback",
			// 操作参数
			request).
		Add(transferInSvc+"/dtm_demo.DisTrans/transferIn",
			transferInSvc+"/dtm_demo.DisTrans/transferInRollback",
			request)
	// 开启等待结果
	saga.WaitResult = true
	// 让saga并发执行（默认是顺序执行）
	saga.Concurrent = true
	// 设定重试次数
	//saga.RetryCount = 1
	saga.RetryLimit = 1
	// saga.RetryInterval = 10
	// saga.TimeoutToFail = 100

	err := saga.Submit()
	if err != nil {
		log.Logger.Info().Msgf("Dtm 汇款 失败, gid: %v, err: %v", gid, err)
	} else {
		log.Logger.Info().Msgf("Dtm 汇款 成功, gid: %v", gid)
	}
	log.Logger.Info().Msgf("remittance 结束")
}

// ######################################
// Dtm示例
// 需要 go get github.com/dtm-labs/client
// ######################################
func main() {
	log.Logger.Info().Msgf("DtmClient 开始")
	// 汇款前银行A余额：10000 银行B余额：10000
	// 汇款第一次：100 成功
	remittance(100, "", "")
	// 汇款第二次：200 transferOut会失败
	remittance(200, "FAILURE", "")
	// 汇款第三次：300 transferIn会失败
	remittance(300, "", "FAILURE")
	// 全部运行后，只有第一次汇款成功
	// 汇款后银行A余额：9900 银行B余额：10100
	log.Logger.Info().Msgf("DtmClient 结束")
}
