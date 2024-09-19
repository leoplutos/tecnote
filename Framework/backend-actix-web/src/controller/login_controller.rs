use crate::middleware::jwt_util::create_jwt;
use crate::utils::result::Result as CommonResult;
use actix_web::{post, web, Responder, Result};
use serde::{Deserialize, Serialize};
use tracing as log;

#[derive(Serialize, Deserialize)]
#[allow(non_snake_case)]
pub struct LoginRequest {
    userId: String,
    password: String,
}

//用户登录
#[post("/login")]
async fn login(login: web::Json<LoginRequest>) -> Result<impl Responder> {
    if login.userId == "" {
        let result: CommonResult<_> =
            CommonResult::fail(400, String::from("账号不能为空"), String::from(""));
        return Ok(web::Json(result));
    }
    if login.password == "" {
        let result: CommonResult<_> =
            CommonResult::fail(400, String::from("密码不能为空"), String::from(""));
        return Ok(web::Json(result));
    }
    // DB校验
    let check_result = get_user_async(LoginRequest {
        userId: login.userId.clone(),
        password: login.password.clone(),
    })
    .await?;
    log::info!("请求Login成功. {}", &check_result);
    if check_result {
        //通过jwt发行token
        let token = create_jwt(&login.userId.clone());
        let result: CommonResult<_> = CommonResult::success(token);
        return Ok(web::Json(result));
    } else {
        let result: CommonResult<_> =
            CommonResult::fail(401, String::from("用户名或密码错误！"), String::from(""));
        return Ok(web::Json(result));
    }
}

// 在内存数据库中取得清单列表
async fn get_user_async(userinfo: LoginRequest) -> Result<bool> {
    //在lazy_static中取得全局数据库连接
    let binding = crate::DB.lock().unwrap();
    let conn = &mut binding.as_ref().unwrap();
    let mut stmt = conn
        .prepare("SELECT * FROM login WHERE userid = ?1 AND password = ?2")
        .unwrap();
    let mut rows = stmt.query([userinfo.userId, userinfo.password]).unwrap();
    while let Some(_row) = rows.next().unwrap() {
        return Ok(true);
    }
    return Ok(false);
}
