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
笔者个人习惯为，比如本地的a.java想从仓库重新取。先把a.java重命名为a.java_bak，然后运行以下代码
```git
git status
git checkout /src/a.java
```

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

### 13.快速路径
git-bash.exe可以建立快捷方式，然后右键→属性→起始位置：粘贴一个路径后。用这个快捷方式启动git-bash就默认在这个路径下。


### 14.git-bash.exe的环境变量设置
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
```bash
MINGW_HOME=/d/Tools/WorkTool/C/codeblocks-20.03mingw-nosetup/MinGW/bin
JAVA_HOME=/d/Tools/WorkTool/Java/jdk17.0.6/bin
PYTHON_HOME=/d/Tools/WorkTool/Python/Python38-32
VSCODE_HOME=/d/Tools/WorkTool/Text/VSCode-win32-x64-1.77.1
CMAKE_HOME=/d/Tools/WorkTool/C/cmake-3.26.1-windows-x86_64/bin
NINJA_HOME=/d/Tools/WorkTool/C/ninja-win
PATH=$PATH:$MINGW_HOME:$JAVA_HOME:$PYTHON_HOME:$VSCODE_HOME:$CMAKE_HOME:$NINJA_HOME
export PATH
```
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
