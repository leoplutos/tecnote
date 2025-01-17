# Docker

## 简介

### 容器技术的起源

假设你正在秘密研发下一个“拼夕夕”APP，我们姑且称为拼狠狠，程序员自己从头到尾搭建了一套环境开始写代码，写完代码后程序员要把代码交给测试同学测试，这时测试同学开始从头到尾搭建这套环境，测试过程中出现问题程序员也不用担心，大可以一脸无辜的撒娇，“明明在人家的环境上可以运行的”。

测试同学测完后终于可以上线了，这时运维同学又要重新从头到尾搭建这套环境，费了九牛二虎之力搭建好环境开始上线，糟糕，上线系统就崩溃了，这时心理素质好的程序员又可以施展演技了，“明明在人家的环境上可以运行的”。

从整个过程可以看到，不但我们重复搭建了三套环境还要迫使程序员转行演员浪费表演才华，典型的浪费时间和效率，聪明的程序员是永远不会满足现状的，因此又到了程序员改变世界的时候了，容器技术应运而生。

### 什么是容器技术
容器一词的英文是 container ，其实 container 还有集装箱的意思，集装箱是商业史上了不起的一项发明，大大降低了海洋贸易运输成本。让我们来看看集装箱的好处：

- 集装箱之间相互隔离
- 长期反复使用
- 快速装载和卸载
- 规格标准，在港口和船上都可以摆放

软件开发行业中的容器技术就类似于运输行业的集装箱，通过类似沙箱的方式隔离应用程序的运行时环境，容器与容器之间可以共享同一个操作系统，这里的运行时环境指的是程序运行依赖的各种库以及配置。

### 容器VS虚拟机
虚拟机虽然可以隔离出很多“子操作系统”，但占用空间更大，启动更慢，虚拟机软件可能还要花钱（例如 VMWare ）。

而容器技术恰好没有这些缺点。它不需要虚拟出整个操作系统，只需要虚拟一个小规模的环境（类似“沙箱”）。
它启动时间很快，几秒钟就能完成。而且，它对资源的利用率很高（一台主机可以同时运行几千个 Docker 容器）。此外，它占的空间很小，虚拟机一般要几 GB 到几十 GB 的空间，而容器只需要 MB 级甚至 KB 级。

| 特性       | 虚拟机           | 容器             |
|------------|------------------|------------------|
| 隔离级别   | 操作系统级       | 进程级           |
| 隔离策略   | Hypervisor       | CGroups          |
| 系统资源   | 5%-15%           | 0%-5%            |
| 启动时间   | 分钟级           | 秒级             |
| 镜像存储   | GB-TB            | KB-MB            |
| 集群规模   | 上百             | 上万             |
| 高可用策略 | 备份、容灾、迁移 | 弹性、负载、动态 |

### 什么是Docker
``Docker`` 是一个用 ``Go`` 语言实现的开源项目，可以让我们方便的创建和使用容器， Docker 将程序以及程序所有的依赖都打包到 ``Docker Container``，这样你的程序可以在任何环境都会有一致的表现  
Docker 本身并不是容器，它是 ``创建容器的工具``，是 ``应用容器引擎``

#### Docker的核心思想
1. Build, Ship and Run  
  即： ``搭建``、``发送``、``运行``

2. Build once，Run anywhere  
  即： ``搭建一次，到处可用``

#### Docker技术的三大核心概念
 - 镜像（Image）  
    Docker镜像，是一个特殊的文件系统。它除了提供容器运行时所需的程序、库、资源、配置等文件外，还包含了一些为运行时准备的一些配置参数（例如环境变量）。镜像不包含任何动态数据，其内容在构建之后也不会被改变

 - 容器（Container）  
    运行起来的进程

 - 仓库（Repository）  
    存放镜像的地方，最常使用的Registry公开服务，是官方的Docker Hub，这也是默认的 Registry，并拥有大量的高质量的官方镜像

### Docker是如何工作的
实际上 Docker 使用了常见的 ``CS架构``，也就是 ``Client-Server模式``，Docker Client 负责处理用户输入的各种命令，比如 ``docker build`` 、 ``docker run`` ，真正工作的其实是 Server，也就是 ``Docker Daemon``，值得注意的是，Docker client 和Docker Daemon 可以运行在同一台机器上。

