import uuid
import logging
import grpc
from stub.ProductInfo_pb2 import Product, ProductId
import stub.ProductInfo_pb2_grpc as gpb


# 实现业务逻辑
class ProductServiceImpl(gpb.ProductInfoServicer):

    def __init__(self, port):
        self.port = port
        # 储存Product的词典
        self.productDict: dict[str, Product] = {}

    # 添加Product
    def addProduct(self, request: Product, context: grpc.ServicerContext) -> ProductId:
        # request的类型为ProductInfo_pb2.Product
        pid: str = f"{uuid.uuid4().hex} | ServerPort: {self.port}"
        request.id = pid
        self.productDict[request.id] = request
        logging.info(
            f"[Python][Server] AddProduct success. id={request.id}, name={request.name}, description={request.description}"
        )
        response: ProductId = ProductId(value=request.id)
        return response

    # 取得Product
    def getProduct(self, request: ProductId, context: grpc.ServicerContext) -> Product:
        # request的类型为ProductInfo_pb2.ProductId
        default: Product = Product(
            id='None Id', name='None Name', description='Python gRPC Server'
        )
        productInfo: Product = self.productDict.get(request.value, default)
        logging.info(f"[Python][Server] GetProduct success. id={productInfo.id}")
        return productInfo
