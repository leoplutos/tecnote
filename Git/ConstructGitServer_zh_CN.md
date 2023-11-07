# 构筑私有Git服务器

## 常用的Git服务器

常用的私有Git服务器包含
 - GitLab
 - Gitea
 - Gogs

相对来说，GitLab功能最为全面，内置CI，但对内存和CPU的要求比较高，适合大型团队

Gogs 项目旨在打造一个以最简便的方式搭建简单、稳定和可扩展的自助 Git 服务。使用 Go 语言开发使得 Gogs 能够通过独立的二进制分发，并且支持 Go 语言支持的 所有平台，包括 Linux、macOS、Windows 以及 ARM 平台

Gitea 是一个开源社区驱动的轻量级代码托管解决方案，后端采用 Go 编写，采用 MIT 许可证。它是由另一款开源 Git 服务解决方案 Gogs 分叉（fork）而来。相比较 Gogs 来说功能更多，社区更加活跃，版本迭代速度快。

如果你是简简单单的小团队使用 Gogs 也是不错的选择。如果你的团队可能具有更大的规模 Gitea 可能更适合你。
因为笔者就构筑给自己用，所以这里采用 ``Gogs``

## Gos功能特性
- 支持Mysql、PostgreSQL、SQLite3和TiDB数据库
- 支持活动时间线
- 支持SSH以及HTTP/HTTPS协议
- 支持SMTP、LDAP和反向代理的用户认证
- 支持反向代理子路径
- 支持用户、组织和仓库管理系统
- 支持仓库和组织界别Web钩子（包括Slack集成）
- 支持仓库Git钩子和部署密钥
- 支持仓库工单（Issue）、合并请求（Pull Request）和WiKi
- 支持添加和删除仓库协作者
- 支持Gravatar以及自定义源
- 支持邮件服务
- 支持后台管理面板
- 支持多语言

## 下载安装
 - [Gogs官网](https://gogs.io/)
 - [Gogs GIthub主页](https://github.com/gogs/gogs)
 - [Gitea官网](https://docs.gitea.com/zh-cn/)
 - [Gitea GIthub主页](https://github.com/go-gitea/gitea)

#### 环境要求
 - [环境要求](https://gogs.io/docs/installation)
 - [下载二进制](https://gogs.io/docs/installation/install_from_binary)

## 安装步骤

1. 安装所需软件
```
sudo apt install sqlite3
sqlite3 --version
git --version
```

2. 创建一个 git 用户
```
sudo adduser --system --group --disabled-password --shell /bin/bash --home /home/git --gecos 'Git Version Control' git
```
这个命令将会创建用户并且设置用户文件夹为/home/git。  
输出将会像下面这样
```
Adding system user `git' (UID 109) ...
Adding new group `git' (GID 117) ...
Adding new user `git' (UID 109) with group `git' ...
Creating home directory `/home/git' ...
```

3. 下载二进制包  

下载二进制包后，到服务器
```
sudo tar -zxvf ~/work/lch/tmp/gogs_0.13.0_linux_amd64.tar.gz -C /home/git
sudo ls -al /home/git/
sudo ls -al /home/git/gogs
```
将权限修改为git用户
```
sudo chown -R git: /home/git/gogs
sudo ls -al /home/git/
sudo ls -al /home/git/gogs
```
修改后就可以用下面的命令启动服务了  
参数说明：
- -u：参数意义为使用git用户运行命令
- bash -c：为了运行多条命令套了一层壳  

因为运行gogs，需要在当前路径下新建``data``文件夹，不这样运行会报错
```
sudo -u git bash -c 'cd /home/git/gogs/;./gogs web'
```
后台启动
```
sudo -u git bash -c 'cd /home/git/gogs/;nohup ./gogs web &'
```
```
ps -ef | grep gogs
```

4. 服务化  

NOTE：**因为WSL无法启用服务化，所以这一步笔者没有验证。**  

Gogs 自带 Systemd 单元文件，方便我们的安装配置  
拷贝这个文件到/etc/systemd/system/目录
```
sudo cp /home/git/gogs/scripts/systemd/gogs.service /etc/systemd/system/
```
一旦完成，启动并且启用 Gogs 服务
```
sudo systemctl start gogs
sudo systemctl enable gogs
```

5. 使用 web 安装器安装 Gogs

打开你的浏览器，输入
```
http://YOUR_DOMAIN_IR_IP:3000
```
屏幕将会安装向导  
按如下填写

- 数据库类型: SQLite3
- 数据库文件路径: 使用绝对路径, /home/git/gogs/gogs.db
- 应用名称: 输入你的组织名字
- 仓库根目录: /home/git/gogs-repositories
- 运行系统用户: git
- 域名: 输入你的域名或者服务器 IP 地址。
- SSH 端口号: 8122, 如果你的 SSH 监听其他端口，请修改它。
- HTTP 端口号: 3000
- 应用 UR: 使用 http 和你的域名或者 服务器 IP 地址。
- 日志路径: /home/git/gogs/log

点击``立即安装``按钮，安装将会立刻进行，并且当安装完成时，将会转向到登录页面。  
点击`` 还没帐户？马上注册。``连接进行注册即可  
**第一个生成的用户被自动添加到 Admin 用户组**

## 修改配置
安装完毕之后配置需要修改的时候可以如下操作
确认
```
sudo -u git cat /home/git/gogs/custom/conf/app.ini
```
如果IP发生变化的时候直接修改即可
```
sudo -u git cp -afp /home/git/gogs/custom/conf/app.ini /home/git/gogs/custom/conf/app.ini_bak20231030
sudo -u git ls -al /home/git/gogs/custom/conf
sudo -u git vim /home/git/gogs/custom/conf/app.ini
```

## 其他
还可以配置 Nginx 作为 SSL 代理服务器 和 邮件通知等内容  
因为笔者暂时不需要就没有设定  
更多可以看这里：[如何在 Ubuntu 18.04 上安装和配置 Gogs](https://cloud.tencent.com/developer/article/1626705)

## 创建仓库

### 创建空仓库
在主页上即可看到 ``创建新的仓库`` 按钮，点击后即可按照页面向导创建仓库

### 初始化仓库
发行命令
```
git clone http://172.20.1.1:3000/testuser/TestGit.git D:\WorkSpace\Git\TestGit
cd D:\WorkSpace\Git\TestGit
touch README.md
git init
git add README.md
git commit -m "仓库初始化"
#git remote add origin http://172.20.1.1:3000/testuser/TestGit.git
git push -u origin master
```
仓库创建好之后，需要添加其他的 ``协作者``  
依次点击 ``仓库设置`` → ``管理协作者`` → 在搜索框搜索其他用户 → 点击 ``添加新的协作者``


### 使用协作者在其它地方克隆仓库
```
git config --global user.name "user2"
git config --global user.email "user2@email.com"
git config --global gui.encoding utf-8
git config --global color.ui true
cat ~/.gitconfig
```
```
git clone http://172.20.1.1:3000/testuser/TestGit.git ~/work/lch/workspace/git/TestGit
cd ~/work/lch/workspace/git/TestGit
nvim .
```
