package services

import (
	"context"
	"fmt"
	"github.com/google/uuid"
	"gogrpc/product/log"
	stub "gogrpc/stub"
)

// ######################################
// Product服务的业务实现
// ######################################
type ProductService struct {
	// 监听端口
	serverPort int
	// 储存Product的全局词典
	productMap map[string]*stub.Product
	// 继承结构体
	stub.UnimplementedProductInfoServer
}

// 构造函数
func ProductServiceBuilder(port int) *ProductService {
	return &ProductService{serverPort: port}
}

// 实现添加商品
func (s *ProductService) AddProduct(_ context.Context, request *stub.Product) (response *stub.ProductId, err error) {
	// 返回值
	response = &stub.ProductId{}

	// 对数据库友好的 UUID v7
	uuidv7, _ := uuid.NewV7()
	pid := fmt.Sprintf("%s | ServerPort: %d", uuidv7.String(), s.serverPort)
	request.Id = pid

	// 将请求放入词典
	if s.productMap == nil {
		s.productMap = make(map[string]*stub.Product)
	}
	s.productMap[request.Id] = request

	// 设定返回值
	response.Value = request.Id

	log.Logger.Info().Msgf("[Golang][Server] AddProduct success. id=%s, name=%s, description=%s", request.Id, request.Name, request.Description)
	return
}

// 实现获取商品
func (s *ProductService) GetProduct(_ context.Context, request *stub.ProductId) (response *stub.Product, err error) {
	if s.productMap == nil {
		s.productMap = make(map[string]*stub.Product)
	}
	// 从Product的全局词典中取得
	response = s.productMap[request.Value]
	if response == nil {
		// 未取得时
		// 使用 & 符号可以将一个结构体的实例转换为指针
		response = &stub.Product{Id: "None Id", Name: "None Name", Description: "Golang gRPC Server"}
		log.Logger.Error().Msgf("[Golang][Server] GetProduct error. id=%s", request.Value)
	} else {
		// 取得时
		log.Logger.Info().Msgf("[Golang][Server] GetProduct success. id=%s", request.Value)
	}
	return
}
