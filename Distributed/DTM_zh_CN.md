# DTM

## 简介

DTM 即 ``Distributed Transactions Manager`` 是 ``分布式事务管理`` 的意思

DTM 是一个分布式事务框架，可提供跨服务的最终数据一致性。它为各种应用程序场景提供 ``saga``、``tcc``、``xa``、``2 阶段消息``、``发件箱``、``工作流模式``。它还支持多种语言和多个 store 引擎来形成交易

## 下载安装
 - [官网](https://dtm.pub/)
 - [Github](https://github.com/dtm-labs/dtm)

DTM 默认端口
 - ``36789``： HTTP 端口
 - ``36790``： gRPC 端口

## Docker 部署

```bash
# 拉取镜像
docker pull yedf/dtm:latest

# 启动容器
docker run -itd \
  -e STORE_DRIVER=boltdb \
  -p 36789:36789 -p 36790:36790 \
  --name dtm \
  --add-host=host.docker.internal:host-gateway \
  yedf/dtm:latest
```

使用 ``boltdb``（一个嵌入式数据库）, 并且将宿主机的IP地址映射到 ``host.docker.internal`` 主机名

启动后访问 http://localhost:36789/ 即可打开后台管理画面

## 多语言支持

已支持 ``go``, ``php``, ``dotnet``, ``python``, ``java``, ``node``  
更多参考 [官网](https://dtm.pub/ref/sdk.html#%E6%94%AF%E6%8C%81%E7%9A%84%E8%AF%AD%E8%A8%80)

## 一些 gPRC 的官方示例

- [Golang gRPC](https://github.com/dtm-labs/dtm-examples/tree/main/examples)
- [C# gRPC](https://github.com/dtm-labs/dtmgrpc-csharp)
- [Node.js gRPC](https://github.com/dtm-labs/dtmgrpc-node)
- [Java](https://github.com/dtm-labs/dtmcli-java-sample)&nbsp;&nbsp;&nbsp;&nbsp;※很遗憾 Java 还不支持 gRPC，详见 [这里](https://github.com/dtm-labs/dtmcli-java/issues/28)

## 实战

笔者使用 ``gRPC`` 的分布式微服务，``Saga`` 模式，来进行一个事务控制示例

### 示例场景

模拟跨行转账  

- ``接口定义``  
    [DisTrans.proto](../Go/Grpc/java/src/main/proto/DisTrans.proto)

- ``资金转出``  
    从银行 A 将资金转出，采用 ``java`` 编写，包含以下 2 个微服务
    - ``transferOut()`` : 资金转出
    - ``transferOutRollback()`` : 资金转出回滚
    - [实现代码](../Go/Grpc/java/src/main/java/javagrpc/service/TransferInServiceImpl.java)  

- ``资金转入``  
    银行 B 接受资金转入，采用 ``dotnet`` 编写，包含以下 2 个微服务
    - ``transferIn()`` : 资金转入
    - ``transferInRollback()`` : 资金转入回滚
    - [实现代码](../Go/Grpc/netcore/netcoreServer/Services/TransferOutService.cs)  

### 服务部署

将 ``dtm``，``资金转出`` 微服务，``资金转入`` 微服务 部署到 Docker

- ``dtm``  
    同上

- ``资金转出`` 微服务 [JavaGrpc](../Go/Grpc/java/)  
```bash
docker run -itd \
  -p 50051:50051 \
  -e "GRPC_SERVER_RESOLVE=false" \
  -e "GRPC_SERVER_HTTP_PORTS=50051" \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --name java_grpc_50051 \
  java_grpc:1.0.0
```

- ``资金转入`` 微服务 [NetcoreGrpc](../Go/Grpc/netcore/)  
```bash
docker run -itd \
  -p 50052:50052 \
  -e ASPNETCORE_ENVIRONMENT=Docker \
  -e ASPNETCORE_HTTP_PORTS=50052 \
  -e GRPC_SERVER_RESOLVE=false \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --name dotnet_grpc_50052 \
  dotnet_grpc:1.0.0
```

### Dtm调用示例

调用链为：  
``Dtm客户端`` → ``Dtm服务器`` → ``微服务``  
其中 ``Dtm服务器`` 会调用各个 ``微服务`` 并且会控制事务

- [dotnet客户端实现代码](../Go/Grpc/netcore/netcoreClient/Clients/DtmClientAsync.cs)  
- [golang客户端实现代码](../Go/Grpc/go/product/dtm/main.go)  


调用后访问 http://localhost:36789/  
在 ``Global Transactions`` → ``All Transactions`` 下，可以看到每个事务的结果
