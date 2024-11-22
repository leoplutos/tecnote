# OpenTelemetry

## 什么是可观测性

可观测性（Observability）是一种软件开发和系统构建的哲学，是对系统内部状态及行为的度量和推断能力，通常包括日志、指标、链路追踪等多个度量维度。也就是说，在软件开发和运维领域中，可观测性是指对于一个复杂的系统，能够通过监控、日志、指标、追踪等手段，快速地发现、诊断、解决问题的能力。

## OpenTelemetry简介

``OpenTelemetry`` 也被称为 ``OTel``。是 CNCF 的一个可观测性项目，旨在提供可观测性领域的标准化方案，解决观测数据的数据模型、采集、处理、导出等的标准化问题，提供与三方 vendor 无关的服务。 OpenTelemetry 是一组标准和工具的集合，旨在管理观测类数据，如 ``Traces``、``Metrics``、``Logs`` 等。目前已经是业内的标准。

[OpenTelemetry官网](https://opentelemetry.io/)

## 观测类数据

### Traces（追踪）
属性: ``请求范围``  
追踪关注请求的质量和服务可行性，是我们优化系统，排查问题的高阶方法  
跟踪请求在系统中的传播路径（调用链），记录请求的处理时间和状态，以及请求经过的组件和服务。分布式追踪可以帮助开发人员了解系统的运行情况，识别瓶颈并进行优化  

分布式追踪的核心概念是 ``Trace（追踪）`` 和 ``Span（跨度）``，一个 Trace 由多个 Span 组成，每个 Span 代表一个请求或者操作

## Metrics（指标/度量）
属性: ``聚合``  
度量关注事件的聚合，当达到一定指标我们会设置告警，会设置自适应机制，会有容灾等等  
例如CPU使用率、内存使用率、网络流量、请求数，函数调用次数等，用于统计请求QPS是多少，或者当天的用户登录次数是多少等等  
``可聚合性`` 即是 Metrics 的特征

OpenTelemetry 中的 Metrics 定义有以下几种类型
- ``Counter(计数器)``：单调递增计数器，比如可以用来记录订单数、总的请求数。
- ``UpDownCounter(计数器)``：与 Counter 类似，只不过它可以递减。
- ``Gauge(轨距)``：用于记录随时在变化的值，比如内存使用量、CPU 使用量等。
- ``Histogram(直方图)``：通常用于记录请求延迟、响应时间等。

### Logs（日志）
属性: ``信息``  
日志记录处理的离散事件，比如我们应用的调试信息或者错误信息，事件发生的时间、位置、原因，这些信息是我们问题排查，取证的一些依据

## OpenTelemetry术语

 - ``OpenTelemetry API`` ：是一个编程接口，您可以使用它来检测代码以收集遥测数据，如跟踪、指标和日志。
 - ``OpenTelemetry SDK``：是OpenTelemetry API的官方实现，用于处理和将收集的遥测数据导出到后端。
 - ``OpenTelemetry Instrumentation``：是流行框架和库的插件，它们使用OpenTelemetry API来记录重要的操作，例如 HTTP 请求、DB查询、日志、错误等。
 - ``OpenTelemetry Collector``：负责收集观测数据，处理观测数据，导出观测数据。是应用程序和后端之间的代理。它接收遥测数据，对其进行转换，然后将数据导出到可以永久存储数据的后端。Collector还可以作为一个代理，从被监视的系统中提取遥测数据，例如，OpenTelemetry Redis或文件系统指标。
 - ``OpenTelemetry Operator``：是一个为了简化 OpenTelemetry 组件在 Kubernetes 环境中的部署和管理而设计的 Kubernetes Operator。
 - ``OTLP Proto``：是SDK和Collector使用的OpenTelemetry协议，用于将数据导出到后端或其他收集器。作为传输协议，OTLP可以使用 gRPC(OTLP/gRPC)或HTTP(OTLP/HTTP)。
 - ``OpenTelemetry Backend``：负责持久化观测数据，即接收、存储和分析 OpenTelemetry 收集的遥测数据。它充当数据的中央存储库或处理管道，允许您聚合、查询、可视化并从应用程序生成的遥测数据中获得见解。
 - ``OpenTelemetry Jaeger``：是OpenTelemetry 生态系统中的一个项目，通常被用作默认的 OpenTelemetry 后端，用于存储、分析和可视化遥测数据。
 - ``Baggage``：是在跨度之间传递的上下文信息,可用于对其他横切关注点进行原型设计。它是一个键值存储，与跟踪中的跨度上下文一起驻留，使值可用于该跟踪中创建的任何跨度。
 - ``Context Propagation上下文传播器``：baggage(span种键值对请求，用户ID、请求ID)，trace context（http headers中编码trace数据，在不同服务间传递数据）。
 - ``Semantic Conventions语义约定``：语义约定定义了描述应用程序使用的常见概念、协议和操作的键和值，语义约定现在位于它们自己的存储库。
 - ``Contrib Packages贡献包``： Contrib 特指由 OpenTelemetry 项目维护的插件和工具的集合；它不涉及在别处托管的第三方插件。可选且独立于 SDK 的插件和检测包称为 Contrib 包，API Contrib 是指完全依赖于 API 的包； SDK Contrib 是指仅依赖于 SDK 的包。
 - ``Tracing Signal分布式追踪``：是一组事件，由单个逻辑操作触发，跨应用程序的各个组件进行整合，分布式跟踪包含跨进程、网络和安全边界的事件。

## 后端
OpenTelemetry 是一个流行的开源项目，用于检测、生成、收集和导出遥测数据，包括指标、日志和跟踪。但是，``OpenTelemetry 不提供监控后端``

实现监控可视化需要组件为
 - ``OpenTelemetry 采集器`` : OpenTelemetry Collector
 - ``Traces 后端`` : 例如 Jaeger、Grafana Tempo
 - ``Metrics 后端`` : 例如 Prometheus
 - ``Logs 后端`` : 例如 Loki
 - ``可视化`` : 例如 Grafana

## 常见的组合

#### Logs 采集
 - [OpenTelemetry Collector](https://opentelemetry.io/docs/collector/)（负责采集Logs） + [Loki](https://grafana.com/docs/loki/latest/)（Logs 后端） + [Grafana](https://grafana.com/zh-cn/grafana/)（可视化）

#### Traces 采集
 - [OpenTelemetry Collector](https://opentelemetry.io/docs/collector/)（负责采集Traces） + [Jaeger](https://www.jaegertracing.io/)（Traces 后端） + [Grafana](https://grafana.com/zh-cn/grafana/)（可视化）

#### Metrics 采集
 - [OpenTelemetry Collector](https://opentelemetry.io/docs/collector/)（负责采集Metrics） + [Prometheus](https://prometheus.io/docs/introduction/overview/)（Metrics 后端） + [Grafana](https://grafana.com/zh-cn/grafana/)（可视化）

### 流程图
![流程图](https://grafana.com/media/docs/grafana-cloud/otlp/grafana-cloud-otlp-architecture-via-otel-collector.png "流程图")

左边是 ``应用程序``，需要进行 ``OTLP导出器`` 的插桩，将内容导出给 ``OpenTelemetry Collector``，``OpenTelemetry Collector``根据设定将内容导出给后端（此图后端为``Grafana Cloud``，在我们的示例中使用其他后端）

## 官方Demo
 - [官网](https://opentelemetry.opendocs.io/docs/demo/)
 - [Github](https://github.com/open-telemetry/opentelemetry-demo)
 - [Demo示例架构](https://opentelemetry.opendocs.io/docs/demo/architecture/)

## 实战

在Docker环境下将微服务的遥测信息通过 ``OTLP导出器`` ，输出给 [OpenTelemetry Collector](https://opentelemetry.io/docs/collector/) ，然后导到后端进行可视化

参考了 [OpenTelemetry Collector 官方Demo](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/examples/demo)

### OpenTelemetry Collector 镜像
- ``core`` : 这仅包含最重要的组件以及经常使用的附加功能，如过滤器和属性处理器，以及流行的导出器，如 Prometheus、Kafka 等
- ``contrib`` : 综合版本，几乎包括 core 和 contrib 存储库中的所有内容，但仍在开发的组件除外
- ``kubernetes`` : 此发行版专为在 Kubernetes 集群中使用而量身定制，用于监控 Kubernetes 基础架构及其中部署的各种服务
- ``OTLP`` : 这是一个最小发行版，仅包含 OpenTelemetry Protocol （OTLP） 接收器和导出器，支持 gRPC 和 HTTP 传输

### 镜像准备
```bash
# OpenTelemetry Collector
# docker pull otel/opentelemetry-collector:latest
docker pull otel/opentelemetry-collector-contrib:latest
# Jaeger
docker pull jaegertracing/all-in-one:latest
# Prometheus
docker pull prom/prometheus:latest
# Grafana
docker pull grafana/grafana:11.3.0
```

### 启动 OpenTelemetry Collector
配置文件准备
```bash
mkdir -p $HOME/workspace/opentelemetry
cd $HOME/workspace/opentelemetry
touch otel-collector-config.yaml
```
修改配置文件
```bash
vim otel-collector-config.yaml
```
内容如下
```yaml
receivers:
  otlp:
    protocols:
      grpc:
        endpoint: 0.0.0.0:4317
      http:
        endpoint: 0.0.0.0:4318

processors:
  batch:

exporters:
  otlp/jaeger:
    endpoint: host.docker.internal:14317
    tls:
      insecure: true
  prometheus:
    endpoint: 0.0.0.0:19090

extensions:
  health_check:

service:
  extensions: [health_check]
  pipelines:
    traces:
      receivers: [otlp]
      processors: [batch]
      exporters: [otlp/jaeger]
    metrics:
      receivers: [otlp]
      processors: [batch]
      exporters: [prometheus]
```
- ``receivers`` : 定义接收器，端口为 gRPC的4317 和 http的4318
- ``processors`` : 定义处理器，batch处理器将跨度、指标或日志分组为基于时间和基于大小的批处理，从而提高效率
- ``exporters`` : 定义导出器，定义了 Jaeger 和 Prometheus 的导出器
- ``pipelines`` : 定义管道，receiver、processor 和 exporter 部分仅定义 collector 将启用的模块。它们仍未被调用。要实际调用/激活它们，必须将它们称为 “pipelines”。管道定义信号如何流经收集器并由收集器处理。

**NOTE:** exporters 定义的的 ``prometheus导出器``，需要指定一个绑定的端口，这里绑定到了 ``0.0.0.0`` 的 ``19090`` 端口，之后再 ``Prometheus`` 容器内会来这个端口 http://localhost:19090/metrics 抓取内容

启动容器
```bash
docker run --rm -d \
  -p 4317:4317 \
  -p 4318:4318 \
  -p 19090:19090 \
  --name otel_collector \
  -v $HOME/workspace/opentelemetry/otel-collector-config.yaml:/etc/otel-collector-config.yaml \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --add-host=host.docker.internal:host-gateway \
  otel/opentelemetry-collector-contrib:latest \
  --config=/etc/otel-collector-config.yaml
```

### 启动 Jaeger

这里使用 ``all-in-one`` 镜像  
Jaeger的 [端口说明](https://www.jaegertracing.io/docs/1.62/getting-started/)

```bash
# 启动容器
docker run --rm -d \
  -p 16686:16686 \
  -p 14317:4317 \
  -e OTEL_TRACES_SAMPLER=always_off \
  --name jaeger \
  --add-host=host.docker.internal:host-gateway \
  jaegertracing/all-in-one:latest
```
为了避免和 OpenTelemetry Collector 的端口冲突，将 4317 映射到了 14317  
16686 为 Jaeger UI 的端口

访问 [Jaeger UI](http://localhost:16686/) 确认

### 启动 Prometheus

配置文件准备
```bash
mkdir -p $HOME/workspace/opentelemetry
cd $HOME/workspace/opentelemetry
touch prometheus.yaml
```
修改配置文件
```bash
vim prometheus.yaml
```
内容如下
```yaml
scrape_configs:
  - job_name: 'otel-collector'
    scrape_interval: 5s
    static_configs:
      - targets: ['host.docker.internal:19090']
```
设定 Prometheus 为每 5 秒轮询一次 19090 端口（OpenTelemetry Collector）以获取指标

```bash
# 启动容器
docker run --rm -d \
  -p 9090:9090 \
  -v $HOME/workspace/opentelemetry/prometheus.yaml:/etc/prometheus/prometheus.yml \
  --add-host=host.docker.internal:host-gateway \
  --name prometheus \
  prom/prometheus:latest \
  --config.file=/etc/prometheus/prometheus.yml
```
9090 为 Prometheus UI 端口  
访问 [Prometheus](http://localhost:9090/) 确认

### 使用程序采集 Traces（追踪）, Metrics（指标/度量）和 Logs（日志）

#### 如何采集Traces（调用链）

在调用链中记录 ``Trace ID`` 和 ``Span ID``  
调用链维持方式：
 - HTTP通信：封装在 ``请求头(Headers)`` 中，在调用链中依次传递
 - gRPC通信：封装在 ``元数据(Metadata)`` 中，在调用链中依次传递

假设有如下的一个调用链
```
●调用链开始（Java客户端）
↓
添加商品（Java服务端）
↓
取得商品（Dotnet服务端）
↓
取得商品（Java服务端）
↓
添加商品（Dotnet服务端）
↓
●调用链结束
```
在调用链最开始 ``Java客户端`` 处生成 ``Trace ID`` 和 ``Span ID`` ，向下依次传递  
然后每个调用链处共用一个 ``Trace ID``，生成各自的 ``Span ID``  

#### 程序的导出器（Exporters）

使用 ``OTLP Exporter``

``应用程序(OTLP导出器)`` → ``OpenTelemetry Collector`` → ``后端(Jaeger、Prometheus)`` → ``可视化(Grafana)``

- [OTLP Exporter 配置](https://opentelemetry.io/docs/languages/sdk-configuration/otlp-exporter/)
- [Java 官方示例](https://github.com/open-telemetry/opentelemetry-java-examples/tree/main/otlp)
- [Dotnet 官方示例](https://github.com/open-telemetry/opentelemetry-dotnet/tree/main/src/OpenTelemetry.Exporter.OpenTelemetryProtocol)

#### 如何采集Metrics（指标/度量）

- Java : [JavaGrpc](../Go/Grpc/java/) 的服务端
    - 使用 ``LongCounter（计数器）`` 和 ``LongHistogram（直方图）`` 进行自定义采集  
    - 参考 [grpc-opentelemetry](https://github.com/grpc/grpc-java/tree/master/examples/example-opentelemetry) 进行 ``gRPC 指标`` 的采集  
    - 使用 [官方的零代码插桩](https://opentelemetry.io/docs/zero-code/java/agent/getting-started/) 进行 ``JVM 指标`` 的采集  

- Dotnet : [NetcoreGrpc](../Go/Grpc/netcore/) 的服务端
    - 使用 ``Counter<long>（计数器）`` 进行自定义采集  
    - 参考 [OpenTelemetry.Instrumentation.AspNetCore](https://github.com/open-telemetry/opentelemetry-dotnet-contrib/blob/main/src/OpenTelemetry.Instrumentation.AspNetCore/README.md) 进行 ``gRPC 指标`` 的采集  

#### 如何采集Logs（日志）
与 Traces 和 Metrics 不同，没有等效的日志API，只有一个SDK  
OTel SDK 将 OTLP 处理程序附加到根记录器

### 可视化

#### 启动 Grafana
```bash
docker run -d \
  -p 3000:3000 \
  --name grafana \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --add-host=host.docker.internal:host-gateway \
  grafana/grafana:11.3.0
```
等待 Docker 容器启动成功  
访问 http://localhost:3000  
默认用户名和密码为 ``admin/admin ``

#### 在 Grafana 中配置 Prometheus 数据源
1. 登录到 Grafana
2. 点击左侧菜单中的 ``Connections``
3. 点击 ``Add new connection``
4. 选择 ``Prometheus``，选择右上角的 ``Add new data source``
5. 在 ``Connection`` 部分，将 ``URL`` 设置为 ``http://host.docker.internal:9090``
6. 点击 ``Save & Test ``验证设置是否成功

#### 在 Grafana 中配置 Jaeger 数据源
1. 登录到 Grafana
2. 点击左侧菜单中的 ``Connections``
3. 点击 ``Add new connection``
4. 选择 ``Jaeger``，选择右上角的 ``Add new data source``
5. 在 ``Connection`` 部分，将 ``URL`` 设置为 ``http://host.docker.internal:16686``
6. 点击 ``Save & Test ``验证设置是否成功

### 在 Grafana 中配置统计

#### 统计 gRPC 吞吐量或 QPS（每秒查询数）
- 客户端: ``rate(grpc_client_call_duration_seconds_count[1m])``
- 服务器: ``rate(grpc_server_call_duration_seconds_count[1m])``

#### 统计 gRPC 错误率
- 客户端: ``sum( increase(grpc_client_call_duration_seconds_count{grpc_status!="OK"}[5m]) ) / sum( increase(grpc_client_call_duration_seconds_count[5m]) )``
- 服务器: ``sum( increase(grpc_server_call_duration_seconds_count{grpc_status!="OK"}[5m]) ) / sum( increase(grpc_server_call_duration_seconds_count[5m]) )``


### 启动程序

#### 启动 gRPC 服务器

- Java : [JavaGrpc](../Go/Grpc/java/) 的服务端

```bash
docker run --rm -d \
  -p 50051:50051 \
  -e "GRPC_SERVER_HTTP_PORTS=50051" \
  -e "GRPC_SERVER_OTEL=true" \
  -e "OTEL_EXPORTER_OTLP_ENDPOINT=http://host.docker.internal:4317" \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --name java_grpc_50051 \
  --add-host=host.docker.internal:host-gateway \
  java_grpc:latest
```

- .NET Core : [NetcoreGrpc](../Go/Grpc/netcore/) 的服务端
```bash
docker run --rm -d \
  -p 50052:50052 \
  -e "ASPNETCORE_HTTP_PORTS=50052" \
  -e "GRPC_SERVER_OTEL=true" \
  -e "OTEL_EXPORTER_OTLP_ENDPOINT=http://host.docker.internal:4317" \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --name dotnet_grpc_50052 \
  --add-host=host.docker.internal:host-gateway \
  dotnet_grpc:latest
```

#### 启动 gRPC 客户端
```bash
cd D:\WorkSpace\Java\JavaGrpc
mvn exec:java -Dexec.mainClass="javagrpc.main.OpenTelemetryMain" -Dexec.cleanupDaemonThreads=false -Dprotoc.skip=true
```

### 确认采集结果
访问 [Grafana](http://localhost:3000) 即可看到采集结果

**官方指标**  
- [gRPC的官方指标](https://grpc.io/docs/guides/opentelemetry-metrics/)  
- [ASP.NET Core 指标](https://learn.microsoft.com/zh-cn/dotnet/core/diagnostics/built-in-metrics-aspnetcore)  

## 其他

### 测试用镜像
Grafana 提供了一个 Docker 镜像 ``grafana/otel-lgtm``，包含基于 OpenTelemetry Collector、Prometheus、Loki、Tempo 和 Grafana 的预配置 OpenTelemetry 后端

- [DockerHub](https://hub.docker.com/r/grafana/otel-lgtm/tags)
- [GitHub](https://github.com/grafana/docker-otel-lgtm/)
- [官方文档](https://grafana.com/blog/2024/03/13/an-opentelemetry-backend-in-a-docker-image-introducing-grafana/otel-lgtm/)
