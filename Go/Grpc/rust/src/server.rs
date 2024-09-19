use core::net::SocketAddr;
use services::product_service::ProductServiceImpl;
use std::error::Error;
use stub::product::product_info_server::ProductInfoServer;
use tonic::transport::Server;
use tracing as log;
use tracing::instrument;

// 导入utils模块（utils.rs）
pub mod utils;
// 导入services模块（services.rs）
pub mod services;
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

// 开始gRPC服务端
#[instrument]
async fn start_server_async() -> Result<(), Box<dyn Error>> {
    // 初始化日志
    utils::log::init_log_async().await?;

    let port: u32 = 50051;
    //let addr_str = format!("{}{}", String::from("[::1]:"), port);
    let addr_str: String = format!("{}:{}", "0.0.0.0", port);
    let addr: SocketAddr = addr_str.parse()?;
    // 业务逻辑
    // let product_service = ProductInfoServer::new(ProductServiceImpl::default());
    let product_service = ProductInfoServer::new(ProductServiceImpl::new_async(port).await?);

    log::info!("[Rust][Server] gRPC 服务端已开启，端口为: {}", port);
    // 开始gRPC服务端
    Server::builder()
        // 绑定业务逻辑
        .add_service(product_service)
        // 添加监听端口
        .serve(addr)
        .await?;

    Ok(())
}

#[tokio::main]
async fn main() -> Result<(), Box<dyn Error>> {
    // 开始gRPC服务端
    let ret = start_server_async().await;
    match ret {
        Ok(()) => log::info!("gRPC 服务端运行结束"),
        Err(e) => {
            log::error!("gRPC 服务端运行失败: {}", e)
        }
    }
    Ok(())
}
