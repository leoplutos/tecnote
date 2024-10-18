# Linux自定义欢迎界面

## /etc/motd简介
在类 Unix 系统中，``/etc/motd`` 是一个包含「今日消息（Message of the day）」的文件，用于自定义欢迎界面，在用户成功登录终端后显示。
此外，作为ssh访问系统用户必须配置 ``/etc/ssh/sshd_config`` 文件。

## 更改ssh配置文件
```bash
vim /etc/ssh/sshd_config
```
修改PrintMotd为yes
```
#远程用户登录时是否打印/etc/motd文件信息
PrintMotd yes
```

## 修改/etc/motd
确认
```bash
ll /etc/motd
```
不存在则新建
```bash
touch /etc/motd
```
修改
```bash
vim /etc/motd
```
加入如下内容
```
     _.-"""""-._         _.-"""""-._         _.-"""""-._
   ,'           `.     ,'           `.     ,'           `.
  /               \   /               \   /               \
 |                 | |                 | |                 |
|                   |                   |                   |
|                   |                   |                   |
 |             _.-"|"|"-._         _.-"|"|"-._             |
  \          ,'   /   \   `.     ,'   /   \   `.          /
   `.       /   ,'     `.   \   /   ,'     `.   \       ,'
     `-..__|..-'         `-..|_|..-'         `-..|__..-'
          |                   |                   |
          |                   |                   |
           |                 | |                 |
            \               /   \               /
             `.           ,'     `.           ,'
               `-..___..-'         `-..___..-'
```
退出重新登录即可

## 定制内容的网站

#### ASCiiWorld
提供现成的图案  
http://www.asciiworld.com/

#### Patorjk
可以根据自己输入的文字，并选择对应的字体来生成字符画，字体种类比较丰富  
http://patorjk.com/software/taag/

# Linux命令别名
## alias简介
在 linux 中，alias 命令（注意全为小写）的功能是设置命令的别名，以简写命令，提高操作效率。

**查看当前的别名设置**
```bash
alias
```
**设置别名**
```bash
alias ll='ls -hl --full-time --time-style=long-iso --color=auto'
alias lla='ls -hal --full-time --time-style=long-iso --color=auto'
alias llt='ls -htl --full-time --time-style=long-iso --color=auto'
alias gdbx='gdb -x ~/work/lch/rc/gdbrc/.gdbinit'
```
**删除别名**
```bash
unalias gdbx
```

## 设定持久化

### 全局设置

通过修改 ``~/.bash_profile`` (或者 ``~/.bashrc`` ) 文件来全局设置。内容如下

```bash
alias ll='ls -hl --full-time --time-style=long-iso --color=auto'
```

# Linux自定义命令提示符


笔者的设定文件 [.bashrc-personal](../Linux/linux_rc/bashrc/.bashrc-personal)  

为了不污染服务器，笔者习惯设定到到自己的 ``.bashrc-personal`` 中，然后 ``source`` 一下即可  

灵感来自
- [bash-prompt-generator.org](https://bash-prompt-generator.org/)
- [my-new-bash-prompt.html](https://www.mikekasberg.com/blog/2021/06/28/my-new-bash-prompt.html)
- [nerdps1](https://github.com/joknarf/nerdps1/)
- [stackoverflow](https://stackoverflow.com/questions/3058325/what-is-the-difference-between-ps1-and-prompt-command)

## PS1简介
PS1是linux系统中的一个全局变量，用于定义用户命令行的字符显示。
```bash
# 命令行中可以通过命令获得PS1结果
echo $PS1
# 默认值为
'[\u@\h \W]\$ '
# 也可以这么写
"`whoami`@`hostname -s`# "
```
注意：颜色代码语言用``方括号``括起来，括号告诉 bash 不应该打印包含的文本  
全部写成一行的话可读性很差，所以笔者用如下设定持久化的写法  
``\e`` 等同于 ``\033``

## 设定持久化

### 全局设置

通过修改 ``~/.bash_profile`` (或者 ``~/.bashrc`` ) 文件来全局设置。内容如下

#### 无NerdFont版本

```bash
PS_IP=$(hostname -I | awk '{print$1}')
PS_IP=`echo ${PS_IP}`
PS_RED="\[\033[0;31m\]"
PS_LIGHT_RED="\[\033[1;31m\]"
PS_GREEN="\[\033[0;32m\]"
PS_YELLOW="\[\033[0;33m\]"
PS_BLUE="\[\033[0;34m\]"
PS_MAGENTA="\[\033[0;35m\]"
PS_CYAN="\[\033[0;36m\]"
PS_CLEAR="\[\033[0m\]"
export PS1="${PS_YELLOW}[bash]${PS_GREEN}[${PS_IP}]${PS_MAGENTA}\u@\h${PS_CLEAR}:${PS_YELLOW}\w${PS_CLEAR}\n${PS_BLUE}\$ ${PS_CLEAR}"
```

#### 有NerdFont版本
```bash
UBUNTU_ICON=`echo  `
PS_IP=$(hostname -I | awk '{print$1}')
PS_IP=`echo ${PS_IP}`
PS_RED="\[\033[0;31m\]"
PS_LIGHT_RED="\[\033[1;31m\]"
PS_GREEN="\[\033[0;32m\]"
PS_YELLOW="\[\033[0;33m\]"
PS_BLUE="\[\033[0;34m\]"
PS_MAGENTA="\[\033[0;35m\]"
PS_CYAN="\[\033[0;36m\]"
PS_CLEAR="\[\033[0m\]"
export PS1="${PS_YELLOW}${UBUNTU_ICON}[bash]${PS_GREEN}[${PS_IP}]${PS_MAGENTA}\u@\h${PS_CLEAR}:${PS_YELLOW}\w${PS_CLEAR}\n${PS_BLUE}\$ ${PS_CLEAR}"
```

#### 显示错误码的版本
```bash
PROMPT_COMMAND=__prompt_command
__prompt_command() {
    local EXIT_STATUS="$?"
    PS1=""
    local UBUNTU_ICON=' '
    local PS_IP=$(hostname -I | awk '{print$1}')
    local PS_RED='\[\e[0;31m\]'
    local PS_LIGHT_RED='\[\e[1;31m\]'
    local PS_GREEN='\[\e[0;32m\]'
    local PS_YELLOW='\[\e[0;33m\]'
    local PS_BLUE='\[\e[0;34m\]'
    local PS_MAGENTA='\[\e[0;35m\]'
    local PS_CYAN='\[\e[0;36m\]'
    local PS_CLEAR='\[\e[0m\]'
    if [ $EXIT_STATUS != 0 ]; then
        PS1+="${PS_LIGHT_RED}[${EXIT_STATUS}] "
    else
        PS1+=""
    fi
    PS1+="${PS_YELLOW}${UBUNTU_ICON}[bash]${PS_GREEN}[${PS_IP}]${PS_MAGENTA}\u@\h${PS_CLEAR}:${PS_YELLOW}\w${PS_CLEAR}\n${PS_BLUE}\$ ${PS_CLEAR}"
}
```

## 格式控制详解
```bash
'[\u@\h \W]\$ '
# '[', ']'表示普通字符，对应样式中的'[', ']'
# '\u'代表当前bash的用户名
# '\h'代表当前的主机名（只显示第一个名字）
# '\W'代表当前工作目录名称
# '\$'是提示字符，当前用户为root用户时，会显示为'#'，为普通用户时，会显示为'$'
# ' '是空格字符，样式中也显示为空格

