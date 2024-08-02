# 构筑私有Git服务器-Gitea

## 关于Gitea
Gitea 是一个轻量级的 DevOps 平台软件。从开发计划到产品成型的整个软件生命周期，他都能够高效而轻松的帮助团队和开发者。包括 Git 托管、代码审查、团队协作、软件包注册和 CI/CD。它与 GitHub、Bitbucket 和 GitLab 等比较类似。 Gitea 最初是从 Gogs 分支而来，几乎所有代码都已更改。

## Gitea 和 Gogs 的选择
如果是几个人的小团队，没有什么 CI/CD 需求的话选择 ``Gogs`` 就够用了  
如果团队规模更大，有类似 ``GitHub Actions`` 的 CI/CD 需求话，可以选择 ``Gitea``

### 建立专用容器网络
因为 ``Gitea`` 和 ``Runner`` 需要互相访问，所以建立专用网络以便可以用容器名互相访问
```
docker network create gitea_network
docker network ls
```

## Gitea下载安装（Docker部署）
 - [Gitea官网](https://docs.gitea.com/zh-cn/)
 - [Gitea GIthub主页](https://github.com/go-gitea/gitea)
 - [Docker Hub](https://hub.docker.com/r/gitea/gitea)

构建命令
```bash
# 拉取镜像
# docker pull gitea/gitea:1-rootless
docker pull gitea/gitea:1.22.1-rootless

# 创建本地数据卷
sudo rm -rf /var/gitea
sudo mkdir -p /var/gitea/{data,config}

# 默认情况下，Docker中的Gitea将使用uid:1000 gid:1000
sudo chown 1000:1000 /var/gitea/data
sudo chown 1000:1000 /var/gitea/config

# （第一次启动）启动容器并挂载数据卷
docker run -itd \
  --name=gitea \
  -v /var/gitea/data:/var/lib/gitea \
  -v /var/gitea/config:/etc/gitea \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  -p 13000:3000 -p 10022:2222 \
  --net gitea_network \
  gitea/gitea:1.22.1-rootless
```

访问 http://localhost:13000/ 安装  
 - 小团队选择 ``SQLite3`` 即可
 - 为了方便内部管理，可以将 ``禁止用户自助注册`` 选项打开

安装后如果跳转到了 ``3000`` 端口的话，修改为 ``13000`` 即可

### 容器内的自定义目录

因为挂载了数据卷，所以自定义文件为
 - 容器内 ``/var/lib/gitea/custom``
 - 宿主机 ``/var/gitea/data/custom``

配置文件为
 - 容器内 ``/etc/gitea/app.ini``
 - 宿主机 ``/var/gitea/config/app.ini``

## Gitea Actions

从 Gitea 1.19 版本开始，``Gitea Actions`` 成为了内置的 CI/CD 解决方案  
从 Gitea1.21.0 开始，默认情况下，Actions 是启用的

``Gitea Actions`` 允许用户在其仓库中自动化各种软件工作流程，例如构建、测试和部署应用程序。用户可以定义特定的触发器，如代码推送或拉取请求，来执行预定义的任务或工作流程。

Gitea 不会自己运行 Job，而是将 Job 委托给 ``Runner``。 Gitea Actions 的 Runner 被称为 ``act runner``，它是一个独立的程序，也是用 Go 语言编写的。 它是基于 ``nektos/act`` 的一个分支

## act runner下载安装（Docker部署）
 - [act runner 的 Docker Hub](https://hub.docker.com/r/gitea/act_runner)

运行 ``act runner`` 需要两个必需的参数
 - ``instance``  
    Gitea实例的地址，因为都使用了Docker部署，所以使用容器名 ``http://gitea:3000``
 - ``token``  
    用于身份验证和标识，有3个级别 ``实例级别``, ``组织级别``, ``存储库级别``，这里笔者使用``实例级别``  
    我们访问 ``http://localhost:13000/admin/actions/runners`` → 右上角的 ``创建 Runner`` 来取得

构建命令
```bash
# 拉取镜像
docker pull gitea/act_runner:latest

# 创建本地数据卷
sudo rm -rf /var/gitea_runner
sudo mkdir -p /var/gitea_runner/{data,config}

# 默认情况下，Docker中的Gitea将使用uid:1000 gid:1000
sudo chown 1000:1000 /var/gitea_runner/data
sudo chown 1000:1000 /var/gitea_runner/config
```

在 ``/var/gitea_runner/config`` 下新建 ``config.yaml``

```bash
touch /var/gitea_runner/config/config.yaml
```

内容如下

```yaml
# config for act-runner 0.2.10

log:
  level: info

runner:
  file: .runner
  capacity: 1
  envs:
    A_TEST_ENV_NAME_1: a_test_env_value_1
    A_TEST_ENV_NAME_2: a_test_env_value_2
  env_file: .env
  timeout: 3h
  insecure: false
  fetch_timeout: 5s
  fetch_interval: 2s
  labels:
    - "ubuntu-latest:docker://gitea/runner-images:ubuntu-latest"
    - "ubuntu-22.04:docker://gitea/runner-images:ubuntu-22.04"
    - "ubuntu-20.04:docker://gitea/runner-images:ubuntu-20.04"

cache:
  enabled: true
  dir: ""
  host: ""
  port: 0
  external_server: ""

container:
  #指定容器将连接到的网络[host, bridge, custom network]
  network: "gitea_network"
  privileged: true
  options:
  workdir_parent:
  valid_volumes: []
  docker_host: ""
  force_pull: true
  force_rebuild: false

host:
  workdir_parent:
```

或者使用命令生成 ``config.yaml``
```bash
docker run --entrypoint="" --rm -it gitea/act_runner:latest act_runner generate-config > config.yaml
```

然后启动容器
```bash
# （第一次启动）启动容器并挂载数据卷
docker run -itd \
  --name=gitea_runner \
  --env=CONFIG_FILE=/config.yaml \
  --env=GITEA_INSTANCE_URL=http://gitea:3000 \
  --env=GITEA_RUNNER_REGISTRATION_TOKEN=画面得到的token \
  -v /var/gitea_runner/config/config.yaml:/config.yaml \
  -v /var/gitea_runner/data:/data \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --net gitea_network \
  gitea/act_runner:latest
```

启动成功后可以在  
http://localhost:13000/admin/actions/runners  
看到新的Runner

### 使用 Gitea Actions
要使用 Gitea Actions 只需在项目目录下创建一个 ``.gitea/workflows/`` 目录，然后在此目录下创建 ``.yaml`` 文件即可

因为 ``Gitea Actions`` 在尽可能兼容 ``GitHub Actions`` 的基础上进行设计，所以也可以看 GitHub Actions 的 官方文档  
https://docs.github.com/en/actions/quickstart  

笔者的配置文件在 [deploy.yaml](../Java/SpringBootUndertow/.gitea/workflows/deploy.yaml)

