# Rust 相关

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
