# Docker实战-Java篇

## 开发环境
- Windows 10
- OpenJDK 21
- WSL2（Ubuntu-22.04）
- Docker 27.0.3

以下所有操作都在 ``WSL2（Ubuntu-22.04）`` 内

## 查找官方的镜像

```
docker search openjdk
```
可以找到官方的 ``eclipse-temurin`` 镜像，进而找到官方仓库  
https://github.com/adoptium/containers  
https://hub.docker.com/_/eclipse-temurin/  

还可以找到官方镜像tag  
https://github.com/docker-library/docs/tree/master/eclipse-temurin#simple-tags

## 1.基于eclipse-temurin镜像部署Spring Boot应用的实现示例

### 示例工程
一个基于SpringBoot，使用Undertow容器的示例工程

 - [SpringBootUndertow](../Java/SpringBootUndertow/)

     - /shell/maven_build.sh：编译java工程的shell
     - /shell/docker_build.sh：制作docker镜像的shell
     - /shell/app_dockerfile：docker脚本

### 编译与制作镜像

将工程放到 ``~/workspace/`` 下

编译工程
```
cd ~/workspace/SpringBootUndertow/shell
bash maven_build.sh
```
制作docker镜像
```
bash docker_build.sh
```
镜像制作完毕可以用下的命令查看（``docker images`` 看的是镜像）
```
docker images
```

### 通过镜像启动容器
启动容器（将容器内的8090端口映射到宿主机的8082）
```
docker run -d -p 8082:8090 -it spring_boot_undertow:1.0.0
```
启动参数
- ``-d`` ``–detach``：在后台运行容器，并且打印容器id
- ``-i`` ``–interactive``：即使没有连接，也要保持标准输入保持打开状态，一般与 ``-t`` 连用
- ``-t`` ``–tty``：分配一个伪tty，一般与 ``-i`` 连用
- ``-p``：指定端口映射，格式为：主机(宿主)端口:容器端口

启动后可以访问  
http://localhost:8082/hello  
查看


查看容器运行情况（``docker ps`` 看的是容器）
```
docker ps
```
查看容器log
```
docker logs -ft --tail ? {容器ID}
```
进入容器内查看信息（因为Alpine自带ash作为默认shell而不是bash，所以这里用的ash）
```
docker exec -it {容器ID} /bin/ash
```
``docker exec``是开辟新进程，所以使用``exit``退出，容器也不会停止

## 2.基于eclipse-temurin镜像部署gRPC应用的实现示例

### 示例工程
一个基于gRPC示例工程

 - [JavaGppc](../Go/Grpc/java/)

     - /shell/maven_build.sh：编译java工程的shell
     - /shell/docker_build.sh：制作docker镜像的shell
     - /shell/app_dockerfile：docker脚本

### 编译与制作容器

将工程放到 ``~/workspace/`` 下

编译工程
```
cd ~/workspace/JavaGppc/shell
bash maven_build.sh
```
制作docker镜像
```
bash docker_build.sh
```
镜像制作完毕可以用下的命令查看（``docker images`` 看的是镜像）
```
docker images
```

### 通过镜像启动容器
启动容器（将容器内的50051端口映射到宿主机的50054）
```
docker run -d -p 50054:50051 -it java_gppc:1.0.0
```

启动后可以使用 [httpYac.http](../DevTool/httpYac.http) 中的 gRPC 客户端测试

进入容器内查看信息（``docker ps`` 看的是容器）
```
docker exec -it {容器ID} /bin/bash
```
