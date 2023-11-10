//添加外部引用声明
#[macro_use]
extern crate lazy_static;

use tonic::{transport::Server, Request, Response, Status};

// rust为当前工程名
// product_info_server为proto文件中定义的server名字[ProductInfo]加上server
use rust::product_info_server::{ProductInfo, ProductInfoServer};
use rust::{Product, ProductId};
use std::collections::HashMap;
use std::sync::Mutex;
use uuid::Uuid;

pub mod rust {
    //这里指定的字符串必须与proto的包名称一致[package grpc_demo;]
    tonic::include_proto!("grpc_demo");
}

//使用第三方库lazy_static来管理全局静态变量
lazy_static! {
    static ref PRODUCT_MAP: Mutex<HashMap<String, Product>> = {
        let mut map: HashMap<String, Product> = HashMap::new();
        Mutex::new(map)
    };
}

#[derive(Debug, Default)]
pub struct MyProductInfo {}

#[tonic::async_trait]
impl ProductInfo for MyProductInfo {
    //添加商品
    async fn add_product(&self, request: Request<Product>) -> Result<Response<ProductId>, Status> {
        // 创建新的uuid
        let uuid: String = Uuid::new_v4().to_string();
        // 请求的结构体
        let request_product: Product = request.into_inner();
        // 复制一个请求内容，并且赋予新的uuid
        let new_product: Product = Product {
            id: uuid,
            //这里调用clone方法，不然所有权会丢失
            name: request_product.name.clone(),
            description: request_product.description.clone(),
        };
        // 添加到全局静态变量中
        PRODUCT_MAP
            .lock()
            .unwrap()
            .insert(new_product.id.clone(), new_product.clone());
        println!("[Rust][Server] AddProduct success. {:?}", new_product);

        //返回的结构体
        let reply: ProductId = rust::ProductId {
            value: new_product.id.clone(),
        };

        Ok(Response::new(reply))
    }

    //获取商品
    async fn get_product(&self, request: Request<ProductId>) -> Result<Response<Product>, Status> {
        let get_id = request.into_inner().value;
        // 从全局静态变量中取得
        let get_product = match PRODUCT_MAP.lock().unwrap().get(&get_id) {
            Some(product) => product.clone(),
            _ => {
                println!("[Rust][Server] GetProduct error. id: {}", &get_id);
                panic!()
            }
        };
        println!("[Rust][Server] GetProduct success. id: {}", &get_id);
        Ok(Response::new(get_product))
    }
}

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let port = 50051;
    let addr_str = format!("{}{}", String::from("[::1]:"), port);
    let addr = addr_str.parse()?;
    let server = MyProductInfo::default();

    println!("[Rust][Server] start gRPC listen on port: {} ", port);
    Server::builder()
        .add_service(ProductInfoServer::new(server))
        .serve(addr)
        .await?;

    Ok(())
}
