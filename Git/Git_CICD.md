# 基于 Git 的 ``CI/CD``

## 概念

### 持续集成 (Continuous Integration)
频繁地（一天多次）将代码集成到主干。让产品可以快速迭代，同时还能保持高质量。它的核心措施是，代码集成到主干之前，必须通过自动化测试。只要一个测试用例失败，就不能集成。“持续集成并不能消除bug”而是让它们非常容易发现和改正。

### 持续交付 (Continuous Delivery)
频繁地将软件的新版本，交付给质量团队或用户，以供评审。如果评审通过，代码就进入生产阶段。持续交付可以看作持续集成的下一步。它强调的是，不管怎么更新，软件是随时随地可以交付的。

### 持续部署 (Continuous Deployment)
代码通过评审以后，自动部署到生产环境。是持续部署是持续交付的下一步，持续部署的目标是，代码在任何时刻都是可部署的，可以进入生产阶段。

## 基于 Gogs + Drone 的持续集成方案

### Drone简介
Drone 是基于 Golang 语言开发的持续集成（Continuous integration，CI）引擎，它可以借助 Docker 容器技术，用于自动化测试与构建，满足持续交付的基本需求，适合小团队开发。Drone 具有简洁、轻量级、启动快、资源占用低等特点。 Jenkins 也是 CI 引擎，它的特点是文档丰富、功能丰富、插件丰富、配置功能强大等特点，但资源占用较高。Drone 比 Jenkins 轻量级，对云原生支持较好。

### Gogs简介
看 [这里](ConstructGitServer_zh_CN.md)

### 实现自动化部署的方案

使用版本
- docker版本：27.0.3
- gogs/gogs版本：0.13.0
- drone/drone版本：2.24.0
- drone/drone-runner-docker版本：1.8.3

### 建立专用容器网络
因为需要容器和容器之间，容器和管道之前的通信，所以建立专用网络以便可以用容器名互相访问
```
docker network create cicd_network
docker network ls
```

### Docker 安装并配置 Gogs
看 [这里](ConstructGitServer_zh_CN.md) 的 ``下载安装（Docker部署）`` 部分

因为要加入专用网络，所以命令为
```
sudo rm -rf /var/gogs
sudo mkdir -p /var/gogs

docker run -itd --name=gogs -p 10022:22 -p 13000:3000 -v /var/gogs:/data --net cicd_network gogs/gogs:0.13
```

安装好以后创建一个 Spring Boot 的测试项目，并提交到 Git 仓库中，笔者使用的是 [SpringBootUndertow](../Java/SpringBootUndertow)

然后访问 Gogs  
http://localhost:13000/  
在 ``账户设置`` → ``授权应用`` → ``管理个人操作令牌`` 处，确认没有 ``drone`` 的 Token（如有则删除）

#### 修改 Gogs 配置
```
vim /var/gogs/gogs/conf/app.ini
```
各个设定如下修改（如果没有则添加）
```
[server]
DOMAIN           = gogs
・・・
EXTERNAL_URL     = http://gogs:3000/
・・・
[security]
・・・
LOCAL_NETWORK_ALLOWLIST = localhost,host.docker.internal,drone
・・・
[time]
FORMAT = RFC3339
```

然后重启gogs
```
docker restart gogs
```


