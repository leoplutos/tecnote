# C相关

## 一.C语言相关

#### 1.终端输出颜色
1：粗体  
31：红色  
33：黄色  
0：重置
```c
#define  TER_ERROR  "\e[1;31m"
#define  TER_WARN   "\e[1;33m"
#define  TER_RESET  "\e[0m"

printf(TER_WARN "[WARN][%s at line:%d]" TER_RESET "这是警告\n", __func__, __LINE__);
fprintf(stderr, TER_ERROR "[ERROR][%s at line:%d]" TER_RESET "这是错误\n", __func__, __LINE__);
```

#### 2.gdb调式
在gdb调试之前，需要在编译的时候加上-g选项
```bash
gdb -tui 程序名
```
打开gdb界面后，上方是源代码窗口，下面是 gdb 终端，窗口管理快捷键模仿 emacs，支持鼠标操作。

gdb终端的常用命令如下:  
查看断点信息
```gdb
i breakpoint
```
设置断点（参数为行数）
```gdb
b 100
```
运行程序
```gdb
run [param...]
```
打印变量
```gdb
p c_str_name
```
执行一行
```gdb
n
```
执行到下一个断点处（如果没有执行到程序结束）
```gdb
c
```
查看监控信息
```gdb
i watchpoint
```
设定监控信息
```gdb
awatch c_str_name
```

## 二.IDE相关
#### CodeBlocks设定
* **设置字体**  
Setting → Editor... → General settings → Editor settings → Font  
* **设置显示空格**  
Setting → Editor... → General settings → Other editor settings → Show spaces in editor: Always  
* **设置UTF-8编码**  
Setting → Editor... → General settings → Encoding settings → Use encoding when opening files: UTF-8  
* **设置背景色**  
Setting → Editor... → Syntax highlighting → Background  
* **设置格式化**  
Setting → Editor... → Source formatter
* **设置默认工程**  
Setting → Environment... → General settings → Open Default workspace  
* **设置编译参数**  
Setting → Compiler... → Global compiler settings → Compiler settings → Other compiler options:-fexec-charset=utf-8  
* **设置链接器**  
Setting → Compiler... → Global compiler settings → Linker settings  