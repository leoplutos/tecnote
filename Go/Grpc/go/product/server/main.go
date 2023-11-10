package main

import (
	"context"
	"fmt"
	"github.com/gofrs/uuid"
	"google.golang.org/grpc"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	"grpc-go-demo/product"
	"net"
)

const port = ":50051"

func main() {
	listener, err := net.Listen("tcp", port)
	if err != nil {
		fmt.Println("[Golang][Server] net listen err ", err)
		return
	}

	grpcServer := grpc.NewServer()
	product.RegisterProductInfoServer(grpcServer, &server{})
	fmt.Println("[Golang][Server] start gRPC listen on port " + port)
	if err := grpcServer.Serve(listener); err != nil {
		fmt.Println("[Golang][server]failed to serve...", err)
		return
	}
}

type server struct {
	productMap map[string]*product.Product
	product.UnimplementedProductInfoServer
}

// 添加商品
func (s *server) AddProduct(ctx context.Context, req *product.Product) (resp *product.ProductId, err error) {
	resp = &product.ProductId{}
	newUuid, err := uuid.NewV4()
	if err != nil {
		return resp, status.Errorf(codes.Internal, "err while generate the uuid ", err)
	}

	req.Id = newUuid.String()
	if s.productMap == nil {
		s.productMap = make(map[string]*product.Product)
	}

	s.productMap[req.Id] = req
	resp.Value = req.Id
	//fmt.Println("[Golang][Server] AddProduct success. id:" + req.Id)
	fmt.Printf("[Golang][Server] AddProduct success. %+v\n", req)
	return
}

// 获取商品
func (s *server) GetProduct(ctx context.Context, req *product.ProductId) (resp *product.Product, err error) {
	if s.productMap == nil {
		s.productMap = make(map[string]*product.Product)
	}

	resp = s.productMap[req.Value]
	fmt.Println("[Golang][Server] GetProduct success. id:" + req.Value)
	return
}
