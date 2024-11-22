#!/usr/bin/python
# -*- coding: utf-8 -*-

import uuid_utils as uuid
from loguru import logger
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
        # 对数据库友好的 UUID v7
        uuidv7: str = str(uuid.uuid7())
        pid: str = f"{uuidv7} | ServerPort: {self.port}"
        request.id = pid
        self.productDict[request.id] = request
        logger.info(
            "[Python][Server] AddProduct success. id={}, name={}, description={}",
            request.id,
            request.name,
            request.description,
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
        logger.info("[Python][Server] GetProduct success. id={}", productInfo.id)
        return productInfo
