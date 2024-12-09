use crate::utils;
use rand::Rng;
use sqlx::postgres::{PgPoolOptions, PgQueryResult, PgRow};
use sqlx::Row;
use std::collections::HashMap;
use std::error::Error;
use tracing as log;
use tracing::instrument;
use uuid::Uuid;

// Postgre的基础示例
#[instrument]
pub async fn postgre_base_async() -> Result<(), Box<dyn Error>> {
    // 需要1:
    // sqlx = { version = "0.8", features = ["postgres", "runtime-tokio", "macros", "chrono", "uuid"] }
    // 需要2: docker run -p 5432:5432 --name postgre -v $HOME/workspace/postgre_data/data:/var/lib/postgresql/data -e POSTGRES_PASSWORD=123456 -d postgres:17.1-alpine3.20
    // 需要3: 建表
    /*
        CREATE TABLE t_employee (
            te_pk UUID NOT NULL UNIQUE,
            employee_id TEXT NOT NULL,
            employe_name TEXT,
            employe_email TEXT,
            employe_status SMALLINT,
            PRIMARY KEY(te_pk)
        );
    */
    // 更多看这里:
    // https://github.com/launchbadge/sqlx
    // https://github.com/launchbadge/sqlx/tree/main/examples/postgres

    // 从config.toml文件读取数据库连接信息
    let datasource_url = utils::config::CONFIG
        .try_read()?
        .get_string("datasource.url")?;
    log::info!("Postgre连接URL: {}", datasource_url);

    // 创建数据库连接池
    //  for MySQL/MariaDB, use MySqlPoolOptions::new()
    //  for SQLite, use SqlitePoolOptions::new()
    // 在实际项目中可以使用 lazy_static 来维持一个全局可用得连接池
    let pool = PgPoolOptions::new()
        .max_connections(5)
        .connect(&datasource_url)
        .await?;
    log::info!("Postgre连接成功");

    // 事务
    //let mut tx = pool.begin().await?;

    // 插入3条t_employee数据
    for _i in 0..3 {
        // 对数据库友好的 UUID v7
        let uuidv7 = Uuid::now_v7();
        // 生成1到99的随机数
        let mut rng = rand::thread_rng();
        let random_number: u32 = rng.gen_range(1..100);
        let employee_id = format!("{}{}", "rust_base_id_", random_number);
        let employe_name = format!("{}{}", "rust_张四_", random_number);
        let employe_status: i16 = 4;
        let pg_query_result: PgQueryResult =
            sqlx::query(r#"INSERT INTO t_employee (te_pk, employee_id, employe_name, employe_status) VALUES ($1, $2, $3, $4)"#)
                .bind(uuidv7)
                .bind(&employee_id)
                .bind(&employe_name)
                .bind(&employe_status)
                // execute返回受影响的行数
                .execute(&pool)
                .await?;
        log::info!(
            "t_employee表插入成功, 插入{}条, {}, {}, {}, {}",
            pg_query_result.rows_affected(),
            uuidv7.to_string(),
            employee_id,
            employe_name,
            employe_status,
        );
        // 编译时验证 需要设定 [DATABASE_URL] 环境变量
        // sqlx::query!(
        //     r#"INSERT INTO t_employee (te_pk, employee_id, employe_name, employe_status) VALUES ($1, $2, $3, $4)"#,
        //     uuidv7,
        //     employee_id,
        //     employe_name,
        //     employe_status
        // )
        // .fetch_all(&pool)
        // .await?;
    }

    // 查询t_employee所有数据
    // 创建一个List，其中每个元素都是map<string, string>类型
    let mut results: Vec<HashMap<String, String>> = Vec::new();
    let all_datas: Vec<PgRow> = sqlx::query(r#"SELECT * FROM t_employee"#)
        .fetch_all(&pool)
        .await?;
    for data in all_datas {
        let te_pk: Uuid = data.try_get(0)?;
        let uuidv7 = te_pk.to_string();
        let employee_id: &str = data.try_get(1)?;
        let employe_name: &str = data.try_get(2)?;
        let employe_email_nullable: Option<String> = data.try_get(3)?;
        let employe_email = employe_email_nullable.map_or("N/A".to_string(), |v| v);
        let employe_status: i16 = data.try_get(4)?;
        // 创建map并添加到List中
        let mut record = HashMap::new();
        record.insert("te_pk".to_string(), uuidv7);
        record.insert("employee_id".to_string(), employee_id.to_string());
        record.insert("employe_name".to_string(), employe_name.to_string());
        record.insert("employe_email".to_string(), employe_email);
        record.insert("employe_status".to_string(), employe_status.to_string());
        results.push(record);
    }
    // 打印结果
    log::info!("t_employee表查询成功");
    log::info!("{:?}", results);

    // 关闭DB连接
    pool.close().await;

    Ok(())
}
