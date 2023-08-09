# bash设定文件载入顺序
/etc/profile ： 系统全局设定（对所有用户生效）  
↓  
~/.bash_profile ： 个别用户，只有在login的时候被读取  
↓  
~/.bashrc ： 个别用户，在login或者shell切换的时候被读取（比如zsh切换到bash）  


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

# \$CDPATH变量
假设你希望仅通过输入 cd html 就可以移至 /var/www/html 目录，并仅使用 cd 和简单目录名即可移至 /var/log 中的子目录。在这种情况下，此 \$CDPATH 就可以起作用：
```bash
export CDPATH=.:/var/log:/var/www
```
当你输入的不是完整路径时，\$CDPATH 就会生效。它向下查看其目录列表，以查看指定的目录是否存在于其中一个目录中。找到匹配项后，它将带你到那里。  
在 \$CDPATH 开头保持 . 意味着你可以进入本地目录，而不必在 $CDPATH 中定义它们。

# Shebang
在Linux系统下文件的第一行注释叫做  ``Shebang``
一般推荐如下写法
```
#!/usr/bin/env bash
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
```
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

### 13.查找文件
```bash
find / -name "a.txt"
```

### 14.source命令
source命令也称为“点命令”，也就是一个点符号（.），是bash的内部命令。  
source命令通常用于重新执行刚修改的初始化文件，使之立即生效，而不必注销并重新登录。因为linux所有的操作都会变成文件的格式存在。  
source 命令可用于：  
**1.刷新当前shell环境**
```bash
[root@localhost ~]# echo "alias ll='ls -al'" >> ~/.bashrc
[root@localhost ~]# source ~/.bashrc
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

### 15.输出重定向“>”和“>>”
**\>**  会覆盖目标的原有内容，当文件存在时，会先删除原文件，再重新创建文件，然后把内容写入该文件，否则直接创建文件。  
```bash
systemctl status wildfly-01 > /temp/status.log
```
**\>>**  会在目标原有内容后追加内容，当文件存在时直接在文件末尾进行内容追加，不会删除原文件，否则直接创建文件。
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
-l 参数为显示行号  

**常用快捷键**  
CTRL+o 回车 保存  
CTRL+x 退出  
SHIFT+方向 选择  
ALT+6 复制  
CTRL+u 粘贴  
CTRL+k 删除当前行（选择多行的时候为删除选择的内容）  
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
* -l 表示列表
* -t 按时间排序
* -r 顺序倒序

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
```bash
""双引用, 除了$\`的其他符号都变成纯文本符号
```
```bash
''单引用, 所有符号都变成纯文本符号
```

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

### 运行程序并且取得pid
```
应用程序 & top -p $! -b > top_result.txt
```
比如运行sleep命令
```
sleep 10 & top -p $! -b > top_result.txt
```
如果想要将top的结果生成报表的话，可以使用这个库  
[linux-top-parser-graph-maker](https://github.com/kaushikvelusamy/linux-top-parser-graph-maker)

### CPU核心数确认命令
```
lscpu
nproc -all
getconf _NPROCESSORS_ONLN
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

# 其他

### 使用7-Zip归档tar

**Windows归档：**
```
7z.exe a result_file target_folder
"D:\Tools\7-Zip\7z.exe" a ziptest.tar ziptest
```
**Linux解档：**
```
tar -xvf file_name
tar -xvf ziptest.tar
```

### 使用7-Zip压缩gz
需要2次命令，第一次归档，第二次压缩  
**Windows压缩：**
```
7z.exe a result_file target_tar_file_name
"D:\Tools\7-Zip\7z.exe" a ziptest.tar.gz ziptest.tar
```
**Linux解档解压缩：**
```
tar -zxvf file_name
tar -zxvf ziptest.tar.gz
```

# 更多
* [BASH CHEATSHEET (中文速查表)](https://github.com/skywind3000/awesome-cheatsheets/blob/master/languages/bash.sh)
* [Shell小教程](https://github.com/dunwu/blog/blob/master/source/_posts/02.%E7%BC%96%E7%A8%8B/02.%E7%BC%96%E7%A8%8B%E8%AF%AD%E8%A8%80/02.shell.md)

