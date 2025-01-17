# Rust 相关

## 编程技巧

### Option 的匹配

#### 使用 ``if let``

``if let`` 用于匹配一个模式，而忽略剩下的所有模式
```rust
// if let 取得的值只可以在 {} 中使用
if let Some(num1) = Some(123) {
    println!("num1: {}", num1);
}
```

#### 使用 ``let-else``（Rust 1.65 新增）

``let-else`` 匹配，可使 let 变为可驳模式。它可以使用 else 分支来处理模式不匹配的情况，但是 else 分支中必须用发散的代码块处理（例如：break、return、panic）

```rust
// let-else 取得的值可以在 {} 外使用
let Some(num2) = Some(123) else {
    panic!("无法取得值")
};
println!("num2: {}", num2);
```

### Result 的匹配

#### 使用 ``unwrap_or()``

当 Result 对象是 Ok 时，返回 Ok 中的值。但是当 Result 对象是 Err 时，``unwrap_or()`` 用于返回一个默认值
```rust
let num3_result: Result<i32, &str> = Err("发生错误，无法取得数字");
// 使用 unwrap_or 返回默认值
let num3 = num3_result.unwrap_or(73);
println!("num3: {}", num3);
```

#### 使用 ``unwrap_or_else()``

当 Result 对象是 Ok 时，返回 Ok 中的值。但是当 Result 对象是 Err 时，``unwrap_or_else()`` 将调用一个闭包，并返回闭包的结果
```rust
let num3_result: Result<i32, &str> = Err("发生错误，无法取得数字");
// 使用 unwrap_or_else 返回闭包的结果
let num4 = num3_result.unwrap_or_else(|err| {
    println!("error message: {}", err);
    74
});
println!("num4: {}", num4);
```

## Rust 的多模块工作区（Workspace）

工程示例
 - [rust_workspace](./rust_workspace)

创建命令
```bash
cd D:\WorkSpace\Rust\rust_workspace

# 创建4个子模块 core app etcd redis
cargo new --lib rw_core
cargo new rw_app
cargo new rw_etcd
cargo new rw_redis
```

在工程根目录新建 ``Cargo.toml`` 内容如下
```toml
[workspace]
resolver="2"
members = [
    "rw_core",
    "rw_app",
    "rw_etcd",
    "rw_redis"
]
```

## 减小编译出的程序的文件大小
随着引入的依赖包越来越多, 编译生成的 rust 程序二进制文件越来越大, 要花更久的 时间把它推送到线上服务器.
通过使用以下手段, 可以显著减小生成的程序文件大小, 同时不破坏其完整性

### 使用Release模式
基础命令为
```
cargo build --release
cargo run --release
```
这里拿笔者做的一个gRPC例子程序来对比  

 - 开启前
```
cargo run --bin rustserver
cargo run --bin rustclient
```
``rustserver.exe`` 文件大小：101 M  
``rustclient.exe`` 文件大小：76.2 M  

 - 开启后
```
cargo run --release --bin rustserver
cargo run --release --bin rustclient
```
``rustserver.exe`` 文件大小：11.3 M  
``rustclient.exe`` 文件大小：11.7 M  

### 链接优化
同 c/c++ 编译器一样, rustc 支持链接优化, 通过牺牲编译时间, 可以生成更小的二进制文件  
开启方式是在 ``Cargo.toml`` 中加入
```
[profile.release]
lto = true
```
 - 开启后
```
cargo run --release --bin rustserver
cargo run --release --bin rustclient
```
``rustserver.exe`` 文件大小：3.55 M  
``rustclient.exe`` 文件大小：3.79 M  

一般来讲优化到这里就可以了，如果还想继续优化的话可以使用下面几个工具
1. strip  
strip 命令用于清除二进制文件中的非关键信息. 可以通过 ``sudo apt install binutils`` 命令来安装 strip 命令
2. upx  
使用 upx 这样的压缩工具. 可以通过 ``sudo apt install upx`` 命令来安装 upx 包
3. 不包含 unwind 信息
4. 清理包依赖列表中存有的多个不同版本的同名包


## 第三方库

#### log
- 简单的工程使用slog即可  https://github.com/slog-rs/slog  
- 异步以及微服务使用  https://github.com/tokio-rs/tracing  
    一个[tracing的教程](https://course.rs/logs/tracing.html)

