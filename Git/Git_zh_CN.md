# Git

## 前言
**如果你是Git初学者的话，强烈建议去下面网站把关卡全部完成。**  
https://learngitbranching.js.org/?locale=zh_CN

## 一.基础设置

### 1.设定用户名和邮箱
```git
git config --global user.name "yourname"
git config --global user.email "your@email.com"
```

### 2.设定用编码UTF-8
```git
git config --global gui.encoding utf-8
```

### 3.打开所有终端颜色
```git
git config --global color.ui true
```

### 4.设置取消git中的sslverify
```git
git config --system http.sslverify false
```

### 5.设置取消HTTP代理
```git
git config --global --unset http.proxy
git config --global --unset https.proxy
```

### 设置取消换行符自动转换
```git
git config --global core.autoCRLF false
```

## 二.代码管理命令

### 6.Clone仓库  
```git
git clone -b [分支名] [URL] [本地路径]
git clone -b master https://github.com/foo/bar.git /D/WorkSpace/bar
```
另外，如果你只是想clone最新版本来使用或学习，而不是参与整个项目的开发工作的话，可以用 depth 参数。
```git
git clone --depth=1 -b [分支名] [URL] [本地路径]
```
用 git clone --depth=1 的好处是限制 clone 的深度，不会下载 Git 协作的历史记录，这样可以大大加快克隆的速度，只取得最近一次commit的一个分支，这样这个项目文件就不会很大

### 7.打开默认GUI画面  
笔者个人习惯在GUI里面进行add/commit/push/pull操作  
```git
git gui
```
* 在GUI中执行pull操作需要自己添加一下：  
Tools → Add... →  
添加内容1：
```
Name：执行 pull
Command：git pull
选中[Add globally]Checkbox
```
添加内容2：
```
Name：执行 pull rebase
Command：git pull --rebase
选中[Add globally]Checkbox
```
* 查看log  
Repository→Visualize xxx's History

#### 关于git pull
**git pull**  
&nbsp;&nbsp;&nbsp;&nbsp;就是 fetch + merge 操作（适用于本地代码没有commit，单纯更新仓库，如果本地代码有commit，那么merge会产生一个叫做merge的commit）  
**git pull --rebase**  
&nbsp;&nbsp;&nbsp;&nbsp;就是 fetch + rebase 操作（适用于本地代码有commit，更新仓库并且合并过来，rebase不会产生commit）  
**※**&nbsp;rebase使你的**提交树变得很干净**, 所有的提交都在一条线上，笔者个人更喜欢rebase

### 8.查看状态  
```git
git status
```

### 9.取消本地修改从仓库重新取文件  
笔者个人习惯为，比如本地的a.java想从仓库重新取。先把a.java重命名为a.java_bak，然后运行以下代码。  
旧版本:
```git
git status
git checkout /src/a.java
```
新版本:
```git
git status
git restore /src/a.java
或者
git restore .
```
由于git checkout这个命令还可以用于切换分支，容易引起混淆。
Git最新版本中将git checkout命令的两项功能分别赋予两个新的命令，一个是git restore，另一个是git switch。

## 三.查看配置文件  

Git中有三层config文件：系统、全局、本地

### 10.查看系统配置
```git
git config --system --list
```

### 11.查看全局配置
```git
git config --global --list
```

### 12.查看本地配置
```git
git config --local --list
```

## 四.其他

### 快速路径
git-bash.exe可以建立快捷方式，然后右键→属性→起始位置：粘贴一个路径后。用这个快捷方式启动git-bash就默认在这个路径下。


### git-bash.exe的环境变量设置
在git-bash下，也是可以加载.bash_profile文件的。所以可以按如下设定。  
在此md文件同路径下有例子文件，请参照使用。

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
* [.bash_profile](.bash_profile)

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
安装 Git Bash 的时候有提示，MinTTY 不支持交互操作，如 Python 和 Node , 用winpty + 命令就可以运行了。
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
.minttyrc 就是 git bash 的配置文件。

#### 笔者的2个设定文件
* [minttyrc-dark](minttyrc-dark) ： 暗色系
* [minttyrc-light](minttyrc-light) - 亮色系

选择1个粘贴到 \~/.minttyrc 即可

#### 定制颜色方案
* [定制终端颜色](http://ciembor.github.io/4bit/)
* [256色颜色码](http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html)
* [rgb转hex](https://www.w3schools.com/colors/colors_converter.asp)

# 更多
* [GIT CHEATSHEET (中文速查表)](https://github.com/skywind3000/awesome-cheatsheets/blob/master/tools/git.txt)
* [团队项目开发的问题和解决方案](https://github.com/jackfrued/Python-100-Days/blob/master/Day91-100/91.%E5%9B%A2%E9%98%9F%E9%A1%B9%E7%9B%AE%E5%BC%80%E5%8F%91%E7%9A%84%E9%97%AE%E9%A2%98%E5%92%8C%E8%A7%A3%E5%86%B3%E6%96%B9%E6%A1%88.md)

