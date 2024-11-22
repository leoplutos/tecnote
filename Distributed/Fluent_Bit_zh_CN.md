# Fluent Bit

## 简介

Fluent Bit 是一个高性能的日志收集和处理工具，特别适合用于边缘设备，致力于建设统一的日志采集层，简化用户的数据接入体验。

支持 ``Docker``，``Kubernetes``，``AWS容器`` 等

## 下载安装
 - [官网](https://docs.fluentbit.io/manual)
 - [Github](https://github.com/fluent/fluent-bit)

默认端口
 - ``24224``

## Docker 部署
 - [docker hub仓库](https://hub.docker.com/r/fluent/fluent-bit/)

拉取镜像
```bash
docker pull fluent/fluent-bit
# 调式用镜像
# docker pull fluent/fluent-bit:3.1.9-debug
```

简单的测试示例  
先启动 fluent-bit 监听  
参考资料: [fluent-bit 命令行](https://docs.fluentbit.io/manual/administration/configuring-fluent-bit)  
```bash
# 启动容器监听24224端口，直接运行二进制
# 参数含义
# -i:指定输入 Forward输入插件
# -o:指定输出 控制台
# -p:指定属性 格式为json_lines（可设定msgpack, json, json_lines, json_stream）
# -p:指定属性 日期格式为2018-05-30 09:39:52.000681
# -f:刷新超时1秒
docker run --rm \
  -p 24224:24224 \
  --name fluent_bit \
  fluent/fluent-bit \
  /fluent-bit/bin/fluent-bit \
  -i forward \
  -o stdout \
  -p format=json_lines \
  -p json_date_format=java_sql_timestamp \
  -f 1
```

再启动一个 debian 测试容器  
参考资料: [Fluentd 日志驱动](https://docs.docker.com/engine/logging/drivers/fluentd/)  
参考资料: [设定日志驱动](https://docs.docker.com/engine/logging/configure/)  
```bash
# --log-driver参数用于指定日志驱动，该驱动决定了容器的日志将如何处理和存储
# 指定为 fluentd 为使用fluent-bit的Forward输入插件
docker run -t --rm \
  --name debian_echo \
  --log-driver=fluentd \
  debian:bookworm-slim \
  echo "测试打印一条消息"
```
注意，容器启动时要加 ``--log-driver=fluentd``

然后再 fluent_bit 容器的控制台即可看到结果

## 实战

在Docker环境下将微服务的所有日志通过 ``Fluent Bit`` 采集，输出给 [Grafana Loki](https://grafana.com/docs/loki/latest/) 存储和可视化

- [Fluent Bit](https://docs.fluentbit.io/manual) : 负责日志采集
- [Loki](https://grafana.org.cn/docs/loki/latest/) : 负责存储日志和处理查询
- [Grafana](https://grafana.com/zh-cn/grafana/) : 用于可视化

### 镜像准备
```bash
# fluent-bit
docker pull fluent/fluent-bit
# Loki
docker pull grafana/loki:3.1.2
# Grafana
docker pull grafana/grafana:11.3.0
```

### 准备配置文件

#### fluent-bit 配置文件

参考资料: [Fluentd设置 YAML模式](https://docs.fluentbit.io/manual/administration/configuring-fluent-bit/yaml)  
参考资料: [Fluentd设置 经典模式](https://docs.fluentbit.io/manual/administration/configuring-fluent-bit/classic-mode)  

```bash
mkdir -p $HOME/workspace/log_monitoring
cd $HOME/workspace/log_monitoring
touch fluent-bit.conf
touch parsers_json.conf
```
修改全局设定文件
```bash
vim fluent-bit.conf
```
内容如下
```text
[SERVICE]
    # 引用解析器文件
    Parsers_file      /fluent-bit/etc/parsers_json.conf

# 输入源为Forward输入插件
[INPUT]
    Name              forward
    Listen            0.0.0.0
    Port              24224

# 因为 log 字段是一个 JSON 字符串而不是 JSON 对象，需要使用 Fluent Bit 的 Parser 过滤器来解析这个嵌套的 JSON 字符串
# 解析 log 字段，使用 json_parser 解析器,保留原始数据
[FILTER]
    Name              parser
    Match             **
    Key_Name          log
    Parser            json_parser
    Reserve_Data      On

#[OUTPUT]
#    Name              stdout
#    Match             **
[OUTPUT]
    Name              loki
    Match             **
    Host              host.docker.internal
    Port              3100
    Remove_keys       source
    Labels            agent=Fluent-Bit
    label_keys        $container_name, $service_name
```
修改解析器文件
```bash
vim parsers_json.conf
```
内容如下
```text
[PARSER]
    Name         json_parser
    Format       json
    Time_Key     time
    Time_Format  %d/%b/%Y:%H:%M:%S %z
```

启动容器
```bash
docker run -d \
  -p 24224:24224 \
  --name fluent_bit \
  -v $HOME/workspace/log_monitoring/fluent-bit.conf:/fluent-bit/etc/fluent-bit.conf \
  -v $HOME/workspace/log_monitoring/parsers_json.conf:/fluent-bit/etc/parsers_json.conf \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --add-host=host.docker.internal:host-gateway \
  fluent/fluent-bit
```

#### Loki 配置文件

可以在官方配置文件 [loki-local-config.yaml](https://raw.githubusercontent.com/grafana/loki/v3.0.0/cmd/loki/loki-local-config.yaml) 基础上修改  

```bash
mkdir -p $HOME/workspace/log_monitoring
cd $HOME/workspace/log_monitoring
curl -Lo loki-config.yaml "https://raw.githubusercontent.com/grafana/loki/v3.0.0/cmd/loki/loki-local-config.yaml"
```

为了方便演示，笔者不设定配置文件直接使用默认设置启动

启动容器
```bash
docker run -d \
  -p 3100:3100 \
  --name loki \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --add-host=host.docker.internal:host-gateway \
  grafana/loki:3.1.2
```

使用配置文件启动容器的方式
```bash
# docker run -d \
#  -p 3100:3100 \
#  --name loki \
#  -v $HOME/workspace/log_monitoring/loki-config.yaml:/mnt/config/loki-config.yaml \
#  -v /etc/timezone:/etc/timezone:ro \
#  -v /etc/localtime:/etc/localtime:ro \
#  --add-host=host.docker.internal:host-gateway \
#  grafana/loki:3.1.2 -config.file=/mnt/config/loki-config.yaml
```

#### Grafana

启动容器
```bash
docker run -d \
  -p 3000:3000 \
  --name grafana \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --add-host=host.docker.internal:host-gateway \
  grafana/grafana:11.3.0
```
Grafana 第一次启动需要一些时间，可以看日志确认

### 访问 Grafana   

等待 Docker 容器启动成功  
访问 http://localhost:3000  
默认用户名和密码为 ``admin/admin ``

#### 在 Grafana 中配置 Loki 数据源
1. 登录到 Grafana
2. 点击左侧菜单中的 ``Connections``
3. 点击 ``Add new connection``
4. 选择 ``Loki``，选择右上角的 ``Add new data source``
5. 在 ``Connection`` 部分，将 ``URL`` 设置为 ``http://host.docker.internal:3100``
6. 点击 ``Save & Test ``验证设置是否成功

### 确认日志采集
笔者的这个设定适合结构化日志的采集，假设应用输出的日志为
```json
{
	"instant": {
		"epochSecond": 1730078975,
		"nanoOfSecond": 405572800
	},
	"thread": "javagrpc.main.ServerMain.main()",
	"level": "INFO",
	"loggerName": "javagrpc.main.ServerMain",
	"message": "输出结构化日志示例123",
	"endOfBatch": false,
	"loggerFqcn": "org.apache.logging.log4j.spi.AbstractLogger",
	"threadId": 31,
	"threadPriority": 5,
	"service_name": "JavaGrpcService"
}
```
模拟此日志输出
```bash
docker run -t --rm \
  --name debian_echo \
  --log-driver=fluentd \
  debian:bookworm-slim \
  echo '{"instant":{"epochSecond":1730078975,"nanoOfSecond":405572800},"thread":"javagrpc.main.ServerMain.main()","level":"INFO","loggerName":"javagrpc.main.ServerMain","message":"输出结构化日志示例123","endOfBatch":false,"loggerFqcn":"org.apache.logging.log4j.spi.AbstractLogger","threadId":31,"threadPriority":5,"service_name":"JavaGrpcService"}'
```
注意，容器启动时要加 ``--log-driver=fluentd``

在 ``Grafana`` 页面即可看到日志采集  
笔者设定了3个 ``Label``
- ``agent`` : 固定值 ``Fluent-Bit``
- ``container_name`` : 容器名（由log-driver提供）
- ``service_name`` : 微服务名（在应用的日志里自定义）

### 已适配的示例

以下示例工程全部采用 json 结构化日志

- Java : [JavaGrpc](../Go/Grpc/java/) 的服务端，使用 ``log4j2``

```bash
docker run -itd \
  -p 50056:50056 \
  -e "GRPC_SERVER_RESOLVE=false" \
  -e "GRPC_SERVER_HTTP_PORTS=50056" \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --name java_grpc_50056 \
  --log-driver=fluentd \
  java_grpc:latest
```

- .NET Core : [NetcoreGrpc](../Go/Grpc/netcore/) 的服务端，使用 ``Serilog``
```bash
docker run -itd \
  -p 50055:50055 \
  -e ASPNETCORE_ENVIRONMENT=Docker \
  -e ASPNETCORE_HTTP_PORTS=50055 \
  -e GRPC_SERVER_RESOLVE=false \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --name dotnet_grpc_50055 \
  --log-driver=fluentd \
  dotnet_grpc:latest
```

- Golang : [GoGrpc](../Go/Grpc/go/) 的服务端，使用 ``zerolog``
```bash
docker run -itd \
  -p 50054:50051 \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --name go_grpc_50054 \
  --log-driver=fluentd \
  go_grpc:latest
```

- Rust : [rust_grpc](../Go/Grpc/rust/) 的服务端，使用 ``tracing``
```bash
docker run -itd \
  -p 50053:50051 \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --name rust_grpc_50053 \
  --log-driver=fluentd \
  rust_grpc:latest
```

- Node.js : [node_grpc](../Go/Grpc/node/) 的服务端，使用 ``pino``
```bash
docker run -itd \
  -p 50052:50051 \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --name node_grpc_50052 \
  --log-driver=fluentd \
  node_grpc:latest
```

- Python : [PythonGrpc](../Go/Grpc/python/) 的服务端，使用 ``loguru``
```bash
docker run -itd \
  -p 50051:50051 \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --name python_grpc_50051 \
  --log-driver=fluentd \
  python_grpc:latest
```
