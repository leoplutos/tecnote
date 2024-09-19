import logging
import grpc
from stub.ProductInfo_pb2 import Product, ProductId
import stub.ProductInfo_pb2_grpc as gpb

server_host: str = "localhost"
server_port = 50051


def start_client():
    # 控制台
    logging.basicConfig(
        level=logging.DEBUG,
        format="[%(asctime)s] %(levelname)s [%(thread)s][%(filename)s:%(lineno)d] - %(message)s",
    )

    global server_host
    global server_port
    server_address: str = f"{server_host}:{server_port}"

    with grpc.insecure_channel(server_address) as channel:
        client = gpb.ProductInfoStub(channel)
        # add_response的类型为ProductInfo_pb2.ProductId
        add_response: ProductId = client.addProduct(
            Product(name='Mac Book Pro 2020', description='Add by Python')
        )
        logging.info(f"[Python][Client] Add product success. id={add_response.value}")
        # get_response的类型为ProductInfo_pb2.Product
        get_response: Product = client.getProduct(ProductId(value=add_response.value))
        logging.info(
            f"[Python][Client] Get prodcut success. id={get_response.id}, name={get_response.name}, description={get_response.description}"
        )


if __name__ == '__main__':
    start_client()
