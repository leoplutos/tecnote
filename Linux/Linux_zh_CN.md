# bash设定文件载入顺序
``/etc/profile`` ： 系统全局设定（对所有用户生效）  
↓  
``~/.bash_profile`` ： 个别用户，只有在login的时候被读取  
↓  
``~/.bashrc`` ： 个别用户，在login或者shell切换的时候被读取（比如zsh切换到bash）  


# Linux命令行常用快捷键
   | 快捷键     | 功能说明                                     |
   | ---------- | -------------------------------------------- |
   | tab        | 自动补全命令或路径                           |
   | Ctrl+a     | 将光标移动到命令行行首                       |
   | Ctrl+e     | 将光标移动到命令行行尾                       |
   | Ctrl+f     | 将光标向右移动一个字符                       |
   | Ctrl+b     | 将光标向左移动一个字符                       |
   | Ctrl+k     | 剪切从光标到行尾的字符                       |
   | Ctrl+u     | 剪切从光标到行首的字符                       |
   | Ctrl+w     | 剪切光标前面的一个单词                       |
   | Ctrl+y     | 复制剪切命名剪切的内容                       |
   | Ctrl+c     | 中断正在执行的任务                           |
   | Ctrl+h     | 删除光标前面的一个字符                       |
   | Ctrl+d     | 退出当前命令行                               |
   | Ctrl+r     | 搜索历史命令                                 |
   | Ctrl+g     | 退出历史命令搜索                             |
   | Ctrl+l     | 清除屏幕上所有内容在屏幕的最上方开启一个新行 |
   | Ctrl+s     | 锁定终端使之暂时无法输入内容                 |
   | Ctrl+q     | 退出终端锁定                                 |
   | Ctrl+z     | 将正在终端执行的任务停下来放到后台           |
   | !!         | 执行上一条命令                               |
   | !数字      | 执行数字对应的历史命令                       |
   | !字母      | 执行最近的以字母打头的命令                   |
   | !$ / Esc+. | 获得上一条命令最后一个参数                   |
   | Esc+b      | 移动到当前单词的开头                         |
   | Esc+f      | 移动到当前单词的结尾                         |

# ``$CDPATH``变量
假设你希望仅通过输入 cd html 就可以移至 /var/www/html 目录，并仅使用 cd 和简单目录名即可移至 /var/log 中的子目录。在这种情况下，``$CDPATH`` 就可以起作用：
```bash
export CDPATH=.:/var/log:/var/www
```
当你输入的不是完整路径时，``$CDPATH`` 就会生效。它向下查看其目录列表，以查看指定的目录是否存在于其中一个目录中。找到匹配项后，它将带你到那里。  
在 ``$CDPATH`` 开头保持 . 意味着你可以进入本地目录，而不必在 ``$CDPATH`` 中定义它们。

# Shebang
在Linux系统下文件的第一行注释叫做  ``Shebang``

``/usr/bin/env`` 是一种常用的 ``Unix/Linux`` 命令，主要用于查找和执行程序。它的主要作用是在不直接指定解释器路径的情况下运行脚本或程序，这样可以使脚本更具可移植性。

``env`` 命令会在环境变量 ``PATH`` 中搜索指定的命令，并执行找到的第一个匹配的命令。这使得您可以不必关心命令的具体位置。

下面给出几个例子

## 使用系统bash运行
```bash
#!/usr/bin/env bash
echo $BASH_VERSION
```

## 使用python运行
```python
#!/usr/bin/env python
print('111')
```

# 文件权限
文件权限分为：可读（r），可写（w），可执行（x）  
他们是将 r、w 和 x 表示的二进制值相加来计算的
 - r = 100b = 4
 - w = 010b = 2
 - x = 001b = 1

举例，如果一个文件的权限是 ``-rw-r--r--``  
那么
 - 6(r+w=4+2)
 - 4(r=4)
 - 4(r=4)

所以权限为 ``644``

也可以用命令来确认文件权限
```bash
stat /path/to/filename
```
命令结果为
```text
Access: (0644/-rw-r--r--)
```

# Linux命令

### 1.生成软链接
```bash
ln [参数][源文件或目录][目标文件或目录]
ln -sf openjdk8.234.12 openjdk8
```

### 2.列出一个程序所需要得动态链接库（so）
```bash
ldd [目标文件]
ldd /bin/ls
```

### 3.查找运行中程序的pid
```bash
ps aux | head -1 && ps aux | grep 程序名
```

### 4.杀掉进程
```bash
kill -9 [pid]
```

### 5.静态库（.a）操作
添加.o文件
```bash
ar r lib.a obj.o
```
删除.o文件
```bash
ar d lib.a obj.o
```
确认静态库.a
```bash
ar t lib.a
```

### 6.确认端口
```bash
netstat -tulpn
netstat -anp | grep sshd
netstat -antlp
```

