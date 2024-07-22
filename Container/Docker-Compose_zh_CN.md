# Docker-Compose相关

## Docker-Compose 简介

``Docker-Compose`` 项目是Docker官方的开源项目，负责实现对Docker容器集群的快速编排。

Docker-Compose 项目由 Python 编写，调用 Docker 服务提供的API来对容器进行管理。因此，只要所操作的平台支持 Docker API，就可以在其上利用Compose 来进行编排管理。

通过一个简单的命令 ``docker compse up`` 可以按照依赖关系启动所有服务

通过一个简单的命令 ``docker compose down`` 停止所有服务

## Docker容器快速编排

通过 ``Docker-Compose`` ，不需要使用shell脚本来启动容器，而使用 ``YAML`` 文件来配置应用程序需要的所有服务，然后使用一个命令，根据 YAML 的文件配置创建并启动所有服务。

### Docker-compose模板文件简介

Compose允许用户通过一个``docker-compose.yml``模板文件（YAML 格式）来定义一组相关联的应用容器为一个项目（project）。

Compose模板文件是一个定义服务、网络和卷的YAML文件。

Compose模板文件默认路径是``当前目录下``的 ``docker-compose.yml``，可以使用 ``.yml`` 或 ``.yaml``作为文件扩展名。

Docker-Compose标准模板文件应该包含version、services、networks 三大部分，最关键的是services和networks两个部分。

## Docker-Compose 的编排结构

Docker-Compose 将所管理的容器分为三层

- 工程（project）：一个工程包含多个服务
- 服务（service）：一个服务当中可包括多个容器实例
- 容器（container）

Docker-Compose 运行目录下的所有文件（docker-compose.yml、extends文件 或 环境变量文件等）组成一个工程，若无特殊指定 ``工程名即为当前目录名``。

Docker Compose 的核心就是其配置文件，采用 YAML 格式，默认为 ``docker-compose.yml`` 。

## docker-compose.yml实例

先确认安装了docker-compose
```
docker compose version
```

下面笔者使用 一个前后端分离的示例进行演示

- [docker-compose.yml](./mycompose1/docker-compose.yml)

工程根目录再 ``~/workspace``

```
📂 ~/workspace
├── 📁 FrontendVue
│  └── 📂 shell
│  └── 📂 src
├── 📁 BackendGin
│  └── 📂 shell
│  └── 📂 src
├── 📁 mycompose1
└─────  docker-compose.yml
```

后台启动
```
cd ~/workspace/mycompose1
docker compose up -d
```

查看日志
```
docker compose logs
```

启动后可以访问  
http://localhost:9500/  
查看

关闭
```
cd ~/workspace/mycompose1
docker compose down
```

## 常用Docker-Compose命令

 - 重新构建服务：``docker compose build``
 - 列出容器：``docker compose ps -a``
 - 创建和启动容器：``docker compose up -d``
 - 在容器里面执行命令：``docker compose exec``
 - 指定一个服务容器启动数量：``docker compose scale``
 - 显示容器进程：``docker compose top``
 - 查看容器输出：``docker compose logs``
 - 删除容器、网络、数据卷和镜像：``docker compose down``
 - 停止：``docker compose stop``
 - 启动：``docker compose start``
 - 重启服务：``docker compose restart``
