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
# 将 Git 新建仓库时的默认分支名设置为 main
git config --global init.defaultBranch main
# git pull 时自动 stash 未提交修改
git config --global pull.autostash true
# git pull 默认使用 merge，而不是 rebase
git config --global pull.rebase false
# git rebase 时自动 stash 未提交修改
git config --global rebase.autoStash true
# Git 在输出文件名时，不要把非 ASCII 字符（尤其是中文、日文等）转义成 \xxx，而是直接显示原字符。
git config --global core.quotePath false
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

### 设置使用 Git 凭证管理器（GCM）管理账号密码

`Git Credential Manager`（GCM）的 [Git 官方文档](https://git-scm.com/doc/credential-helpers) 和 [GitHub](https://github.com/git-ecosystem/git-credential-manager)

Git Credential Manager（GCM）是一个基于 .NET 构建的跨平台 Git 凭证帮助程序，可在 Windows、macOS 和 Linux 上运行。它用于为 GitHub、GitLab、Azure DevOps、Bitbucket 等代码托管服务提供一致且安全的身份验证体验，并支持多重身份验证（MFA）。

#### Windows 平台

GCM 已经包含在 `Git for Windows` 中，通常无需单独安装。  
默认目录通常为：

```text
C:\Program Files\Git\mingw64\bin\git-credential-manager.exe
```

```bash
# 确认 GCM 版本
git credential-manager --version

# Git for Windows 通常已经自动配置好 GCM。
# 如需显式指定，可以执行：
git config --global credential.helper manager

# 显式指定使用 Windows 凭据管理器保存凭证（通常无需手动设置）
git config --global credential.credentialStore wincredman
```

如果想删除已经保存的凭证：  
打开 `设置` → 搜索 `Windows 凭据`（日文系统为 `Windows 資格情報`） → 选择 `管理 Windows 凭据` → 在普通凭据中找到对应的 Git/GitHub/GitLab 凭证并删除。

#### WSL 平台（推荐使用 Windows 中的 GCM）

如果是在 Windows + WSL 环境中使用 Git，推荐直接让 WSL 中的 Git 调用 `Git for Windows` 自带的 GCM。这样凭证会保存在 Windows Credential Manager 中，也可以在 Windows Git 与多个 WSL 发行版之间共享凭证。

```bash
# 确认 WSL 中使用的是 Linux Git
which git
# 正常一般应为：/usr/bin/git

# 配置 WSL 中的 Git 使用 Windows 的 GCM
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager.exe"

# 确认当前 credential helper 及其来源
git config --show-origin --get-all credential.helper
```

这种方式下，不需要在 WSL 中另外设置：

```bash
git config --global credential.credentialStore wincredman
```

因为实际运行的是 Windows 版 GCM，它会使用 Windows 的凭据存储机制。

#### macOS

推荐使用 Homebrew 安装：

```bash
brew install --cask git-credential-manager

# 确认 GCM 版本
git credential-manager --version

# 配置 GCM（安装程序通常会自动完成）
git-credential-manager configure
```

#### Linux 平台

Linux 上可以使用 GCM，但需要自行选择凭证存储方式。优先使用系统安全存储，例如 `secretservice` 或 `gpg`，不推荐长期使用明文存储。

##### 推荐方式：使用 .NET Tool 安装

先安装当前 GCM 官方文档要求的 .NET SDK，然后执行：

```bash
# 安装 GCM
dotnet tool install -g git-credential-manager

# 配置 Git 使用 GCM
git-credential-manager configure

# 确认 GCM 版本
git credential-manager --version
```

##### Debian / Ubuntu：使用 .deb 包安装

也可以从 GCM 的 GitHub Releases 下载对应架构的 `.deb` 包。由于 GCM 会持续更新，不建议在文档中长期固定某个旧版本号。

```bash
# 示例：下载当前所需版本后安装
sudo dpkg -i ./gcm-linux-x64-<VERSION>.deb

# 配置 Git 使用 GCM
git-credential-manager configure

# 确认 GCM 版本
git credential-manager --version
```

如果安装时提示缺少依赖，请根据当前 Linux 发行版和当前 .NET/GCM 版本安装对应依赖，不建议固定写死 `libicu70`、`libicu72` 等包名。

##### Linux 凭证存储方式

带桌面环境的 Linux 推荐使用 Secret Service：

```bash
git config --global credential.credentialStore secretservice
```

无 GUI 的服务器环境可以考虑使用 GPG/pass：

```bash
git config --global credential.credentialStore gpg
```

也可以使用 `plaintext`，但凭证会以明文保存到 `~/.gcm/store`，安全性较低，不推荐：

```bash
# 不推荐：以明文方式保存凭证
git config --global credential.credentialStore plaintext
```

GCM 在 Linux 上可用的常见 credential store 包括：

- `secretservice`：Linux Secret Service / libsecret
- `gpg`：GPG + pass
- `cache`：Git credential cache
- `plaintext`：明文文件，不安全
- `none`：不由 GCM 持久化保存凭证

相关说明可参考：  
<https://github.com/git-ecosystem/git-credential-manager/blob/release/docs/credstores.md>

#### Linux 平台使用 Git 内置 `store`

如果不使用 GCM，也可以使用 Git 自带的 `store`：

```bash
# 先安装 Git
# sudo apt update
# sudo apt install git

# 凭证会以纯文本形式保存到 ~/.git-credentials
# 不推荐在安全要求较高的环境中使用
git config --global credential.helper store
```

#### Alpine Linux 使用 Git 内置 `store`

```bash
# 安装 Git
apk update --quiet
apk add --no-cache --upgrade git

# 凭证会以纯文本形式保存到 ~/.git-credentials
# 不推荐在安全要求较高的环境中使用
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
  https://github.com/leoplutos/tecnote.git \

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

### 创建分支
```bash
# 创建 develop 分支（在没有 develop 分支的情况下）
git switch -c develop
# git checkout -b develop

# 推送本地 develop 分支到远程，因为远程还没有 develop 分支，所以需要使用 -u 参数建立追踪关系
git push -u origin develop
```

使用 VSCode 操作

1. 创建 develop 分支（在没有 develop 分支的情况下）  
点击下面 ``状态栏`` 上面的 ``master`` → ``创建新分支`` → ``develop``

2. ``源代码管理`` → 点击右上角的 ``三点菜单`` → 选择 ``推送 (Push)`` → 如果当前 develop 分支在远程没有，它会提示 ``分支 develop 没有远程分支。是否要发布此分支？`` → ``确定``

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
```bash
git status
git restore /src/a.java
# git checkout /src/a.java
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
语法为 ``git switch -c <新分支名> <起点>``
```bash
git switch -c feature-bugfix-v1.3 v1.3
# git checkout -b feature-bugfix-v1.3 v1.3
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

# 最佳实践

## 团队开发时的一般做法

### 分支管理

- master 分支对应 ``生产环境``
- develop 分支对应 ``开发环境``（即开发中的内容）
- feature 分支对应 ``添加特定功能``
- bugfix 分支对应 ``常规问题修复``（修复开发过程中发现的非紧急Bug）
- hotfix 分支对应 ``紧急修复``（紧急Bug，生产环境出问题必须立刻修复并上线）

### 命令行操作流程（以 feature 分支举例）
```bash
# 切换到 develop 分支
git switch develop
# git checkout develop

# 拉取最新代码
git pull

# 保证 develop 分支是最新的情况下，切出 feature 分支
git switch -c feature/it_001
# git checkout -b feature/it_001

# 修改代码后提交
git add .
git commit -m "添加功能it_001"

# 推送本地 feature 分支到远程，因为远程还没有 feature 分支，所以需要使用 -u 参数建立追踪关系
git push -u origin feature/it_001
```

### VSCode 操作流程（以 feature 分支举例）

1. 切换到 develop 分支  
点击下面 ``状态栏`` 上面的 ``master`` → 选择 ``develop``

2. 拉取最新代码  
``源代码管理`` → 点击右上角的 ``三点菜单`` → 选择 ``拉取``

3. 保证 develop 分支是最新的情况下，切出 feature 分支  
点击下面 ``状态栏`` 上面的 ``develop`` → ``创建新分支`` → ``feature/it_001``

4. 修改代码后提交

5. 推送本地 feature 分支到远程  
``源代码管理`` → 点击右上角的 ``三点菜单`` → 选择 ``推送 (Push)`` → 如果当前 feature 分支在远程没有，它会提示 ``分支 feature 没有远程分支。是否要发布此分支？`` → ``确定``

### Pull Request（PR）

然后创建 ``Pull requests（合并请求）``，下面以 GitHub 举例

#### 1.在 GitHub 上创建 Pull Request（PR）

创建 PR 时确认以下内容：

- base：``develop``
- compare：``feature/it_001``

填写 ``标题`` 和 ``内容``，如果需要还可以指定 `Reviewer` → ``创建合并请求`` 按钮

这时会在仓库的 ``Pull requests`` 标签 下看到已经有了一个请求

#### 2. Reviewer 对 PR 进行代码审查。

##### 无问题时
确认代码没有问题后，在 PR 中进行 `Approve`

##### 有问题时
如果 Reviewer 提出修改意见：

根据 Review Comment 修改代码
Commit 修改
Push 到原来的工作分支
```bash
git add .
git commit -m "fix: xxxxxx"
git push
```
Push 后，原 PR 会自动更新，无需重新创建 PR。

#### 3.合并 PR

Review 通过后，由有合并权限的人员执行 `Merge Pull Request`

确认以下内容后进行合并：

- Code Review 已完成
- Reviewer 已 Approve
- CI / 自动检查通过（如有）
- Bug 票对应的修改内容已完成
- Target Branch 确认是 develop

确认无误后，将 PR 合并到：`develop`


## 将已有目录关联到 GitHub 仓库并 Push

将本地已有项目目录关联到一个已有的 GitHub 仓库，并将代码 Push 到 `main` 分支。

```bash
# 进入项目目录
cd C:\path\to\project

# 检查是否已经是 Git 仓库
git status
# 如果报错则说明当前目录还没有初始化 Git

# 初始化 Git
git init

# 关联 GitHub 仓库
git remote add origin https://github.com/user/project.git

git add .
git commit -m "Initial commit"
# 将当前分支设置为 main
git branch -M main
# Push 到 GitHub
git push -u origin main
```

## Feature分支同步Develop
你有一个自己开发用的分支 feature/mock-frontend-demo  
每次都在这个分支上开发自己的内容然后提PR到develop的流程为  
先保存当前未提交的修改 → 用最新 develop 重置你的 feature 分支 → 强制同步远程 feature 分支 → 再恢复你自己的修改。

```bash
# 检查当前是否在 feature/mock-frontend-demo 分支，不是则停止
git branch --show-current

# 临时保存当前所有未提交的修改（包括未跟踪的新文件），命名为 sync
git stash push -u -m sync

# 从远程 origin 获取最新的分支和提交信息，但不修改当前代码
git fetch origin

# 把当前分支强制重置为远程 develop 的最新状态
git reset --hard origin/develop

# 把重置后的 feature 分支安全地强制推送到远程，覆盖远程 feature 分支
git push --force-with-lease origin feature/mock-frontend-demo

# 把第①步保存的本地修改重新恢复到当前工作区
git stash pop
```

# 其他

## 定制 Windows 下的命令

前提条件: 在 [cmdautorun.cmd](../Windows/cmdautorun.cmd) 中设置好环境变量 ``OLD_PROMPT``

1. 新建目录 ``D:\Tools\WorkTool\Team\Git_bat``

2. 在 ``Git_bat`` 目录下新建文件 ``git.bat`` 内容如下
```
@echo off
D:\Tools\WorkTool\Team\Git\cmd\git.exe %*
set GITBRANCH=
for /f %%I in ('D:\Tools\WorkTool\Team\Git\cmd\git.exe rev-parse --abbrev-ref HEAD 2^> NUL') do set GITBRANCH=%%I

if "%GITBRANCH%" == "" (
  prompt %OLD_PROMPT%
) else (
  prompt $P $C$E[32;7;32;47m%GITBRANCH%$E[0m$F $G 
)
```

3. 将 ``D:\Tools\WorkTool\Team\Git_bat`` 配置到环境变量  
确保每次在命令行中键入 ``git`` 时，都会触发 ``git.bat`` 而不是 ``git.exe``, 然后在 ``git.bat`` 中调用 ``git.exe`` 即可

## .gitignore文件不生效问题
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

# 客户端

## rgitui
一个使用 Rust + GPUI（Zed 的 UI 框架）开发的、支持 GPU 加速和跨平台的现代桌面 Git GUI 客户端。

https://github.com/noahbclarkson/rgitui

## git-Agent
基于 Rust 和 egui 构建的原生桌面 Git 客户端，支持 Windows、macOS 和 Linux。 在一个应用中管理仓库、审查改动、浏览历史和解决冲突，并可选用 AI 辅助三方合并

https://github.com/adoin/git-Agent

## GitButler
一个现代化的 Git 客户端，通过并行分支、堆叠分支、可视化提交管理和 AI 能力，让复杂的 Git 分支与 PR 工作流变得更简单

https://github.com/gitbutlerapp/gitbutler

# 更多
* [GIT CHEATSHEET (中文速查表)](https://github.com/skywind3000/awesome-cheatsheets/blob/master/tools/git.txt)
* [团队项目开发的问题和解决方案](https://github.com/jackfrued/Python-100-Days/blob/master/Day91-100/91.%E5%9B%A2%E9%98%9F%E9%A1%B9%E7%9B%AE%E5%BC%80%E5%8F%91%E7%9A%84%E9%97%AE%E9%A2%98%E5%92%8C%E8%A7%A3%E5%86%B3%E6%96%B9%E6%A1%88.md)