# 其他转义字符
# '\d': 日期
# '\t': 24小时格式时间 HH:MM:SS
# '\T': 12小时格式时间
# '\A': 12小时格式时间 HH:MM
# '\H': 完整的主机名称
# '\v': 当前BASH的版本信息
# '\w': 当前完整的工作目录名称，家目录在显示时会以'~'代替


# 颜色设置
# '\e[?m': 设置颜色，?处填写数字代表颜色
# '\e[m': 取消颜色设置
# '\[\e[?m\]': 这部分放在字符串左边用来控制其后显示的字符串的前景色
# '\[\e[?;?m\]': 同上，第一个?号表示前景色，第2个?表示背景色

# 综上字符显示的控制格式为: '\[ \e[A;F;Bm \]'，此设置会对其后字符串生效
# A代表加粗、下划线样式，编号0-8
# F代表字体颜色值，编号30-37
# B代表背景颜色值，编号40-47
# 如果不想有某样式，直接省略即可

```

## 编号对应格式
```bash
# 字体样式A：编号0-7
# 0 关闭所有属性
# 1 高亮显示
# 2 所有字符都有下划线
# 3 斜体
# 4 用户输入输出带有下划线
# 7 反显，有字符的地方有背景

# 字体F、背景B颜色
# F    B    Color
# 30   40   black
# 31   41   red
# 32   42   green
# 33   43   yellow
# 34   44   blue
# 35   45   purple-red
# 36   46   green-blue
# 37   47   white

```

## 更改ls的内容颜色
设定文件所在位置：  
全局
```
/etc/DIR_COLORS
```
用户
```
~/.dir_colors
```
#### 查看当前定义命令
```
dircolors -p
```
自定义方式
```
cp /etc/DIR_COLORS ~/.dir_colors
or
dircolors -p > ~/.dir_colors
```
然后修改 ``~/.dir_colors`` 即可
