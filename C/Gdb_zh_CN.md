# gdb相关

## gdb简介
GDB 全称“GNU symbolic debugger”，从名称上不难看出，它诞生于 GNU 计划（同时诞生的还有 GCC、Emacs 等），是 Linux 下常用的程序调试器。发展至今，GDB 已经迭代了诸多个版本，当下的 GDB 支持调试多种编程语言编写的程序，包括 C、C++、Go、Objective-C、OpenCL、Ada 等。实际场景中，GDB 更常用来调试 C 和 C++ 程序。

## 启动gdb调式
在gdb调试之前，需要在编译的时候加上 **-g** 选项
```bash
gcc -g main.c second.c -o main
```
启动gdb调试命令为：
```bash
gdb -tui 程序名
```
打开gdb界面后，上方是源代码窗口，下面是 gdb 终端，窗口管理快捷键模仿 emacs，支持鼠标操作。

## gdb常用启动参数
| 参数   | 说明                                           |
|--------|------------------------------------------------|
| -q     | 不打印gdb版本信息，界面较为干净                |
| -tui   | 打开TUI模式，会显示 command 窗口和 source 窗口 |
| --args | 设置命令行参数                                 |

## gdb终端的常用命令
查看断点信息
```gdb
(gdb)i breakpoint
```
设置断点（参数为行数）
```gdb
(gdb)b 100
```
设置断点为main函数
```gdb
(gdb)b main
```
运行程序
```gdb
(gdb)run [param...]
```
打印变量
```gdb
(gdb)p c_str_name
```
执行一行源程序代码，此行代码中的函数调用也一并执行，不进入函数
```gdb
(gdb)n
```
执行一行源程序代码，如果此行代码中有函数调用，则进入该函数(单步跟踪进入)
```gdb
(gdb)s
(gdb)step
```
执行到当前函数结束(单步跟踪退出)
```gdb
(gdb)fin
(gdb)finish
```
运行到x处(常用来跳过循环)
```gdb
(gdb)u 70
(gdb)until 70
(gdb)until main.c:60
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

### 获取GDB使用的Python版本
系统上的 Python 版本不一定是用 GDB 编译的版本，可以通过以下方式找到：
```
gdb --batch -ex 'python import sys; print(sys.version)'
```

### 更多
* [GDB CHEATSHEET (中文速查表)](https://github.com/skywind3000/awesome-cheatsheets/blob/master/tools/gdb.txt)

## gdb插件
虽然默认的gdb有TUI，但是信息不够丰富。
gdb支持python插件，这个时候可以用插件让显示内容丰富一些让开发者把注意力回到调式程序本身。  
\~/.gdbinit 是一个 gdb配置脚本，可以设定一些由 python 编写的插件。  
用法就是将python脚本放到.gdbinit文件中。或者启动gdb的时候跟上参数 -x 指定插件路径。  
另外，.gdbinit 文件在Linux系统下是隐藏文件，如果查看要使用命令 **ls -al**

主流的插件有下面几种
- gdb-dashboard
- peda
- gef
- pwndbg

这里只记录gdb-dashboard的用法，剩下的大同小异

#### 1.取得python脚本
手动去github网页取得.gdbinit文件  
https://github.com/cyrus-and/gdb-dashboard  
或者用命令取得
```bash
wget -P ~ https://git.io/.gdbinit
```
在此md同路径也有，哪里下载都可以
* [.gdbinit](.gdbinit)

#### 2.配置到终端上运行
因为放到\~/.gdbinit会影响到使用终端的所有人，为了不污染服务器，笔者习惯放到自己的路径下用参数运行。  
具体操作如下：  
将.gdbinit上传到服务器路径
/path/to/gdbinit
然后gdb启动的时候添加参数
```bash
gdb -x /lch/workspace/gdbinit/.gdbinit 你的程序名
```
如果你实在不想每次都敲那么多东西，可以用alias键映射：
```bash
alias gdbx='gdb -x /lch/workspace/gdbinit/.gdbinit'
```
gdb启动后发现gdb的提示符从 (gdb) 变成了 **\>\>\>**，证明脚本载入成功。  
gdb-dashboard不会改变任何gdb命令，只要添加1个断点，并且运行。那么gdb-dashboard的各个仪表盘就会表示出来
```gdb
>>>b main
>>>run
```

#### ３．定义显示的仪表盘
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

#### ４.监视变量
```gdb
>>>dashboard expressions watch 变量名
```

#### ５．使用多个终端显示

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

#### 配置持久化
每次打开 gdb-dashboard 都要为自己的定制敲上几行命令才顺手。为了解决这个问题（主要就是懒），可以将如下定义放到 ``/lch/workspace/gdbinit/.gdbinit`` 的最下面即可
```
#主分割线填充
dashboard -style divider_fill_char_primary '#'
#分割线颜色设置
#dashboard -style divider_fill_style_primary '33'
#关键字颜色设置
#dashboard -style divider_label_style_on_primary '1;31'
#定制显示内容
dashboard -layout !assembly breakpoints expressions !history !memory !registers source stack threads variables
#代码高度
dashboard source -style height 25
#变量单行显示
#dashboard variables -style compact False
#设定别名
alias -a w = dashboard expression watch
```

#### gdb-dashboard里面source(代码窗口)的滚动
首先在个人路径下新建 ``inputrc`` 文件
```
cd /lch/workspace
mkdir readline
cd readline
touch inputrc
vim inputrc
```
编辑，复制以下内容，保存
```
$include /etc/inputrc

