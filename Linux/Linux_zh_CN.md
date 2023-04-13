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
```

### 7.Shell调试Debug
在sh文件第一行加上
```console
#!/bin/sh -xv
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