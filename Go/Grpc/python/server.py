from email.policy import default
import uuid
import argparse
from xml.sax import parseString
from datetime import datetime
import grpc
from concurrent import futures
import ProductInfo_pb2
import ProductInfo_pb2_grpc

# server_address = "[::]:50051"
# server_address = "localhost:50051"
server_host: str = "localhost"
# 储存Product的词典
productDict: dict[str, ProductInfo_pb2.Product] = {}


# 实现业务逻辑
class ProductServiceImpl(ProductInfo_pb2_grpc.ProductInfoServicer):

    # 添加Product
    def addProduct(self, request, context):
        # request的类型为ProductInfo_pb2.Product
        global productDict
        request.id = uuid.uuid4().hex
        productDict[request.id] = request
        dtStr = datetime.now().strftime("%Y/%m/%d %H:%M:%S")
        print(
            f"[{dtStr}][Python][Server] AddProduct success. id = {request.id}, name = {request.name}, description = {request.description}"
        )
        print(request)
        return ProductInfo_pb2.ProductId(value=request.id)

    # 取得Product
    def getProduct(self, request, context):
        # request的类型为ProductInfo_pb2.ProductId
        global productDict
        productInfo = productDict.get(request.value)
        if productInfo == None:
            productInfo = ProductInfo_pb2.Product(
                id='None Id', name='None Name', description='Python gRPC Server'
            )
        dtStr = datetime.now().strftime("%Y/%m/%d %H:%M:%S")
        print(f"[{dtStr}][Python][Server] GetProduct success. id = {request.value}")
        print(productInfo)
        return productInfo


def serve():
    # 服务端口，如果参数传入则使用，默认50051
    parser = argparse.ArgumentParser()
    parser.add_argument("--port", help="service port", type=int, default=50051)
    args = parser.parse_args()
    server_port = 50051
    if args.port:
        server_port = args.port
    server_address = server_host + ":" + str(server_port)

    # 启动gRPC服务
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    # 绑定处理器
    ProductInfo_pb2_grpc.add_ProductInfoServicer_to_server(ProductServiceImpl(), server)

    server.add_insecure_port(server_address)
    server.start()

    dtStr = datetime.now().strftime("%Y/%m/%d %H:%M:%S")
    print(f"[{dtStr}][Python][Server] gRPC 服务端已开启，端口为:{server_address}")
    server.wait_for_termination()


# 程序主入口
if __name__ == '__main__':
    serve()
