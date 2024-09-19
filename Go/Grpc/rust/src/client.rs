use std::error::Error;
use stub::product::product_info_client::ProductInfoClient;
use stub::product::{Product, ProductId};
use tonic::Request;
use tracing as log;
use tracing::instrument;

// 导入utils模块（utils.rs）
pub mod utils;
// 导入自动生成存根
pub mod stub {
    // 如果有多个服务可以多次定义
    pub mod product {
        //这里指定的字符串必须与proto的包名称一致[package grpc_demo;]
        tonic::include_proto!("grpc_demo");
    }
    // pub mod hello {
    //     tonic::include_proto!("hello");
    // }
    // pub mod greeter {
    //     tonic::include_proto!("greeter");
    // }
}

// 开始gRPC客户端
#[instrument]
async fn start_client_async() -> Result<(), Box<dyn Error>> {
    // 初始化日志
    utils::log::init_log_async().await?;

    let host: &str = "localhost";
    let port: u32 = 50051;
    let address = format!("http://{}:{}", host, port);
    log::info!("[Rust][Client] 连接服务器: {}", address);
    // 连接 gRPC 服务端
    //let mut client = ProductInfoClient::connect("http://[::1]:50051").await?;
    let mut client = ProductInfoClient::connect(address).await?;

    // 调用添加商品
    let add_request = Request::new(Product {
        id: "".into(),
        name: "Mac Book Pro 2022".into(),
        description: "Add by Rust".into(),
    });
    let add_response = client.add_product(add_request).await?;
    let product_id = add_response.into_inner().value.clone();
    log::info!("[Rust][Client] AddProduct success. id={}", product_id);

    // 调用取得商品
    let get_request = Request::new(ProductId { value: product_id });
    let get_response = client.get_product(get_request).await?;
    let get_info: Product = get_response.into_inner();
    log::info!(
        "[Rust][Client] GetProduct success. id={}, name={}, description={}",
        get_info.id,
        get_info.name,
        get_info.description
    );

    Ok(())
}

#[tokio::main]
async fn main() -> Result<(), Box<dyn Error>> {
    // 开始gRPC客户端
    let ret = start_client_async().await;
    match ret {
        Ok(()) => log::info!("gRPC 客户端运行结束"),
        Err(e) => {
            log::error!("gRPC 客户端运行失败: {}", e)
        }
    }
    Ok(())
}
