import logging
import argparse
import grpc
from service.product_service import ProductServiceImpl
from concurrent import futures
import stub.ProductInfo_pb2_grpc as gpb

# server_address = "[::]:50051"
# server_address = "localhost:50051"
server_host: str = "0.0.0.0"
server_port: int = 50051


def start_server():
    # 控制台
    logging.basicConfig(
        level=logging.DEBUG,
        format="[%(asctime)s] %(levelname)s [%(thread)s][%(filename)s:%(lineno)d] - %(message)s",
    )

    global server_host
    global server_port

    # 服务端口，如果参数传入则使用，默认50051
    parser = argparse.ArgumentParser()
    parser.add_argument("--port", help="service port", type=int, default=50051)
    args = parser.parse_args()
    if args.port:
        server_port = args.port
    server_address: str = f"{server_host}:{server_port}"

    # gRPC服务
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    # 绑定业务逻辑
    # gpb.add_ProductInfoServicer_to_server(ProductServiceImpl(), server)
    gpb.add_ProductInfoServicer_to_server(ProductServiceImpl(server_port), server)
    # 添加监听端口
    server.add_insecure_port(server_address)
    # 启动服务
    server.start()

    logging.info(f"[Python][Server] gRPC 服务端已开启，端口为:{server_address}")
    server.wait_for_termination()


# 程序主入口
if __name__ == '__main__':
    start_server()
