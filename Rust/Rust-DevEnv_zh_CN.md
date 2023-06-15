# Rust环境构建-在线安装（推荐）

## Windows环境（gnu工具链）
#### 下载
访问官网：  
https://forge.rust-lang.org/infra/other-installation-methods.html  
下载：rustup-init.exe  
下载后放到要安装的路径下。  
比如：D:\Tools\WorkTool\Rust\Rust_gnu_1.70

#### 新建rust启动cmd文件
在要安装的路径下新建start_rust.cmd，内容如下
```
set CARGO_HOME=D:\Tools\WorkTool\Rust\Rust_gnu_1.70
set RUSTUP_HOME=D:\Tools\WorkTool\Rust\Rust_gnu_1.70
set PATH=%PATH%;%CARGO_HOME%\bin
set CARGO_HOME
set RUSTUP_HOME
set PATH
cmd
```
双击start_rust.cmd启动命令行。

#### 安装
在start_rust.cmd启动命令行中运行 rustup-init.exe  
```
rustup-init.exe
```
先询问是否安装Visual C++，因为笔者使用gnu工具链所以选3
```
Rust Visual C++ prerequisites

Rust requires a linker and Windows API libraries but they don't seem to be
available.

These components can be acquired through a Visual Studio installer.

1) Quick install via the Visual Studio Community installer
   (free for individuals, academic uses, and open source).

2) Manually install the prerequisites
   (for enterprise and advanced users).

3) Don't install the prerequisites
   (if you're targeting the GNU ABI).

>3
```

然后会出现欢迎信息，选2（自定义安装）
```
Welcome to Rust!

This will download and install the official compiler for the Rust
programming language, and its package manager, Cargo.

Rustup metadata and toolchains will be installed into the Rustup
home directory, located at:

  D:\Tools\WorkTool\Rust\Rust_gnu_1.70

This can be modified with the RUSTUP_HOME environment variable.

The Cargo home directory is located at:

  D:\Tools\WorkTool\Rust\Rust_gnu_1.70

This can be modified with the CARGO_HOME environment variable.

The cargo, rustc, rustup and other commands will be added to
Cargo's bin directory, located at:

  D:\Tools\WorkTool\Rust\Rust_gnu_1.70\bin

This path will then be added to your PATH environment variable by
modifying the HKEY_CURRENT_USER/Environment/PATH registry key.

You can uninstall at any time with rustup self uninstall and
these changes will be reverted.

Current installation options:


   default host triple: x86_64-pc-windows-msvc
     default toolchain: stable (default)
               profile: default
  modify PATH variable: yes

1) Proceed with installation (default)
2) Customize installation
3) Cancel installation

>2
```

接下来按如下设定安装选项  
* x86_64-pc-windows-gnu
* stable
* default
* n  

然后选1（安装）
```
I'm going to ask you the value of each of these installation options.
You may simply press the Enter key to leave unchanged.

Default host triple? [x86_64-pc-windows-msvc]
x86_64-pc-windows-gnu

Default toolchain? (stable/beta/nightly/none) [stable]
stable

Profile (which tools and data to install)? (minimal/default/complete) [default]
default

Modify PATH variable? (Y/n)
n


Current installation options:


   default host triple: x86_64-pc-windows-gnu
     default toolchain: stable
               profile: default
  modify PATH variable: no

1) Proceed with installation (default)
2) Customize installation
3) Cancel installation
>1
```
之后就是在线安装，提示如下信息即安装完成
```
stable-x86_64-pc-windows-gnu installed - rustc 1.70.0 (90c541806 2023-05-31)

Rust is installed now. Great!
```

安装完成后，会在bin目录下会新增很多exe。确认
```bash
cargo --version
rustc --version
rustup --version
```

这些工具分别是
- cargo ： 包管理器
- rustc ： 编译器
- rustfmt ： 格式化工具
- clippy ： 静态代码分析工具
- rust-docs ： 官方文档
- rust-std ： 标准库

## Rust的更新与卸载
#### 更新rust
```
rustup update
```
#### 卸载rust
```
rustup self uninstall
```


## Linux环境
这里拿Ubuntu举例。Ubuntu的换源参照这里。  
[废旧手机安装Linux](../Other/Android-Linux_zh_CN.md)

**安装rust**
```bash
apt install cargo
```
由于 cargo 包含 rustc，所以笔者建议安装它，以便一次性安装所有必需的软件包。
当然，你可以自由使用 apt install rustc，只安装 Rust。这取决于你的选择。

确认
```bash
cargo --version
rustc --version
```