## Windows下安装使用Docker(使用 Windows 容器)
这个安装方式为：使用 ``Hyper-V后端`` 并且使用 ``Windows 容器``  
因为 ``Docker Desktop for Windows`` 已经变的 Licence 不友好了，所以笔者使用 ``Docker CLI`` 来使用 Docker
 - [官方二进制下载](https://download.docker.com/win/static/stable/x86_64)
 - [官方二进制安装说明](https://docs.docker.com/engine/install/binaries/#install-server-and-client-binaries-on-windows)

### 打开Windows的功能
打开 Windows 下的设定 → 在上面的搜索框搜索 ``Windows功能`` → 选择 ``启用或关闭 Windows 功能``  
需要打开这4个功能
 - Hyper-V
 - Containers（容器）
 - Virtual Machine Platform（虚拟机平台）
 - Windows Hypervisor Platform（Windows 虚拟机监控程序平台）

功能打开后需要 ``重启计算机``

### 下载二进制
笔者下载的为 [docker-24.0.7.zip](https://download.docker.com/win/static/stable/x86_64/docker-24.0.7.zip)  
下载后解压缩，并且将路径添加到环境变量。  
可以得到 3 个 exe 可执行文件。  
其中：
 - docker.exe：即 Docker Client
 - dockerd.exe：即 Docker Server 也就是 ``Docker Daemon`` 守护进程
 - docker-proxy.exe：对应 Docker 配置参数 ``userland-proxy``

#### 命令行确认
```bash
docker --version
dockerd --version
docker-proxy --version
```

### 设定配置文件
registry server是默认指向官方仓库 ``https://hub.docker.com`` 的  
因为服务器在国外，所以在国内访问度异常慢，需要修改镜像源进行镜像加速  

Windows配置文件位置
```
C:\ProgramData\docker\config\daemon.json
```

修改配置文件（如果没有则新建），添加内容
```json
{
    "debug": false,
    "experimental": true,
    "registry-mirrors": [
        "https://docker.nju.edu.cn",
        "https://docker.m.daocloud.io",
        "https://dockerhub.icu",
        "https://docker.chenby.cn",
        "https://docker.1panel.live",
        "https://docker.awsl9527.cn",
        "https://docker.anyhub.us.kg",
        "https://dhub.kubesre.xyz"
    ],
    "insecure-registries": [
        "127.0.0.1:3111"
    ],
    "hosts": [
        "tcp://localhost:3101"
    ]
}
```

配置文件的内容说明
 - debug：关闭调试
 - experimental：打开实验性功能
 - registry-mirrors：配置加速镜像源
 - insecure-registries：配置私有仓库（http，非https）
 - hosts：开启tcp协议（不开启的话需要用管理员权限运行Docker Client）

NOTE：Docker从1.3.X之后，与docker registry交互默认使用的是https，所以当与私有仓库交互需要填写到insecure-registries下面。

更多设定内容可以看 [这里](https://docs.docker.com/engine/reference/commandline/dockerd/#daemon-configuration-file)

### 注册服务并且开启Docker Daemon
有两种方式，选择其一即可  
**方式一**：使用 ``cmd``（**需要管理员权限**）  
```bash
dockerd --register-service
net start docker
```
**方式二**：使用 ``Powershell``（**需要管理员权限**）  
```bash
dockerd --register-service
Start-Service docker
```
**服务注册成功后确认**  
Windows键 + r → 输入 ``services.msc`` 回车 → 打开服务管理器  
查看是否有一个名字叫做 ``Docker Engine`` 的服务被注册，并且成功启动

### 服务删除命令(卸载的时候使用)
使用 ``cmd``（**需要管理员权限**）  
```bash
net stop docker
sc delete docker
reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\docker /f
reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EventLog\Application\docker /f
```

### 测试命令
```bash
SET DOCKER_HOST=tcp://localhost:3101
docker version
docker ps
docker info
```
查看有无出错信息，设定环境变量``DOCKER_HOST``是为了越过管理员权限

### 运行一个HelloWorld
下面这个命令会下载测试镜像并在容器中运行。它会打印 ``Hello from Docker!`` 后结束。
```
docker run hello-world:nanoserver
```
NOTE：nanoserver是基于 Windows 上的虚拟化实践。

## WSL2下安装使用Docker(使用 Linux 容器)
这个安装方式为：使用 ``WSL2后端`` 并且使用 ``Linux 容器``  

### 安装WSL2并且安装Ubuntu-22.04
参照 [这里](../Windows/WSL_zh_CN.md) 安装

### 在WSL2下安装Docker
首先卸载冲突包
```bash
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
```

~~参照 [官网说明](https://docs.docker.com/engine/install/ubuntu/) 运行命令~~  
~~cd ~/work/lch/tmp~~  
~~curl -fsSL https://get.docker.com -o get-docker.sh~~  
~~sudo sh get-docker.sh~~  
~~执行脚本安装过程中，脚本提示“建议使用Docker Desktop for windows”，20s内按Ctrl+C会退出安装，所以需要等待20s，另外此种方式需要访问外网。~~  

#### 方式1：使用清华大学源
因为 docker 国内已经无法访问，使用 [清华大学源](https://mirror.tuna.tsinghua.edu.cn/help/docker-ce/) 来安装

安装依赖
```bash
sudo apt update
sudo apt install ca-certificates curl gnupg
```

信任 Docker 的 GPG 公钥并添加仓库
```bash
sudo install -m 0755 -d /etc/apt/keyrings

sudo curl -fsSL https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

sudo chmod a+r /etc/apt/keyrings/docker.gpg

sudo echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

安装
```bash
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

安装的组件包括：

- docker-ce：Docker Engine
- docker-ce-cli：用于与 Docker 守护进程通信的命令行工具
- containerd.io：管理容器生命周期的容器运行时环境
- docker-buildx-plugin：增强镜像构建功能的 Docker 扩展工具，特别是在多平台构建方面
- docker-compose-plugin：通过单个 YAML 文件管理多容器 Docker 应用的配置管理插件

检查 Docker 服务状态
```bash
sudo systemctl is-active docker
```

安装后命令行确认
```bash
docker --version
dockerd --version
docker-proxy --version
```

#### 方式2：使用技术爬爬虾每天同步的仓库
https://github.com/tech-shrimp/docker_installer

### 替换 DockerHub 国内镜像源

#### DaoCloud源（推荐）
现在这个镜像比较稳定，但是有白名单限制  
https://github.com/DaoCloud/public-image-mirror

白名单列表  
https://github.com/DaoCloud/public-image-mirror/issues/2328

#### dockerpull.org（推荐）
https://dockerpull.org

#### 1panelproxy
https://docker.1panelproxy.com/

#### docker-mirror
https://github.com/gebangfeng/docker-mirror

#### 南大源
https://sci.nju.edu.cn/9e/05/c30384a564741/page.htm

#### AtomHub 可信镜像中心（镜像比较少）
https://hub.atomgit.com/  

#### 配置方法

Linux配置文件位置
```bash
/etc/docker/daemon.json
```
运行命令
```bash
sudo touch /etc/docker/daemon.json
sudo vim /etc/docker/daemon.json
```
添加内容
```json
{
    "registry-mirrors": [
        "https://dockerpull.org",
        "https://docker.nju.edu.cn",
        "https://docker.m.daocloud.io",
        "https://dockerhub.icu",
        "https://docker.chenby.cn",
        "https://docker.1panel.live",
        "https://docker.awsl9527.cn",
        "https://docker.anyhub.us.kg",
        "https://dhub.kubesre.xyz"
    ],
    "log-driver": "json-file",
    "log-opts": {
        "max-size": "10m",
        "max-file": "10"
    }
}
```

### 确认
启动服务
```bash
# 重新加载 Docker 配置
sudo systemctl daemon-reload
# 重启 Docker 服务
sudo systemctl restart docker.service
# sudo service docker start
```
确认
```bash
systemctl status docker.service
sudo docker info
# service docker status
# ps aux | grep docker
# export DOCKER_HOST="tcp://localhost:3102"
# docker version
# docker ps
# docker info
```

### DockerHub 镜像查找

因为 [官网](https://hub.docker.com) 已经无法访问, 可以使用下面的镜像站

https://docker.ccfuu.com/

### 允许非 root 用户运行 Docker 命令
在大多数安装Docker的系统上，默认会创建一个名为docker的用户组。可以通过运行以下命令来确认这个组是否存在
```bash
sudo addgroup --system docker
```
默认情况下，只有 root 用户或具有 sudo 权限的用户才能够执行 Docker 命令。如果不加sudo前缀直接运行docker命令，系统会报权限错误。
```bash
sudo usermod -aG docker $USER
newgrp docker
sudo chown root:docker /var/run/docker.sock
sudo chmod g+w /var/run/docker.sock
```
在这条命令中，``$USER`` 是一个环境变量，表示当前登录的用户名。

如果上述设定还是不行的话，运行
```bash
unset DOCKER_HOST
```
如果这样做有效，在 ``.bashrc`` 文件中注释掉 ``export DOCKER_HOST=xxx``

### 运行一个HelloWorld容器
```bash
docker run hello-world
```

### 卸载 Docker
卸载 Docker 及其相关组件
```bash
sudo apt purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
```
执行以下命令来删除 Docker 创建的目录
```bash
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
```

## 常用Docker命令
 - 列出所有镜像：``docker images`` 或 ``docker image ls``
 - 搜索镜像：``docker search {镜像}``
 - 下载镜像：``docker pull {镜像id:targe}``
 - 删除镜像：``docker rmi -f {镜像id} {镜像id} {镜像id}``
 - 批量删除：``docker rmi -f ${docker images -aq}``
 + 启动镜像： ``docker run [可选参数] image``
    + ``--name="xxx"``  给容器起名
    + ``-d``  后台方式运行
    + ``-it``  使用交互式方式运行，进入容器内部
    + ``-p``  指定容器端口，通常用 -p ip:主机端口:容器端口
    + ``-P``  随机指定端口
 + 列出所有运行的容器：``docker ps``
    + ``-a`` 列出正在运行和历史运行的容器
    + ``-n=?`` 显示最近创建的容器
    + ``-q`` 只显示容器的编号
    + ``--no-trunc`` 不省略，示列的完整信息
 - 启动容器：``docker start {容器id}``
 - 启动容器并且使用交互式方式进入容器内部：``docker start -a {容器id}``
 - 停止容器：``docker stop {容器id}``
 - 强制停止容器：``docker kill {容器id}``
 - 重启容器：``docker restart {容器id}``
 - 暂停容器：``docker pause {容器id}``
 - 取消暂停容器：``docker unpause {容器id}``
 - 删除容器：``docker rm {容器id}``
 - 删除所有容器：``docker rm -f $(docker ps -aq)``
 - 删除所有容器：``docker ps -aq | xargs docker rm -f``
 - 制作镜像：``docker commit -m="描述信息" -a="作者" {容器id} 目标镜像名:[TAG]``
 - 启动一个远程Shell：``docker run -it centos /bin/bash``
 - 拷贝容器文件到主机：``docker cp {容器id:容器文件} {主机目录}``
 - 构造日志：``docker run -d centos /bin/bash -c 'echo date; echo date; echo date'``
 - 查看日志：``docker logs -ft --tail ? {容器id}``
 - 查看容器端口：``docker container port {容器id/容器名}``
 - 查看容器占用资源：``docker stats``
 - 查看容器的进程：``docker top {容器id/容器名}``
 - 查看进行元数据：``docker inspect {容器id}``
 - 查看数据卷：``docker volume ls``
 - 查看数据卷信息：``docker volume inspect {数据卷名}``
 - 查看容器ip地址：``docker inspect --format='{{.NetworkSettings.IPAddress}}' {容器id/容器名}``
 - 查看容器ip地址：``docker inspect {容器id/容器名} | grep '"IPAddress":' | head -n 1 | awk '{ print $2}' | awk -F '"' '{print $2}'``
 - 进入运行的容器：``docker exec -it {容器id} /bin/bash``（开辟新进程）
 - 进入运行的容器：``docker attach -it {容器id} /bin/bash``（进入原有进程）
 - 退出容器不关闭容器：``Ctrl + P + Q``
 - 退出容器并关闭容器：``exit``

## 制作镜像时开启缓存
可以参考 [官方文档](https://docs.docker.com/build/cache/optimize/#use-cache-mounts)

## 容器的通信
安装 Docker 以后，会默认创建三种网络，可以通过下面命令查看
```bash
docker network ls
```
他们分别是
- Bridge
- Host
- None

安装了 docker 之后，在宿主机运行 ``ip addr`` 会看到一个叫 ``docker0`` 的网卡，作用是为容器充当路由器。每启动一个 docker 容器，就会为容器分配一个 ip 对，和 ``docker0`` 的网卡进行Bridge（桥接）模式。使用的是 ``evth-pair``技术

### Bridge模式

**``重要``**：启动Bridge模式时，容器内的端口监听一定要监听 ``0.0.0.0``   
比如：
- OK例子：``0.0.0.0:9501``
- NG例子：``127.0.0.1:9501``

Bridge 网络模式 是 Docker 的默认网络模式，又称网桥模式，它为 Docker 容器提供了一种简单且有效的网络连接方式。以下是 Bridge 网络模式的主要作用和应用：

1. 容器间通信：在 Bridge 网络模式下，同一 Bridge 网络中的 Docker 容器可以通过 IP 地址或者容器名进行通信。这使得在同一主机上运行的不同容器可以方便地共享数据和服务。

2. 网络隔离：每个 Bridge 网络都是独立的，不同 Bridge 网络之间的容器无法直接通信。这为 Docker 容器提供了一种有效的网络隔离机制，可以防止不同应用之间的网络干扰。

3. 端口映射：Bridge 网络模式支持 Docker 容器和主机之间的端口映射。这意味着，您可以将 Docker 容器的网络服务通过特定的端口暴露给主机，从而使得外部网络可以访问到 Docker 容器的服务。

Bridge模式的启动命令
```bash
docker run -itd -p 8082:8090 --name spring_8082 spring_boot_undertow:1.0.0
```
- 容器名：spring_8082
- 宿主机端口：8082
- 容器虚拟机端口：8090
- 镜像：spring_boot_undertow:1.0.0

查看容器 ``spring_8082`` 规格
```bash
docker inspect spring_8082
```
可以看到
```bash
"Gateway": "172.17.0.1",
"IPAddress": "172.17.0.3",
```
- Gateway：这是 Docker 容器的默认网关，也就是容器发送的所有非本地地址的网络流量都会通过这个网关路由。在大多数情况下，这个网关就是 Docker 容器所在的主机。
- IPAddress：这是 Docker 容器在其网络内的 IP 地址。每个 Docker 容器在其所连接的网络中都会有一个唯一的 IP 地址，其他容器可以通过这个 IP 地址与其进行通信。

查看默认网络 ``bridge`` 规格
```bash
docker inspect bridge
```

### Host模式
Host 网络模式 是 Docker 的一种网络模式，又称主机模式，它允许 Docker 容器共享宿主机的网络命名空间。以下是 Host 网络模式的主要作用和应用：

- 性能优化：在 Host 网络模式下，Docker 容器可以直接使用宿主机的网络，无需通过 Docker 的网络桥接，这可以减少网络延迟，提高网络性能。

- 端口管理：在 Host 网络模式下，Docker 容器内的端口会直接映射到宿主机的端口，无需进行额外的端口映射设置。这使得端口管理更加简单，也避免了端口映射可能带来的端口冲突问题。

- 网络服务部署：对于需要直接使用宿主机网络的网络服务，例如需要监听宿主机所有 IP 地址的服务，或者需要使用特定网络接口或协议的服务，Host 网络模式是一个很好的选择。

需要注意的是，Host 网络模式下的 Docker 容器会直接共享宿主机的网络，这可能会带来一些安全风险，因此在使用 Host 网络模式时，需要对 Docker 容器的网络访问进行适当的控制和限制。

Host模式的启动命令
```bash
docker run -itd -p 8082:8090 --name spring_8082 --net host spring_boot_undertow:1.0.0
```

### None模式
None 网络模式 是 Docker 的一种网络模式，它为 Docker 容器提供了一个最小化的网络环境。  
在 None 网络模式下，Docker 容器拥有自己的网络命名空间，但是不会进行任何网络设备、IP 地址和路由的配置。这意味着，Docker 容器在 None 网络模式下无法进行网络通信。
以下是 None 网络模式的主要应用：

- 网络隔离：None 网络模式可以为 Docker 容器提供一个完全隔离的网络环境，这对于需要高度网络隔离的应用非常有用。例如，您可以使用 None 网络模式来运行一些安全敏感的应用，以防止这些应用被网络攻击。

- 自定义网络配置：虽然 None 网络模式下的 Docker 容器默认无法进行网络通信，但是您可以在容器内部进行自定义的网络配置，以满足特殊的网络需求。例如，您可以在 None 网络模式下的 Docker 容器内部设置 VPN，以实现容器的网络通信。

Host模式的启动命令
```bash
docker run -itd --name spring_8082 --net none spring_boot_undertow:1.0.0
```

### 容器既没有 netstat 和 lsof 也不是 root 时如何排查网络
直接手动解析 procfs 里面的输出，执行
```bash
awk 'function hextodec(str,ret,n,i,k,c){
    ret = 0
    n = length(str)
    for (i = 1; i <= n; i++) {
        c = tolower(substr(str, i, 1))
        k = index("123456789abcdef", c)
        ret = ret * 16 + k
    }
    return ret
}
function getIP(str,ret){
    ret=hextodec(substr(str,index(str,":")-2,2));
    for (i=5; i>0; i-=2) {
        ret = ret"."hextodec(substr(str,i,2))
    }
    ret = ret":"hextodec(substr(str,index(str,":")+1,4))
    return ret
}
NR > 1 {{if(NR==2)print "Local - Remote";local=getIP($2);remote=getIP($3)}{print local" - "remote}}' /proc/net/tcp
```
就可以获得类似 ``netstat`` 的输出了

或者在宿主机使用命令
```bash
docker container port {容器id/容器名}
```

### 配置容器内访问主机服务
当我们在Docker容器中运行应用程序时，有时候需要访问宿主机的IP地址。然而，默认情况下，Docker容器内无法直接使用宿主机的IP地址。为了解决这个问题，Docker提供了一个特殊的主机名 ``host.docker.internal``，使得容器可以轻松访问宿主机。

用 ``--add-host`` 参数将宿主机的IP地址映射到 ``host.docker.internal`` 主机名

```bash
docker run --add-host=host.docker.internal:host-gateway <image>
```
在这个命令中，我们使用 ``--add-host`` 参数将宿主机的IP地址映射到 ``host.docker.internal`` 主机名。``host-gateway`` 是Docker网络中宿主机的默认网关地址。

在容器内部，您可以使用 ``host.docker.internal`` 主机名来访问宿主机的IP地址。例如，在Python代码中使用 ``socket.gethostbyname()`` 函数：
```python
import socket

# 获取宿主机IP
host_ip = socket.gethostbyname('host.docker.internal')
print("Host IP:", host_ip)
```

### 如何使用容器名进行容器间的通信

- 针对已经运行的容器
    ```
    docker network create myNetwork
    docker network connect myNetwork web1
    docker network connect myNetwork web2
    ```

- 针对没有创建的容器
    ```
    docker network create myNetwork
    docker run -itd --name=web1 --net myNetwork nginx
    docker run -itd --name=web2 --net myNetwork nginx
    ```

删除命令
```
docker network rm myNetwork
```

## Docker容器数据卷
Docker将运行的环境打包形成容器运行， Docker容器产生的数据，如果不通过docker commit生成新的镜像，使得数据做为镜像的一部分保存下来， 那么当容器删除后，数据自然也就没有了。 为了能保存数据在Docker中我们使用卷。

**卷的设计目的就是数据的持久化，完全独立于容器的生存周期，因此Docker不会在容器删除时删除其挂载的数据卷。**

数据卷的特点:

- 数据卷可在容器之间共享或重用数据
- 卷中的更改可以直接生效
- 数据卷中的更改不会包含在镜像的更新中
- 数据卷的生命周期一直持续到没有容器使用它为止

### 使用方式
运行容器，指定挂载数据卷
```bash
docker run -it -v 主机目录:容器目录
```

查看所有的数据卷
```bash
docker volume ls
```

更多数据卷的介绍可以看 [这里](https://blog.csdn.net/huangjhai/article/details/119860628)

## 其他

### LazyDocker

[LazyDocker](https://github.com/jesseduffield/lazydocker) 是一个 Docker 管理的 TUI 程序（类似LazyGit）

LazyDocker [快捷键](https://github.com/jesseduffield/lazydocker/blob/master/docs/keybindings/Keybindings_zh.md)

### 宿主机和容器之间的文件复制

需要注意的是，不管容器有没有启动，拷贝命令都会生效

#### 从容器复制文件到宿主机
将容器的 ``/home/licence.txt`` 文件复制到宿主机的 ``/home`` 目录下
```bash
docker cp nginx-web:/home/licence.txt /home
```

#### 从宿主机复制文件到容器
将宿主机的 ``/home/licence.txt`` 文件复制到容器的 ``/home`` 目录下
```bash
docker cp /home/licence.txt nginx-web:/home
```

### 容器直接退出，如何进入容器调试 
此时可覆盖主进程启动命令，更换一个挂起的命令即可
```bash
docker run -it --entrypoint /bin/bash {镜像}
```
对于没有 ``bash`` 的镜像比如 ``alpine``，可以使用
```bash
docker run -it --entrypoint /bin/ash {镜像}
```

### 搭建私有仓库
看 [这里](https://zhuanlan.zhihu.com/p/78543733)

### 关于 Docker Desktop for Windows 的替代品 Rancher Desktop
因为 ``Docker Desktop for Windows`` 已经涉及到授权问题，可以选择使用 ``Rancher Desktop``，github上5.2k星，界面和 ``Docker Desktop for Windows``差别不大，支持 ``Kubernetes`` 本地环境（k3s），商业环境友好
 - [官网](https://rancherdesktop.io/)
 - [Github地址](https://github.com/rancher-sandbox/rancher-desktop/)
