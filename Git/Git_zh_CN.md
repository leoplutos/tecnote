# Git命令

## 前言
**如果你是Git初学者的话，强烈建议去下面网站把关卡全部完成。**  
https://learngitbranching.js.org/?locale=zh_CN

## 一.基础设置

#### 设定用户名和邮箱
```bash
git config --global user.name "yourname"
git config --global user.email "your@email.com"
```

#### 设定用编码UTF-8
```bash
git config --global gui.encoding utf-8
```

#### 打开所有终端颜色
```bash
git config --global color.ui true
```

#### 设置取消git中的sslverify（任意）
```bash
git config --system http.sslverify false
```

#### 设置取消HTTP代理（任意）
```bash
git config --global --unset http.proxy
git config --global --unset https.proxy
```

#### 设置取消换行符自动转换
```bash
git config --global core.autoCRLF false
```

#### 设置开启稀疏检出
```bash
git config --global core.sparseCheckout true
```

#### 设置使用Windows 凭证管理器（Windows Credential Manager）管理账号密码
```bash
git config --global credential.helper manager
git config --global credential.credentialStore wincredman
```

如果想删除凭证的话，如下操作  
打开 ``设置`` → 搜索 ``Windows 凭据`` → 选择 ``管理 Windows 凭据`` → 在普通凭据下面会看到，删除即可

### 设置合并策略（执行git pull不带参数时的默认策略）
以下3选1即可，推荐缺省策略
```bash
# 合并（缺省策略）
git config --global pull.rebase false
# 变基：执行 git pull 等于执行 git pull --rebase
git config --global pull.rebase true
# 仅快进合并
git config --global pull.ff only
```

## 二.代码管理命令

### Clone仓库
```bash
git clone -b [分支名] [URL] [本地路径]
git clone -b master https://github.com/foo/bar.git /D/WorkSpace/bar
```
另外，如果你只是想clone最新版本来使用或学习，而不是参与整个项目的开发工作的话，可以用 depth 参数。
```bash
git clone --depth=1 -b [分支名] [URL] [本地路径]
```
用 git clone --depth=1 的好处是限制 clone 的深度，不会下载 Git 协作的历史记录，这样可以大大加快克隆的速度，只取得最近一次commit的一个分支，这样这个项目文件就不会很大

### 部分克隆（Partial clone）

首先需要开启稀疏检出（需要 ``Git 2.25 以上``）
```bash
git config --global core.sparseCheckout true
```

首先只下载索引文件
```bash
git clone \
  -b master \
  --depth 1 \
  --filter=blob:none \
  --no-checkout \
  --sparse \
  https://bgithub.xyz/leoplutos/tecnote.git \

```
- ``filter=blob:none`` : Blobless克隆，将大文件的 blob 移除
- ``--depth`` : 深度1
- ``--no-checkout`` : 不进行检出（checkout）操作
- ``--sparse`` : 开启稀疏检出

然后，只 checkout 子文件甲
```bash
cd tecnote
# 锥形检出（cone checkout）模式
# git sparse-checkout init --cone
# 设定检出子目录
git sparse-checkout set --no-cone "DevTool/Neovim_lazy-conf" "DevTool/Vim-conf"
# 拉取到本地
git checkout
```

### 打开默认GUI画面
笔者个人习惯在GUI里面进行add/commit/push/pull操作  
```bash
git gui
```
- 在GUI中执行pull操作需要自己添加一下：  
Tools → Add... →  
添加内容1：
```bash
Name：执行 pull
Command：git pull
选中[Add globally]Checkbox
```
添加内容2：
```bash
Name：执行 pull rebase
Command：git pull --rebase
选中[Add globally]Checkbox
```
- 查看log  
``Repository`` → ``Visualize xxx's History``

#### 关于git pull
**git pull**  
&nbsp;&nbsp;&nbsp;&nbsp;就是 fetch + merge 操作（适用于本地代码没有commit，单纯更新仓库，如果本地代码有commit，那么merge会产生一个叫做merge的commit）  
**git pull --rebase**  
&nbsp;&nbsp;&nbsp;&nbsp;就是 fetch + rebase 操作（适用于本地代码有commit，更新仓库并且合并过来，rebase不会产生commit）  
**※**&nbsp;rebase使你的**提交树变得很干净**, 所有的提交都在一条线上，笔者个人更喜欢rebase

### 查看状态  
```bash
git status
```

### 取消本地修改从仓库重新取文件  
笔者个人习惯为，比如本地的a.java想从仓库重新取。先把a.java重命名为a.java_bak，然后运行以下代码。  
旧版本:
```bash
git status
git checkout /src/a.java
```
新版本:
```bash
git status
git restore /src/a.java
# 或者
git restore .
```
由于git checkout这个命令还可以用于切换分支，容易引起混淆。
Git最新版本中将git checkout命令的两项功能分别赋予两个新的命令，一个是git restore，另一个是git switch。

