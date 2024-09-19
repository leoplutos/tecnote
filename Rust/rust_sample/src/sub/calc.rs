use std::error::Error;
use std::time::Duration;
use tracing as log;
use tracing::instrument;

#[instrument]
pub async fn add_plus_async(param: i64) -> Result<i64, Box<dyn Error>> {
    log::info!("传入的参数为: {}", param);
    let b: i64 = 1;
    let c: i64 = 2;
    let ret = (param + b) * c;
    // if ret == 72 {
    //     // 返回Result枚举的Err
    //     // .into() 的计算结果为 Result<_, Box<dyn Error>>
    //     // https://users.rust-lang.org/t/help-understanding-return-for-box-dyn-error/33748/4
    //     return Err("不允许计算为72,别问为什么!".into());
    // }
    log::info!("计算结果为: {}", ret);
    tokio::time::sleep(Duration::from_secs(1)).await;
    // 返回Result枚举的Ok
    return Ok(ret);
}
