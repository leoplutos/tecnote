import uuid
import grpc
from concurrent import futures
import ProductInfo_pb2
import ProductInfo_pb2_grpc

server_address = "[::]:50051"
productDict = {}


class ProductInfo(ProductInfo_pb2_grpc.ProductInfoServicer):
    def addProduct(self, request, context):
        # request的类型为ProductInfo_pb2.Product
        global productDict
        request.id = uuid.uuid4().hex
        productDict[request.id] = request
        print(f"[Python][Server] AddProduct success. id = {request.id}")
        print(request)
        return ProductInfo_pb2.ProductId(value=request.id)

    def getProduct(self, request, context):
        # request的类型为ProductInfo_pb2.ProductId
        global productDict
        productInfo = productDict[request.value]
        print(f"[Python][Server] GetProduct success. id = {request.value}")
        print(productInfo)
        return productInfo


def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    # 绑定处理器
    ProductInfo_pb2_grpc.add_ProductInfoServicer_to_server(ProductInfo(), server)

    server.add_insecure_port(server_address)
    server.start()
    print(f"[Python][Server] gRPC 服务端已开启，端口为:{server_address}")
    server.wait_for_termination()


if __name__ == '__main__':
    serve()
