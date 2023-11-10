package main

import (
	"context"
	"fmt"
	"google.golang.org/grpc"
	"grpc-go-demo/product"
)

const (
	address = "localhost:50051"
)

func main() {
	conn, err := grpc.Dial(address, grpc.WithInsecure())
	if err != nil {
		fmt.Println("[Golang][Client] did not connect.", err)
		return
	}
	defer conn.Close()

	client := product.NewProductInfoClient(conn)
	ctx := context.Background()

	id := AddProduct(ctx, client)
	GetProduct(ctx, client, id)
}

// 添加一个测试的商品
func AddProduct(ctx context.Context, client product.ProductInfoClient) (id string) {
	aMac := &product.Product{Name: "Mac Book Pro 2019", Description: "Add by Golang"}
	productId, err := client.AddProduct(ctx, aMac)
	if err != nil {
		fmt.Println("[Golang][Client] Add product fail.", err)
		return
	}
	fmt.Println("[Golang][Client] Add product success, id = ", productId.Value)
	return productId.Value
}

// 获取一个商品
func GetProduct(ctx context.Context, client product.ProductInfoClient, id string) {
	p, err := client.GetProduct(ctx, &product.ProductId{Value: id})
	if err != nil {
		fmt.Println("[Golang][Client] Get product err.", err)
		return
	}
	fmt.Printf("[Golang][Client] Get prodcut success : %+v\n", p)
}
