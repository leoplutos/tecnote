use std::error::Error;
use tracing::instrument;
use tracing::Level;
use tracing_subscriber::fmt;

#[instrument]
pub async fn init_log_async() -> Result<(), Box<dyn Error>> {
    // 日志级别
    let log_min_lev: Level = Level::INFO;
    println!("日志级别: {}", log_min_lev.as_str());

    // 日志格式设定
    let format = fmt::format()
        // 显示颜色
        .with_ansi(true)
        // 格式化时间
        .with_timer(fmt::time::ChronoLocal::new(String::from(
            "%Y-%m-%d %H:%M:%S.%6f",
        )))
        // 显示日志等级
        .with_level(true)
        // 不显示module
        .with_target(false)
        // 显示线程ID
        .with_thread_ids(true)
        // 不显示线程名
        .with_thread_names(false)
        // 显示文件路径
        .with_file(true)
        // 显示行号
        .with_line_number(true)
        // 使用紧凑格式
        .compact();

    // 配置全局日志
    // tracing_subscriber::fmt::init();
    tracing_subscriber::fmt()
        .event_format(format)
        // 设定最小日志等级
        .with_max_level(log_min_lev)
        .init();

    Ok(())
}
