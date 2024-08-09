# Docker的常用镜像以及镜像和容器的区别

## Docker的常用镜像

### HTTP测试服务器
[httpbin.org](https://httpbin.org/) 可以测试 HTTP 请求和响应的各种信息，比如 cookie、ip、headers 和登录验证等，且支持 GET、POST 等多种方法。对 Web 开发和测试很有帮助

https://httpbin.org/  
https://github.com/postmanlabs/httpbin  
https://hub.docker.com/r/kennethreitz/httpbin/  

端口：
 - 50080： HTTP端口

使用命令
```bash
# 拉取镜像
docker pull kennethreitz/httpbin

docker run -itd \
  -p 50080:80 \
  --name httpbin \
  kennethreitz/httpbin
```
可以添加的参数
 - ``--restart=always \``

启动后使用命令确认
```
curl -X POST "http://127.0.0.1:50080/delay/2" -H "accept: application/json"
```

### FTP服务器
https://github.com/fauria/docker-vsftpd  
https://hub.docker.com/r/fauria/vsftpd/  

FTP 分为 ``主动模式（PORT）`` 和 ``被动模式(PASV)``

主动模式使用 ``20`` 和 ``21`` 端口，其中 ``20`` 为数据端口，``21`` 为控制端口。

被动模式使用 ``21`` 控制端口和一个其他随机端口作数据端口。

主动模式因为防火墙的原因，经常会断掉，因此被动模式是通常情况下的优选

端口：
 - 50020： 数据端口
 - 50021： 控制端口
 - 60020： 被动模式数据端口

账号密码：
 - ftpuser／123456

使用命令
```bash
# 挂载目录
mkdir -p /home/$USER/vsftpd
mkdir -p /home/$USER/vsftpd_log

# 拉取镜像
docker pull fauria/vsftpd

docker run -itd \
  -v /home/$USER/vsftpd:/home/vsftpd \
  -v /home/$USER/vsftpd_log/:/var/log/vsftpd/ \
  -p 50020:20 -p 50021:21 -p 60020:60020 \
  -e FTP_USER=ftpuser \
  -e FTP_PASS=123456 \
  -e PASV_ADDRESS=127.0.0.1 \
  -e PASV_MIN_PORT=60020 \
  -e PASV_MAX_PORT=60020 \
  -e LOG_STDOUT=1 \
  --name vsftpd \
  fauria/vsftpd
```
可以添加的参数
 - ``--restart=always \``

启动后在 Windows 下打开资源管理器， 输入 ``ftp://ftpuser:123456@127.0.0.1:50021`` 即可访问

### SFTP服务器
https://github.com/atmoz/sftp  
https://hub.docker.com/r/atmoz/sftp/  

端口：
 - 50022： OpenSSH 服务器端口

账号密码：
 - sftpuser／123456

上传文件目录
 - upload

使用命令
```bash
# 挂载目录
mkdir -p /home/$USER/sftp/upload

# 拉取镜像
docker pull atmoz/sftp

docker run -itd \
  -v /home/$USER/sftp/upload:/home/sftpuser/upload \
  -p 50022:22 \
  --name sftp \
  atmoz/sftp \
  sftpuser:123456:::upload
```
可以添加的参数
 - ``--restart=always \``

启动后使用 WinSCP 等工具测试连接

## 镜像和容器的区别

### 镜像
镜像是一个只读的模板，用于``创建容器``。镜像包含了应用程序运行所需的一切，比如代码、运行时、库和环境变量等。镜像可以通过 Dockerfile 定义并构建。

``docker images`` 命令，看的就是镜像，比如

```
docker images
REPOSITORY             TAG       IMAGE ID       CREATED         SIZE
java_gppc              1.0.0     bf5d9e0d84c1   5 minutes ago   482MB
spring_boot_undertow   1.0.0     1bd92c8bc1a5   4 hours ago     393MB
hello-world            latest    d2c94e258dcb   14 months ago   13.3kB
```
我本地有3个镜像 ``java_gppc``， ``spring_boot_undertow`` 和 ``world``，他们分别有各自的 ``IMAGE ID``

### 容器
容器是一种轻量级、可移植的、独立的环境，可以不准确的理解为它就是一个 ``线程``

``docker ps -a`` 命令，看的就是容器，比如
```
docker ps -a
CONTAINER ID   IMAGE                        COMMAND                  CREATED          STATUS
d67dedbaadb7   java_gppc:1.0.0              "…"                     11 minutes ago   Exited (143) 7 minutes ago
18775ff1b2d3   spring_boot_undertow:1.0.0   "…"                     3 hours ago      Exited (143) 3 hours ago
5d7edebed187   spring_boot_undertow:1.0.0   "…"                     4 hours ago      Exited (143) 3 hours ago
9a2a82b88b4e   spring_boot_undertow:1.0.0   "…"                     4 hours ago      Exited (143) 4 hours ago
74496a04d628   hello-world                  "/hello"                 5 hours ago      Exited (0) 5 hours ago
20c745297e83   hello-world                  "/hello"                 3 days ago       Exited (0) 3 days ago
```
我本地有6个容器（线程），他们分别有各自的 ``CONTAINER ID``

## 镜像和容器的删除

### 删除镜像
需要先停止相关的容器运行，然后删除容器，再进行镜像的删除
```
docker rmi {镜像ID)
```

### 删除容器
需要先停止相关的容器运行，再进行容器的删除
```
docker rm {容器ID)
```

## Docker镜像与容器备份迁移

### 镜像的备份迁移

使用命令为 ``docker save`` 和 ``docker load`` （对应``docker images``）

``docker save`` 可以将多个镜像导出到一个文件内

#### 示例
镜像备份
```
docker images
mkdir -p ~/workspace/docker_tmp
docker save -o ~/workspace/docker_tmp/img_java_gppc.tar.gz java_gppc:1.0.0
ll ~/workspace/docker_tmp
```

导入镜像
```
docker load -i ~/workspace/docker_tmp/img_java_gppc.tar.gz
docker images
```

### 容器的备份迁移

使用命令为 ``docker export`` 和 ``docker import`` （对应``docker ps -a``）

#### 示例

容器备份
```
docker ps -a
docker export -o ~/workspace/docker_tmp/ctn_java_gppc.tar {容器ID}
ll ~/workspace/docker_tmp
```

导入镜像（注意：虽然备份的是容器，但是导入的是镜像）
```
cd ~/workspace/docker_tmp
docker import ctn_java_gppc.tar java_gppc_xxx:1.0.0
docker images
```
