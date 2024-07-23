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

## 下载安装（服务器部署）
 - [Gogs官网](https://gogs.io/)
 - [Gogs GIthub主页](https://github.com/gogs/gogs)
 - [Gitea官网](https://docs.gitea.com/zh-cn/)
 - [Gitea GIthub主页](https://github.com/go-gitea/gitea)

#### 环境要求
 - [环境要求](https://gogs.io/docs/installation)
 - [下载二进制](https://gogs.io/docs/installation/install_from_binary)

## 安装步骤（服务器部署）

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
http://localhost:3000/  
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
因为默认时间显示是 ``RFC1123``，需要改成 ``RFC3339``  
用如下命令修改
```
sudo -u git cp -afp /home/git/gogs/custom/conf/app.ini /home/git/gogs/custom/conf/app.ini_bak20231030
sudo -u git ls -al /home/git/gogs/custom/conf
sudo -u git vim /home/git/gogs/custom/conf/app.ini
```
在最下面添加
```
[time]
FORMAT = RFC3339
```
如果IP发生变化等情况，也可以按此方法修改  
修改后确认
```
sudo -u git cat /home/git/gogs/custom/conf/app.ini
```
确认无误后重启服务即可

## 其他
还可以配置 Nginx 作为 SSL 代理服务器 和 邮件通知等内容  
因为笔者暂时不需要就没有设定  
更多可以看这里：[如何在 Ubuntu 18.04 上安装和配置 Gogs](https://cloud.tencent.com/developer/article/1626705)

## 下载安装（Docker部署）
 - [Gogs Docker 说明页](https://github.com/gogs/gogs/tree/main/docker)
 - [Docker Hub](https://hub.docker.com/u/gogs)
 - [可用Tag](https://github.com/gogs/gogs/pkgs/container/gogs)

构建命令
```
# 拉取镜像
docker pull gogs/gogs:0.13

# 创建本地数据卷
sudo mkdir -p /var/gogs

# （第一次启动）启动容器并挂载数据卷
docker run -itd --name=gogs -p 10022:22 -p 13000:3000 -v /var/gogs:/data gogs/gogs:0.13
```
剩下步骤和 ``服务器部署`` 一致，访问 http://localhost:13000/ 安装即可

安装后如果跳转到了 ``3000`` 端口的话，修改为 ``13000`` 即可

### 容器内的自定义目录
``自定义目录`` 在 Docker 环境中可能并不明显。 宿主机的 ``/var/gogs/gogs`` 和 容器内 ``/data/gogs`` 已经是 ``自定义目录``，无需创建另一个图层，而是直接编辑该目录下的相应文件。

因为挂载了数据卷，所以自定义文件为
 - 容器内 ``/data/gogs/conf/app.ini``
 - 宿主机 ``/var/gogs/gogs/conf/app.ini``

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
先确认全局设定
```
cat ~/.gitconfig
```
```
git clone http://172.20.1.1:3000/testuser/TestGit.git ~/work/lch/workspace/git/TestGit
cd ~/work/lch/workspace/git/TestGit
```
修改本地级(工程级)git设定
```
cat .git/config
git config --local user.name "user2"
git config --local user.email "user2@email.com"
git config --local gui.encoding utf-8
git config --local color.ui true
```

## 工单管理(issues)
不知为何会把 ``issues`` 翻译成 ``工单``  
在 Gogs 内置了 issues 管理，使用流程为

1. 创建 ``标签(labels)`` 和 ``里程碑(milestones)``  
  标签可以为
    - Bug（报告问题）
    - Enhancement（请求新特性）
    - Duplicate（重复问题）
    - Invalid（无效问题）
2. 创建 ``工单(issues)``，填写标题与内容，并在画面右侧选择 ``标签`` 和 ``里程碑``
3. 在画面右侧选择 ``指派成员``，将 issues 指派给特定人员
4. 对应后可以关闭 issues

## 版本发布(releases)
在 Gogs 内置了 版本 管理，使用流程为

1. 在仓库的 `` 版本发布`` 中点击 ``发布新版`` 按钮
    - 标签名称： 填入一个 ``tag``，tag存在则使用存在的tag，不存在则会在当前commit下新建tag
    - 标题： 一般填写和``标签名称``一致
    - 内容： 记录版本概要
    - 附件： 可选，如果想除了代码之外发布编译好的内容则可以在此上传
    - 预发行标识： 通知用户发行版尚未准备投入生产，并且可能不稳定的话选择此项
2. 点击 ``发布版本`` 按钮

## 组织

在 gogs 中 ``组织`` 相当于公司，``团队`` 相当于公司内部的部门，比如php组，java组，而属于php组的项目，java组没有管理权限。  
默认加入组织的人员对任何项目没有权限，需要创建团队，将人员加入团队中  
所以要使用组织来管理项目的话需要：  
1. 新建 ``组织``
2. 在组织下面新建 ``团队``，并且给与 ``写入权限``
3. 将项目添加到 ``团队仓库``
4. 将人员添加到 ``团队``

NOTE：个人创建的项目，转移到组织，个人将保留管理权限。

## 自定义模板
更多看 [这里](https://gogs.io/docs/features/custom_template)

### 注入自定义 CSS 文件

新建 ``head.tmpl``

```
sudo -u git mkdir -p /home/git/gogs/custom/templates/inject
sudo -u git touch /home/git/gogs/custom/templates/inject/head.tmpl
sudo -u git ls -al /home/git/gogs/custom/templates/inject
sudo -u git vim /home/git/gogs/custom/templates/inject/head.tmpl
```
内容如下
```
<link rel="stylesheet" href="/css/custom.css">
```

新建 ``custom.css``
```
sudo -u git mkdir -p /home/git/gogs/custom/public/css/
sudo -u git touch /home/git/gogs/custom/public/css/custom.css
sudo -u git ls -al /home/git/gogs/custom/public/css/
sudo -u git vim /home/git/gogs/custom/public/css/custom.css
```

内容如下
```
.markdown:not(code) table {
    padding: 0;
    border-collapse: collapse;
    border-spacing: 0;
    font-size: 1em;
    border: 0;
    margin: 1.2em 0;
}
.markdown:not(code) tbody {
    margin: 0;
    padding: 0;
    border: 0;
}
.markdown:not(code) table th {
    background-color: rgba(55, 48, 73, 0.2) !important;
}
.markdown:not(code) table tr {
    border: 0;
    border-top: 1px solid #777;
    margin: 0;
    padding: 0;
}
.markdown:not(code) table tr:nth-child(2n) {
    background-color: rgba(210, 210, 210, 0.3);
}
.markdown:not(code) table tr th,
.markdown:not(code) table tr td {
    font-size: 1em;
    border: 1px solid #777;
    margin: 0;
    padding: 0.5em 1em;
}
.markdown:not(code) table tr th {
    font-weight: bold;
}
```

重启 Gogs
```
ps -ef | grep gogs
sudo kill -9 {pid}
sudo -u git bash -c 'cd /home/git/gogs/;nohup ./gogs web &'
ps -ef | grep gogs
```

## 常见问题

### Markdown表格无法渲染

在 Gogs 的 ``Markdown`` 下使用表格必须让表格代码的上下都有一个空行，不然会渲染失败  
一个可以正常渲染的例子（表格的上部和下部都需有一个空行）
```
foo

| Syntax      | Description |
| ----------- | ----------- |
| Header      | Title       |
| Paragraph   | Text        |

bar
```

### 私有服务器的IP改变
因为笔者的私有服务器建立在自己的WSL2中，所以每次重启后IP地址都会变化，导致已经下载的工程无法推送  
解决方式是打开工程根路径下的 ``.git/config`` 文件，修改如下内容中的IP即可
```
[remote "origin"]
	url = http://111.112.113.114:3000/foo/bar.git
```

