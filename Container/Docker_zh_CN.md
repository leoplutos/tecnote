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
```
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
```
{
    "debug": false,
    "experimental": true,
    "registry-mirrors": [
        "https://hub-mirror.c.163.com",
        "https://mirror.baidubce.com",
        "https://ccr.ccs.tencentyun.com",
        "https://dockerproxy.com",
        "https://registry.docker-cn.com",
        "https://reg-mirror.qiniu.com",
        "https://dockerhub.azk8s.cn",
        "https://docker.mirrors.ustc.edu.cn"
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
```
dockerd --register-service
net start docker
```
**方式二**：使用 ``Powershell``（**需要管理员权限**）  
```
dockerd --register-service
Start-Service docker
```
**服务注册成功后确认**  
Windows键 + r → 输入 ``services.msc`` 回车 → 打开服务管理器  
查看是否有一个名字叫做 ``Docker Engine`` 的服务被注册，并且成功启动

### 服务删除命令(卸载的时候使用)
使用 ``cmd``（**需要管理员权限**）  
```
net stop docker
sc delete docker
reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\docker /f
reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EventLog\Application\docker /f
```

### 测试命令
```
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

### 安装WSL2并且安装Ubuntu
参照 [这里](../Windows/WSL_zh_CN.md) 安装

### 在WSL2下安装Docker
首先卸载冲突包
```
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
```

参照 [官网说明](https://docs.docker.com/engine/install/ubuntu/) 运行命令
```
cd ~/work/lch/tmp
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```
执行脚本安装过程中，脚本提示“建议使用Docker Desktop for windows”，20s内按Ctrl+C会退出安装，所以需要等待20s，另外此种方式需要访问外网。

### 设定配置文件
Linux配置文件位置
```
/etc/docker/daemon.json
```
运行命令
```
sudo touch /etc/docker/daemon.json
sudo vim /etc/docker/daemon.json
```
添加内容
```
{
    "debug": false,
    "iptables": false,
    "experimental": true,
    "registry-mirrors": [
        "https://hub-mirror.c.163.com",
        "https://mirror.baidubce.com",
        "https://ccr.ccs.tencentyun.com",
        "https://dockerproxy.com",
        "https://registry.docker-cn.com",
        "https://reg-mirror.qiniu.com",
        "https://dockerhub.azk8s.cn",
        "https://docker.mirrors.ustc.edu.cn"
    ],
    "insecure-registries": [
        "127.0.0.1:3111"
    ],
    "hosts": [
        "tcp://localhost:3102"
    ]
}
```

### 确认
~~更新设定~~  
~~``sudo update-alternatives --config iptables``~~  
~~输入数字 ``1`` 后按 ``回车`` 以选择 ``iptables-legacy``~~  

启动服务
```
sudo service docker start
```
确认
```
service docker status
ps aux | grep docker
export DOCKER_HOST="tcp://localhost:3102"
docker version
docker ps
docker info
```
运行一个HelloWorld
```
docker run hello-world
```

## 常用Docker命令
 - 列出所有镜像：docker images ls
 - 搜索镜像：docker search 镜像
 - 下载镜像：docker pull 镜像id:targe
 - 删除镜像：docker rmi -f 镜像id 镜像id 镜像id
 - 批量删除：docker rmi -f ${docker images -aq}
 + 启动镜像： docker run \[可选参数\] image
    + --name="xxx"  给容器起名
    + -d  后台方式运行
    + -it  使用交互式方式运行，进入容器内部
    + -p  指定容器端口，通常用 -p ip:主机端口:容器端口
    + -P  随机指定端口
 + 列出所有运行的容器：docker ps
    + -a 列出正在运行和历史运行的容器
    + -n=? 显示最近创建的容器
    + -q 只显示容器的编号
 - 启动容器：docker start 容器id
 - 停止容器：docker stop 容器id
 - 强制停止容器：docker kill 容器id
 - 重启容器：docker restart 容器id
 - 暂停容器：docker pause 容器id
 - 取消暂停容器：docker unpause 容器id
 - 删除容器：docker rm 容器id
 - 删除所有容器：docker rm -f $(docker ps -aq)
 - 删除所有容器：docker ps -aq | xargs docker rm -f
 - 制作镜像：docker commit -m="描述信息" -a="作者" 容器id 目标镜像名:\[TAG\]
 - 启动一个远程Shell：docker run -it centos /bin/bash
 - 拷贝容器文件到主机：docker cp 容器id:容器文件 主机目录
 - 构造日志：docker run -d centos /bin/bash -c 'echo date; echo date; echo date'
 - 查看日志：docker logs -ft --tail ? 容器id
 - 查看容器端口：docker container port 容器id/容器名
 - 查看容器占用资源：docker stats
 - 查看容器的进程：docker top 容器id/容器名
 - 查看进行元数据：docker inspect 容器id
 - 查看数据卷：docker volume ls
 - 查看数据卷信息：docker volume inspect 数据卷名
 - 查看容器ip地址：docker inspect --format='{{.NetworkSettings.IPAddress}}' 容器id/容器名
 - 查看容器ip地址：docker inspect 容器id/容器名 | grep '"IPAddress":' | head -n 1 | awk '{ print $2}' | awk -F '"' '{print $2}'
 - 进入运行的容器：docker exec -it 容器id /bin/bash（开辟新进程）
 - 进入运行的容器：docker attach -it 容器id /bin/bash（进入原有进程）
 - 退出容器不关闭容器：  Ctrl + P + Q
 - 退出容器并关闭容器：  exit

## 使用案例-在WSL2下使用Docker

使用 Linux 容器创建一个 Nodejs 镜像

### Docker 安装 Node.js
查看可用的 Node 版本
```
docker search node
```
拉取 node 镜像
```
docker pull node:18-alpine
```
查看是否下载成功
```
docker images
```
NOTE：Node.js Docker团队维护了一个 ``node:alpine`` 镜像tag以及他的变体，alpine 经常因为其非常小的镜像体积而被引用，小体积意味着更新的软件占用空间和更少的漏洞

### 构建一个简单的Web服务
```
mkdir -p ~/work/lch/workspace/typescript/docker_express
cd ~/work/lch/workspace/typescript/docker_express
npm init -y
npm install express @types/express --save
npm install typescript --save-dev
npx tsc --init
```
修改 ``package.json``
```
nvim package.json
```
 内容如下
```
{
	"name": "docker_express",
	"version": "1.0.0",
	"description": "",
	"main": "App.js",
	"scripts": {
		"test": "echo \"Error: no test specified\" && exit 1",
		"tsc": "tsc -p tsconfig.json",
		"start": "node dist/App.js"
	},
	"keywords": [],
	"author": "",
	"license": "ISC",
	"dependencies": {
		"@types/express": "^4.17.21",
		"express": "^4.18.2"
	},
	"devDependencies": {
		"typescript": "^5.3.2"
	}
}
```
修改 ``tsconfig.json``
```
nvim tsconfig.json
```
 内容如下
```
{
	"compilerOptions": {
		"target": "ES2020",
		"module": "commonjs",
		"outDir": "dist",
		"rootDir": "src",
		"declaration": true,
		"sourceMap": true,
		//"mapRoot": "maps",
		"esModuleInterop": true,
		"forceConsistentCasingInFileNames": true,
		"strict": true,
		"skipLibCheck": true
	},
	"exclude": [
		"node_modules"
	]
}
```
```
mkdir -p ~/work/lch/workspace/typescript/docker_express/src
touch ~/work/lch/workspace/typescript/docker_express/src/App.ts
```
修改 ``App.ts``
```
nvim src/App.ts
```
 内容如下
```typescript
import express from 'express';
import { Express, Request, Response } from 'express';

const app: Express = express();
const PORT: number = 3300;

app.use(express.json());

app.get('/', (reueset: Request, response: Response) => {
	console.log("responsed!");
	response.status(200).send('Hello, This is build by docker!');
});

app.listen(PORT, () => {
	console.log(`Express with Typescript! Server is listening on port ${PORT}`);
});
```
然后在本地进行测试
```
rm -rf dist
npm run tsc
npm run start
```
打开浏览器访问  
http://localhost:3300/  
确认服务正常启动

### 构建Web服务为Docker镜像
项目根目录中创建 Docker 配置文件 ``Dockerfile``
```
cd ~/work/lch/workspace/typescript/docker_express
touch Dockerfile
nvim Dockerfile
```
内容如下
```
# Node 版本
FROM node:18-alpine

# 构建时变量，仅在构建Docker映像期间可用
ARG NODE_ENV=production
ARG registry=https://npmreg.proxy.ustclug.org/
# 在容器内部设置环境变量
ENV NODE_ENV $NODE_ENV

# 将文件或目录复制到镜像中，这里复制的为编译后的js文件
COPY ./dist /dist
COPY ./package.json /package.json
COPY ./package-lock.json /package-lock.json

# 执行后面跟着的命令行命令
RUN npm config set registry $registry
RUN NODE_ENV=$NODE_ENV npm install

# 声明容器运行时监听的特定网络端口
EXPOSE 3300

# 指定容器创建时的默认命令
CMD ["node", "dist/App.js"]
```
构建 Docker 镜像
```
docker build --tag my-test-app:test . --network=host
```
``--network=host``参数一定要加上，不然无法联网，会在 ``npm install`` 的时候超时

确认镜像是否构建成功
```
docker images
```

运行容器
```
docker run -p 3300:3300 -it my-test-app:test
```

打开浏览器访问  
http://localhost:3300/  
确认服务正常启动

NOTE：容器运行如果不是后台运行的话是无法使用 ``Ctrl+c`` 停止的，可以使用下面的命令
```
docker ps
docker stop ${CONTAINER ID}
```

**后台运行容器**  
通过 ``-d`` 参数指定容器后台运行
```
docker run -d -p 3300:3300 -it my-test-app:test
```

### 搭建私有仓库
看 [这里](https://zhuanlan.zhihu.com/p/78543733)

## 其他

### 关于 Docker Desktop for Windows 的替代品 Rancher Desktop
因为 ``Docker Desktop for Windows`` 已经涉及到授权问题，可以选择使用 ``Rancher Desktop``，github上5.2k星，界面和 ``Docker Desktop for Windows``差别不大，支持 ``Kubernetes`` 本地环境（k3s），商业环境友好
 - [官网](https://rancherdesktop.io/)
 - [Github地址](https://github.com/rancher-sandbox/rancher-desktop/)
