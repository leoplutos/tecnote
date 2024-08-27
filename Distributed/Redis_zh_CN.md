# Redis

## 简介

在我们日常的开发中，无不都是使用数据库来进行数据的存储，由于一般的系统任务中通常不会存在高并发的情况，所以这样看起来并没有什么问题，可是一旦涉及大数据量的需求，比如一些商品抢购的情景，或者是主页访问量瞬间较大的时候，单一使用数据库来保存数据的系统会因为面向磁盘，磁盘读/写速度比较慢的问题而存在严重的性能弊端，一瞬间成千上万的请求到来，需要系统在极短的时间内完成成千上万次的读/写操作，这个时候往往不是数据库能够承受的，极其容易造成数据库系统瘫痪，最终导致服务宕机的严重生产问题。
为了克服上述的问题，Web项目通常会引入NoSQL技术，这是一种基于内存的数据库，并且提供一定的持久化功能。

``Redis`` 和 ``MongoDB`` 是当前使用最广泛的NoSQL，而就Redis技术而言，它的性能十分优越，可以支持每秒十几万此的读/写操作，其性能远超数据库，并且还支持``集群``、``分布式``、``主从同步``等配置，原则上可以无限扩展，让更多的数据存储在内存中，更让人欣慰的是它还支持一定的事务能力，这保证了高并发的场景下数据的安全和一致性。

Redis 支持执行 ``Lua`` 脚本

Redis 默认端口为 ``6379``

## 下载安装
 - [官网](https://redis.io/)
 - [Github](https://github.com/redis/redis)

### Windows
下载地址  
https://github.com/tporadowski/redis/releases

### Docker
官方镜像tag  
https://github.com/docker-library/docs/tree/master/redis

```bash
# 使用基于BSD开源许可证的版本(<=7.2.4)
docker pull redis:7.0.15-alpine
# docker pull redis:7.0.15-bookworm

# 启动容器
docker run -itd -p 6379:6379 --name redis redis:7.0.15-alpine
```

### Windows运行服务端
```bash
redis-server.exe
```

### Windows运行客户端
连接到本机
```bash
redis-cli
或者
redis-cli -h 127.0.0.1 -p 6379
```
连接到远程机
```bash
redis-cli -h 170.1.1.1 -p 6379 -a "mypassword"
```

### 简单命令确认
在客户端中运行
```bash
# 设定Key
Set myKey "123"
# 取得Key
Get myKey
# 判断Key是否存在
Exists myKey
Exists abcde
# 为Key设置过期时间(10秒)
Expire myKey 10
# 列出所有Key
Keys *
```

## 数据类型
Redis支持五种数据类型：
 - string（字符串）
 - hash（哈希）
 - list（列表）
 - set（集合）
 - zset(sorted set：有序集合)

## Redis 中的 Lua

### 运行 Lua 代码
Redis 中使用 ``Eval`` 命令来直接执行指定的 ``Lua`` 代码
```bash
Eval luascript numkeys key [key ...] arg [arg ...]
```
- ``Eval`` 命令的关键字
- ``luascript`` Lua 代码
- ``numkeys`` 指定的 Lua 需要处理键的数量，其实就是 key 数组的长度
- ``key`` 传递给 Lua 的零到多个键，空格隔开，在 Lua 中通过 ``KEYS[INDEX]`` 来获取对应的值，其中 1 <= INDEX <= numkeys
- ``arg`` 是传递给 Lua 的零到多个附加参数，空格隔开，在 Lua 中通过 ``ARGV[INDEX]`` 来获取对应的值，其中 1 <= INDEX <= numkeys

例子
```bash
Set myKey "123"
Eval "return redis.pcall('GET',KEYS[1])" 1 myKey
Eval "return redis.pcall('GET',KEYS[1])" 1 abcde
```

### 执行 Lua 脚本
Redis 中使用 ``redis-cli --eval`` 命令来执行写好的 ``Lua`` 脚本

脚本 ``D:\WorkSpace\Script\reids_sample.lua`` 内容如下
```lua
--使用lua table来存储日志内容，并把这个日志进行返回
local logtable = {}

--...为可变参数
local function logmsg(...)
  -- 遍历所有传入的参数
  for i = 1, select('#', ...) do
    -- 将每个参数添加到logtable的末尾
    logtable[#logtable + 1] = select(i, ...)
  end
end

--取得Key1
local key = KEYS[1]
--取得参数1
local value = ARGV[1]
logmsg(key)
logmsg(value)
--取得所有Key
for k, v in pairs(KEYS) do
  logmsg(k, v)
end
--取得所有参数
for k, v in pairs(ARGV) do
  logmsg(k, v)
end

return logtable
```

执行命令
```
cd D:\Tools\WorkTool\DB\Redis-x64-5.0.14.1
redis-cli --eval D:\WorkSpace\Script\reids_sample.lua key1 key2 , val1-abc val2-3000
```

## 分布式锁
https://redis.io/docs/latest/develop/use/patterns/distributed-locks/  
官方给了很多第三方库

## 主流语言绑定

### C# / .NET
https://github.com/StackExchange/StackExchange.Redis  
https://www.nuget.org/packages/StackExchange.Redis  

#### 新版 .NET Core 安装依赖
```
dotnet add package StackExchange.Redis
```

#### 旧版 .Net Framework 安装依赖
在工程鼠标右键 → ``管理 NuGet 程序包`` → 将 [StackExchange.Redis](https://www.nuget.org/packages/StackExchange.Redis) 添加为依赖项

示例代码（新旧都可运行）  
[RedisClientExample.cs](../Dotnet/dotnet-core-sample/dotnet-console-sample/Redis/RedisClientExample.cs)

### Node.js
https://github.com/redis/node-redis  

添加依赖
```bash
bun add redis
bun add @types/node --dev
# 选装
bun add uuid
bun add @types/uuid --dev
```

示例代码  
[RedisClientExample.ts](../Web/TSSampleProject/src/components/RedisClientExample.ts)

运行
```bash
bun src\components\RedisClientExample.ts
```

### Java
https://github.com/redis/jedis  
https://github.com/redis/lettuce  

pom.xml添加依赖
```xml
<!-- jedis依赖 -->
<dependency>
    <groupId>redis.clients</groupId>
    <artifactId>jedis</artifactId>
    <version>5.0.0</version>
</dependency>
```

示例代码  
[RedisClientExample.java](../Java/JavaMavenBatProject/src/main/java/my/mavenbatsample/RedisClientExample.java)

### Python
https://github.com/redis/redis-py  

添加依赖
```bash
poetry add "redis[hiredis]"
```

示例代码  
[redis_client_example.py](../Python/PoetryTest/src/poetrytest/sub_module/redis_client_example.py)

### Go
https://github.com/redis/go-redis  

添加依赖
```bash
go get github.com/redis/go-redis/v9
```

示例代码  
[redis_client_example.go](../Go/GoSampleProject/src/redis/redis_client_example.go)

### Rust
https://github.com/redis-rs/redis-rs  

Cargo.toml添加依赖
```toml
[dependencies]
redis = "0.26.1"
```

示例代码  
[redis_client_example.rs](../Rust/rust_sample/src/redis_client_example.rs)
