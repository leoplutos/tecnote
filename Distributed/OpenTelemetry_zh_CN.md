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

分布式追踪的核心概念是 ``Trace`` 和 ``Span``，一个 Trace 由多个 Span 组成，每个 Span 代表一个请求或者操作

## Metrics（指标/度量）
属性: ``聚合``  
度量关注事件的聚合，当达到一定指标我们会设置告警，会设置自适应机制，会有容灾等等  
例如CPU使用率、内存使用率、网络流量、请求数，函数调用次数等，用于统计请求QPS是多少，或者当天的用户登录次数是多少等等  
``可聚合性`` 即是 Metrics 的特征

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
 - ``OTEL 采集器`` : OpenTelemetry Collector
 - ``Traces 后端`` : 例如 Jaeger、Grafana Tempo
 - ``Metrics 后端`` : 例如 Prometheus
 - ``可视化`` : 例如 Grafana

Traces 采集可视化常见的组合
 - OpenTelemetry Collector（负责采集Traces） + [Jaeger](https://www.jaegertracing.io/)（Traces 后端） + [Grafana](https://grafana.com/zh-cn/grafana/)（可视化）
 - OpenTelemetry Collector（负责采集Traces） + [Tempo](https://grafana.com/docs/tempo/latest/)（Traces 后端） + [Grafana](https://grafana.com/zh-cn/grafana/)（可视化）

Metrics 采集可视化常见的组合
 - OpenTelemetry Collector（负责采集Metrics） + [Prometheus](https://prometheus.io/docs/introduction/overview/)（Metrics 后端） + [Grafana](https://grafana.com/zh-cn/grafana/)（可视化）

## 官方Demo
 - [官网](https://opentelemetry.opendocs.io/docs/demo/)
 - [Github](https://github.com/open-telemetry/opentelemetry-demo)
 - [Demo示例架构](https://opentelemetry.opendocs.io/docs/demo/architecture/)

## 实战
待补充

## 其他

### 测试用镜像
Grafana 提供了一个 Docker 镜像 ``grafana/otel-lgtm``，包含基于 OpenTelemetry Collector、Prometheus、Loki、Tempo 和 Grafana 的预配置 OpenTelemetry 后端

- [DockerHub](https://hub.docker.com/r/grafana/otel-lgtm/tags)
- [GitHub](https://github.com/grafana/docker-otel-lgtm/)
- [官方文档](https://grafana.com/blog/2024/03/13/an-opentelemetry-backend-in-a-docker-image-introducing-grafana/otel-lgtm/)
