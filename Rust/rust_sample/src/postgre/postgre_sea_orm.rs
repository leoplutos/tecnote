use super::employee_entity::ActiveModel as EmployeeActiveModel;
use crate::postgre::employee_entity::Entity as EmployeeEntity;
use crate::postgre::employee_entity::Model as EmployeeModel;
use crate::utils;
use rand::Rng;
use sea_orm::ActiveValue::{NotSet, Set};
use sea_orm::{
    ActiveModelTrait, ActiveValue, ColumnTrait, ConnectOptions, Database, DbBackend, DeleteResult,
    EntityTrait, IntoActiveModel, QueryFilter, Statement,
};
use std::error::Error;
use std::time::Duration;
use tracing as log;
use tracing::instrument;
use uuid::Uuid;

// Postgre的sea-orm示例
#[instrument]
pub async fn postgre_sea_orm_async() -> Result<(), Box<dyn Error>> {
    // 需要1:
    // sea-orm = { version = "1.1", features = ["sqlx-postgres", "runtime-tokio-rustls", "macros", "debug-print", "with-chrono", "with-uuid"] }
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
    // https://github.com/SeaQL/sea-orm
    // https://www.sea-ql.org/SeaORM/docs/index/
    // https://github.com/SeaQL/sea-orm/blob/master/examples/basic

    // 从config.toml文件读取数据库连接信息
    let datasource_url = utils::config::CONFIG
        .try_read()?
        .get_string("datasource.url")?;
    log::info!("Postgre连接URL: {}", datasource_url);
    let schema = "public";

    // 创建数据库连接池
    // 在实际项目中可以使用 lazy_static 来维持一个全局可用得连接池
    let mut opt = ConnectOptions::new(datasource_url);
    opt.max_connections(100)
        .min_connections(5)
        .connect_timeout(Duration::from_secs(8))
        .acquire_timeout(Duration::from_secs(8))
        .idle_timeout(Duration::from_secs(8))
        .max_lifetime(Duration::from_secs(8))
        .sqlx_logging(false)
        // 使用::设定为从根开始
        .sqlx_logging_level(::log::LevelFilter::Info)
        .set_schema_search_path(schema);
    let db = Database::connect(opt).await?;

    // 测试连接
    let result = db.ping().await;
    match result {
        Ok(()) => log::info!("Postgre连接成功"),
        Err(e) => {
            log::error!("Postgre连接失败: {}", e);
            panic!("{}", e);
        }
    }

    let mut search_id = String::new();
    let mut delete_id = String::new();
    // 插入3条t_employee数据
    for i in 0..3 {
        // 对数据库友好的 UUID v7
        let uuidv7 = Uuid::now_v7();
        // 生成1到99的随机数
        let mut rng = rand::thread_rng();
        let random_number: u32 = rng.gen_range(1..100);
        let employee_id = format!("{}{}", "rust_orm_id_", random_number);
        let employe_name = format!("{}{}", "rust_张四_", random_number);
        let employe_status: i16 = 4;
        // 创建Entity实例
        let active_model = EmployeeActiveModel {
            te_pk: Set(uuidv7.to_owned()),
            employee_id: Set(employee_id.to_owned()),
            employe_name: Set(Some(employe_name).to_owned()),
            employe_email: NotSet,
            employe_status: Set(Some(employe_status).to_owned()),
        };
        let result: EmployeeModel = active_model.insert(&db).await?;
        log::info!("t_employee表插入成功, {:?}", result);
        match i {
            0 => {
                search_id = employee_id.clone();
            }
            1 => {
                delete_id = employee_id.clone();
            }
            _ => {}
        };
    }

    // 查询数据
    // EmployeeEntity::find_by_id(1).one(&db).await?;
    let result: Option<EmployeeModel> = EmployeeEntity::find()
        // 使用employee_id作为条件查找
        .filter(super::employee_entity::Column::EmployeeId.eq(&search_id))
        .one(&db)
        .await?;
    let mut active_model = match result {
        None => {
            log::warn!("未找到用户, search_id: {}", search_id);
            panic!()
        }
        Some(employee) => {
            log::info!("使用 employee_id 查询成功, {:?}", employee);
            // 返回active_model以便更新操作
            employee.into_active_model()
        }
    };

    // 更新数据
    // 生成1到99的随机数
    let mut rng = rand::thread_rng();
    let random_number: u32 = rng.gen_range(1..100);
    let employe_email = format!("changed_{}@exsample.com", random_number);
    active_model.employe_email = ActiveValue::Set(Some(employe_email).to_owned());
    let result: EmployeeModel = active_model.update(&db).await?;
    log::info!("t_employee表更新成功, {:?}", result);

    // 删除数据
    // 根据条件删除
    // EmployeeEntity::delete_by_id(1).exec(&db).await?;
    let result: Option<EmployeeModel> = EmployeeEntity::find()
        // 使用employee_id作为条件查找
        .filter(super::employee_entity::Column::EmployeeId.eq(&delete_id))
        .one(&db)
        .await?;
    match result {
        None => {
            log::warn!("未找到用户, delete_id: {}", delete_id);
        }
        Some(employee) => {
            let active_model = employee.into_active_model();
            // 执行删除
            let delete_result: DeleteResult = active_model.delete(&db).await?;
            log::info!(
                "t_employee表删除成功, 删除行数: {}, delete_id: {}",
                delete_result.rows_affected,
                delete_id
            );
        }
    };

    // 查询全部数据
    let all_datas: Vec<EmployeeModel> = EmployeeEntity::find().all(&db).await?;
    log::info!("查询全部数据成功");
    for data in all_datas.iter() {
        log::info!("{data:?}");
    }

    // 自定义SQL查询
    // 使用原生SQL的方式查询
    // 更多:
    //  https://www.sea-ql.org/SeaORM/docs/basic-crud/raw-sql/
    // 使用 $1 的方式只适用 PostgreSQL, 其他数据库详见官方文档
    let cust_condi = "%@exsample.com";
    let cust_result: Vec<EmployeeModel> = EmployeeEntity::find()
        .from_raw_sql(Statement::from_sql_and_values(
            DbBackend::Postgres,
            r#"SELECT * FROM t_employee WHERE employe_email LIKE $1"#,
            [cust_condi.into()],
        ))
        .all(&db)
        .await?;
    log::info!("自定义SQL查询成功");
    for data in cust_result.iter() {
        log::info!("{data:?}");
    }

    // 关闭连接
    db.close().await?;

    Ok(())
}
