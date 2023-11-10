import grpc

import ProductInfo_pb2
import ProductInfo_pb2_grpc


def main():
    with grpc.insecure_channel('localhost:50051') as channel:
        stub = ProductInfo_pb2_grpc.ProductInfoStub(channel)
        # addRespon的类型为ProductInfo_pb2.ProductId
        addRespon = stub.addProduct(
            ProductInfo_pb2.Product(
                name='Mac Book Pro 2020', description='Add by Python'
            )
        )
        print(f"[Python][Client] Add product success. id = {addRespon.value}")
        # getRespon的类型为ProductInfo_pb2.Product
        getRespon = stub.getProduct(ProductInfo_pb2.ProductId(value=addRespon.value))
        print(f"[Python][Client] Get prodcut success")
        print(getRespon)


if __name__ == '__main__':
    main()
