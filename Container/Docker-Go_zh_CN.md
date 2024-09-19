# Docker实战-Go篇

## 开发环境
- Windows 10
- Go 1.22.5
- WSL2（Ubuntu-22.04）
- Docker 27.0.3

以下所有操作都在 ``WSL2（Ubuntu-22.04）`` 内

## 查找官方的镜像

```bash
docker search golang
```
可以找到官方的 ``golang`` 镜像，进而找到官方仓库  
https://github.com/docker-library/golang  
https://hub.docker.com/_/golang/   

还可以找到官方镜像tag  
https://github.com/docker-library/docs/tree/master/golang#simple-tags  
因为做了编译环境和运行环境隔离，还使用到了  
https://github.com/docker-library/docs/tree/master/alpine  

这里放一些tag的含义
 - bookworm：Debian 12
 - bullseye：Debian 11
 - buster：Debian 10
 - stretch：Debian 9
 - slim：是完整镜像的配对版本。这个镜像通常只安装运行特定工具所需的最小包
 - alpine：基于alpine linux项目，这是一个专门为容器内部使用而构建的操作系统。在很长一段时间里，这些是最受欢迎的镜像变体，因为它们的尺寸很小

## 基于Golang镜像部署Gin应用的实现示例

### 示例工程
一个基于 Gin 的 Web 示例工程

 - [BackendGin](../Framework/BackendGin/)

     - /shell/docker_build.sh：制作docker镜像的shell（默认采用多阶段构建）
     - /shell/app_dockerfile：docker脚本（多阶段构建）
     - /shell/app_dockerfile_singel：docker脚本（普通构建）

### 宿主机确认工程无问题
```bash
cd D:\WorkSpace\FBS\BackendGin
go mod tidy
go build -o ./bin/BackendGin.exe ./src/main.go
.\bin\BackendGin.exe
```
访问  
http://localhost:9501/login  
确认服务可以启动

### 编译与制作镜像

将工程放到 ``~/workspace/`` 下（只需要 ``shell``文件夹，``src``文件夹和``go.mod``文件）

制作docker镜像
```bash
cd ~/workspace/BackendGin/shell
bash docker_build.sh
```
镜像制作完毕可以用下的命令查看（``docker images`` 看的是镜像）
```bash
docker images
```

### 通过镜像启动容器
启动容器（将容器内的9501端口映射到宿主机的9502）
```bash
docker run -itd -p 9502:9501 --name gin_9502 backend_gin:1.0.0
```
默认端口 ``9501``，可以用环境变量 ``GIN_HTTP_PORT`` 指定端口

启动后可以访问  
http://localhost:9502/login  
查看

也可以用命令查看
```bash
curl -v http://localhost:9502/login
```
会返回
```json
{"code":900,"message":"请求内容不正确","data":null}
```

## 基于Golang镜像部署gRPC应用的实现示例

### 示例工程
一个基于 ``Buf``工具链 的 gRPC 示例工程

 - [go](../Go/Grpc/go/)

     - /shell/docker_build.sh：制作docker镜像的shell
     - /shell/app_dockerfile：docker脚本

### 编译与制作镜像

将工程放到 ``~/workspace/`` 下

制作docker镜像
```bash
cd ~/workspace/GoGrpc/shell
bash docker_build.sh
```

启动容器
```bash
docker run -itd -p 50051:50051 --name grpc_50051 go_grpc:1.0.0
```
