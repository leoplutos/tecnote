# Postgresql

## 在 Docker 中运行 Postgres

[Tags 说明](https://github.com/docker-library/docs/blob/master/postgres/README.md)

拉取镜像与启动容器
```bash
# 拉取镜像
docker pull postgres:17.1-alpine3.20

# 创建本地数据卷保存数据库内容
mkdir $HOME/workspace/postgre_data/data

# 启动容器
docker run -p 5432:5432 --name postgre -v $HOME/workspace/postgre_data/data:/var/lib/postgresql/data -e POSTGRES_PASSWORD=123456 -d postgres:17.1-alpine3.20
```

使用 ``A5M2`` 或者 ``DBeaver`` 连接数据库

- ``Server Name``: 容器宿主机的IP
- ``Database Name``: postgres
- ``User ID``: postgres
- ``Password``: 123456

### 主流语言连接 Postgres

### C# / .NET
示例代码  
[Postgre](../Dotnet/dotnet-core-sample/dotnet-console-sample/Postgre/)
- PostgreBase.cs : 基础用法
- PostgreEFCore.cs : ORM用法

### Java
示例代码  
[SpringBootConsole](../Java/SpringBootConsole/)
- PostgreBaseService.java : 基础 JDBC 用法
- PostgreJpaService.java : Spring Data JPA 用法
- PostgreJdbcClientService.java : Spring Boot JdbcClient 用法

## EDB设定
Oracle中，默认情况下事务中有异常的SQL时，异常SQL前执行的正常SQL对数据库产生的应用会继续保留，并且可以继续执行SQL。提交时正常执行SQL产生的影响都会被提交。

PostgreSQL中，默认情况下，事务中只有有任意SQL异常，都会导致整个事务回滚，默认为事务原子性。(但是PG可以通过开启SAVEPOINT实现ORACLE一样的效果，PPAS则通过这个参数控制。)

Oracle 兼容模式(开启它有性能影响，注意)：

设定文件: ``/db/pgdata/data/postgresql.conf``

修改内容
```text
#edb_stmt_level_tx = off                # allow continuing on errors instead
```
修改为
```text
edb_stmt_level_tx = on                # allow continuing on errors instead
```

修改后切换DBA用户
```bash
su - enterprisedb
```
重启DB即可
```bash
/usr/edb/as14/bin/pg_ctl reload
```

## pgAdmin4里面格式化SQL快捷键
``Ctrl + Shift + k``

## 死锁的确认与kill

#### 查找死锁的pid
```sql
SELECT l.pid,l.granted,d.datname,l.locktype,relation,relation::regclass,transactionid,l.mode
FROM pg_locks l  LEFT JOIN pg_database d ON l.database = d.oid
WHERE  l.pid != pg_backend_pid()
ORDER BY l.pid;
```

### kill死锁的pid
```sql
SELECT pg_cancel_backend(2490);
SELECT pg_terminate_backend(2490);
```
