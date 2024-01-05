use rusqlite::{Connection, Result};
use std::sync::Mutex;
mod bootstrap;
mod common_response;
mod controller;
mod middleware;

#[macro_use]
extern crate lazy_static;

lazy_static! {
    //全局数据库连接
    static ref DB: Mutex<Result<Connection>> = Mutex::new(Connection::open_in_memory());
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    use actix_web::{App, HttpServer};

    // 初始化内存数据库
    let _ = bootstrap::db::initialize_db();

    println!("starting HTTP server at http://localhost:9501/");
    HttpServer::new(|| {
        App::new()
            //添加中间件
            .wrap(middleware::auth::Auth)
            //添加路由
            .service(controller::login_controller::login)
            .service(controller::todo_controller::todo_get_all)
    })
    .bind(("127.0.0.1", 9501))?
    .run()
    .await
}
