// rust为当前工程名
// product_info_client为proto文件中定义的server名字[ProductInfo]加上client
use rust::product_info_client::ProductInfoClient;
use rust::{Product, ProductId};

pub mod rust {
    //这里指定的字符串必须与proto的包名称一致[package grpc_demo;]
    tonic::include_proto!("grpc_demo");
}

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    //let mut client = ProductInfoClient::connect("http://[::1]:50051").await?;
    let mut client = ProductInfoClient::connect("http://127.0.0.1:50051").await?;

    let add_request = tonic::Request::new(Product {
        id: "".into(),
        name: "Mac Book Pro 2022".into(),
        description: "Add by Rust".into(),
    });
    let product_id_message = client.add_product(add_request).await?;
    let product_id = product_id_message.into_inner().value.clone();
    println!("[Rust][Client] Add product success, id = {}", product_id);

    let get_request = tonic::Request::new(ProductId { value: product_id });
    let product_info_message = client.get_product(get_request).await?;
    let product_info = product_info_message.into_inner();
    println!("[Rust][Client] Get product success,  {:?}", product_info);

    Ok(())
}