### 7.Shell调试Debug
* 方法1：在sh文件第一行加上
```text
#!/bin/sh -xv
```
* 方法2：在启动shell的时候加上参数
```bash
sh -xv test.sh
bash -xv test.sh
```

### 8.复制文件
```bash
cp -afp fromfile tofile(topath)
```

### 9.移动文件
```bash
mv fromfile tofile(topath)
```

### 10.取得当前路径
```bash
current_path=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" > /dev/null 2>&1 && pwd )
echo $current_path
```

### 11.查找命令绝对路径
```bash
which ll
```

### 12.终端输出颜色
1：粗体  
31：红色  
33：黄色  
0：重置
```bash
echo -e "\e[1;31m发生错误。\e[0m提示：参数错误。"
```

### 13.查找文件和查找内容

查找文件
```bash
# 使用find
find / -name "a.txt"
# 使用fd 需要
# sudo apt install fd-find
# sudo ln -s $(which fdfind) /usr/bin/fd
fd README.md
```

查找内容
```bash
# 使用ripgrep 需要
# sudo apt install ripgrep
rg 'abc'
```

### 14.source命令
source命令也称为 ``点命令``，也就是一个点符号 ``.`` ，是bash的内部命令。  
source命令通常用于重新执行刚修改的初始化文件，使之立即生效，而不必注销并重新登录。因为linux所有的操作都会变成文件的格式存在。  
source 命令可用于：  
**1.刷新当前shell环境**
```bash
echo "alias ll='ls -al'" >> ~/.bashrc
source ~/.bashrc
# 或者
. ~/.bashrc
```
**2.当前环境下执行shell脚本**
```bash
[root@localhost ~]# nano echo.sh
#!/bin/bash
echo $(id)
[root@localhost ~]# source echo.sh
```
**3.从脚本中导入shell函数到当前环境**
```bash
[root@localhost ~]# nano func.sh
#!/bin/bash
foo(){
  echo "test_function"
}
[root@localhost ~]# source func.sh
[root@localhost ~]# foo
test_function
```
**4.从另一个shell脚本中读取变量**
```bash
#创建var.sh脚本
[root@localhost ~]# nano var.sh
#!/bin/bash 
a=1
b=2
c=3
#创建read.sh
[root@localhost ~]# nano read.sh
#!/bin/bash
source ~/var.sh
echo $a
echo $b
echo $c
```

### 15.输出重定向 ``>`` 和 ``>>``
- ``>``: 会覆盖目标的原有内容，当文件存在时，会先删除原文件，再重新创建文件，然后把内容写入该文件，否则直接创建文件。  
```bash
systemctl status wildfly-01 > /temp/status.log
```
- ``>>``: 会在目标原有内容后追加内容，当文件存在时直接在文件末尾进行内容追加，不会删除原文件，否则直接创建文件。
```bash
systemctl status wildfly-01 >> /temp/status.log
```

### 16.查看当前终端的序号
```bash
tty
```

### 17.文本编辑器nano
终端下如果你不喜欢 Vim/Emacs 的话，Nano 是一个不错的选择，它是一个真正意义上的跨平台编辑器，基本上在所有 Linux 发行版上都默认自带 Nano，并且有 Windows 版本。
```bash
nano -l 文件名
```
``-l`` 参数为显示行号  

**常用快捷键**  
- ``CTRL+o`` : 回车 保存  
- ``CTRL+x`` : 退出  
- ``SHIFT+方向`` : 选择  
- ``ALT+6`` : 复制  
- ``CTRL+u`` : 粘贴  
- ``CTRL+k`` : 删除当前行（选择多行的时候为删除选择的内容）  
更多请参照  
https://zhuanlan.zhihu.com/p/47794948

### 18.查看log日志
在监视终端log日志的时候，有时候log是实时更新的，这种时候用tail命令会很方便
```bash
tail -f -n200 filename.log
```

### 19.删除非空文件夹
```bash
rm -rf dir-name
```

### 20.按照时间倒序表示文件列表
```bash
ls -ltr
```
- ``-l`` : 表示列表
- ``-t`` : 按时间排序
- ``-r`` : 顺序倒序

### 21.shell的启动方式
shell有2种常用的启动方式。
* 方法1：需要运行权限
```bash
./test.sh
```
* 方法2：不需要运行权限
```bash
sh test.sh
bash test.sh
```

### 22.单引号与双引号
- ``""`` : 双引用, 除了 ``$`` 的其他符号都变成纯文本符号
- ``''`` : 单引用, 所有符号都变成纯文本符号

### 23.保持权限压缩与解压缩
压缩
```bash
tar cvzfp xxxxx.tar.gz [路径]
```
解压缩
```bash
tar xvzfp xxxxx.tar.gz
```

### 24.给其他用户发送信息
```bash
write [用户名] [tty名]
write user1 pts/2
```
tty名可以以下命令确认
```bash
w
```
使用Ctrl+d结束发送信息

### 记录脚本执行时间
```bash
time sleep 0.7
```

