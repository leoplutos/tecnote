use actix_web::{
    dev::{forward_ready, Service, ServiceRequest, ServiceResponse, Transform},
    error,
    http::header::HeaderValue,
    Error,
};
use futures_util::future::LocalBoxFuture;
use std::future::{ready, Ready};

// 权限认证中间件
// 中间件处理有两个步骤。
// 1.中间件初始化，中间件工厂使用链中的 next service 作为参数。
// 2.中间件的 call 方法在正常请求中被调用。

pub struct Auth;

// 中间件需要实现 Transform 特征
// `S` - 下一个服务的类型
// `B` - 响应正文的类型
impl<S, B> Transform<S, ServiceRequest> for Auth
where
    S: Service<ServiceRequest, Response = ServiceResponse<B>, Error = Error>,
    S::Future: 'static,
    B: 'static,
{
    type Response = ServiceResponse<B>;
    type Error = Error;
    type InitError = ();
    type Transform = AuthMiddleware<S>;
    type Future = Ready<Result<Self::Transform, Self::InitError>>;

    fn new_transform(&self, service: S) -> Self::Future {
        ready(Ok(AuthMiddleware { service }))
    }
}

// 自定义权限认证中间件
pub struct AuthMiddleware<S> {
    service: S,
}

impl<S, B> Service<ServiceRequest> for AuthMiddleware<S>
where
    S: Service<ServiceRequest, Response = ServiceResponse<B>, Error = Error>,
    S::Future: 'static,
    B: 'static,
{
    type Response = ServiceResponse<B>;
    type Error = Error;
    type Future = LocalBoxFuture<'static, Result<Self::Response, Self::Error>>;

    forward_ready!(service);

    // call方法会在请求时被调用
    fn call(&self, req: ServiceRequest) -> Self::Future {
        // 进行鉴权操作，判断是否有权限
        if has_permission(&req) {
            // 有权限，继续执行后续中间件
            let fut = self.service.call(req);
            Box::pin(async move {
                let res = fut.await?;
                Ok(res)
            })
        } else {
            // 没有权限，立即返回响应
            Box::pin(async move {
                // 鉴权失败，返回未授权的响应，停止后续中间件的调用
                // Err(error::ErrorUnauthorized("Unauthorized"))
                Err(error::ErrorUnauthorized("未携带token,请重新登录!!!"))
            })
        }
    }
}

// 实现鉴权逻辑，根据需求判断是否有权限
// 返回 true 表示有权限，返回 false 表示没有权限
fn has_permission(req: &ServiceRequest) -> bool {
    // unimplemented!()
    if req.path().to_string() == "/login" {
        // 登录放行
        return true;
    }
    let value = HeaderValue::from_str("").unwrap();
    let token = req.headers().get("token").unwrap_or(&value);
    let result = crate::middleware::jwt_util::validate_token(token.to_str().unwrap());
    match result {
        Ok(_) => return true,
        Err(_) => return false,
    }
}
