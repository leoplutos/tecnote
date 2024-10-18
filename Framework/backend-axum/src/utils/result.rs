use serde::Serialize;

// JSON返回内容的统一封装
#[derive(Debug, Serialize)]
pub struct Result<T> {
    code: i32,
    message: String,
    data: T,
}

impl<T> Result<T> {
    pub fn success(_data: T) -> Result<T> {
        let result = Result {
            code: 200,
            message: String::from("success"),
            data: _data,
        };
        return result;
    }
    pub fn fail(_code: i32, _message: String, _data: T) -> Result<T> {
        let result = Result {
            code: _code,
            message: _message,
            data: _data,
        };
        return result;
    }
}
