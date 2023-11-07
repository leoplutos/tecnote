# Git命令

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

### 设置合并策略（执行git pull不带参数时的默认策略）
以下3选1即可，推荐缺省策略
```
# 合并（缺省策略）
git config --global pull.rebase false
# 变基：执行 git pull 等于执行 git pull --rebase
git config --global pull.rebase true
# 仅快进合并
git config --global pull.ff only
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

## 四.凭证存储模式
使用Git 向远程仓库（例如：GitHub，gitee）提交代码 ，需要输入账号和密码。可能会遇到这样的情况密码输错一次，想修改，但是不知道去哪里修改。一直报错fatal: Authentication failed for 又不弹出用户名和密码输入框 。
你需要了解Git是如何保存账号密码的，也就是凭据管理。
### Git凭据管理的三种方式
Git的凭据存储有cache、store、manager三种方式  
Git 中有三种级别system 、global 、local ，可以针对不同的级别设置不同的凭据存储方式
### 查询当前凭证存储模式
```git
git config credential.helper
```
global 、local 如果不设置，默认是没有的
### 修改指定级别的凭据管理方式
```git
git config --system credential.helper manager
```

### 凭据管理模式
相信你现在有几个疑问，我平时输入账号密码，用的是哪种？账号密码保存在哪里？如何进行修改？下面一一介绍
#### 1.manager
若安装Git时安装了GitGUI，自动会在system级别中设置credential.helper为manager。

git-credential-manager.exe和 git-credential-wincred.exe 都是将凭据存储在系统的凭据管理器中，只不过前者是有图形界面，后者没有图形界面，需要在命令行中输入密码

**凭据保存的位置**  
在控制面板 → 用户账户 → 凭据管理器，可以看到对应的git账号凭据管理，可以修改或者删除。
删除后，再次pull或者push，会重新输入密码
#### 2.store
如果你在输入账号密码的时候，关闭了manager 方式的输入框，就会要求你在命令行中输入账号
#### 3.cache
将凭证存放在内存中一段时间。 密码永远不会被存储在磁盘中，并且默认在15分钟后从内存中清除。

# 其他

### .gitignore文件不生效问题
原因是因为在git忽略目录中，新建的文件在git中会有缓存，如果某些文件已经被纳入了版本管理中，就算是在.gitignore中已经声明了忽略路径也是不起作用的，
这时候我们就应该先把本地缓存删除，然后再进行git的提交，这样就不会出现忽略的文件了。

处理方式如下：
```
# 清除缓存文件
git rm -r --cached .
git add .
git commit -m ".gitignore重写缓存成功"
git push
```

# 更多
* [GIT CHEATSHEET (中文速查表)](https://github.com/skywind3000/awesome-cheatsheets/blob/master/tools/git.txt)
* [团队项目开发的问题和解决方案](https://github.com/jackfrued/Python-100-Days/blob/master/Day91-100/91.%E5%9B%A2%E9%98%9F%E9%A1%B9%E7%9B%AE%E5%BC%80%E5%8F%91%E7%9A%84%E9%97%AE%E9%A2%98%E5%92%8C%E8%A7%A3%E5%86%B3%E6%96%B9%E6%A1%88.md)
