# 包管理工具 Cargo
Cargo 是 Rust 的包管理工具，可以用于依赖包的下载、编译、更新、分发等，与 Cargo 一样有名的还有 [crates.io](https://crates.io/)，它是社区提供的包注册中心：用户可以将自己的包发布到该注册中心，然后其它用户通过注册中心引入该包。

#### cargo init
初始化一个rust工程（已经存在目录时使用）
```
cd /path/to/your_project
cargo init
```

#### cargo new
初始化一个rust工程（不存在目录时使用）  
新建二进制工程
```
cd /path/to
cargo new your_project
```
新建库工程
```
cd /path/to
cargo new your_project --lib
```

#### cargo build
编译并构建工程，Cargo 会自动下载并构建 Cargo.toml 中描述的外部包。
```
cargo build
cargo b
```

#### cargo run
执行程序，如果需要编译的时候会自动编译
```
cargo run
cargo r
```

#### cargo check
执行编译检查，并不会编译出工程。
```
cargo check
cargo c
```

#### cargo add
添加外部包，也可直接修改 Cargo.toml 的 dependencies 语句块来描述
```
cargo add rand
```
这个命令等价于在 Cargo.toml 添加
```
[dependencies]
rand = "0.8.0"
```
注：在 Cargo.lock 中包含了我们项目使用的所有依赖的准确版本信息。这个非常重要，未来就算包有升级，我们依然会下载 Cargo.lock 中的版本，而不是最新的版本

#### cargo tree
确认当前包的构成树
```
cargo tree
```

#### cargo install[uninstall]
安装或卸载二进制包。
```
cargo install <package>
```
```
cargo uninstall <package>
```

#### cargo update
更新二进制包。由于 Cargo.lock 会锁住依赖的版本，你需要通过手动的方式将依赖更新到新的版本。  
更新所有依赖
```
cargo update
```
只更新 “regex”
```
cargo update -p regex
```

#### cargo test
Cargo 可以通过 cargo test 命令运行项目中的测试文件：它会在 src/ 底下的文件寻找单元测试，也会在 tests/ 目录下寻找集成测试。
```
cargo test
```

## 从国内源（其它注册中心）引入依赖包
为了使用 crates.io 之外的注册服务，我们需要对 $HOME/.cargo/config.toml ($CARGO_HOME下) 文件进行配置，添加新的服务提供商，有两种方式可以实现。  
由于国内访问国外注册服务的不稳定性，我们可以使用科大的注册服务来提升下载速度，参照以下网址设定  
http://mirrors.ustc.edu.cn/help/crates.io-index.html

