# Docker实战-Vue篇

## 开发环境
- Windows 10
- Node.js 20
- WSL2（Ubuntu-22.04）
- Docker 27.0.3

以下所有操作都在 ``WSL2（Ubuntu-22.04）`` 内

## 查找官方的镜像

```
docker search node
```
可以找到官方的 ``node`` 镜像，进而找到官方仓库  
https://github.com/nodejs/docker-node  
https://hub.docker.com/_/node/  

还可以找到官方镜像tag  
https://github.com/docker-library/docs/tree/master/node#simple-tags  
因为做了编译环境和运行环境隔离，还使用到了  
https://github.com/docker-library/docs/tree/master/nginx  

这里放一些tag的含义
 - bookworm：Debian 12
 - bullseye：Debian 11
 - buster：Debian 10
 - stretch：Debian 9
 - slim：是完整镜像的配对版本。这个镜像通常只安装运行特定工具所需的最小包
 - alpine：基于alpine linux项目，这是一个专门为容器内部使用而构建的操作系统。在很长一段时间里，这些是最受欢迎的镜像变体，因为它们的尺寸很小


## 基于Nodejs镜像部署Vue应用的实现示例

### 示例工程
一个基于 Vue 的 前端 示例工程

 - [FrontendVue](../Framework/FrontendVue/)

     - /shell/docker_build.sh：制作docker镜像的shell
     - /shell/app_dockerfile：docker脚本

工程创建命令为
```
npm create vue@latest
```

### 编译与制作镜像

将工程放到 ``~/workspace/`` 下

制作docker镜像
```
cd ~/workspace/FrontendVue/shell
bash docker_build.sh
```
镜像制作完毕可以用下的命令查看（``docker images`` 看的是镜像）
```
docker images
```

### 通过镜像启动容器
启动容器（将容器内的80端口映射到宿主机9500端口）
```
docker run -itd -p 9500:80 --name vue_9500 frontend_vue:1.0.0

# 启动失败时调试用
# docker run -itd -p 9500:9500 -p 4173:4173 --name vue_9500 frontend_vue:1.0.0
# docker run -it --entrypoint /bin/bash vue_9500:1.0.0
```

启动后可以访问  
http://localhost:9500/  
查看

### Nginx重启命令
如果 nginx 设定修改需要重启时，用如下命令即可
```
nginx -s reload
```

## 关于前后分离的部署

可以将此前端工程与如下实战工程一起部署到docker下，可以完全访问示例工程  
前端端口为 ``9500`` ，后端端口为 ``9501``，部署时宿主机的端口需要注意

- Vue + Java Srping
- Vue + Python Sanic
- Vue + Go Gin
- Vue + Rust actix-web
