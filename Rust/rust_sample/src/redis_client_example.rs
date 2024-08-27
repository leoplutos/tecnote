//use redis::Commands;
use redis::Commands;
use std::error::Error;
use std::time::Duration;
use tracing as log;
use uuid::Uuid;

fn redis_client() -> Result<(), Box<dyn Error>> {
    // 连接参数
    let conn_timeout: u64 = 1000;
    let client = redis::Client::open("redis://localhost:6379/")?;
    // 建立连接
    let conn = client.get_connection_with_timeout(Duration::from_millis(conn_timeout));
    let mut conn = match conn {
        Ok(conn) => conn,
        Err(error) => {
            log::error!("Redis连接失败: {:?}", error);
            panic!();
        }
    };

    // 设定Key
    let key: String = String::from("RustKey");
    let uuid: String = Uuid::new_v4().to_string();
    let set_value: String = format!("使用Rust客户端添加_{}", uuid);
    let _: () = conn.set(&key, &set_value)?;
    log::info!("添加Key成功    key={}    value={}", key, set_value);

    // 取得Key
    let get_value: String = conn.get(&key)?;
    log::info!("取得Key成功    key={}    value={}", key, get_value);

    // 判断Key是否存在
    let is_exists: bool = conn.exists(&key)?;
    log::info!("Key[{}]是否存在    {}", key, is_exists);
    let not_existkey: String = String::from("abcde");
    let is_exists: bool = conn.exists(&not_existkey)?;
    log::info!("Key[{}]是否存在    {}", not_existkey, is_exists);

    // 为Key设置过期时间(秒)
    let expire_seconds: i64 = 10;
    let _: () = conn.expire(&key, expire_seconds)?;
    log::info!("设定Key[{}]的过期时间为：{}秒", key, expire_seconds);

    Ok(())
}

fn main() {
    // install global collector configured based on RUST_LOG env var.
    tracing_subscriber::fmt::init();

    let _ = redis_client();
}
