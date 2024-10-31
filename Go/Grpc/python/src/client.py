#!/usr/bin/python
# -*- coding: utf-8 -*-

from loguru import logger
import asyncio
import grpc
from log.log import init_logger_async
from stub.ProductInfo_pb2 import Product, ProductId
import stub.ProductInfo_pb2_grpc as gpb

server_host: str = "localhost"
server_port = 50051


async def start_client():
    # 日志初始化
    await init_logger_async()

    global server_host
    global server_port
    server_address: str = f"{server_host}:{server_port}"
    logger.info("连接服务器: {}", server_address)

    with grpc.insecure_channel(server_address) as channel:
        client = gpb.ProductInfoStub(channel)
        # add_response的类型为ProductInfo_pb2.ProductId
        add_response: ProductId = client.addProduct(
            Product(name='Mac Book Pro 2020', description='Add by Python')
        )
        logger.info("[Python][Client] Add product success. id={}", add_response.value)
        # get_response的类型为ProductInfo_pb2.Product
        get_response: Product = client.getProduct(ProductId(value=add_response.value))
        logger.info(
            "[Python][Client] Get prodcut success. id={}, name={}, description={}",
            get_response.id,
            get_response.name,
            get_response.description,
        )


if __name__ == '__main__':
    try:
        asyncio.run(start_client())
    except KeyboardInterrupt:
        logger.info("[Python][Client] gRPC 客户端已关闭.")
