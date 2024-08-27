# Etcd

## 简介

``Etcd`` 是 ``CoreOS`` 团队于 2013 年 6 月发起的开源项目，它的目标是构建一个高可用、强一致的分布式键值(key-value)数据库, 用于 ``服务发现``、``共享配置``、``分布式锁``等。

目前已广泛应用在kubernetes、ROOK、CoreDNS、M3以及openstack等领域。

Etcd 默认端口
 - ``2379``： 用于客户端通信
 - ``2380``： 伙伴通讯，用于服务器到服务器通信

## 下载安装
 - [官网](https://etcd.io/)
 - [Github](https://bgithub.xyz/etcd-io/etcd)

### Windows
下载地址  
https://bgithub.xyz/etcd-io/etcd/releases

### Docker

#### etcd 官方维护的镜像地址  
主仓库： gcr.io/etcd-development/etcd  
副仓库： quay.io/coreos/etcd  

#### bitnami 提供的镜像
https://github.com/bitnami/containers/tree/main/bitnami/etcd  

```bash
# 拉取镜像
# docker pull gcr.io/etcd-development/etcd:v3.5.15
docker pull quay.io/coreos/etcd:v3.5.15
# docker pull bitnami/etcd:latest

# 启动容器（bitnami提供的镜像需要其他方式）
docker run -itd \
  -p 2379:2379 -p 2380:2380 \
  --name etcd \
  quay.io/coreos/etcd:v3.5.15 \
  /usr/local/bin/etcd \
  --name s1 \
  --data-dir /etcd-data \
  --listen-client-urls http://0.0.0.0:2379 \
  --advertise-client-urls http://0.0.0.0:2379 \
  --listen-peer-urls http://0.0.0.0:2380 \
  --initial-advertise-peer-urls http://0.0.0.0:2380 \
  --initial-cluster s1=http://0.0.0.0:2380 \
  --initial-cluster-token tkn \
  --initial-cluster-state new \
  --log-level info \
  --logger zap \
  --log-outputs stderr
```

### Windows运行服务端
```bash
etcd.exe
```

### Windows运行客户端（v3）
```bash
# 设置etcdctl为v3版本
# export ETCDCTL_API=3
set ETCDCTL_API=3

# 设置etcd的端点信息，即etcd集群的ip:port，以逗号分隔
# export ENDPOINTS=10.10.10.45:2379,10.10.10.46:2379,10.10.10.47:2379
set ENDPOINTS=localhost:2379

cd D:\Tools\WorkTool\DB\etcd-v3.5.15-windows-amd64
# 服务器状态
etcdctl --endpoints=localhost:2379 --write-out=table endpoint status
etcdctl --write-out=table endpoint status
# 健康检查
etcdctl --write-out=table endpoint health
# 集群列表
etcdctl --write-out=table member list
# 租约列表
etcdctl lease list
```

### 简单命令确认
在客户端中运行（v3）
```bash
# 设定Key（无租约）
etcdctl put /mykey/key1 "123"
etcdctl put /mykey/key2 "456"
etcdctl put /ukey/key1 "abc"
# 取得Key
etcdctl get /mykey/key1
# 取得Key（前缀机制）
etcdctl get /mykey --prefix
# 判断Key是否存在
# 没有直接的命令，通常用get确认

# 创建租约（Lease），为Key设置过期时间
## 新建一个过期时间为120s的租约（这条命令会返回一个leaseID）
etcdctl lease grant 120
## 将租约附加到一个Key上
etcdctl put --lease=<leaseID> /lskey/key1 "will be delete"
## 续租，在租约过期之前续租
etcdctl lease keep-alive <leaseID>

# 列出所有Key
etcdctl get --from-key ''
# 删除Key
etcdctl del /mykey/key1
# 删除所有Key（慎用）
etcdctl del / --prefix
```

## Etcd 特性

### Lease 机制

即租约机制（``TTL``，Time To Live），Etcd 可以为存储的 key-value 对设置租约，当租约到期，key-value 将失效删除；同时也支持续约，通过客户端可以在租约到期之前续约，以避免 key-value 对过期失效；此外，还支持解约，一旦解约，与该租约绑定的 key-value 将失效删除

如果客户端未能及时发送 LeaseKeepAlive 请求，或者客户端与服务器之间的连接中断，那么 Lease 就会过期。当 Lease 过期后， etcd 服务器会自动删除与该 Lease 关联的所有键值对，并触发相应的事件通知。

为了处理Lease过期的情况，客户端可以采取以下策略：

1. ``监听Lease过期事件``：客户端可以监听etcd的事件通知，以便在Lease过期时及时获知。当接收到Lease过期事件时，客户端可以重新创建Lease并恢复之前的键值对。
2. ``使用租约续期机制``：除了定期发送LeaseKeepAlive请求外，客户端还可以设置一个定时器，在Lease即将到期时自动发送续期请求。这样可以确保即使客户端在处理其他任务时忘记发送续期请求，Lease也能被成功续期。
3. ``优雅地处理Lease过期``：在Lease过期后，客户端需要重新创建Lease并恢复之前的键值对。为了避免在Lease过期期间出现数据不一致的情况，客户端可以在重新创建Lease之前先删除与过期Lease关联的键值对。

### Prefix 机制

即前缀机制，也称目录机制，如两个 key 命名如下：``key1="/mykey/key1"`` , ``key2="/mykey/key2"``，那么，可以通过前缀 ``"/mykey"`` 查询，返回包含两个 key-value 对的列表；

### Watch 机制

即监听机制，Watch 机制支持 Watch 某个固定的 key，也支持 Watch 一个范围（前缀机制），当被 Watch 的 key 或范围发生变化，客户端将收到通知；

### Revision 机制
每个 key 带有一个 Revision 号，每进行一次事务加一，因此它是全局唯一的，如初始值为 0，进行一次 put 操作，key 的 Revision 变为 1，同样的操作，再进行一次，Revision 变为 2；换成 key1 进行 put 操作，Revision 将变为 3；这种机制有一个作用：通过 Revision 的大小就可以知道进行写操作的顺序，这对于实现公平锁，队列十分有益。

## 分布式锁

1. 分别在两个窗口执行相同的加锁命令

```bash
etcdctl lock /lock/kv/uuid_a
```

2. 可以观察到，只有一个加锁成功，并返回了实际存储与 Etcd 中 key 值，另一个窗口处在堵塞状态
```bash
etcdctl lock /lock/kv/uuid_a
mylock/3f35917771c16410
```

3. 在加锁成功的窗口执行 ``Ctrl + c`` 释放锁；与此同时，另一个窗口加锁成功

很明显，同样的锁名 ``mylock`` 在两个客户端分别进行加锁操作，实际存储于 Etcd 中的 key 并不是 mylock，而是以 mylock 为前缀，分别加了一个全局唯一的 ID

## 主流语言绑定
官方文档： https://etcd.io/docs/v3.5/integrations/  

下面内容为只针对支持 ``v3`` 的示例

### C# / .NET
https://github.com/shubhamranjan/dotnet-etcd  

#### 新版 .NET Core 安装依赖
```
dotnet add package dotnet-etcd
```

#### 旧版 .Net Framework 安装依赖
菜单栏的 ``工具`` -> ``NuGet 包管理器`` -> ``包管理器控制台``，输入下面的命令安装。因为版本比较旧，所以需要使用版本小于 5.x 的库  
https://www.nuget.org/packages/dotnet-etcd/4.2.0  
```
Install-Package dotnet-etcd -Version 4.2.0
```

示例代码（新旧都可运行）  
[EtcdClientExample.cs](../Dotnet/dotnet-core-sample/dotnet-console-sample/Etcd/EtcdClientExample.cs)

### Node.js
https://github.com/microsoft/etcd3  

添加依赖
```bash
bun add etcd3
```

示例代码  
[EtcdClientExample.ts](../Web/TSSampleProject/src/components/EtcdClientExample.ts)

运行
```bash
bun src/components/EtcdClientExample.ts
```

### Java
https://github.com/etcd-io/jetcd  

pom.xml添加依赖
```xml
<!-- jetcd依赖 -->
<dependency>
	<groupId>io.etcd</groupId>
	<artifactId>jetcd-core</artifactId>
	<version>0.8.3</version>
</dependency>
```

示例代码  
[EtcdClientExample.java](../Java/JavaMavenBatProject/src/main/java/my/mavenbatsample/EtcdClientExample.java)

### Python
~~https://github.com/Revolution1/etcd3-py~~  
https://github.com/kragniz/python-etcd3  

添加依赖
```bash
# 0.12.0的库代码存在问题，作者的github上面的最新版本没有问题，所以添加git为依赖
# 详见此issues: https://github.com/kragniz/python-etcd3/issues/2149
# poetry add git+https://github.com/kragniz/python-etcd3
poetry add git+https://bgithub.xyz/kragniz/python-etcd3
```

示例代码  
[etcd_client_example.py](../Python/PoetryTest/src/poetrytest/sub_module/etcd_client_example.py)

### Go
https://github.com/etcd-io/etcd/tree/main/client/v3  

添加依赖
```bash
go get go.etcd.io/etcd/client/v3
```

示例代码  
[etcd_client_example.go](../Go/GoSampleProject/src/etcd/etcd_client_example.go)

### Rust
https://github.com/etcdv3/etcd-client  

Cargo.toml添加依赖
```toml
[dependencies]
etcd-client = "0.14"
tokio = { version = "1.0", features = ["full"] }
```

示例代码  
[etcd_client_example.rs](../Rust/rust_sample/src/etcd_client_example.rs)
