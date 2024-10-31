# Git命令

## 前言
**如果你是Git初学者的话，强烈建议去下面网站把关卡全部完成。**  
https://learngitbranching.js.org/?locale=zh_CN

## 基础设置

### 必选设定

```bash
# 用户名和邮箱
git config --global user.name "yourname"
git config --global user.email "your@email.com"
# 编码UTF-8
git config --global gui.encoding utf-8
# 打开终端颜色
git config --global color.ui true
# 取消换行符自动转换
git config --global core.autoCRLF false
# 取消忽略大小写
git config --global core.ignorecase false
```

### 任选设置

```bash
# 开启稀疏检出
git config --global core.sparseCheckout true
# 取消git中的sslverify
git config --system http.sslverify false
# 取消HTTP代理
git config --global --unset http.proxy
# 取消HTTPS代理
git config --global --unset https.proxy
```

```bash
# 设置合并策略（执行git pull不带参数时的默认策略）
## 合并（缺省策略）
git config --global pull.rebase false
## 变基：执行 git pull 等于执行 git pull --rebase
git config --global pull.rebase true
## 仅快进合并
git config --global pull.ff only
```

### 设置使用 Git 凭证管理器 （GCM） 管理账号密码

``Git Credential Manage`` 的 [官方文档](https://git-scm.com/doc/credential-helpers) 和 [GitHub](https://github.com/git-ecosystem/git-credential-manager)

Git 凭证管理器 （GCM） 是一个基于 .NET 构建的安全 Git 凭证帮助程序，可在 Windows、macOS 和 Linux 上运行。它旨在为每个主要的源代码控制托管服务和平台提供一致且安全的身份验证体验，包括多重身份验证。

#### Windows平台

已经包含在 ``Git for Windows`` 中  
目录为 ``Git\mingw64\bin\git-credential-manager.exe``

```bash
# 确认gcm版本
git credential-manager --version
# 启用gcm
git config --global credential.helper manager
# 配置存储方式为使用[Windows 凭据管理器]
git config --global credential.credentialStore wincredman
```

如果想删除凭证的话，如下操作  
打开 ``设置`` → 搜索 ``Windows 凭据`` → 选择 ``管理 Windows 凭据`` → 在普通凭据下面会看到，删除即可

#### Linux平台

**Debian12 /Ubuntu22.04** 使用 ``gcm``
```bash
# 先安装git
# sudo apt update
# sudo apt install git

# 安装gcm依赖库：libicu
sudo apt install libicu72
# for Ubuntu22.04
# sudo apt install libicu70

# 下载安装gcm
export GITHUB_URL=https://bgithub.xyz
# export GITHUB_URL=https://github.com
curl -Lo gcm-linux_amd64.2.6.0.deb "${GITHUB_URL}/git-ecosystem/git-credential-manager/releases/download/v2.6.0/gcm-linux_amd64.2.6.0.deb"
dpkg -i gcm-linux_amd64.2.6.0.deb
rm gcm-linux_amd64.2.6.0.deb

# 确认gcm版本
git credential-manager --version
# 启用gcm
git config --global credential.helper manager
# 配置存储方式为使用[纯文本文件 ~/.gcm/store]
# 不推荐，安全的做法为使用GPG/pass
# https://github.com/git-ecosystem/git-credential-manager/blob/release/docs/credstores.md
git config --global credential.credentialStore plaintext
```

**Debian12 /Ubuntu22.04** 使用内置 ``store``
```bash
# 先安装git
# sudo apt update
# sudo apt install git

# 配置存储方式为使用[纯文本文件 ~/.git-credentials]
# 不推荐，安全的做法为使用gcm
git config --global credential.helper store
```

**alpine** 使用内置 ``store``
```bash
# 先安装git
apk update --quiet
apk add --no-cache --upgrade git

# 配置存储方式为使用[纯文本文件 ~/.git-credentials]
# 不推荐，安全的做法为使用gcm
git config --global credential.helper store
```

## 代码管理命令

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

### 打开默认 GUI 画面

笔者个人习惯在 ``GUI`` 里面进行 ``add/commit/push/pull`` 操作

```bash
git gui
```

#### GUI设定-添加内容1

``Tools`` → ``Add...`` →
 - Name：``执行 pull``
 - Command：``git pull``
 - 选中 ``Add globally`` Checkbox

#### GUI设定-添加内容2

``Tools`` → ``Add...`` →
 - Name：``执行 pull rebase``
 - Command：``git pull --rebase``
 - 选中 ``Add globally`` Checkbox

#### 查看log
``Repository`` → ``Visualize xxx's History``

### 关于git pull

#### ``git pull``
就是 fetch + merge 操作（适用于本地代码没有commit，单纯更新仓库，如果本地代码有commit，那么merge会产生一个叫做merge的commit）

#### ``git pull --rebase``
就是 fetch + rebase 操作（适用于本地代码有commit，更新仓库并且合并过来，rebase不会产生commit）
**※** ``rebase`` 使你的 ``提交树变得很干净``, 所有的提交都在一条线上，笔者个人更喜欢rebase

### 查看状态
```bash
git status
```

### 取消本地修改从仓库重新取文件
比如本地的 ``a.java`` 想从仓库重新取。先把 ``a.java`` 重命名为 ``a.java_bak``，然后运行以下代码  
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
由于 ``git checkout`` 这个命令还可以用于切换分支，容易引起混淆。
Git 最新版本中将 ``git checkout`` 命令的两项功能分别赋予两个新的命令，一个是 ``git restore``，另一个是 ``git switch``

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

## 查看配置文件

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

## 凭证存储模式

### Git凭据管理的三种方式

Git的凭据存储有 ``cache``、``store``、``manager`` 三种方式  
详细介绍可以看官方文档

### 查询当前凭证存储模式

```bash
git config credential.helper
```

global 、local 如果不设置，默认是没有的

### 修改指定级别的凭据管理方式
```bash
git config --system credential.helper manager
```

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
