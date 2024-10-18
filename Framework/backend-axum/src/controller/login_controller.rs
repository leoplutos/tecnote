use crate::middleware::jwt_util::create_jwt;
use crate::utils::result::Result as CommonResult;
use axum::{http::StatusCode, response::IntoResponse, Json};
use serde::Deserialize;
use tracing as log;

#[derive(Deserialize)]
#[allow(non_snake_case)]
pub struct LoginRequest {
    userId: String,
    password: String,
}

//用户登录
//#[post("/login")]
pub async fn login(Json(payload): Json<LoginRequest>) -> impl IntoResponse {
    if payload.userId == "" {
        let result: CommonResult<_> =
            CommonResult::fail(400, String::from("账号不能为空"), String::from(""));
        return (StatusCode::BAD_REQUEST, Json(result));
    }
    if payload.password == "" {
        let result: CommonResult<_> =
            CommonResult::fail(400, String::from("密码不能为空"), String::from(""));
        return (StatusCode::BAD_REQUEST, Json(result));
    }
    // DB校验
    let check_result = get_user_async(LoginRequest {
        userId: payload.userId.clone(),
        password: payload.password.clone(),
    })
    .await
    .unwrap();
    log::info!("请求Login成功. {}", &check_result);
    if check_result {
        //通过jwt发行token
        let token = create_jwt(&payload.userId.clone());
        let result: CommonResult<_> = CommonResult::success(token);
        return (StatusCode::OK, Json(result));
    } else {
        let result: CommonResult<_> =
            CommonResult::fail(401, String::from("用户名或密码错误！"), String::from(""));
        return (StatusCode::UNAUTHORIZED, Json(result));
    }
}

// 在内存数据库中取得清单列表
async fn get_user_async(userinfo: LoginRequest) -> Result<bool, &'static str> {
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
