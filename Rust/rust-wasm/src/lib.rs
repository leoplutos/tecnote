extern crate wasm_bindgen;

use wasm_bindgen::prelude::wasm_bindgen;

// 声明 JavaScript 的 alert 函数
#[wasm_bindgen]
extern {
    pub fn alert(s: &str);
}

// wasm函数add
#[wasm_bindgen]
pub fn add(a: i32, b: i32) -> i32 {
    a + b
}

// wasm函数greet
#[wasm_bindgen]
pub fn greet(name: &str) {
    let msg: String = format!("你好, {}!", name);
    // 调用JavaScript 的 alert 函数
    alert(msg.as_str());
}
