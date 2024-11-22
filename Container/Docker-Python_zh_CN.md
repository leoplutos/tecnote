# Docker实战-Python篇

## 开发环境
- Windows 10
- Python3.12
- WSL2（Ubuntu-22.04）
- Docker 27.0.3

以下所有操作都在 ``WSL2（Ubuntu-22.04）`` 内

## 查找官方的镜像

```bash
docker search python
```
可以找到官方的 ``python`` 镜像，进而找到官方仓库  
https://github.com/docker-library/python  
https://hub.docker.com/_/python/  

还可以找到官方镜像tag  
https://github.com/docker-library/docs/tree/master/python#simple-tags

因为做了编译环境和运行环境隔离，还使用到了  
https://github.com/docker-library/docs/tree/master/alpine  
https://github.com/docker-library/docs/tree/master/debian  

这里放一些tag的含义
 - bookworm：Debian 12
 - bullseye：Debian 11
 - buster：Debian 10
 - stretch：Debian 9
 - slim：是完整镜像的配对版本。这个镜像通常只安装运行特定工具所需的最小包
 - alpine：基于alpine linux项目，这是一个专门为容器内部使用而构建的操作系统。在很长一段时间里，这些是最受欢迎的镜像变体，因为它们的尺寸很小

## 基于python镜像部署Sanic应用的实现示例

### 宿主机安装poetry
```bash
pip install poetry -i https://pypi.tuna.tsinghua.edu.cn/simple
```

```bash
poetry config virtualenvs.in-project true
poetry config --list
```

### 示例工程
一个基于 Sanic 的 Python Web 示例工程

 - [BackendSanic](../Framework/BackendSanic/)

     - /shell/docker_build.sh：制作docker镜像的shell
     - /shell/app_dockerfile：docker脚本

### 宿主机确认工程无问题
```bash
cd D:\WorkSpace\FBS\BackendSanic
poetry install
poetry run sanic src.backendsanic.server:app --single-process --debug --no-repl --host=0.0.0.0 --port=9501
```
访问  
http://localhost:9501/login  
确认服务可以启动

### 编译与制作镜像

将工程放到 ``~/workspace/`` 下（只需要 ``shell``文件夹，``src``文件夹和 ``pyproject.toml``文件 ）

制作docker镜像
```bash
cd ~/workspace/BackendSanic/shell
bash docker_build.sh
```
镜像制作完毕可以用下的命令查看（``docker images`` 看的是镜像）
```bash
docker images
```

### 通过镜像启动容器
启动容器（将容器内的9501端口映射到宿主机的9501）
```bash
docker run -itd -p 9501:9501 --name sanic_9501 backend_sanic:latest

# 启动失败时调试用
# docker run -it -p 9501:9501 --entrypoint /bin/bash backend_sanic:latest
```

默认端口 ``9501``，可以用环境变量 ``SANIC_HTTP_PORT`` 指定端口

启动后可以访问  
http://localhost:9501/login  
查看

也可以用命令查看
```bash
curl -v http://localhost:9501/login
```
会返回
```json
{"code":400,"message":"账号不能为空","data":null}
```
