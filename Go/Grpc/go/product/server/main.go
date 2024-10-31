package main

import (
	"flag"
	"fmt"
	"gogrpc/product/log"
	"gogrpc/product/services"
	stub "gogrpc/stub"
	"google.golang.org/grpc"
	"net"
)

var (
	// 使用flag包解析命令行参数
	port = flag.Int("port", 50051, "gRPC端口")
)

// ######################################
// gRPC服务启动主入口
// ######################################
func main() {
	// 解析命令行参数
	flag.Parse()

	// 初始化log
	// log.InitLog()

	// 监听端口
	listener, err := net.Listen("tcp", fmt.Sprintf(":%d", *port))
	if err != nil {
		log.Logger.Fatal().Stack().Err(err).Msg("[Golang][Server] 监听端口失败")
		panic(err)
	}

	// gRPC服务端
	grpcServer := grpc.NewServer()
	// 注册服务
	// product.RegisterProductInfoServer(grpcServer, &services.ProductService{})
	productService := services.ProductServiceBuilder(*port)
	stub.RegisterProductInfoServer(grpcServer, productService)
	log.Logger.Info().Msgf("[Golang][Server] gRPC 服务端已开启，监听 %v", listener.Addr())

	// 启动gRPC服务（这里会堵塞线程）
	if err := grpcServer.Serve(listener); err != nil {
		log.Logger.Fatal().Stack().Err(err).Msg("[Golang][server] gRPC 服务端启动失败")
	}
	// 程序关闭前，关闭gRPC连接
	defer func() {
		grpcServer.Stop()
	}()
}
