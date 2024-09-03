# gRPC服务发现

## 简介
随着微服务的流行，``服务发现`` 已经是必不可少的功能，虽然 gRPC 并没有内置服务发现功能，但是它提供了相关接口让我们扩展  
笔者使用 ``Etcd`` 作为 ``服务注册中心`` 来进行一个示例

## 服务发现原理

gPRC 官方的 [服务发现指南](https://grpc.io/docs/guides/custom-name-resolution/)

### gRPC 官方定义的 URI

在实际动手之前，有必要了解一下 [gRPC Name Resolution](https://github.com/grpc/grpc/blob/master/doc/naming.md)，它定义了 gRPC 的 URI 格式  

```
dns:[//authority/]host[:port]
```

举个例子：``dns://127.0.0.1/grpc.com``，其中：

- ``Scheme``：dns
- ``Authority``：127.0.0.1
- ``Endpoint``：grpc.com

表示通过 ``dns`` 服务器 ``127.0.0.1`` 查询 ``grpc.com`` 有哪些节点

### 本示例使用的 URI

既然我们要支持 ``Etcd``，那么我们首先要想好 Etcd 对应的 URI 应该是什么样的  
笔者使用如下的 URI
- ``Scheme``：etcd
- ``Authority``：留空（为了避免太臃肿）
- ``Endpoint``：/service/grpc

既
```
etcd:///service/grpc
```

### 服务注册发现流程

#### 服务端启动时
1. 在 Etcd 里通过租约注册键为 ``/service/grpc/uuid_a`` 并且值为``http://ipaddress:port`` 的数据
2. 为租约``KeepAlive``（定期发送心跳包），一旦节点退出会注销相关数据

#### 客户端启动时
1. 注册自己写的服务发现Provider ``EtcdNameResolverProvider``
2. 在 ``EtcdNameResolverProvider`` 中找到 ``Scheme`` 和 ``NameResolver``
3. 最后，负载均衡会挑选出一个节点来提供服务

### Java语言的接口

 - [EtcdNameResolver.java](./Grpc/java/src/main/java/javagrpc/grpc/lb/EtcdNameResolver.java)

    里面重写了 start 和 refresh 方法，这两个方法都调用一个 resolve 方法做服务发现。  
    resovle 方法内部通过 Etcd 的 前缀查询 拉取服务实例列表，然后调用 Listener 的 onResult方法，将实例列表传递给 LoadBalancer，完成服务解析。  
    在服务运行期间，因为实例可能会发生变化，通过 Etcd 的 Watch 功能监听变更，回调触发。  

 - [EtcdNameResolverProvider.java](./Grpc/java/src/main/java/javagrpc/grpc/lb/EtcdNameResolverProvider.java)

    NameResolverProvider 主要用于注册 NameResolver，可以设置默认的协议，是否可用，优先级等。  
    优先级有效值是 0-10，gRPC 默认的 DnsNameResolver 优先级是5，所以自定义的优先级要大于5。  

### .NET Core语言的接口

 - [EtcdResolver.cs](./Grpc/netcore/netcoreClient/Resolvers/EtcdResolver.cs)

    里面重写了 ResolveAsync 方法，做服务发现。  
    在构造函数中通过 Etcd 的 前缀查询 拉取服务实例列表，然后调用 ``Listener(ResolverResult.ForResult）``，将实例列表传递给 LoadBalancer，完成服务解析。  
    在服务运行期间，因为实例可能会发生变化，通过 Etcd 的 Watch 功能监听变更，回调触发。  

 - [EtcdResolverFactory.cs](./Grpc/netcore/netcoreClient/Resolvers/EtcdResolverFactory.cs)

    主要用于注册 Resolver，可以设置默认的协议

## 实战

笔者将 ``Java``，``.NET Core`` 的2个工程，以及 ``Etcd`` 分别如下部署

### Etcd 部署到 Docker 容器内
参考 [这里](../Distributed/Etcd_zh_CN.md.md)

### Java 服务端 部署到 Docker 容器内

部署端口 ``50051`` 和 ``50052``

```bash
docker run -itd \
  -p 50051:50051 \
  -e "JAVA_ENVIRONMENT=docker" \
  -e "GRPC_SERVER_RESOLVE=true" \
  -e "GRPC_SERVER_HTTP_PORTS=50051" \
  --add-host=host.docker.internal:host-gateway \
  --name grpc_50051 \
  java_grpc:1.0.0
```

```bash
docker run -itd \
  -p 50052:50052 \
  -e "JAVA_ENVIRONMENT=docker" \
  -e "GRPC_SERVER_RESOLVE=true" \
  -e "GRPC_SERVER_HTTP_PORTS=50052" \
  --add-host=host.docker.internal:host-gateway \
  --name grpc_50052 \
  java_grpc:1.0.0
```

### .NET Core 服务端 部署到 Docker 容器内

部署端口 ``50053`` 和 ``50054``

```bash
docker run -itd \
  -p 50053:50053 \
  -e ASPNETCORE_ENVIRONMENT=Docker \
  -e ASPNETCORE_HTTP_PORTS=50053 \
  -e GRPC_SERVER_RESOLVE=true \
  --add-host=host.docker.internal:host-gateway \
  --name grpc_50053 \
  dotnet_grpc:1.0.0
```

```bash
docker run -itd \
  -p 50054:50054 \
  -e ASPNETCORE_ENVIRONMENT=Docker \
  -e ASPNETCORE_HTTP_PORTS=50054 \
  -e GRPC_SERVER_RESOLVE=true \
  --add-host=host.docker.internal:host-gateway \
  --name grpc_50054 \
  dotnet_grpc:1.0.0
```

### 启动 Java 客户端
```bash
set GRPC_SERVER_RESOLVE=true
mvn exec:java -Dexec.mainClass="javagrpc.main.ClientMain"
```
然后 停止容器 → 开启容器 即可看到效果

### 启动 .NET Core 客户端
```bash
set GRPC_SERVER_RESOLVE=true
dotnet run --project netcoreClient -- Sync
```
然后 停止容器 → 开启容器 即可看到效果
