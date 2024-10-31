use crate::stub::product::product_info_server::ProductInfo;
use crate::stub::product::{Product, ProductId};
use lazy_static::lazy_static;
use std::collections::HashMap;
use std::error::Error;
use std::sync::RwLock;
use tonic::{Request, Response, Status};
use tracing as log;
// use tracing::instrument;
use uuid::Uuid;

//使用第三方库lazy_static来管理全局静态变量
lazy_static! {
    // RwLock（读写锁）
    // 同时允许多个读，最多只能有一个写，读和写不能同时存在
    pub static ref PRODUCT_MAP: RwLock<HashMap<String, Product>> = {
        let map: HashMap<String, Product> = HashMap::new();
        RwLock::new(map)
    };
}

// 定义业务逻辑
#[derive(Debug, Default)]
// #[derive(Debug)]
pub struct ProductServiceImpl {
    // 服务端启动端口
    port: u32,
}

// 自定义构造函数，为了将port传递进来
impl ProductServiceImpl {
    // 构造函数
    pub async fn new_async(port: u32) -> Result<Self, Box<dyn Error>> {
        let instance = Self { port };
        Ok(instance)
    }
}

// 实现业务逻辑
#[tonic::async_trait]
impl ProductInfo for ProductServiceImpl {
    //添加商品
    // 添加 #[instrument] 会打印 self 信息，导致日志庞大
    // #[instrument]
    async fn add_product(&self, request: Request<Product>) -> Result<Response<ProductId>, Status> {
        // 创建请求id
        let pid = format!("{} | ServerPort: {}", Uuid::new_v4().to_string(), self.port);
        // 请求的结构体
        let request_product: Product = request.into_inner();
        // 复制一个请求内容，并且赋予新的uuid
        let new_product: Product = Product {
            id: pid,
            //这里调用clone方法，不然所有权会丢失
            name: request_product.name,
            description: request_product.description,
        };
        // 添加到全局静态变量中
        PRODUCT_MAP
            .try_write()
            .unwrap()
            .insert(new_product.id.clone(), new_product.clone());
        log::info!(
            "[Rust][Server] AddProduct success. id={}, name={}, description={}",
            &new_product.id,
            &new_product.name,
            &new_product.description
        );

        //返回的结构体
        let response: ProductId = ProductId {
            value: new_product.id.clone(),
        };

        Ok(Response::new(response))
    }

    //获取商品
    // 添加 #[instrument] 会打印 self 信息，导致日志庞大
    // #[instrument]
    async fn get_product(&self, request: Request<ProductId>) -> Result<Response<Product>, Status> {
        let get_id: String = request.into_inner().value;
        // 从全局静态变量中取得
        let get_product: Product = match PRODUCT_MAP.try_read().unwrap().get(&get_id) {
            Some(product) => {
                // 取得时返回的内容
                log::info!("[Rust][Server] GetProduct success. id={}", &get_id);
                product.clone()
            }
            _ => {
                // 未取得时返回的内容
                log::warn!("[Rust][Server] GetProduct error. id={}", &get_id);
                // panic!()
                Product {
                    id: String::from("None Id"),
                    name: String::from("None Name"),
                    description: String::from("Rust gRPC Server"),
                }
            }
        };
        Ok(Response::new(get_product))
    }
}
