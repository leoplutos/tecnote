use crate::bootstrap::db::Todo;
use crate::common_response::common_result::CommonResult;
use actix_web::{post, web, Responder, Result};

// 取得清单列表
#[post("/todo/getAll")]
async fn todo_get_all() -> Result<impl Responder> {
    let result_list = get_todo_from_db()?;
    println!("{:?}", result_list);
    let result: CommonResult<_> = CommonResult::success(result_list);
    Ok(web::Json(result))
}

// 在内存数据库中取得清单列表
pub fn get_todo_from_db() -> Result<Vec<Todo>> {
    //在lazy_static中取得全局数据库连接
    let binding = crate::DB.lock().unwrap();
    let conn = &mut binding.as_ref().unwrap();
    let mut stmt = conn.prepare("SELECT * FROM todo").unwrap();
    let mut result_list: Vec<Todo> = Vec::new();
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
        result_list.push(todo.unwrap());
    }
    return Ok(result_list);
}
