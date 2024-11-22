# Docker实战-Rust篇

## 开发环境
- Windows 10
- Rust 1.79
- WSL2（Ubuntu-22.04）
- Docker 27.0.3

以下所有操作都在 ``WSL2（Ubuntu-22.04）`` 内

## 查找官方的镜像

```
docker search rust
```
可以找到官方的 ``rust`` 镜像，进而找到官方仓库  
https://github.com/rust-lang/docker-rust  
https://hub.docker.com/_/rust/   

还可以找到官方镜像tag  
https://github.com/docker-library/docs/tree/master/rust  
因为做了编译环境和运行环境隔离，还使用到了  
https://github.com/docker-library/docs/tree/master/alpine  

这里放一些tag的含义
 - bookworm：Debian 12
 - bullseye：Debian 11
 - buster：Debian 10
 - stretch：Debian 9
 - slim：是完整镜像的配对版本。这个镜像通常只安装运行特定工具所需的最小包
 - alpine：基于alpine linux项目，这是一个专门为容器内部使用而构建的操作系统。在很长一段时间里，这些是最受欢迎的镜像变体，因为它们的尺寸很小

## 关于Rust使用scratch镜像
因为scratch镜像里面不包含任何额外的组件或库，所以编译的时候需要``静态链接编译``，需要如下设定

### 设定 ``musl`` 目标
```bash
rustup target add x86_64-unknown-linux-musl
cargo build --release --target x86_64-unknown-linux-musl
```
Rust在glibc环境（比如：Ubuntu、Debian、RedHat）编译时，``glibc默认不会被打包进去``  
而使用musl的libc，可支持``静态链接到 musl libc``，知名的 [ripgrep](https://github.com/BurntSushi/ripgrep) 就是这样做的


## 基于Rust镜像部署actix-web应用的实现示例

不同于其他实战篇的是，这次笔者要使用多阶段构建，将编译环境和运行环境分离
 - 阶段1：使用rust官方镜像编译
 - 阶段2：使用alpine镜像运行

Docker 17.05 版本以后，支持了多阶段构建，允许一个 Dockerfile 中出现多个 FROM 指令  
Docker 的镜像内容中，并非只是一个文件，而是有依赖关系的层级结构，后面以前一层为基础  
多个 FROM 指令时，最后生成的镜像，仍以``最后一条 FROM 为准，之前的 FROM 会被抛弃``  
最大的使用场景是将编译环境和运行环境分离

### 示例工程
一个基于 Rust 的 actix-web 示例工程

 - [backend-actix-web](../Framework/backend-actix-web/)

     - /shell/docker_build.sh：制作docker镜像的shell
     - /shell/app_dockerfile：docker脚本
     - /shell/config.toml：编译环境Rust仓库镜像设定文件

### 编译与制作镜像

将工程放到 ``~/workspace/`` 下（只需要 ``shell``文件夹，``src``文件夹和``Cargo.toml``文件）

制作docker镜像
```bash
cd ~/workspace/backend-actix-web/shell
bash docker_build.sh
```
镜像制作完毕可以用下的命令查看（``docker images`` 看的是镜像）
```bash
docker images
```

### 通过镜像启动容器
启动容器（将容器内的9501端口映射到宿主机的9503）
```bash
docker run -itd -p 9503:9501 --name actix_web_9503 backend_actix_web:latest

# 启动失败时调试用
# docker run -it --entrypoint /bin/bash backend_actix_web:latest
```

默认端口 ``9501``，可以用环境变量 ``RUST_HTTP_PORT`` 指定端口

启动后可以访问  
http://localhost:9503/  
查看

也可以用命令查看
```
curl -v http://localhost:9503
```
会返回
```
Unauthorized
```
