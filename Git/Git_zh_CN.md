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

# 更多
* [GIT CHEATSHEET (中文速查表)](https://github.com/skywind3000/awesome-cheatsheets/blob/master/tools/git.txt)
* [团队项目开发的问题和解决方案](https://github.com/jackfrued/Python-100-Days/blob/master/Day91-100/91.%E5%9B%A2%E9%98%9F%E9%A1%B9%E7%9B%AE%E5%BC%80%E5%8F%91%E7%9A%84%E9%97%AE%E9%A2%98%E5%92%8C%E8%A7%A3%E5%86%B3%E6%96%B9%E6%A1%88.md)

