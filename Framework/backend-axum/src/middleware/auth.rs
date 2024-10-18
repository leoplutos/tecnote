use axum::{
    async_trait,
    extract::FromRequestParts,
    http::{request::Parts, StatusCode},
};
use serde::{Deserialize, Serialize};

// 单元结构体（中间件名字）
#[derive(Debug, Serialize, Deserialize)]
pub struct Auth;

// 实现中间件拦截请求，查看Header中是否存在 [token]，并验证
#[async_trait]
impl<S> FromRequestParts<S> for Auth
where
    S: Send + Sync,
{
    type Rejection = StatusCode;

    async fn from_request_parts(parts: &mut Parts, _state: &S) -> Result<Self, Self::Rejection> {
        let auth_header = parts
            .headers
            .get("token")
            .and_then(|value| value.to_str().ok());
        match auth_header {
            Some(auth_header) if token_is_valid(auth_header) => Ok(Self),
            _ => Err(StatusCode::UNAUTHORIZED),
        }
    }
}

// 验证token
fn token_is_valid(token: &str) -> bool {
    let result = crate::middleware::jwt_util::validate_token(token);
    match result {
        Ok(_) => return true,
        Err(_) => return false,
    }
}