$if gdb
    "\C-p": "\C-a\C-kserver dashboard source scroll 1\n\C-y"
    "\C-n": "\C-a\C-kserver dashboard source scroll -1\n\C-y"
    "\C-\M-p": "\C-a\C-kserver dashboard assembly scroll 1\n\C-y"
    "\C-\M-n": "\C-a\C-kserver dashboard assembly scroll -1\n\C-y"
$endif
```
笔者的inputrc
* [inputrc](inputrc)

然后在自定义 ``bashrc`` 中加入如下内容
```
export INPUTRC='/lch/workspace/readline/inputrc'
```
重新登录服务器，启动 ``gdb`` ，在 ``gdb-dashboard`` 窗口出现以后，即可 ``Ctrl+p`` 向上滚动代码，``Ctrl+n`` 向下滚动代码  

**原理说明：**  
Linux下的Readline初始化文件（即inputrc）的加载顺序为：
 - 环境变量 ``INPUTRC`` 中
 - ``~/.inputrc``
 - ``/etc/inputrc``
我们在自定义bashrc中设定了环境变量 ``INPUTRC`` 的路径，让 ``gdb`` 启动的时候可以加载自定义内容，以实现快捷键绑定

## 一些特殊情况下的调试

#### 参数传递
启动gdb之后，每次运行程序(run命令)都要跟参数，可以用如下方式启动
```bash
gdb -q -tui --args 程序名 参数1 参数2
```
这样启动之后直接运行run即可。

#### shell调用的C程序
有些工程里，我们想调式的程序是用shell启动的。这种时候可以复制一份调试用的shell : xxx_forgdb.sh，用复制的xxx_forgdb.sh调试。  

修改前的xxx.sh
```bash
export main_env=333
cd /path/to/yourPJ
./main $1 $2 $3
```
复制的xxx_forgdb.sh
```bash
export main_env=333
cd /path/to/yourPJ
gdb -q -tui --args main $1 $2 $3
```
如果使用了插件，可以如下写
```bash
export main_env=333
cd /path/to/yourPJ
gdb -x /lch/workspace/gdbinit/.gdbinit -q --args main $1 $2 $3
```
启动调试用的shell，执行到gdb的地方会弹出gdb界面，正常调试即可。