### Docker 安装 Drone
 - [Drone 说明页](https://docs.drone.io/server/provider/gogs/)
 - [Docker Hub](https://hub.docker.com/r/drone/drone)

构建命令
```bash
# 拉取镜像
docker pull drone/drone:2.24.0
# 备用
# docker pull dockerhub.icu/drone/drone:2.24.0

# 创建本地数据卷
sudo rm -rf /var/drone
sudo mkdir -p /var/drone

# （第一次启动）启动容器并挂载数据卷
# 参数说明：
#   DRONE_AGENTS_ENABLED: 启动代理；
#   DRONE_GOGS_SERVER: Gogs的Web服务地址；（因为在一个网络内，这里用了gogs的容器名）
#   DRONE_SERVER_HOST: Drone Server的Web服务地址；
#   DRONE_SERVER_PROTO: Drone Server的Web访问协议；
#   DRONE_USER_CREATE: Drone Server的管理员账号，需要与Gogs的管理员账号一直，一定要配置；
#   DRONE_RPC_SECRET: Drone Server的共享秘钥，为Drone runner提供RPC提供远程过程调用；
docker run -itd \
  --name=drone \
  --env=DRONE_AGENTS_ENABLED=true \
  --env=DRONE_GOGS_SERVER=http://gogs:3000 \
  --env=DRONE_SERVER_PROTO=http \
  --env=DRONE_SERVER_HOST=localhost \
  --env=DRONE_USER_CREATE=username:lch,machine:false,admin:true \
  --env=DRONE_RPC_SECRET=123456 \
  -p 14000:80 -p 14001:443 -v /var/drone:/data \
  --net cicd_network \
  drone/drone:2.24.0
```
需要自动重启的话可以添加 ``--restart=always \`` 参数

### Docker 安装 Runner
 - [Drone 说明页](https://docs.drone.io/runner/docker/installation/linux/)
 - [Docker Hub](https://hub.docker.com/r/drone/drone-runner-docker)

Drone 服务启动并运行后，需要安装运行器（``Runner``）来执行生成管道（``PipeLine``）  
官方提供了很多 Runner
 - **Docker Runner**  
     针对可以在无状态容器中运行测试和编译代码的项目进行了优化; 不太适合无法在容器内运行测试或编译代码的项目，包括面向 Docker 不支持的操作系统或体系结构（如 macOS）的项目。Docker 运行器也不太适合需要在管道执行之间在主机上存储文件或文件夹的有状态管道
 - **Exec Runner**  
     它使用默认 shell 直接在主机上执行构建管道，而无需隔离。出于安全原因，此运行器不适用于不受信任的工作负载。
 - **SSH Runner**  
     用 SSH 协议在静态远程服务器上执行管道命令。管道命令直接在远程服务器上执行，没有隔离，使用默认 shell。出于安全原因，此运行器不适合不受信任的工作负荷。

这里笔者使用 ``Docker Runner``

构建命令
```bash
docker pull drone/drone-runner-docker:1.8.3

# （第一次启动）启动容器并挂载数据卷
# 参数说明：
#  DRONE_RPC_PROTO: 连接到Drone server的Web访问协议；
#  DRONE_RPC_HOST:  Drone Server的Web服务地址；（因为在一个网络内，这里用了drone的容器名）
#  DRONE_RPC_SECRET: Drone Server的共享秘钥；
#  DRONE_RUNNER_CAPACITY: Drone runner流水线并发执行的任务量；
#  DRONE_RUNNER_NAME: Drone runner的名称；
#  DRONE_RUNNER_NETWORKS: 每个管道步骤内 Docker 使用的网络（可逗号分隔）；
#  注意：映射目录必须这样写“/var/run/docker.sock:/var/run/docker.sock”
docker run -itd \
  --name=drone-runner \
  --env=DRONE_RPC_PROTO=http \
  --env=DRONE_RPC_HOST=drone:80 \
  --env=DRONE_RPC_SECRET=123456 \
  --env=DRONE_RUNNER_CAPACITY=2 \
  --env=DRONE_RUNNER_NAME=drone-runner-line \
  --env=DRONE_RUNNER_NETWORKS=cicd_network \
  -p 15000:3000 -v /var/run/docker.sock:/var/run/docker.sock \
  --net cicd_network \
  drone/drone-runner-docker:1.8.3
```

需要自动重启的话可以添加 ``--restart=always \`` 参数

查看日志是否启动成功
```
docker logs -f drone-runner
```

### 确认

#### Drone确认
访问 Drone  
 http://localhost:14000/  

依次如下操作
 - 点击 ``CONTINUE``
 - 使用 ``Gogs`` 的 ``管理员账号密码`` 登录
 - 填写 ``邮箱地址``，``名称``，``公司名``
 - 点击 ``SUBMIT`` 后，可进入主页，然后会看到 gogs 里面的 仓库

#### Gogs确认
然后访问 Gogs  
http://localhost:13000/  
在 ``账户设置`` → ``授权应用`` → ``管理个人操作令牌`` 处，可以看到生成了 ``drone`` 的 Token

### 配置 ``.drone.yml`` 流水线
要使用 Drone 只需在项目根创建一个 ``.drone.yml`` 文件即可，这个是 Drone 构建脚本的配置文件，它随项目一块进行版本管理，开发者不需要额外再去维护一个配置脚本。

官网给了很多语言的配置例子  
https://docs.drone.io/pipeline/docker/examples/  

笔者的配置文件在 [.drone.yml](../Java/SpringBootUndertow/.drone.yml)

### 在Drone中设置宿主机的SSh登录账号和密码

因为在 ``.drone.yml`` 中设定了 ``from_secret`` 来进行关键信息隐藏，所以要在网页端设定

访问 Drone  
 http://localhost:14000/  

依次如下操作
 - 选择对象仓库
 - 点击 ``Activate Repository`` 以激活
 - 在 ``Settings`` → ``General`` → ``Trusted`` → 打开 → 保存
 - 在 ``Settings`` → ``Secrets`` → ``NEW SECRETS`` → 按如下填写
    - ``ssh_host`` : 填写ssh服务器ip
    - ``ssh_port`` : 填写ssh服务器port
    - ``ssh_user`` : 填写ssh到服务器的账号
    - ``ssh_password`` : 填写ssh到服务器的密码

因为笔者要在管道内ssh到宿主机，所以 ``SECRETS`` 处要填写宿主机的信息，其中IP可以使用以下命令查看
```
docker inspect drone-runner | grep "Gateway"
```

### 配置 Web 钩子

访问 Gogs  
http://localhost:13000/  

依次如下操作
 - ``仓库设置`` → ``管理 Web 钩子`` 可以看到配置成功的地址，点击进去，修改为 ``http://drone/hook`` → 点击 ``更新 Web 钩子`` 更新
 - 点击 ``测试推送``，测试是否成功
 - 成功了的话会在 Drone 的 ``Builds`` 下看到运行结果

最后，根据需求配置好 Web 钩子即可
