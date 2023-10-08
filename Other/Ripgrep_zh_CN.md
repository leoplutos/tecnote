# 文本搜索工具ripgrep

## 简介
> ripgrep recursively searches directories for a regex pattern


在 Linux 下可以用自带的 grep ，不过 grep 的命令行还是有点难记。``ripgrep`` 是开源工具，使用 ``Rust`` 编写，全平台支持。看上去比 grep 要强大不少。如果你使用 ``VS Code``，那么你必定间接的用过这个工具了，因为 ``VS Code`` 的 Find In Files 功能就是直接调用的 ``ripgrep``。

笔者觉得 ``ripgrep`` 最大的好处是默认选项，默认选项就是没有选项，直接 ``rg xxx`` 就是在当前工作目录下，递归搜索所有的文本文件里出现 ``xxx`` 字符串的位置，完全不用记什么命令行。当然如果需要的时候，可以用 ``rg -h`` 来查看帮助。


## 下载安装

#### 方式1：Github下载
* [Github地址](https://github.com/BurntSushi/ripgrep)  
``releases`` 下有对应各个系统的编译好的可执行文件。下载加进PATH即可

#### 方式2：VSCode自带
如果你有 ``VS Code``，那么就不用安装了，在 ``VS Code`` 的安装目录搜索 ``rg.exe`` 即可找到路径  
笔者的路径为
```
D:\Tools\WorkTool\Text\VSCode-win32-x64-1.81.1\resources\app\node_modules.asar.unpacked\@vscode\ripgrep\bin
```
将 ``rg.exe`` 复制到
```
D:\Tools\WorkTool\Search\ripgrep\bin
```
然后添加到 ``PATH``
```
set RIPGREP_HOME=D:\Tools\WorkTool\Search\ripgrep
set PATH=%PATH%;%RIPGREP_HOME%\bin
```
确认
```
rg --version
```

## 使用方法
进入目标目录检索 ``set`` 关键字  
无参数时为递归当前文件夹下，包括子文件夹里所有的文本文件搜索
```
cd D:\Tools\WorkTool\Cmd
rg set
```
可以看到路径，行号，颜色都有  
如果发生乱码，可以用 ``-E`` 参数修改编码  
```
rg set -E UTF-8
```

