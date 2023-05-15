# Git-bash使用

## 前言
git-bash是集成在MINGW64环境下的，而MINGW64用的默认终端是mintty。  
\~/.minttyrc 是 mintty 的默认启动设定文件。下面记录一些使用git-bash的技巧。

## 快速路径
git-bash.exe可以建立快捷方式，右键→属性→起始位置：粘贴一个路径后。用这个快捷方式启动git-bash就默认在这个路径下。

## git-bash.exe的环境变量设置
在git-bash下，也是可以加载.bash_profile文件的。所以可以按如下设定。  
这里的 [.bash_profile](.bash_profile) 例子文件，请参照使用。

查看.bash_profile是否存在
```bash
ls ~/.bash_profile
```

如果不存在就新建一个
```bash
touch ~/.bash_profile
ls ~/.bash_profile
```

用nano编辑文件
```bash
nano -l ~/.bash_profile
```

在nano编辑器复制粘贴如下内容（path按自己的路径修改下）
Ctrl+o(不是数字是字母) 并且按回车保存文件  
Ctrl+x 退出  

确认添加内容
```bash
cat ~/.bash_profile
```
退出git-bash并重新打开  
确认环境变量和设定是否成功
```bash
echo $PATH
java -version
which java
```
**如果遇到python有问题，可能是C:\Users\xxx\AppData\Local\Microsoft\WindowsApps下有python.exe。可尝试如下解决**
* 1.以管理员身份运行 打开命令提示符cmd
* 2.使用 del 命令进行删除
```cmd
cd C:\Users\xxx\AppData\Local\Microsoft\WindowsApps
del python.exe
del python3.exe
```

补充：
如果要删除的文件属性勾选了“只读”，执行del 删除命令会提示“拒绝访问”，导致删除失败，我们可以取消勾选“只读”属性，即可删除成功。

## 在git-bash快速打开资源浏览器
在windows下是有start命令的。输入以下命令即可在当前路径下打开资源浏览器。
```bash
start .
```

## 在git-bash下运行python等交互式命令
安装 Git Bash 的时候有提示，MinTTY 不支持交互操作，如 Python 和 Node , 用 winpty + 命令 就可以运行了。
```bash
winpty python
```
如果你实在不想每次都敲那么多东西，可以用alias键映射：
```bash
alias python='winpty python'
```

## 快捷键打开Git Bash
在桌面添加一个 Git Bash 的快捷方式 → 右键 → 属性 → 快捷键  
设置即可，比如 Ctrl + Alt + G

## Git Bash的颜色设置
修改Git Bash配置文件
进入用户主目录
```bash
cd ~
```
修改Git Bash配置文件
```bash
vim .minttyrc
```
.minttyrc 就是 git bash 默认终端 mintty 的配置文件。

#### 笔者的2个设定文件
* [minttyrc-dark](minttyrc-dark) ： 暗色系
* [minttyrc-light](minttyrc-light) ： 亮色系

选择1个粘贴到 \~/.minttyrc 即可，或者用指定设定文件的方式启动

#### 定制颜色方案
* [定制终端颜色](http://ciembor.github.io/4bit/)
* [256色颜色码](http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html)
* [rgb转hex](https://www.w3schools.com/colors/colors_converter.asp)

## 使用git-bash作为自己的终端
git-bash下是默认自带ssh的。所以只要使用下面的命令就可以直接ssh到服务器
```bash
ssh -t user@1.2.3.4 -p 22 '/bin/bash --rcfile /lch/workspace/bashrc/.bashrc-personal'
```
 --rcfile参数为不使用默认bashrc，使用指定的文件

## 使用git-bash内置的mintty制作快捷方式
制作如下快捷方式就可以直接ssh到服务器
```bash
D:\Tools\WorkTool\Team\Git\usr\bin\mintty.exe /usr/bin/ssh -t user@1.2.3.4 -p 22 '/bin/bash --rcfile /lch/workspace/bashrc/.bashrc-personal'
```

## git-bash指定minttyrc文件启动

在~下配置2个设定文件，1个为暗色，1个为亮色
* [minttyrc-dark](minttyrc-dark) ： 暗色系
* [minttyrc-light](minttyrc-light) ： 亮色系

新建 [git-bash-light.cmd](git-bash-light.cmd) 批处理
内容如下
```
set MSYSTEM=MINGW64
D:\Tools\WorkTool\Team\Git\usr\bin\mintty.exe ^
  -o AppID=GitForWindows.Bash ^
  -o RelaunchCommand="..\..\git-bash.exe" ^
  -o RelaunchDisplayName="Git Bash" ^
  -i /mingw64/share/git/git-for-windows.ico ^
  --loadconfig "%USERPROFILE%\minttyrc-light" ^
  --dir "%USERPROFILE%" ^
  /bin/bash --login -i

REM 下面是另一种用法
REM D:\Tool\Git\usr\bin\mintty.exe --loadconfig "%USERPROFILE%\minttyrc-light" --dir "%USERPROFILE%" --exec "/bin/bash" --login -i
```
