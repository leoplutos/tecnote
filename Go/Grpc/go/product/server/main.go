package main

import (
	"flag"
	"fmt"
	"gogrpc/product/services"
	stub "gogrpc/stub"
	"google.golang.org/grpc"
	"log"
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

	// 监听端口
	listener, err := net.Listen("tcp", fmt.Sprintf(":%d", *port))
	if err != nil {
		log.Fatalf("[Golang][Server] 监听端口失败: %v", err)
		panic(err)
	}

	// gRPC服务端
	grpcServer := grpc.NewServer()
	// 注册服务
	// product.RegisterProductInfoServer(grpcServer, &services.ProductService{})
	productService := services.ProductServiceBuilder(*port)
	stub.RegisterProductInfoServer(grpcServer, productService)
	log.Printf("[Golang][Server] gRPC 服务端已开启，监听 %v", listener.Addr())

	// 启动gRPC服务（这里会堵塞线程）
	if err := grpcServer.Serve(listener); err != nil {
		log.Fatalf("[Golang][server] gRPC 服务端启动失败: %v", err)
	}
	// 程序关闭前，关闭gRPC连接
	defer func() {
		grpcServer.Stop()
	}()
}
