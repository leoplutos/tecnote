package services

import (
	"context"
	"fmt"
	"github.com/google/uuid"
	stub "gogrpc/stub"
	"log"
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

	pid := fmt.Sprintf("%s | ServerPort: %d", uuid.NewString(), s.serverPort)
	request.Id = pid

	// 将请求放入词典
	if s.productMap == nil {
		s.productMap = make(map[string]*stub.Product)
	}
	s.productMap[request.Id] = request

	// 设定返回值
	response.Value = request.Id

	log.Printf("[Golang][Server] AddProduct success. id=%s, name=%s, description=%s\n", request.Id, request.Name, request.Description)
	return
}

// 实现获取商品
func (s *ProductService) GetProduct(_ context.Context, request *stub.ProductId) (response *stub.Product, err error) {
	if s.productMap == nil {
		s.productMap = make(map[string]*stub.Product)
	}

	response = s.productMap[request.Value]
	log.Printf("[Golang][Server] GetProduct success. id=%s\n", request.Value)
	return
}
