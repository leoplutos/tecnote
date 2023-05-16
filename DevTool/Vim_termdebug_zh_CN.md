# Vim 调试：termdebug

## Netrw简介
termdebug是从Vim8.1开始内置的调试插件，仅支持GDB。  
笔者在Vim8.0上也运行成功

## 安装
将 Vim 升级至 8.1 或以上版本。  
GDB 需升级至 7.12 或以上版本。

## 启动
默认情况下需手动加载 termdebug 插件：
```
:packadd termdebug
```
设定窗口参数，代码在左边，调试窗口在右边：
```
:let g:termdebug_wide=1
```
假设我们有一个简单的 helloworld.c 文件：
```c
#include <stdio.h>

int main()
{
	printf("Hello, World!");
	return 0;
}
```
我们将其编译为二进制文件 helloworld：
```bash
gcc -g helloworld.c -o helloworld
```
现在，我们在 Vim 中启动 termdebug 来调试这个程序：
```bash
:Termdebug helloworld
```
这时 termdebug 会为我们开三个窗口。 其中， GDB 窗口提供 GDB 原生操作；程序窗口供被调试程序使用，提供 IO 功能；源码窗口提供源码交互。 在 GUI 版本的 Vim （如 gvim）中，源码窗口还提供交互按钮。  
我们可以通过 Ctrl-W 按键切换不同窗口。

## 编辑.vimrc实现按键映射
如果感觉每次输入termdebug命令太麻烦，可以使用按键映射，在.vimrc中写入：
```
"use termdebug
map <F10> :call Runtermdebug()<CR>
func! Runtermdebug()
    exec "w"
    if &filetype == 'c'
        exec "!gcc % -g -o %<"
    elseif &filetype == 'cpp'
        exec "!g++ % -g -o %<"
    endif
    exec "packadd termdebug"
    exec "Termdebug %<"
endfunc
```
之后vim打开源代码，按下F10就进入调试状态了
