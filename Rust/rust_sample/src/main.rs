use std::error::Error;
use tracing as log;
use tracing::instrument;

// 导入sub模块（sub.rs）
mod sub;
// 导入utils模块（utils.rs）
mod utils;

#[instrument]
async fn start_app_async() -> Result<(), Box<dyn Error>> {
    // 从config.toml读取内容
    log::info!("读取config和环境变量开始");
    let hacker = utils::config::CONFIG.try_read()?.get_bool("hacker")?;
    log::info!("hacker: {}", hacker);
    let name = utils::config::CONFIG.try_read()?.get_string("name")?;
    log::info!("name: {}", name);
    let age = utils::config::CONFIG.try_read()?.get_int("age")?;
    log::info!("age: {}", age);
    let env = utils::config::CONFIG.try_read()?.get_string("env")?;
    log::info!("env: {}", env);
    let datasource_url = utils::config::CONFIG
        .try_read()?
        .get_string("datasource.url")?;
    log::info!("datasource_url: {}", datasource_url);
    let src_path = utils::config::CONFIG
        .try_read()?
        .get_string("environment")?;
    log::info!("环境变量 RUST_ENVIRONMENT: {}", src_path);
    log::info!("读取config和环境变量结束");

    // 调用函数
    let ret = sub::calc::add_plus_async(age).await?;
    log::info!("调用函数的返回值为：{}", ret);

    Ok(())
}

#[tokio::main]
async fn main() -> Result<(), Box<dyn Error>> {
    // 初始化日志
    // ?的意思为错误传播，如果发生错误就将错误返回(向上传播)
    // ?可以用来传播Result和Option枚举
    utils::log::init_log_async().await?;
    // 调用开始
    let ret = start_app_async().await;
    match ret {
        Ok(()) => log::info!("App示例运行结束"),
        Err(e) => {
            log::error!("App示例运行失败: {}", e)
        }
    }
    Ok(())
}
