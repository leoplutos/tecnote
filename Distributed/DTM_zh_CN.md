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
  yedf/dtm:latest
```

启动后访问 http://localhost:36789/ 即可打卡后台管理画面

## 多语言支持

已支持 ``go``, ``php``, ``dotnet``, ``python``, ``java``, ``node``  
更多参考 [官网](https://dtm.pub/ref/sdk.html#%E6%94%AF%E6%8C%81%E7%9A%84%E8%AF%AD%E8%A8%80)

## 一些 gPRC 的官方示例

- [Golang gRPC](https://github.com/dtm-labs/dtm-examples/tree/main/examples)
- [C# gRPC](https://github.com/dtm-labs/dtmgrpc-csharp)
- [Node.js gRPC](https://github.com/dtm-labs/dtmgrpc-node)

## 实战

笔者使用 dotnet, java, go 来进行一个演示，使用 ``gRPC`` 的微服务，``Saga`` 模式

### 示例场景

模拟跨行转账  

- ``资金转出``  
    从银行 A 将资金转出，采用 ``java`` 编写，包含以下 2 个函数
    - ``TransferOut()`` : 资金转出
    - ``TransferOutRollback()`` : 资金转出回滚

- ``资金转入``  
    银行 B 接受资金转入，采用 ``dotnet`` 编写，包含以下 2 个函数
    - ``TransferIn()`` : 资金转入
    - ``TransferInRollback()`` : 资金转入回滚

- ``请求客户端``  
    事务控制者，采用 ``go`` 编写

其他待补充
