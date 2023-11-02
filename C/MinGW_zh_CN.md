# MinGW64

## 简介

### 官方网站
[https://www.mingw-w64.org/](https://www.mingw-w64.org/)

### MinGW 和 MinGW-W64 区别和联系

MinGW和MinGW-W64都是用于Windows平台的轻量级GNU工具链，用于开发和编译C和C++程序。

MinGW（Minimalist GNU for Windows）是一个32位的GNU工具链，它提供了一套基于GNU的开发环境，包括GCC编译器和一些GNU库，可以用来编译Windows下的C和C++程序。但MinGW只支持32位程序的编译。

MinGW-W64是一个64位的GNU工具链，是MinGW的升级版，原本它是MinGW的分支，后来成为独立发展的项目，它支持同时编译32位和64位程序。它包括了一系列的GNU库和工具，例如GCC、Binutils、GDB等，还支持一些实用工具和库，如OpenMP、MPI等。

总的来说，MinGW-W64可以看作是MinGW的升级版，它支持更多的编译选项和更多的库，可以编译出更加高效和安全的程序。

另外，MinGW-W64原本是从MinGW项目fork出来的独立的项目。MinGW 早已停止更新，内置的GCC最高版本为4.8.1，而MinGW-W64目前仍在维护，它也是GCC官网所推荐的。

### MSVCRT 和 UCRT 介绍
MSVCRT和UCRT都是用于Windows平台的C运行时库，提供了基本的C函数和类型，用于C程序的开发和运行。

MSVCRT（Microsoft Visual C Runtime）是Microsoft Visual C++早期版本使用的运行时库，用于支持C程序的运行。它提供了一些常用的C函数，如printf、scanf、malloc、free等。MSVCRT只能在32位Windows系统上运行，对于64位系统和Windows Store应用程序不支持。

UCRT（Universal C Runtime）是在Windows 10中引入的新的C运行时库，用于支持C程序的运行和开发。UCRT提供了一些新的C函数，同时还支持Unicode字符集和安全函数，如strcpy_s、strcat_s、_itoa_s等。UCRT同时支持32位和64位系统，并且可以与Windows Store应用程序一起使用。

总的来说，UCRT是Microsoft为了更好地支持Windows 10和Windows Store应用程序而开发的新一代C运行时库，相比于MSVCRT，UCRT提供了更多的功能和更好的兼容性，对 UTF-8 语言环境的支持更好。但对旧的32位Windows系统，MSVCRT仍然是必需的。

## 下载安装

### 二进制包下载
[Github-niXman](https://github.com/niXman/mingw-builds-binaries/releases)

### 二进制包的选择
- 32位的操作系统，选择 ``i686``，64位的操作系统，选择 ``x86_64``
- ``win32`` 是开发Windows系统程序的协议，``posix`` 是其他系统的协议（例如Linux、Unix、Mac OS）
- 异常处理模型 ``seh``（新的，仅支持64位系统），``sjlj``（稳定的，64位和32位都支持）， ``dwarf``（优于sjlj的，仅支持32位系统）
- ``rt_v11`` 运行时库版本
- ``rev1`` 构建版本

### 笔者选择的为
[x86_64-13.2.0-release-posix-seh-ucrt-rt_v11-rev0.7z](https://github.com/niXman/mingw-builds-binaries/releases/download/13.2.0-rt_v11-rev0/x86_64-13.2.0-release-posix-seh-ucrt-rt_v11-rev0.7z)

## 配置
下载后解压缩，配置到环境变量里就可以在命令行使用了
```
gcc --version
gdb --version
```