### 发布版本(git tag)
通常在软件发布的时候会打一个tag，用于标注这次发布的相关信息, 这样做的好处是，将来如果这个版本出现了问题，可以通过tag迅速定位到当前版本，进行错误修复。

#### 在当前commit上新建tag
```bash
git tag -a v0.0.7 -m "publish v0.0.7 version"
```

#### 列出已有的tag
```bash
git tag
```

#### 同步tag到远程服务器
```bash
git push origin v0.0.7
```
和提交代码一样，tag默认创建是在本地的，需要进行推送才能到达远程服务器，如果要推送本地所有tag,可以使用
```bash
git push origin --tags
```

#### 为历史版本添加tag
```bash
git tag v0.0.3 03f98856b1a422b5604fc1337500b756513e785c
```

#### 删除tag
```bash
git tag -d v1.6
git push origin :refs/tags/v1.6
```

#### 利用tag功能切换并修改某个历史版本
以修改v1.3版本举例  
新建分支 feature-bugfix-v1.3  
语法为 ``git checkout -b [branchName] [tagName]``
```bash
git checkout -b feature-bugfix-v1.3 v1.3
```
修改问题并且commit，然后切回 master分支 并 合并bugfix 分支
```bash
git switch master
git merge feature-bugfix-v1.3
```
修改之后推送 master 即可

## 三.查看配置文件  

Git中有三层config文件：``系统``、``全局``、``本地``

### system系统级
```bash
git config --system --list
```
系统级配置文件含有系统里每位用户及他们所拥有的仓库的配置值。其位置为git的安装目录下的 ``/etc/gitconfig``，即如果git的安装目录为 ``D:\Git``，则配置文件地址为 ``D:\Git\etc\gitconfig``  
**优先度最低**，其配置值可被全局级配置和本地级配置的值覆盖。一般我们很少会使用系统级的配置

### global全局级
```bash
git config --global --list
```
全局级配置文件包含当前系统用户的拥有的仓库配置值，每个系统用户的全局级配置相互隔离。全局级别的配置默认保存在当前系统用户的主目录下的 ``.gitconfig`` 文件内。Windows通常保存在 ``%USERPROFILE%\.gitconfig`` ，Linux为 ``~/.gitconfig``

**优先度比系统级高，可覆盖系统级的配置值**。全局级的配置平时使用得比较多

### local本地级
```bash
git config --local --list
```
虽然名字叫做本地级，但是笔者认为应该叫 ``工程级`` 比较好理解。  
本地级别的配置保存在当前仓库下面的 ``.git\config`` 文件内，通常 ``.git`` 文件夹是隐藏的，Window要在文件管理器的文件夹选项中打开显示隐藏文件夹才可以看到。这里的配置仅对当前仓库有效，不影响其他的仓库。

**优先级别最高**，如果全局级别或系统级别的配置里出现了同一配置项，则以本地级别配置内容为准

## 四.凭证存储模式
使用Git 向远程仓库（例如：GitHub，gitee）提交代码 ，需要输入账号和密码。可能会遇到这样的情况密码输错一次，想修改，但是不知道去哪里修改。一直报错fatal: Authentication failed for 又不弹出用户名和密码输入框 。
你需要了解Git是如何保存账号密码的，也就是凭据管理。

**如果你习惯了以前``Windows凭据``的管理方式直接选择 ``wincred`` 即可**

### Git凭据管理的三种方式
Git的凭据存储有cache、store、manager三种方式  
Git 中有三种级别system 、global 、local ，可以针对不同的级别设置不同的凭据存储方式
### 查询当前凭证存储模式
```bash
git config credential.helper
```
global 、local 如果不设置，默认是没有的
### 修改指定级别的凭据管理方式
```bash
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

## gitignore
可以看这个示例文件 [.gitignore](.gitignore_sample)

# 其他

### .gitignore文件不生效问题
原因是因为在git忽略目录中，新建的文件在git中会有缓存，如果某些文件已经被纳入了版本管理中，就算是在.gitignore中已经声明了忽略路径也是不起作用的，
这时候我们就应该先把本地缓存删除，然后再进行git的提交，这样就不会出现忽略的文件了。

处理方式如下：
```bash
# 清除缓存文件
git rm -r --cached .
git add .
git commit -m ".gitignore重写缓存成功"
git push
```

# 更多
* [GIT CHEATSHEET (中文速查表)](https://github.com/skywind3000/awesome-cheatsheets/blob/master/tools/git.txt)
* [团队项目开发的问题和解决方案](https://github.com/jackfrued/Python-100-Days/blob/master/Day91-100/91.%E5%9B%A2%E9%98%9F%E9%A1%B9%E7%9B%AE%E5%BC%80%E5%8F%91%E7%9A%84%E9%97%AE%E9%A2%98%E5%92%8C%E8%A7%A3%E5%86%B3%E6%96%B9%E6%A1%88.md)
