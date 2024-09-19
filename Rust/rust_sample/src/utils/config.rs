use config::Config;
use lazy_static::lazy_static;
use std::collections::HashMap;
use std::env;
use std::sync::RwLock;
use tracing::instrument;

// 配置文件和环境变量读取
// 全局静态变量
lazy_static! {
    // RwLock（读写锁）
    // 同时允许多个读，最多只能有一个写，读和写不能同时存在
    pub static ref CONFIG: RwLock<Config> = {
        let defualt_env = String::from("dev");
        // 读取环境变量，默认dev
        let rust_env: String = match env::var("RUST_ENVIRONMENT") {
            Ok(value) => value,
            Err(_) => {
                // 读取环境变量失败，设定默认值
                defualt_env.clone()
            }
        };
        println!("环境变量 RUST_ENVIRONMENT 的设定值为: {}", rust_env);

        // 配置文件名
        let config_evn_file: String = format!("config.{}.toml", rust_env);

        // 使用config-rs配置多来源
        // 1.config.toml
        // 2.config.{env.RUST_ENVIRONMENT}.toml
        // 3.OS的环境变量
        let settings = Config::builder()
            // 设定默认值
            .set_default("environment", defualt_env).unwrap()
            // 读取 config.toml
            .add_source(config::File::with_name("config.toml"))
            // 读取 config.{env.RUST_ENVIRONMENT}.toml
            .add_source(config::File::with_name(config_evn_file.as_str()))
            // 读取环境变量，附带前缀 `APP`
            // 例：`APP_DEBUG=1` 会读取到 `debug` 键中
            .add_source(config::Environment::with_prefix("RUST"))
            // 读取所有环境变量
            // .add_source(config::Environment::default())
            .build()
            // 文件不存在时，unwrap 就将直接 panic
            // .unwrap()
            // 文件不存在时，expect 就将直接 panic，可以自定义错误信息
            .expect("无法找到配置文件");

        // 返回
        RwLock::new(settings)
    };
}

// 打印设定内容
#[allow(dead_code)]
#[instrument]
pub async fn print_config() {
    println!(
        "{:?}",
        CONFIG
            .read()
            .unwrap()
            .clone()
            .try_deserialize::<HashMap<String, String>>()
            .unwrap()
    );
}
