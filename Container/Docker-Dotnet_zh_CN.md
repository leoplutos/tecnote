# Docker实战-Dotnet篇

## 开发环境
- Windows 10
- Dotnet 8
- WSL2（Ubuntu-22.04）
- Docker 27.0.3

以下所有操作都在 ``WSL2（Ubuntu-22.04）`` 内

## 查找官方的镜像

### 微软镜像

官方 .NET Docker 映像是由 Microsoft 创建和优化的 Docker 映像。 它们在 [Microsoft 工件注册表](https://mcr.microsoft.com/) 上公开提供

更多可以看 [这里](https://learn.microsoft.com/zh-cn/dotnet/architecture/microservices/net-core-net-framework-containers/official-net-docker-images)

官方镜像tag  
https://mcr.microsoft.com/en-us/product/dotnet/sdk/tags  
https://mcr.microsoft.com/en-us/product/dotnet/aspnet/tags  
https://mcr.microsoft.com/en-us/product/dotnet/runtime/tags  

### docker hub 镜像

官方仓库  
https://github.com/dotnet/dotnet-docker  
https://hub.docker.com/_/microsoft-dotnet  

这里放一些tag的含义
 - noble：Ubuntu 24.04 LTS
 - jammy：Ubuntu 22.04 LTS
 - alpine：基于alpine linux项目，这是一个专门为容器内部使用而构建的操作系统。在很长一段时间里，这些是最受欢迎的镜像变体，因为它们的尺寸很小
 - bookworm：Debian 12
 - slim：是完整镜像的配对版本。这个镜像通常只安装运行特定工具所需的最小包


## 控制台 程序部署到Docker

示例工程
 - [dotnet-core-sample](../Dotnet/dotnet-core-sample/)

     - /shell/docker_build.sh：制作docker镜像的shell
     - /shell/app_dockerfile：docker脚本

将工程放到 ``~/workspace/`` 下

### 制作docker镜像
```bash
cd ~/workspace/dotnet-core-sample/shell
bash docker_build.sh
```

### 启动容器
```bash
docker run -itd --name dotnet-console-app dotnet-console-app:latest
```

## Asp.NET 程序部署到Docker

示例工程
 - [BackendAspCore](../Framework/BackendAspCore/)

     - /shell/docker_build.sh：制作docker镜像的shell
     - /shell/app_dockerfile：docker脚本

将工程放到 ``~/workspace/`` 下

#### 制作docker镜像
```bash
cd ~/workspace/BackendAspCore/shell
bash docker_build.sh
```

#### 启动容器
```bash
docker run -itd \
  -p 9501:9501 \
  -e ASPNETCORE_HTTP_PORTS=9501 \
  --name aspcore_9501 \
  backend_aspwebapi:latest
```

默认端口 ``9501``，可以用环境变量 ``ASPNETCORE_HTTP_PORTS`` 指定端口

启动后可以用命令确认
```bash
curl -X POST http://localhost:9501/login
```
会返回
```
{"type":"https://tools.ietf.org/html/rfc9110#section-15.5.16","title":"Unsupported Media Type","status":415,"traceId":"00-6c4ec21df08bca54fb268609f05afbd8-3ac1e4d40c7335f7-00"}
```

## gRPC 程序部署到Docker

示例工程
 - [netcore](../Go/Grpc/netcore/)

     - /shell/docker_build.sh：制作docker镜像的shell
     - /shell/app_dockerfile：docker脚本

将工程放到 ``~/workspace/`` 下

#### 制作docker镜像
```bash
cd ~/workspace/netcore/shell
bash docker_build.sh
```

#### 启动容器
```bash
docker run -itd \
  -p 50051:50051 \
  -e ASPNETCORE_ENVIRONMENT=Docker \
  -e ASPNETCORE_HTTP_PORTS=50051 \
  -e GRPC_SERVER_RESOLVE=false \
  --name grpc_50051 \
  dotnet_grpc:latest
```

默认端口 ``50051``，可以用环境变量 ``ASPNETCORE_HTTP_PORTS`` 指定端口

启动后可以使用 [httpYac.http](../DevTool/httpYac.http) 中的 gRPC 客户端测试

进入容器内查看信息
```bash
docker exec -it {容器ID} /bin/bash
```
