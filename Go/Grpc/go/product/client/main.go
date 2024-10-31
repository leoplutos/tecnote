package main

import (
	"context"
	"flag"
	"gogrpc/product/log"
	stub "gogrpc/stub"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
	"time"
)

var (
	// 使用flag包解析命令行参数
	addr = flag.String("addr", "localhost:50051", "连接Endpoint")
)

// ######################################
// gRPC客户端主入口
// ######################################
func main() {
	// 解析命令行参数
	flag.Parse()

	// address := "localhost:50051"
	// conn, err := grpc.Dial(address, grpc.WithInsecure())
	// 连接服务器
	conn, err := grpc.NewClient(*addr, grpc.WithTransportCredentials(insecure.NewCredentials()))
	if err != nil {
		log.Logger.Fatal().Stack().Err(err).Msg("[Golang][Client] 无法连接服务器")
		return
	}
	// 程序关闭前，释放连接
	defer func() {
		conn.Close()
		log.Logger.Info().Msgf("[Golang][Client] 已关闭gRPC连接")
	}()

	// 创建创建超时Context
	ctx, cancel := context.WithTimeout(context.Background(), time.Second)
	// 确保在函数结束时调用cancel，释放资源
	defer cancel()

	// 创建业务客户端
	client := stub.NewProductInfoClient(conn)
	// 添加商品
	id := AddProduct(ctx, client)
	// 取得商品
	GetProduct(ctx, client, id)
}

// 添加商品
func AddProduct(ctx context.Context, client stub.ProductInfoClient) (id string) {
	aMac := &stub.Product{Name: "Mac Book Pro 2019", Description: "Add by Golang"}
	// 远程调用
	response, err := client.AddProduct(ctx, aMac)
	if err != nil {
		log.Logger.Fatal().Stack().Err(err).Msg("[Golang][Client] Add product fail")
		return
	}
	log.Logger.Info().Msgf("[Golang][Client] Add product success. id=%s", response.Value)
	return response.Value
}

// 取得商品
func GetProduct(ctx context.Context, client stub.ProductInfoClient, id string) {
	// 远程调用
	response, err := client.GetProduct(ctx, &stub.ProductId{Value: id})
	if err != nil {
		log.Logger.Fatal().Stack().Err(err).Msg("[Golang][Client] Get product fail")
		return
	}
	log.Logger.Info().Msgf("[Golang][Client] Get product success.  %+v", response)
}
