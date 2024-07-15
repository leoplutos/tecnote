# Docker的镜像和容器

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
