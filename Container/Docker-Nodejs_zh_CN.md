# Docker实战-Nodejs篇

## 开发环境
- Windows 10
- Node.js 20
- WSL2（Ubuntu-22.04）
- Docker 27.0.3

以下所有操作都在 ``WSL2（Ubuntu-22.04）`` 内

## 查找官方的镜像

```bash
docker search node
```
可以找到官方的 ``node`` 镜像，进而找到官方仓库  
https://github.com/nodejs/docker-node  
https://hub.docker.com/_/node/  

还可以找到官方镜像tag  
https://github.com/docker-library/docs/tree/master/node#simple-tags

这里放一些tag的含义
 - bookworm：Debian 12
 - bullseye：Debian 11
 - buster：Debian 10
 - stretch：Debian 9
 - slim：是完整镜像的配对版本。这个镜像通常只安装运行特定工具所需的最小包
 - alpine：基于alpine linux项目，这是一个专门为容器内部使用而构建的操作系统。在很长一段时间里，这些是最受欢迎的镜像变体，因为它们的尺寸很小


## 基于Deno镜像部署Express应用的实现示例

### 示例工程
一个基于 Express 的 Deno Web 示例工程

 - [BackendExpress](../Web/BackendExpress/)

     - /shell/docker_build.sh：制作docker镜像的shell
     - /shell/app_dockerfile：docker脚本


### 编译与制作镜像

将工程放到 ``~/workspace/`` 下

制作docker镜像
```bash
cd ~/workspace/BackendExpress/shell
bash docker_build.sh
```
镜像制作完毕可以用下的命令查看（``docker images`` 看的是镜像）
```bash
docker images
```

### 通过镜像启动容器
启动容器（将容器内的9500端口映射到宿主机的9500）
```bash
docker run -itd -p 9500:9500 --name express_9500 backend_express:latest
```

启动后可以访问  
http://localhost:9500/  
查看

## 基于Bunjs镜像部署Fastify应用的实现示例

### 示例工程
一个基于 Fastify 的 Bunjs Web 示例工程

 - [BackendFastify](../Framework/BackendFastify/)

     - /shell/docker_build.sh：制作docker镜像的shell
     - /shell/app_dockerfile：docker脚本

### 编译与制作镜像

将工程放到 ``~/workspace/`` 下（只需要 ``shell``文件夹，``src``文件夹， ``package.json``文件,``tsconfig.json``文件和``bunfig.toml``文件）

制作docker镜像
```bash
cd ~/workspace/BackendFastify/shell
bash docker_build.sh
```
镜像制作完毕可以用下的命令查看（``docker images`` 看的是镜像）
```bash
docker images
```

### 通过镜像启动容器
启动容器（将容器内的9501端口映射到宿主机的9501）
```bash
docker run -itd -p 9501:9501 --name fastify_9501 backend_fastify:latest
```

启动后可以用命令确认
```bash
curl -X POST http://localhost:9501/login
```
会返回
```json
{"statusCode":400,"code":"FST_ERR_VALIDATION","error":"Bad Request","message":"body must be object"}
```

## 基于Nodejs镜像部署gRPC应用的实现示例

### 示例工程

 - [node_grpc](../Go/Grpc/node/)

     - /shell/docker_build.sh：制作docker镜像的shell
     - /shell/app_dockerfile：docker脚本

制作docker镜像
```bash
cd ~/workspace/node_grpc/shell
bash docker_build.sh
```

启动容器（将容器内的50051端口映射到宿主机的50051）
```bash
docker run -itd \
  -p 50051:50051 \
  --name grpc_50051 \
  node_grpc:latest
```

默认端口 ``50051``

启动后可以使用 [httpYac.http](../DevTool/httpYac.http) 中的 gRPC 客户端测试
