# Docker实战-Java篇

## 开发环境
- Windows 10
- OpenJDK 21
- WSL2（Ubuntu-22.04）
- Docker 27.0.3

以下所有操作都在 ``WSL2（Ubuntu-22.04）`` 内

## 查找官方的镜像

```bash
docker search openjdk
```
可以找到官方的 ``eclipse-temurin`` 镜像，进而找到官方仓库  
https://github.com/adoptium/containers  
https://hub.docker.com/_/eclipse-temurin/  

还可以找到官方镜像tag  
https://github.com/docker-library/docs/tree/master/eclipse-temurin#simple-tags  
因为做了编译环境和运行环境隔离，还使用到了  
https://github.com/docker-library/docs/tree/master/maven  
https://github.com/docker-library/docs/tree/master/alpine  
https://github.com/docker-library/docs/tree/master/ubuntu  

这里放一些tag的含义
 - jammy：Ubuntu 22.04 LTS
 - focal：Ubuntu 20.04 LTS
 - centos7：CentOS 7
 - ubi9-minimal：红帽通用基础最小映像
 - alpine：基于alpine linux项目，这是一个专门为容器内部使用而构建的操作系统。在很长一段时间里，这些是最受欢迎的镜像变体，因为它们的尺寸很小

## 1.基于eclipse-temurin镜像部署Spring Boot应用的实现示例

### 示例工程
一个基于SpringBoot，使用Undertow容器的示例工程

 - [SpringBootUndertow](../Java/SpringBootUndertow/)

     - /shell/maven_build.sh：编译java工程的shell
     - /shell/docker_build.sh：制作docker镜像的shell
     - /shell/app_dockerfile：docker脚本（普通构建）

此示例工程需要在宿主机用Maven编译好jar文件，然后放到容器内运行

### 编译与制作镜像

将工程放到 ``~/workspace/`` 下

编译工程
```bash
cd ~/workspace/SpringBootUndertow/shell
bash maven_build.sh
```
制作docker镜像
```bash
bash docker_build.sh
```
镜像制作完毕可以用下的命令查看（``docker images`` 看的是镜像）
```bash
docker images
```

### 通过镜像启动容器
启动容器（将容器内的8090端口映射到宿主机的9500）
```bash
docker run -itd -p 9500:8090 --name spring_9500 spring_boot_undertow:latest
```
默认端口 ``8090``，可以用环境变量 ``SPRING_HTTP_PORT`` 指定端口

启动参数
- ``-d`` ``–detach``：在后台运行容器，并且打印容器id
- ``-i`` ``–interactive``：即使没有连接，也要保持标准输入保持打开状态，一般与 ``-t`` 连用
- ``-t`` ``–tty``：分配一个伪tty，一般与 ``-i`` 连用
- ``-p``：指定端口映射，格式为：宿主机端口:容器端口
- ``--name``：容器名

启动后可以访问  
http://localhost:9500/hello  
查看


查看容器运行情况（``docker ps`` 看的是容器）
```bash
docker ps
```
查看容器log
```bash
docker logs -ft --tail ? {容器ID}
```
进入容器内查看信息（因为Alpine自带ash作为默认shell而不是bash，所以这里用的ash）
```bash
docker exec -it {容器ID} /bin/ash
```
``docker exec`` 是开辟新进程，所以使用 ``exit`` 退出，容器也不会停止

## 2.基于Maven镜像部署gRPC应用的实现示例

### 示例工程
一个基于gRPC示例工程

 - [JavaGrpc](../Go/Grpc/java/)

     - /shell/docker_build.sh：制作docker镜像的shell
     - /shell/app_dockerfile：docker脚本（多阶段构建）
     - /shell/settings.xml：Maven国内源设定文件

此示例工程不需要在宿主机编译，使用多阶段构建，将编译环境（jdk）和运行环境分离（jre）

### 编译与制作容器

将工程放到 ``~/workspace/`` 下

制作docker镜像
```bash
cd ~/workspace/JavaGrpc/shell
bash docker_build.sh
```
镜像制作完毕可以用下的命令查看（``docker images`` 看的是镜像）
```bash
docker images
```

### 通过镜像启动容器
启动容器（将容器内的50051端口映射到宿主机的50051）
```bash
docker run -itd \
  -p 50051:50051 \
  -e "GRPC_SERVER_RESOLVE=false" \
  -e "GRPC_SERVER_HTTP_PORTS=50051" \
  --name grpc_50051 \
  java_grpc:latest
```

默认端口 ``50051``，可以用环境变量 ``GRPC_SERVER_HTTP_PORTS`` 指定端口

启动后可以使用 [httpYac.http](../DevTool/httpYac.http) 中的 gRPC 客户端测试

进入容器内查看信息（``docker ps`` 看的是容器）
```bash
docker exec -it {容器ID} /bin/bash
```
