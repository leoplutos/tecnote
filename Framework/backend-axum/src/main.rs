use axum::{
    middleware::from_extractor,
    routing::{get, post},
    Router,
};
use core::net::SocketAddr;
use lazy_static::lazy_static;
use rusqlite::{Connection, Result};
use std::env;
use std::error::Error;
use std::sync::Mutex;
use tracing as log;
use tracing::instrument;

// 导入controller模块（controller.rs）
mod controller;
// 导入middleware模块（middleware.rs）
mod middleware;
// 导入utils模块（utils.rs）
mod utils;

// 使用第三方库lazy_static来管理全局静态变量
lazy_static! {
    // Mutex 互斥锁
    // 同一时间，只允许一个线程访问该值，其它线程需要等待访问完成后才能继续
    // 全局数据库连接
    static ref DB: Mutex<Result<Connection>> = Mutex::new(Connection::open_in_memory());
}

// 开启HTTP服务
#[instrument]
async fn start_server_async() -> Result<(), Box<dyn Error>> {
    // 初始化日志
    utils::log::init_log_async().await?;
    // 初始化内存数据库
    utils::db::init_db_async().await?;

    // 读取环境变量[RUST_HTTP_PORT]的设定值
    let defualt_port: u32 = 9501;
    // 读取环境变量，默认9501
    let rust_env_str: String = match env::var("RUST_HTTP_PORT") {
        Ok(value) => {
            log::info!("环境变量 RUST_HTTP_PORT 的设定值为: {}", value);
            value
        }
        Err(_) => {
            log::info!(
                "环境变量 RUST_HTTP_PORT 未设定，使用默认值: {}",
                defualt_port
            );
            // 读取环境变量失败，设定默认值
            defualt_port.to_string()
        }
    };

    // HTTP启动参数
    let host = "0.0.0.0";
    let port: u32 = match rust_env_str.parse::<u32>() {
        Ok(port) => port,
        Err(_) => defualt_port,
    };
    let addr_str: String = format!("{}:{}", host, port);
    let addr: SocketAddr = addr_str.parse()?;
    log::info!("后端服务 axum 已开启. {}", addr_str);

    // 路由信息
    let app = Router::new()
        .route("/", get(root))
        .route("/login", post(controller::login_controller::login))
        // 绑定路由并注册中间件Auth
        .route(
            "/todo/getAll",
            post(controller::todo_controller::todo_get_all)
                .layer(from_extractor::<middleware::auth::Auth>()),
        );
    // 添加监听端口
    let listener = tokio::net::TcpListener::bind(addr).await?;
    // 注册路由并开启HTTP服务
    axum::serve(listener, app).await?;

    Ok(())
}

// 根目录的路由
async fn root() -> &'static str {
    "backend-axum"
}

#[tokio::main]
async fn main() {
    // 开始服务
    let ret = start_server_async().await;
    match ret {
        Ok(()) => log::info!("后端服务 actix_web 运行结束"),
        Err(e) => {
            log::error!("后端服务 actix_web 运行失败: {}", e)
        }
    }
}
