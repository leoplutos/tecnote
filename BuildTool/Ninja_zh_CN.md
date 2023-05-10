# Ninja

## Ninja简介
Google 工程师要解决的问题是 Chromium：超过500万行代码的大型项目，且使用了非常多的开源项目，并且很多有自己的分支或者 Patch，为了提升构建效率，这帮工程师无所不用其极。所以Ninja诞生了，它的设计就是为了更快的编译。  
Ninja的神奇之处在于，你不必使用一些混乱的构建语言，它们很难记住，因为你不经常使用它（比如 make）  
在此md文件同路径下有build.ninja例子。请参照食用。

## 1.使用前需要先安装Ninja
https://ninja-build.org/

## 2.创建build.ninja文件
在你的工程根目录下，新建**build.ninja**

## 3.build.ninja内容

* [build.ninja](build.ninja)

* 设定编译文件夹
```ninja
builddir = build
```

* 设定变量
```ninja
cc = D:/Tools/WorkTool/C/codeblocks-20.03mingw-nosetup/MinGW/bin/gcc.exe
coption = -Wall -g -fexec-charset=utf-8 -D UNICODE
loption = -mwindows
```

* 设定规则
```ninja
rule compile
    command = $cc $coption -c $in -o $out
rule link
    command = $cc $loption $in -o $out
```

* 设定编译目标  
意思为  
目标1：从messagebox.c编译成messagebox.exe  
目标2：从hello.c编译成hello.exe  
```ninja
build $builddir/hello.o: compile hello.c
build $builddir/hello.exe: link $builddir/hello.o
build $builddir/messagebox.o: compile messagebox.c
build $builddir/messagebox.exe: link $builddir/messagebox.o
```

## 4.运行Ninja

下面的运行命令环境为Window的Git客户端git-bash.exe。  
使用的工具链为MinGW。

#### 1. 进入你的项目路径

进入你的项目路径（就是build.ninja所在的地方）
```bash
cd /D/WorkSpace/yourProjectHome
```

### 2. 使用Ninja编译

```bash
ninja
```

编译成功后，会在build文件夹下找到可执行文件。  
Ninja还支持多线程编译。具体用法请参照官方文档。
