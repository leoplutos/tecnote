# Kubernetes

## 引言
在接触 ``K8s`` 之前，大多人首先要接触到的就是 ``Docker``。我们得到一个容器的镜像之后，要把应用运行起来最简单的方式就是 ``docker run`` 的命令。然而在实际的生产环境中，很少仅靠一个单容器就能够满足需求，也就是所谓的容器编排，此处就是 ``K8s`` 发挥强项之处

## 简介
``K8s`` 的全称是 [Kubernetes](https://kubernetes.io/zh-cn/docs/home/) ，官方称其是负责自动化运维管理多个 Docker 程序的集群

## K8s组件

``K8s`` 是属于主从设备模型（Master-Slave架构），即有 ``Master`` 节点负责核心的调度、管理和运维， ``Slave`` 节点则在执行用户的程序。但是在 K8s 中，主节点一般被称为 ``Master Node`` 或者 ``Head Node`` ，而从节点则被称为 ``Worker Node``或者 ``Node``

### Master Node

 - ``API Server`` ：K8s的请求入口服务。API Server负责接收K8s所有请求（来自UI界面或者CLI命令行工具），然后，API Server根据用户的具体请求，去通知其他组件干活
 - ``Scheduler`` ：K8s中的调度服务。当用户要部署服务时，Scheduler会选择最合适的Worker Node（服务器）来部署
 - ``Controller Manager`` ：K8s的控制服务。Controller Manager本身就是总称，实际上有很多具体的Controller，在文章Components of Kubernetes Architecture中提到的有Node Controller、Service Controller、Volume Controller等，分别负责不同K8s对象
 - ``etcd`` ：K8s的存储服务。etcd存储了K8s的关键配置和用户配置，K8s中仅API Server才具备读写权限，其他组件必须通过API Server的接口才能读写数据

### Worker Node

 - ``Kubelet`` ：Worker Node的监视器，以及与Master Node的通讯器。Kubelet是Master Node安插在Worker Node上的“眼线”，它会定期向Master Node汇报自己Node上运行的服务的状态，并接受来自Master Node的命令，并执行
 - ``Kube-Proxy`` ：K8s的网络代理。私以为称呼为Network-Proxy可能更适合？Kube-Proxy负责Node在K8s的网络通讯、以及对外部网络流量的负载均衡
 - ``Container Runtime`` ：Worker Node的运行环境。即安装了容器化所需的软件环境确保容器化程序能够跑起来，比如Docker Engine。大白话就是帮忙装好了Docker运行环境
 - ``Logging Layer`` ：K8s的监控状态收集器。私以为称呼为Monitor可能更合适？Logging Layer负责采集Node上所有服务的CPU、内存、磁盘、网络等监控项信息
 - ``Add-Ons`` ：K8s管理运维Worker Node的插件组件。有些文章认为Worker Node只有三大组件，不包含Add-On，但笔者认为K8s系统提供了Add-On机制，让用户可以扩展更多定制化功能，是很不错的亮点

## K8s概念

### Pod
Pod 是可以在 Kubernetes 中创建和管理的、最小的可部署的计算单元。可以被理解成一群可以共享网络、存储和计算资源的容器化服务的集合

打个形象的比喻，在同一个 Pod 里的几个 Docker 服务/程序，``好像被部署在同一台机器上``，可以``通过 localhost 互相访问``，并且可以``共用 Pod 里的存储资源``（这里是指 Docker 可以挂载 Pod 内的数据卷）。
- 同一个 Pod 之间的 Container 可以通过 localhost 互相访问，并且可以挂载 Pod 内所有的数据卷
- 不同的 Pod之 间的 Container 不能用 localhost 互相访问，也不能挂载其他 Pod 的数据卷

有了 Pod 之后，同一个 Pod 内的容器可以共享很多信息，也可能需要读取同一份配置。比如 Pod 内有两个容器需要访问同一个数据库，那么我们可以把相关的配置信息写到 ``ConfigMap`` 里。那如果还有一些比较敏感的信息的话，就需要放到 ``Secret`` 对象中，它其实是一个保存在 Etcd 里的键值对数据。这样，你把 ``Credential`` 信息以 ``Secret`` 的方式存在 Etcd 里，Kubernetes 就会在你指定的 Pod（比如，Web 应用的 Pod）启动时，自动把 Secret 里的数据以 Volume 的方式挂载到容器里。

### Volume 数据卷
K8s 支持很多类型的 Volume 数据卷挂载。可以理解为 ``需要手动 mount 的磁盘``，此外，有一点可以帮助理解：数据卷 Volume 是 Pod 内部的磁盘资源


Volume 是 K8s 的对象，对应一个实体的数据卷；而 VolumeMounts 只是 Container 的挂载点，对应 Container 的其中一个参数。但是，VolumeMounts 依赖于 Volume，只有当 Pod 内有 Volume 资源的时候，该 Pod 内部的 Container 才可能有 VolumeMounts

### Container 容器
一个 Pod 内可以有多个容器 Container

在 Pod 中，容器也有分类：

- 标准容器 Application Container
- 初始化容器 Init Container
- 边车容器 Sidecar Container
- 临时容器 Ephemeral Container

一般来说，我们部署的大多是标准容器（``Application Container``）

### Deployment 和 ReplicaSet（简称RS）
Deployment 的作用是管理和控制 Pod 和 ReplicaSet ，管控它们运行在用户期望的状态中

Deployment 负责监督底下的工人 Pod 干活，确保每时每刻有用户要求数量的 Pod 在工作。如果一旦发现某个工人 Pod 不行了，就赶紧新拉一个 Pod 过来替换它

ReplicaSet 的作用就是管理和控制 Pod，管控他们好好干活。但是，ReplicaSet 受控于 Deployment。形象来说， ReplicaSet 就是 Deployment 手下的小包工头

许多地方建议 K8s 用户，``使用 Deployment`` 来部署服务，而不要直接用 ReplicaSet。当 Deployment 被部署的时候，K8s 会自动生成要求的 ReplicaSet 和 Pod。在 K8s 官方文档中也指出``用户只需要关心 Deployment 而不必操心 ReplicaSet``

### Service 和 Ingress

#### Service（对内提供服务）

K8s 中的服务（Service）并不是我们常说的“服务”的含义，而更像是网关层，是若干个 Pod 的流量入口、流量均衡器。目的是``将服务提供给同一个集群内的其他服务使用``

以下引用官方解释：

> Kubernetes Pod 是有生命周期的。 它们可以被创建，而且销毁之后不会再启动。 如果您使用 Deployment 来运行您的应用程序，则它可以动态创建和销毁 Pod。
每个 Pod 都有自己的 IP 地址，但是在 Deployment 中，在同一时刻运行的 Pod 集合可能与稍后运行该应用程序的 Pod 集合不同。
这导致了一个问题： 如果一组 Pod（称为“后端”）为群集内的其他 Pod（称为“前端”）提供功能， 那么前端如何找出并跟踪要连接的 IP 地址，以便前端可以使用工作量的后端部分？答案是使用 Service

可以通过 Service 的域名访问到服务，形式是 ``<ServiceName>.<NameSpace>``，比如你有为 Deployment 的应用创建了一个名为 ``portal`` 的 Service 在默认的命名空间，那么集群内想要通过 Http 访问这个应用，就可以使用 ``http://portal.default`` 。这个域名仅在集群内有效，因为是内部的一个DNS负责解析。

总结来说，``Service 是 K8s 服务的核心``，屏蔽了服务细节，统一对外暴露服务接口，真正做到了 ``微服务``。对于用户来说，只需要关注一个 Service的 入口就可以，而不需要操心究竟应该请求哪一个 Pod

K8s 的 Service有3种类型（最新出了一种新的ClusterName，可以直接提供DNS Name）

- ``ClusterIP``：只能提供 K8s 集群内可以访问的 IP 和 Port
- ``NodePort``：在上面的基础上，提供K8s集群外部可以访问的 Port，IP 则是集群内任意一个 NodeIP
- ``LoadBlancer``：在上面的基础上，提供 K8s 集群外可以访问的 IP 和 Port。需要注意的是，在 LoadBlancer 中可以设置关闭 NodePort。还有一点需要注意，LoadBlanacer 依赖集群底座的能力，并不是所有的 K8s 都能使用 LoadBlancer
- ``ExternalName``：将 Service 映射到 externalName 字段的内容（例如 ``foo.bar.example.com``），通过返回带有该名称的 CNAME 记录实现。不设置任何类型的代理。这种类型需要 kube-dns 的 v1.7 或更高版本，或者 CoreDNS 的 0.8 或更高版本

#### Ingress（对外提供服务）
正如其名，它是集群的入口。比如我们的集群 Web 应用想要让用户能够访问，那必然要在Ingress 入口上增加一条解析记录。这一点，熟悉像N ginx 的朋友应该比较容易理解，事实上 Nginx Ingress 也是 K8s 生态中的一个成员

### NameSpace 命名空间
NameSpace 跟 Pod 没有直接关系，而是 K8s 另一个维度的对象。或者说，前文提到的概念都是为了服务 Pod 的，而 NameSpace 则是为了服务整个 K8s 集群的

NameSpace 是为了把一个 K8s 集群划分为若干个资源不可共享的虚拟集群而诞生的。
也就是说，可以通过在 K8s 集群内创建 NameSpace 来分隔资源和对象。

### CronJob 和 Job
- CronJob：定时任务。假设我的系统内有一个全网信息排行榜展示，要求每天需要在凌晨0点的时候更新一次，可以用CronJob来搞定
- Job：单次任务。仅仅需要执行一次的任务

### DaemonSet
``以守护进程的方式运行一个应用``。比如，我想要在后台进行日志的收集。这个时候DaemonSet就派上了用场，它会保证在所有的目标节点上运行一个 Pod 的副本。在这期间，如果有新的 Node 加入到 K8s 集群中的话，它也会自动完成调度，在新的机器上运行一个 Pod 副本。因此，前面说的监控、日志等任务很适合用 DaemonSet 的方式执

## K3s 实战

[K3s](https://docs.k3s.io/zh/) 是 ``rancher`` 公司开发维护的一套 ``K8s`` 发行版。是一个轻量级 Kubernetes，易于安装，内存使用减半，全部采用小于 100 MB 的二进制文件。其内核机制还是和 K8s 一样，但是剔除了很多外部依赖以及 K8s 的 alpha、beta 特性，同时改变了部署方式和运行方式，目的是轻量化 K8s，并将其应用于 IoT 设备（比如树莓派）。 简单来说，K3s 就是阉割版 K8s，消耗资源极少，非常适合本地测试和学习

K3s 相较于 K8s 其较大的不同点如下：
- 存储 etcd 使用 嵌入的 sqlite 替代，但是可以外接 etcd 存储
- apiserver 、schedule 等组件全部简化，并以进程的形式运行在节点上
- 网络插件使用 Flannel， 反向代理入口使用 traefik 代替 ingress nginx
- 默认使用 local-path-provisioner 提供本地存储卷

我们采用官方的``单节点``进行本地安装

![单节点](https://docs.k3s.io/zh/img/k3s-architecture-single-server.svg "单节点")

### 卸载 Docker
卸载 Docker 及其相关组件
```bash
sudo apt purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
```

### 安装 Nerdctl
K3s 默认的容器运行时是 ``containerd``，因为 ctr 和 crictl 设计对人类非常不友好，它无法像 Docker 一样去全生命周期的管理容器，我们使用 [nerdctl](https://github.com/containerd/nerdctl) 来管理本地和远程的镜像资源  

[NerdCtl FAQ](https://github.com/containerd/nerdctl/blob/main/docs/faq.md)

#### 下载安装
```bash
export GITHUB_URL="https://bgithub.xyz"
```

**精简版**
```bash
# 下载
# curl -Lo nerdctl-linux-amd64.tar.gz "${GITHUB_URL}/containerd/nerdctl/releases/download/v2.0.0/nerdctl-2.0.0-linux-amd64.tar.gz"
# 复制二进制文件
# sudo tar Cxzvvf /usr/local/bin nerdctl-linux-amd64.tar.gz
# rm nerdctl-linux-amd64.tar.gz
```

**完整版 - 包含 containerd, runc, CNI, buildkit 等依赖 (推荐)**
```bash
# 下载
curl -Lo nerdctl-full-linux-amd64.tar.gz "${GITHUB_URL}/containerd/nerdctl/releases/download/v2.0.0/nerdctl-full-2.0.0-linux-amd64.tar.gz"
# 解压缩
mkdir ./nerdctl-full-linux-amd64
tar Cxzvvf ./nerdctl-full-linux-amd64 nerdctl-full-linux-amd64.tar.gz
# 复制二进制文件
sudo cp ./nerdctl-full-linux-amd64/bin/* /usr/local/bin
# 复制systemd启动文件
sudo cp -ra ./nerdctl-full-linux-amd64/lib/systemd/system/* /etc/systemd/system/
sudo chown root:root /etc/systemd/system/buildkit.service \
  /etc/systemd/system/containerd.service \
  /etc/systemd/system/stargz-snapshotter.service
# systemd启动和开机启动
sudo systemctl enable buildkit containerd
sudo systemctl restart buildkit containerd
sudo systemctl status buildkit containerd
# 复制 CNI 插件
sudo mkdir -p /opt/cni/bin
sudo cp -ra ./nerdctl-full-linux-amd64/libexec/cni/* /opt/cni/bin/
sudo chown -R root:root /opt/cni/bin/
rm nerdctl-full-linux-amd64.tar.gz
```

CNI 插件 依赖 iptables, 所以需要安装
```bash
sudo apt install iptables
```

#### 配置 nerdctl
- root 模式: ``/etc/nerdctl/nerdctl.toml``
```bash
sudo mkdir -p /etc/nerdctl
sudo touch /etc/nerdctl/nerdctl.toml
sudo vim /etc/nerdctl/nerdctl.toml
```

- 非 root 模式: ``~/.config/nerdctl/nerdctl.toml``
```bash
mkdir -p ~/.config/nerdctl
touch ~/.config/nerdctl/nerdctl.toml
vim ~/.config/nerdctl/nerdctl.toml
```

内容如下
```toml
debug          = false
debug_full     = false
#address        = "unix:///run/k3s/containerd/containerd.sock"
#namespace      = "k8s.io"
#snapshotter    = "stargz"
#group_manager = "cgroupfs"
#hosts_dir      = ["/etc/containerd/certs.d", "/etc/docker/certs.d"]
#hosts_dir      = ["/var/lib/rancher/k3s/agent/etc/containerd/certs.d"]
cni_path       = "/opt/cni/bin"
#cni_netconfpath = "/var/lib/nerdctl/cni/net.d"
experimental   = true
```

#### 配置 containerd 国内源

创建目录
```bash
# _default为适用所有
sudo mkdir -p /etc/containerd/certs.d/_default
# docker.io为docker hub
# sudo mkdir -p /etc/containerd/certs.d/docker.io
```

创建配置文件 config.toml

**注意：**
- 在 containerd 2.x 中 配置值为 ``io.containerd.cri.v1.images``
- 在 containerd 1.x 中 配置值为 ``io.containerd.grpc.v1.cri``

```bash
sudo tee /etc/containerd/config.toml << 'EOF'
version = 3

[plugins]
  [plugins."io.containerd.cri.v1.images".registry]
    config_path = "/etc/containerd/certs.d"
EOF
```

创建配置文件 hosts.toml
```bash
sudo tee /etc/containerd/certs.d/_default/hosts.toml << 'EOF'
[host."https://dockerpull.org"]
  capabilities = ["pull", "resolve"]

[host."https://docker.m.daocloud.io"]
  capabilities = ["pull", "resolve"]
EOF
```

重启 containerd
```bash
sudo systemctl daemon-reload
sudo systemctl restart containerd
```

确认
```bash
sudo nerdctl pull hello-world:latest
sudo nerdctl run hello-world
sudo nerdctl images
sudo nerdctl ps -a
```

#### 配置 buildkit 国内源

创建目录
```bash
sudo mkdir -p /etc/buildkit
```

创建配置文件 buildkitd.toml
```bash
sudo tee /etc/buildkit/buildkitd.toml << 'EOF'
[registry."docker.io"]
  mirrors = ["https://dockerpull.org", "https://docker.m.daocloud.io"]
  http = true
  insecure = true
EOF
```

重启 buildkit
```bash
sudo systemctl daemon-reload
sudo systemctl restart buildkit
```

测试工程为 [FetchDemo](../Web/FetchDemo/)

确认
```bash
cd $HOME/workspace/FetchDemo
sudo nerdctl build -t fetchdemo .
sudo nerdctl run -d -p 9500:9500 --name fetchdemo_9500 fetchdemo:latest
curl localhost:9500
```

#### 个性化配置

为了使用方便可以给 Nerdctl 制作一个别名，保持和 Docker 一样的使用习惯

```bash
sudo tee /usr/local/bin/docker << 'EOF'
#!/bin/bash
/usr/local/bin/nerdctl $@
EOF
```

增加执行权限
```bash
sudo chmod +x /usr/local/bin/docker
```

确认
```bash
docker -v
nerdctl -v
```

### 安装 K3s
```bash
# sudo curl -sfL https://rancher-mirror.rancher.cn/k3s/k3s-install.sh | INSTALL_K3S_MIRROR=cn sh -s - --write-kubeconfig-mode 666 --disable traefik
sudo curl -sfL https://rancher-mirror.rancher.cn/k3s/k3s-install.sh | INSTALL_K3S_MIRROR=cn sh -s - --write-kubeconfig-mode 666
```

运行此安装后即安装好了``单节点 Server``，它是一个功能齐全的 Kubernetes 集群，包括了托管工作负载 pod 所需的所有数据存储、control plane、kubelet 和容器运行时组件

K3s 服务将被配置为在节点重启后或进程崩溃或被杀死时自动重启

K3s会安装在 ``/usr/local/bin/``
- ``k3s``: 二进制可执行文件
- ``k3s-killall.sh``: 用于停止并清理 K3s 相关的所有进程和服务
- ``k3s-uninstall.sh``: 卸载 K3s
- ``crictl -> k3s``: K3s 的软连接（用于别名），它是一个用于与容器运行时接口（Container Runtime Interface，CRI）进行交互的命令行工具，可以理解用于平替docker命令
- ``kubectl -> k3s``: K3s 的软连接（用于别名），用于管理 K3s 的命令行工具

配置文件在 ``/etc/rancher/k3s/k3s.yaml``，由 K3s 安装的 kubectl 将自动使用该文件

查看 K3s 状态
```bash
# sudo systemctl start k3s
# sudo systemctl stop k3s
sudo systemctl status k3s
sudo kubectl version
```

### 配置 K3s 国内镜像
修改配置文件
```bash
sudo touch /etc/rancher/k3s/registries.yaml
sudo vim /etc/rancher/k3s/registries.yaml
```
内容如下
```yml
mirrors:
  docker.io:
    endpoint:
      - "https://dockerpull.org"
      - "https://docker.m.daocloud.io"
      - "https://docker.nju.edu.cn"
      - "https://dockerhub.icu"
      - "https://docker.chenby.cn"
      - "https://docker.1panel.live"
      - "https://docker.awsl9527.cn"
      - "https://docker.anyhub.us.kg"
      - "https://dhub.kubesre.xyz"
```
然后重启
```bash
sudo systemctl restart k3s
```
配置确认
```bash
sudo cat /var/lib/rancher/k3s/agent/etc/containerd/certs.d/docker.io/hosts.toml
```

#### 确认

拉取确认
```bash
# 使用 K3s 拉取 hello-world（第一次拉取会等待K3s组件拉取完毕才会执行，所以需要一些时间）
sudo crictl pull hello-world:latest
# K3s 可以看到
sudo crictl images
sudo crictl ps -a
# nerdctl 也可以看到
sudo nerdctl --address=/run/k3s/containerd/containerd.sock --namespace=k8s.io images
sudo nerdctl --address=/run/k3s/containerd/containerd.sock --namespace=k8s.io ps -a

# 使用 nerdctl 拉取 busybox
sudo nerdctl --address=/run/k3s/containerd/containerd.sock --namespace=k8s.io pull busybox:latest
# K3s 可以看到
sudo crictl images
sudo crictl ps -a
# nerdctl 也可以看到
sudo nerdctl --address=/run/k3s/containerd/containerd.sock --namespace=k8s.io images
sudo nerdctl --address=/run/k3s/containerd/containerd.sock --namespace=k8s.io ps -a
```

构建确认
```bash
cd $HOME/workspace/FetchDemo
sudo nerdctl --address=/run/k3s/containerd/containerd.sock --namespace=k8s.io build -t fetchdemo .
# K3s 可以看到
sudo crictl images
sudo crictl ps -a
# nerdctl 也可以看到
sudo nerdctl --address=/run/k3s/containerd/containerd.sock --namespace=k8s.io images
sudo nerdctl --address=/run/k3s/containerd/containerd.sock --namespace=k8s.io ps -a
```

### K3s 部署服务

#### 创建 Deployment

```bash
sudo kubectl apply -f - << 'EOF'
apiVersion: apps/v1
kind: Deployment                #Deployment类型
metadata:
  name: fetchdemo-deployment    #Deployment名称
  labels:                       #标签
    app: fetchdemo-app          #key为app，value为fetchdemo-app
spec:
  replicas: 1                   #创建实例个数
  selector:                     #标签选择器
    matchLabels:
      app: fetchdemo-app        #选择包含标签app:fetchdemo-app的资源
  template:                     #选择或创建的Pod模板
    metadata:
      labels:
        app: fetchdemo-app      #选择包含标签app:fetchdemo-app的Pod
    spec:                       #期望Pod实现的功能（即在pod中部署）
      containers:               #生成container
      - name: fetchdemo-app     #container名称
        image: fetchdemo:latest #镜像
        imagePullPolicy: Never  #镜像拉取策略:从不拉取镜像只使用本地已有的镜像
        ports:
        - containerPort: 9500   #内部服务暴露的端口
EOF
```
部署完 Deployment 之后，会自动创建 ReplicaSet 和 Pod

确认 Deployment, ReplicaSet 和 Pod
```bash
sudo kubectl get deployments
sudo kubectl get rs
sudo kubectl get pods
```

确认 Pod 详细信息
```bash
# 获取 Pod 名称，将其存储到环境变量 POD_NAME 中
export POD_NAME=$(sudo kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')

sudo kubectl describe pods $POD_NAME
```
可以看到有一个Pod 被创建出来，IP地址为 ``10.42.0.xx``  
这个IP地址只允许被 ``Kubenetes 内部环境``所访问，外网不能正常访问
```bash
# 在server节点访问
curl http://10.42.0.xx:9500
```
为了公开到集群外部，我们需要创建 ``Service``

另外，如果是通过 Deployment 部署的服务，正确的删除方式应该是：``先删除Deployment，再删除Pod``

#### 创建 Service

```bash
sudo kubectl apply -f - << 'EOF'
apiVersion: v1
kind: Service                   #Service类型
metadata:
  name: fetchdemo-service       #服务名称
spec:
  type: NodePort                #NodePort类型
  selector:                     #标签选择器
    app: fetchdemo-app          #选择包含标签app:fetchdemo-app的Deployment
  ports:                        #暴露的端口
  - protocol: TCP               #TCP协议
    port: 9500                  #Kubenetes内部环境可访问的端口
    targetPort: 9500            #容器内服务的端口
    nodePort: 31000             #对外服务端口(default: 30000-32767)
EOF
```
- ``port`` : Kubenetes 内部环境可访问的端口
- ``targetPort`` : 容器内服务的端口
- ``nodePort`` : 外部环境可访问，但Kubenetes内部环境不能访问的端口

确认 Service
```bash
sudo kubectl get services
sudo kubectl describe services fetchdemo-service
```

确认 Service 详细信息
```bash
# 获取 Node 端口，将其存储到环境变量 NODE_PORT 中
export NODE_PORT="$(sudo kubectl get services/fetchdemo-service -o go-template='{{(index .spec.ports 0).nodePort}}')"

# K3s外部访问
curl http://"$(k3s ip):$NODE_PORT"
```

### 常用 K3s 命令

#### Node
 - 获取节点(Node)信息：``kubectl get nodes``

#### Deployments
 - 获取Deployments信息：``kubectl get deployments``
 - 删除Deployments：``kubectl delete deployment {deployment名}``
 - 重启Deployments：``kubectl rollout restart deployment -n``

#### ReplicaSet
 - 获取ReplicaSet信息：``kubectl get rs``

#### Pods
 - 获取Pods信息：``kubectl get pods -A``
 - 排查Pod问题：``kubectl describe pods {podname}``
 - 获取Pods日志：``kubectl logs {podname}``
 - 删除Pods：``kubectl delete pod {pod名}``

#### 容器
 - 在容器上执行命令：``kubectl exec {podname} -- {命令}``
    - ``kubectl exec {podname} -- env``
    - ``kubectl exec -it {podname} -- bash``

#### Service
 - 获取Service信息：``kubectl get services``
 - 排查Service问题：``kubectl describe services {servicename}``
 - 删除Service：``kubectl delete services {servicename}``

#### NameSpace
 - 获取NameSpace信息：``kubectl get ns``

#### 其他
 - 查看事件：``sudo kubectl get event -A``
 - 列出所有上下文信息：``kubectl config get-contexts``
 - 查看当前的上下文信息：``kubectl config current-context``
 - 查看API版本：``sudo kubectl api-versions``
