# Meson

## Meson简介
Meson是用Python语言开发的构建工具，编译需要Ninja（用C++实现）命令。Meson 旨在开发最具可用性和快速的构建系统。  
原生支持最新的工具和框架，如 Qt5 、代码覆盖率、单元测试和预编译头文件等。利用一组优化技术来快速变异代码，包括增量编译和完全编译。  
使用meson的一个优点是当工程依赖一些库没有时，meson可以到git上自动下载并帮你安装，相比config要好。


## 1.使用前需要先安装Meson
https://mesonbuild.com/Getting-meson.html  
除了Meson之外，还需要Ninja和Python环境

## 2.创建meson.build文件
在你的工程根目录下，新建**meson.build**

## 3.meson.build内容
内容如下
```
project('MesonTest', 'c')

add_project_arguments('-Wall', language : 'c')
add_project_arguments('-g', language : 'c')
add_project_arguments('-fexec-charset=utf-8', language : 'c')
add_project_arguments('-D UNICODE', language : 'c')

add_project_link_arguments('-mwindows', language : 'c')

executable('hello', 'hello.c', gui_app : true)
```

## 4.配置工具链
在你的工程根目录下，新建**windows-mingw-w64-64bit.txt**  
内容如下
```
[constants]
toolchain = 'D:/MinGW'

[binaries]
c = toolchain / 'bin/gcc.exe'
cpp = toolchain / 'bin/g++.exe'
ar = toolchain / 'bin/ar.exe'
strip = toolchain / 'bin/strip.exe'
windres = toolchain / 'bin/windres.exe'

[host_machine]
system = 'windows'
cpu_family = 'x86_64'
cpu = 'x86_64'
endian = 'little'
```

## 5.运行Meson

下面的运行命令环境为Window的Git客户端git-bash.exe。  
使用的工具链为MinGW。

#### 1. 进入你的项目路径

进入你的项目路径（就是meson.build所在的地方）
```bash
PATH=$PATH:/D/tool/ninja-win
echo $PATH
ninja --version

cd /d/workspace/mesontest
```

### 2. 使用Meson编译

```bash
/D/python/python.exe /d/meson/meson.py setup --cross-file windows-mingw-w64-64bit.txt build
ninja -C build
```

编译成功后，会在build文件夹下找到可执行文件。
