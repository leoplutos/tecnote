# Sqlite3

## 简介
SQLite 是一个开源、轻量级的 ``SQL`` 嵌入式数据库  
SQLite 实现了自给自足的、无服务器的、零配置的、事务性的 SQL 数据库引擎  
SQLite 是在世界上最广泛部署的 SQL 数据库引擎  
SQLite 源代码不受版权限制  

## 官方网站
- [Github](https://github.com/sqlite/sqlite)
- [官方网站](https://www.sqlite.org/index.html)

## 下载安装

进入官方网站 Download 页面，找到这 2 个文件下载
- sqlite-dll-win64-x64-3430200.zip
- sqlite-tools-win32-x86-3430200.zip

将下载的2个zip文件全部解压缩到一个自定义路径后，文件夹内应有如下文件
- sqldiff.exe
- sqlite3.def
- sqlite3.dll
- sqlite3.exe
- sqlite3_analyzer.exe

将这个自定义路径配置到环境变量后即可

## 安装后确认命令
```bash
sqlite3 --version
```

## 一些命令

### 创建数据库
```bash
sqlite3 D:\WorkSpace\DB\Sqlite3\sl3test.db
```

```sql
.database

.quit
```

### 创建表
```bash
sqlite3 D:\WorkSpace\DB\Sqlite3\sl3test.db
```

```sql
CREATE TABLE COMPANY(
   ID INT PRIMARY KEY     NOT NULL,
   NAME           TEXT    NOT NULL,
   AGE            INT     NOT NULL,
   ADDRESS        CHAR(50),
   SALARY         REAL
);

.tables
```

### 插入数据
```sql
INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (1, 'Paul', 32, 'California', 20000.00 );

INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (2, 'Allen', 25, 'Texas', 15000.00 );
```

### 查询数据
```sql
.header on

.mode column

SELECT * FROM COMPANY;
```

# RocksDB

## 简介
RocksDB 是一个开源、轻量级的 ``NoSQL`` 嵌入式数据库  
2012年基于谷歌的 [LevelDB](https://github.com/google/leveldb) 分叉而来，最初由 Dhruba Borthakur 在 Facebook 创建，目的是提高服务器工作负载性能。目前，RocksDB 由 Meta 开发和维护。

RocksDB 以 C++ 语言编写，支持通过 С 绑定嵌入到以 C、C++、Rust、Go 和 Java 等多种语言编写的应用程序中。这种灵活性使得开发人员可以将 RocksDB 集成到自己的应用程序，而无需考虑使用的编程语言。

### RocksDB 数据模型
- 基于键值对存储数据，任意字节数组可作为键，并可存储相关值。字节数组可以是字符串、整数、序列化对象或自定义数据结构。任何类型的数据都可以作为值存储。
- 键和值都是任意长度的字节数组，没有任何预定义数据类型。

## 官方网站
- [Github](https://github.com/facebook/rocksdb)
- [官方网站](https://rocksdb.org/)
