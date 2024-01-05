use serde::{Deserialize, Serialize};

// json返回内容的统一封装
#[derive(Debug, Serialize, Deserialize)]
pub struct CommonResult<T> {
    code: i32,
    message: String,
    data: T,
}
impl<T> CommonResult<T> {
    pub fn success(_data: T) -> CommonResult<T> {
        let result = CommonResult {
            code: 200,
            message: String::from("success"),
            data: _data,
        };
        return result;
    }
    pub fn fail(_code: i32, _message: String, _data: T) -> CommonResult<T> {
        let result = CommonResult {
            code: _code,
            message: _message,
            data: _data,
        };
        return result;
    }
}
