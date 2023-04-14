# C语言相关

## 1.终端输出颜色
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

## 2.gdb调式
在gdb调试之前，需要在编译的时候加上 **-g** 选项，启动调试命令为：
```bash
gdb -tui 程序名
```
打开gdb界面后，上方是源代码窗口，下面是 gdb 终端，窗口管理快捷键模仿 emacs，支持鼠标操作。

gdb终端的常用命令如下:  
查看断点信息
```gdb
(gdb)i breakpoint
```
设置断点（参数为行数）
```gdb
(gdb)b 100
```
运行程序
```gdb
(gdb)run [param...]
```
打印变量
```gdb
(gdb)p c_str_name
```
执行一行
```gdb
(gdb)n
```
执行到下一个断点处（如果没有执行到程序结束）
```gdb
(gdb)c
```
查看监控信息
```gdb
(gdb)i watchpoint
```
设定监控信息
```gdb
(gdb)awatch c_str_name
```
退出gdb
```gdb
(gdb)q
```
打印环境变量HOME
```gdb
(gdb) show environment HOME
```
运行shell命令pwd
```gdb
(gdb) shell pwd
```

## 3.gdb插件
虽然默认的gdb有TUI，但是信息不够丰富。
gdb支持python插件，这个时候可以用插件让显示内容丰富一些让开发者把注意力回到调式程序本身。  
~/.gdbinit 是一个 gdb配置脚本，可以设定一些由 python 编写的插件。  
用法就是将python脚本放到.gdbinit文件中。或者启动gdb的时候跟上参数 -x 指定插件路径。  
另外，.gdbinit 文件在Linux系统下是隐藏文件，如果查看要使用命令 **ls -al**

主流的插件有下面几种
- gdb-dashboard
- peda
- gef
- pwndbg

这里只记录gdb-dashboard的用法，剩下的大同小异

**1.取得python脚本**  
手动去github网页取得.gdbinit文件  
https://github.com/cyrus-and/gdb-dashboard  
或者用命令取得
```bash
wget -P ~ https://git.io/.gdbinit
```
在此md同路径也有，哪里下载都可以

**2.配置到终端上运行**  
因为放到~/.gdbinit会影响到使用终端的所有人，为了不污染服务器，笔者习惯放到自己的路径下用参数运行。  
具体操作如下：  
将.gdbinit上传到服务器路径
/aaa/gdbinit
然后gdb启动的时候添加参数
```bash
gdb -x /aaa/gdbinit/.gdbinit 你的程序名
```
gdb启动后发现gdb的提示符从** (gdb)** 变成了 **\>\>\>**，证明脚本载入成功。  
gdb-dashboard不会改变任何gdb命令，只要添加1个断点，并且运行。那么gdb-dashboard的各个仪表盘就会表示出来
```gdb
>>>b 64
>>>run
```

**３．定义显示的仪表盘**  
默认显示的模块太多、屏幕放不下了，有个别模块我们目前用不到，可以通过修改配置关闭一些模块的显示  
dashboard 目前支持的全部组件如下：
- assembly 汇编
- breakpoints 断点信息
- expressions 监视表达式
- history 历史
- memory 内存
- registers 寄存器
- source 代码
- stack 栈
- threads 线程
- variables 变量

我们可以在配置文件中定义启动后显示的组件  
也可以使用-layout指令来定义需要显示的内容和隐藏的内容  
比如我们只显示 breakpoints expressions source variables
```gdb
>>>dashboard -layout breakpoints expressions source variables !assembly !history !memory !registers !stack !threads
```
这个定义顺序也表示模组的展示顺序，从上到下  
!叹号表示默认不显示该模组，当我们输入命令 dashboart variables命令时候，可以在对应的位置插入显示

**４.监视变量**
```gdb
>>>dashboard expressions watch 变量名
```

**５．使用多个终端显示**

除了设置某些组件不显示之外，我们还可以设置让某个组件在其他终端显示输出  
整个gdb-dashboard的显示内容或者是单个模块组件的显示内容都可以单独独立的在不同的终端输出显示  
使用-output 命令用来将输出内容重定向到其他的界面或设备，可以实现上面的目标  

输入tty命令查看当前终端的序号
```bash
tty
```
假设我有3个终端  
终端1为：/dev/pts/4  
终端2为：/dev/pts/6  
终端3为：/dev/pts/7  

在终端1开启gdb调试，然后运行如下命令重定向内容

重定向全部输出到 /dev/pts/6
```gdb
>>>dashboard -output /dev/pts/6
```
重定向 assembly 组件到 /dev/pts/7
```gdb
>>>dashboard assembly -output /dev/pts/7
```
重定向 source组件输出到 /dev/pts/7
```gdb
>>>dashboard source -output /dev/pts/7
```
将组件重定向到其他窗口以后，可以使用下面的命令使得组件全屏显示
```gdb
>>>dashboard source -style height 0
```

