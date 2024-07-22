# Docker实战-Nodejs篇

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

这里放一些tag的含义
 - bookworm：Debian 12
 - bullseye：Debian 11
 - buster：Debian 10
 - stretch：Debian 9
 - slim：是完整镜像的配对版本。这个镜像通常只安装运行特定工具所需的最小包
 - alpine：基于alpine linux项目，这是一个专门为容器内部使用而构建的操作系统。在很长一段时间里，这些是最受欢迎的镜像变体，因为它们的尺寸很小


## 基于Nodejs镜像部署Express应用的实现示例

### 示例工程
一个基于 Express 的 Nodejs Web 示例工程

 - [BackendExpress](../Web/BackendExpress/)

     - /shell/docker_build.sh：制作docker镜像的shell
     - /shell/app_dockerfile：docker脚本

其中
 - ``package.json`` 文件使用 ``npm init -y`` 创建
 - ``tsconfig.json`` 文件使用 ``npx tsc --init`` 创建
 - 依赖的安装命令为
    ```
    npm install express @types/express --save
    npm install typescript --save-dev
    ```

### 宿主机确认工程无问题
```
cd D:\WorkSpace\Nodejs\BackendExpress
npm install
npm run tsc
npm run start
```
访问  
http://localhost:3300/  
确认服务可以启动

### 编译与制作镜像

将工程放到 ``~/workspace/`` 下（只需要 ``shell``文件夹，``src``文件夹， ``package.json``文件和``tsconfig.json``文件）

制作docker镜像
```
cd ~/workspace/BackendExpress/shell
bash docker_build.sh
```
镜像制作完毕可以用下的命令查看（``docker images`` 看的是镜像）
```
docker images
```

### 通过镜像启动容器
启动容器（将容器内的3300端口映射到宿主机的3301）
```
docker run -itd -p 3301:3300 --name express_3301 backend_express:1.0.0
```

启动后可以访问  
http://localhost:3301/  
查看
