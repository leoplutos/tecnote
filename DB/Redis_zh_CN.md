# Redis

## 简介
在我们日常的开发中，无不都是使用数据库来进行数据的存储，由于一般的系统任务中通常不会存在高并发的情况，所以这样看起来并没有什么问题，可是一旦涉及大数据量的需求，比如一些商品抢购的情景，或者是主页访问量瞬间较大的时候，单一使用数据库来保存数据的系统会因为面向磁盘，磁盘读/写速度比较慢的问题而存在严重的性能弊端，一瞬间成千上万的请求到来，需要系统在极短的时间内完成成千上万次的读/写操作，这个时候往往不是数据库能够承受的，极其容易造成数据库系统瘫痪，最终导致服务宕机的严重生产问题。
为了克服上述的问题，Web项目通常会引入NoSQL技术，这是一种基于内存的数据库，并且提供一定的持久化功能。

``Redis`` 和 ``MongoDB`` 是当前使用最广泛的NoSQL，而就Redis技术而言，它的性能十分优越，可以支持每秒十几万此的读/写操作，其性能远超数据库，并且还支持集群、分布式、主从同步等配置，原则上可以无限扩展，让更多的数据存储在内存中，更让人欣慰的是它还支持一定的事务能力，这保证了高并发的场景下数据的安全和一致性。

## 什么场景下需要使用Redis
一般而言在使用 Redis 进行存储的时候，我们需要从以下几个方面来考虑：

- **业务数据常用吗？命中率如何？** 如果命中率很低，就没有必要写入缓存
- **该业务数据是读操作多，还是写操作多？** 如果写操作多，频繁需要写入数据库，也没有必要使用缓存
- **业务数据大小如何？** 如果要存储几百兆字节的文件，会给缓存带来很大的压力，这样也没有必要

## 使用 Redis 作为缓存的读取逻辑
- 当第一次读取数据的时候，读取 Redis 的数据就会失败，此时就会触发程序读取数据库，把数据读取出来，并且写入 Redis 中
- 当第二次以及以后需要读取数据时，就会直接读取 Redis，读到数据后就结束了流程，这样速度就大大提高了

## 下载安装
 - [官网](https://redis.io/)
 - [Github](https://github.com/tporadowski/redis)

#### Windows
直接去Github下载二进制使用即可，笔者使用的版本为 ``Redis-x64-5.0.14.1.zip``  
配置文件为同路径下的 ``redis.windows.conf``

#### Linux
```
sudo apt install lsb-release curl gpg
curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list
sudo apt update
sudo apt install redis
```
配置文件为 ``redis.conf``

#### 运行服务端
```
redis-server
```

#### 运行客户端
连接到本机
```
redis-cli
或者
redis-cli -h 127.0.0.1 -p 6379
```
连接到远程机
```
redis-cli -h 170.1.1.1 -p 6379 -a "mypassword"
```

## 数据类型
Redis支持五种数据类型：
 - string（字符串）
 - hash（哈希）
 - list（列表）
 - set（集合）
 - zset(sorted set：有序集合)

## Java下的用法
可以看 [这里](https://zhuanlan.zhihu.com/p/37982685)

## Python下的用法
可以看 [这里](https://zhuanlan.zhihu.com/p/374381314)
