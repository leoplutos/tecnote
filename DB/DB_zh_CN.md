# 数据库相关

## 数据库主键 UUIDv7

``UUID 版本 7 (UUIDv7)`` 是一种按时间排序的 UUID，它在最高有效 48 位中以毫秒精度对 Unix 时间戳进行编码。与所有 UUID 格式一样，6 位用于指示 UUID 版本和变体。其余 74 位是随机生成的。由于 UUIDv7 是按时间排序的，因此生成的值实际上是连续的，因此消除了DB索引局部性问题。

与 随机前缀的 UUIDv4 相比，UUIDv7 的时间顺序性质可带来更好的数据库性能。

[这篇文章](https://www.enterprisedb.com/blog/sequential-uuid-generators) 对 ``随机前缀的UUIDv4`` 与 ``时间顺序的UUIDv7`` 进行了基准测试，不仅显示了写入性能的改进，而且还显示了读取性能的改进。

``BuildKite`` 也发表了 [文章](https://buildkite.com/resources/blog/goodbye-integers-hello-uuids/) 表示将内部的 Postgres 主键全面更换为 ``UUIDv7``

### 主流语言的 UUIDv7 实现

下面这些第三方库都实现了 ``UUIDv7``, 在 ``.NET 9`` 的标准库中内置了 UUIDv7 的实现，相信将来其他语言也都会跟进  
在笔者的 [gRPC](../Go/Grpc/) 示例工程里使用的也是下面的库

- ``Java`` : [java-uuid-generator](https://github.com/cowtowncoder/java-uuid-generator)
- ``C#`` : [UUIDNext](https://github.com/mareek/UUIDNext)
- ``Golang`` : [google/uuid](https://github.com/google/uuid)
- ``Rust`` : [uuid-rs/uuid](https://github.com/uuid-rs/uuid)
- ``Node/JavaScript`` : [uuidjs/uuid](https://github.com/uuidjs/uuid)
- ``Python`` : [uuid-utils](https://github.com/aminalaee/uuid-utils)

## 数据同步工具AirByte
 - [Github](https://github.com/airbytehq/airbyte)
 - [公众号示例](https://mp.weixin.qq.com/s/n-4symNxeuP2Umiyi1xBMQ)

## 数据库设计工具DrawDB
DrawDB是一款多功能且用户友好的在线工具，允许用户轻松设计数据库实体关系。通过简单直观的界面，DrawDB使用户能够创建图表、导出SQL脚本、自定义编辑环境，而无需创建账户
 - [Github](https://github.com/drawdb-io/drawdb)
 - [在线版本](https://www.drawdb.app/editor)
 - [公众号示例](https://mp.weixin.qq.com/s/9Y6hFg5NVm9BR3r_bmkNqQ)


