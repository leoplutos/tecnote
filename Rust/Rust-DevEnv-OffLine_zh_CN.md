# Rust环境构建-离线安装

## 关于离线安装
离线安装会带rustc, cargo, rustdoc，标准库和官方文档，但是不会带rustup和rustfmt等其他工具，所以无法升级。不太推荐。

## Windows环境（gnu工具链）
#### 下载
访问官网：  
https://forge.rust-lang.org/infra/other-installation-methods.html  
下载：x86_64-pc-windows-gnu.msi  
笔者下载的为稳定版：stable (1.69.0)  
#### 安装
运行下载的文件，选择安装路径，正常安装即可。
安装后会自动加入到环境变量PATH里。
#### 关于绿色版
重新做系统后，不用每次都安装。如下操作即可。
打开git-bash.exe
```bash
cd ~
pwd
```
在显示的路径下新建.bash_profile，内容如下
```bash
MINGW_HOME=/d/Tools/WorkTool/C/codeblocks-20.03mingw-nosetup/MinGW/bin
RUST_HOME=/d/Tools/WorkTool/Rust/Rust_gnu_1.69/bin
JAVA_HOME=/d/Tools/WorkTool/Java/jdk17.0.6/bin
PYTHON_HOME=/d/Tools/WorkTool/Python/Python38-32
VSCODE_HOME=/d/Tools/WorkTool/Text/VSCode-win32-x64-1.77.1
CMAKE_HOME=/d/Tools/WorkTool/C/cmake-3.26.1-windows-x86_64/bin
NINJA_HOME=/d/Tools/WorkTool/C/ninja-win
PATH=$PATH:$MINGW_HOME:$RUST_HOME:$JAVA_HOME:$PYTHON_HOME:$VSCODE_HOME:$CMAKE_HOME:$NINJA_HOME
export PATH
```
保存文件，退出git-bash.exe并重新打开，确认
```bash
cargo --version
rustc --version
```