### Here Document （HereDoc）
HereDoc 是 ``Here Document`` 的缩写，是一种在 Bash 脚本中包含文本块的方法。该文本块可以包含您想要的任何内容，包括命令、变量和其他特殊字符。 HereDocs 很有用，因为它们允许您包含大块文本，而不必担心转义特殊字符或处理复杂的引用规则

例子1: 输出内容
```bash
cat << EOF
这是一个 Here Document 例子
它可以包含多行文本
EOF
```

例子2: 统计行数
```bash
wc -l << EOF
第一行
第二行
第三行
EOF
```

例子3: 生成配置文件
```bash
cat << EOF > config.ini
[server]
host = example.com
port = 80
user = $USER
EOF
```

例子4: 生成root权限的配置文件
```bash
sudo tee config.ini << EOF
[server]
host = example.com
port = 80
user = $USER
EOF
```

例子5: 生成root权限的配置文件，并且使用单引号防止 Bash 解释块中的任何变量或特殊字符
```bash
sudo tee config.ini << 'EOF'
[server]
host = example.com
port = 80
user = $USER
EOF
```

### 测试网络端口

安装 ``netcat``
```bash
sudo apt install netcat-traditional -y
```

比如想测试 IP ``172.30.8.172`` 的端口 ``9500`` 是否可用

TCP
```bash
nc -vz 172.30.8.172 9500
```

UPD
```bash
nc -vzu 172.30.8.172 9500
```

### 运行程序并且取得pid
```bash
应用程序 & top -p $! -b > top_result.txt
```
比如运行sleep命令
```bash
sleep 10 & top -p $! -b > top_result.txt
```
如果想要将top的结果生成报表的话，可以使用这个库  
[linux-top-parser-graph-maker](https://github.com/kaushikvelusamy/linux-top-parser-graph-maker)

### CPU核心数确认命令
```bash
lscpu
nproc -all
getconf _NPROCESSORS_ONLN
```

### 查看当前Shell
```bash
echo $0
echo $SHELL
```

# 函数处理
``$0`` ： 脚本名称  

``$1`` ： -$9 第一个参数到第9个参数  

``$#`` ： 返回参数个数(不包括$0)  

``$*`` ： 返回所有参数(不包括$0)  

``$@`` ： 返回所有参数(不包括$0)  

``$$`` ： 脚本当前运行的进程ID  

``$!`` ： 后台运行的最后一个进程ID  

``$-`` ： 返回Shell使用的当前选项，与set命令相同  

``$?`` ： 函数返回值  

``$FUNCNAME`` ： 函数名称(仅再函数内部有值)  

# musl libc 与 glibc
musl Linux 和 glibc 是两种不同的 C 标准库实现，它们在多个方面存在显著差异

## glibc
glibc 是较早且广泛使用的 C 标准库实现，具有较长的开发历史和广泛的社区支持。它被大多数 Linux 发行版采用，特别是在桌面和服务器环境中  
glibc 功能全面且复杂，支持多种扩展和功能，具有较高的稳定性和可靠性。  
glibc 采用 ``LGPL`` 许可证  
glibc 在桌面和服务器环境中更为常见，支持更多的功能和扩展

## musl libc
musl 是一个相对较新的实现，旨在提供更小、更快、更安全的 C 库。它被一些轻量级 Linux 发行版如 Alpine Linux 采用  
musl 虽然功能较少，但更严格地遵循 POSIX 标准，且代码量比 glibc 少得多，不需要额外的外部依赖库。musl 的二进制兼容性有限，但随着新版本的发布，兼容性在逐步提高  
musl 设计为轻量级，适用于嵌入式系统和资源受限的环境，能够创建小巧的静态可执行文件  
musl 采用 ``MIT 许可证``，比 glibc 更宽松，``便于发布静态可执行文件``  
musl 在嵌入式系统、容器化应用和轻量级发行版中表现出色

# 其他

### 使用 7-Zip 归档 tar

**Windows 归档：**
```bash
7z.exe a result_file target_folder
"D:\Tools\7-Zip\7z.exe" a ziptest.tar ziptest
```
**Linux 解档：**
```bash
tar -xvf file_name
tar -xvf ziptest.tar
```

### 使用 7-Zip 压缩 gz
需要 2 次命令，第一次归档，第二次压缩  
**Windows 压缩：**
```bash
7z.exe a result_file target_tar_file_name
"D:\Tools\7-Zip\7z.exe" a ziptest.tar.gz ziptest.tar
```
**Linux 解档解压缩：**
```bash
tar -zxvf file_name
tar -zxvf ziptest.tar.gz
```

# 更多
* [BASH CHEATSHEET (中文速查表)](https://github.com/skywind3000/awesome-cheatsheets/blob/master/languages/bash.sh)
* [Shell小教程](https://github.com/dunwu/blog/blob/master/source/_posts/02.%E7%BC%96%E7%A8%8B/02.%E7%BC%96%E7%A8%8B%E8%AF%AD%E8%A8%80/02.shell.md)

