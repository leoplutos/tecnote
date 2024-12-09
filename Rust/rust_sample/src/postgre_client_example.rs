use std::error::Error;
use tracing as log;

// 导入utils模块（utils.rs）
mod utils;
// 导入postgre模块（postgre.rs）
mod postgre;

#[tokio::main]
async fn main() -> Result<(), Box<dyn Error>> {
    // 初始化日志
    utils::log::init_log_async().await?;
    // Postgre的基础示例
    let ret = postgre::postgre_base::postgre_base_async().await;
    match ret {
        Ok(()) => log::info!("PostgreBase示例运行结束"),
        Err(e) => {
            log::error!("PostgreBase示例运行失败: {}", e)
        }
    }
    log::info!("=====================================");
    // Postgre的sea-orm示例
    let ret = postgre::postgre_sea_orm::postgre_sea_orm_async().await;
    match ret {
        Ok(()) => log::info!("PostgreSeaOrm示例运行结束"),
        Err(e) => {
            log::error!("PostgreSeaOrm示例运行失败: {}", e)
        }
    }

    Ok(())
}
