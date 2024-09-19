# Rust环境构建-在线安装（推荐）

## Windows环境（gnu工具链）
#### 下载
访问官网：  
https://forge.rust-lang.org/infra/other-installation-methods.html  
下载：``rustup-init.exe  ``
下载后放到要安装的路径下。  
比如：``D:\Tools\WorkTool\Rust\Rust_gnu_1.79``

#### 新建rust启动cmd文件
在要安装的路径下新建 ``start_rust.cmd``，内容如下
```
@echo off
set CARGO_HOME=D:\Tools\WorkTool\Rust\Rust_gnu_1.79
set RUSTUP_HOME=D:\Tools\WorkTool\Rust\Rust_gnu_1.79
set PATH=%PATH%;%CARGO_HOME%\bin
:: 国内源：中国科学技术大学
set RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
set RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup
:: 国内源：清华大学
:: RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
echo CARGO_HOME: %CARGO_HOME%
echo RUSTUP_HOME: %RUSTUP_HOME%
echo RUSTUP_DIST_SERVER: %RUSTUP_DIST_SERVER%
echo RUSTUP_UPDATE_ROOT: %RUSTUP_UPDATE_ROOT%
echo PATH: %PATH%
cmd
```
双击 ``start_rust.cmd`` 启动命令行。

#### 安装
在start_rust.cmd启动命令行中运行 rustup-init.exe  
```bash
rustup-init.exe
```
先询问是否安装Visual C++，因为笔者使用gnu工具链所以输入 ``y`` 继续
```
Rust Visual C++ prerequisites

Rust requires the Microsoft C++ build tools for Visual Studio 2013 or
later, but they don't seem to be installed.

You can acquire the build tools by installing Microsoft Visual Studio.

  https://visualstudio.microsoft.com/downloads/

Check the box for "Desktop development with C++" which will ensure that the
needed components are installed. If your locale language is not English,
then additionally check the box for English under Language packs.

For more details see:

  https://rust-lang.github.io/rustup/installation/windows-msvc.html

Install the C++ build tools before proceeding.

If you will be targeting the GNU ABI or otherwise know what you are
doing then it is fine to continue installation without the build
tools, but otherwise, install the C++ build tools before proceeding.

Continue? (y/N)
```

然后会出现欢迎信息，选 ``2``（自定义安装）
```
Welcome to Rust!

This will download and install the official compiler for the Rust
programming language, and its package manager, Cargo.

Rustup metadata and toolchains will be installed into the Rustup
home directory, located at:

  D:\Tools\WorkTool\Rust\Rust_gnu_1.79

This can be modified with the RUSTUP_HOME environment variable.

The Cargo home directory is located at:

  D:\Tools\WorkTool\Rust\Rust_gnu_1.79

This can be modified with the CARGO_HOME environment variable.

The cargo, rustc, rustup and other commands will be added to
Cargo's bin directory, located at:

  D:\Tools\WorkTool\Rust\Rust_gnu_1.79\bin

This path will then be added to your PATH environment variable by
modifying the HKEY_CURRENT_USER/Environment/PATH registry key.

You can uninstall at any time with rustup self uninstall and
these changes will be reverted.

Current installation options:


   default host triple: x86_64-pc-windows-msvc
     default toolchain: stable (default)
               profile: default
  modify PATH variable: yes

1) Proceed with standard installation (default - just press enter)
2) Customize installation
3) Cancel installation
>
```

接下来按如下设定安装选项  
- default host triple: ``x86_64-pc-windows-gnu``
- default toolchain: ``stable``
- profile: ``default``
- modify PATH variable: ``no``

然后选 ``1``（安装）
```
Current installation options:


   default host triple: x86_64-pc-windows-gnu
     default toolchain: stable
               profile: default
  modify PATH variable: no

1) Proceed with selected options (default - just press enter)
2) Customize installation
3) Cancel installation
>
```
之后就是在线安装，提示如下信息即安装完成
```
stable-x86_64-pc-windows-gnu installed - rustc 1.79.0 (129f3b996 2024-06-10)

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
```bash
rustup update
```
#### 卸载rust
```bash
rustup self uninstall
```

## Rust使用国内源
全局配置
 - ``$USER_HOME/.cargo/config.toml``

工程配置
 - ``$PROJECT_HOME/.cargo/config.toml``

```toml
[source.crates-io]
replace-with = 'aliyun'

[source.aliyun]
#registry = "sparse+https://mirrors.ustc.edu.cn/crates.io-index/"
registry = "sparse+https://mirrors.aliyun.com/crates.io-index/"

[http]
check-revoke = false
```

## gcc安装
在 Windows 平台下，如果使用 ``-gnu`` 的话，有时会需要 ``gcc.exe`` 在 PATH 中可用  
参考 [这里](../C/MinGW_zh_CN.md) 安装 ``MinGW`` 即可

## Linux环境
这里拿Ubuntu举例。Ubuntu的换源参照这里。  
[废旧手机安装Linux](../Other/Android-Linux_zh_CN.md)

#### 安装rust
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
