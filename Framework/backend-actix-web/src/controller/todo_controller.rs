use crate::utils::db::Todo;
use crate::utils::result::Result as CommonResult;
use actix_web::{post, web, Responder, Result};
use tracing as log;

// 取得清单列表
#[post("/todo/getAll")]
async fn todo_get_all() -> Result<impl Responder> {
    // 在内存数据库中查询
    let todo_list = get_todo_async().await?;
    let result: CommonResult<_> = CommonResult::success(todo_list);
    log::info!("请求TodoList成功");
    Ok(web::Json(result))
}

// 在内存数据库中取得清单列表
async fn get_todo_async() -> Result<Vec<Todo>> {
    //在lazy_static中取得全局数据库连接
    let binding = crate::DB.lock().unwrap();
    let conn = &mut binding.as_ref().unwrap();
    let mut stmt = conn.prepare("SELECT * FROM todo").unwrap();
    let mut todo_list: Vec<Todo> = Vec::new();
    let todo_iter = stmt
        .query_map([], |row| {
            Ok(Todo {
                todoId: row.get(0)?,
                todoName: row.get(1)?,
                image: row.get(2)?,
                studied: row.get(3)?,
            })
        })
        .unwrap();
    for todo in todo_iter {
        todo_list.push(todo.unwrap());
    }
    return Ok(todo_list);
}
