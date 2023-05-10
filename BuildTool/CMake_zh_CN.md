# CMake

## CMake简介
CMake可以帮助你生成make文件，并且编译你的工程。举1个不恰当的例子：直接用命令编译，等于裸奔。用make编译，等于穿了一条内裤。用Cmake编译，等于内裤外面又穿了一条秋裤。
在此md文件同路径下有例子代码。请参照食用。

## 1.使用前需要先安装CMake
https://cmake.org/

## 2.创建Cmake文件
在你的工程根目录下，新建**CMakeLists.txt**

* [CMakeLists.txt](CMakeLists.txt)

## 3.CMakeLists.txt内容

* 设定最低版本
```cmake
cmake_minimum_required (VERSION 3.24)
```

* 输出编译信息
```cmake
set(CMAKE_VERBOSE_MAKEFILE ON)
```

* 设定gcc路径（也可以添加到环境变量里，添加后不用设定）
```cmake
set(CMAKE_C_COMPILER "D:/MinGW/bin/gcc.exe")
set(CMAKE_C_COMPILER_WORKS TRUE)
```

* 添加编译Option
```cmake
add_compile_options(-Wall -g -fexec-charset=utf-8 -D UNICODE)
```

* 设定工程名和开发语言
```cmake
project (Win32Sample LANGUAGES C)
```

* 设定编译目标  
意思为  
目标1：从messagebox.c编译成messagebox.exe  
目标2：从hello.c编译成hello.exe  
WIN32为不带控制台的Windows应用
```cmake
add_executable(messagebox WIN32 messagebox.c)
add_executable(hello WIN32 hello.c)
```

## 4.运行CMake命令

下面的运行命令环境为Window的Git客户端git-bash.exe。  
使用的工具链为MinGW。  
因为笔者不喜欢什么都添加到环境变量里。所以全部参数指定。

### 1. 运行命令生成build文件夹，并且生成make文件

进入你的项目路径（就是CMakeLists.txt所在的地方）
```bash
cd /D/WorkSpace/yourProjectHome
```

生成build文件夹。  
-G "MinGW Makefiles"的意思为使用MinGW的工具链  
-D"CMAKE_MAKE_PROGRAM:PATH="为设定make.exe的路径（如果添加了环境变量，可不设）
```bash
D:/cmake-3.26.1-windows-x86_64/bin/cmake.exe --fresh -S . -B build -G "MinGW Makefiles" -D"CMAKE_MAKE_PROGRAM:PATH=D:/MinGW/bin/mingw32-make.exe"
```

### 2. 使用make文件编译

编译所有目标
```bash
D:/cmake-3.26.1-windows-x86_64/bin/cmake.exe --build build
```

只编译目标messagebox
```bash
D:/cmake-3.26.1-windows-x86_64/bin/cmake.exe --build build --target messagebox
```


只编译目标hello
```bash
D:/cmake-3.26.1-windows-x86_64/bin/cmake.exe --build build --target hello
```

编译成功后，会在build文件夹下找到可执行文件。

