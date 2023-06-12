# Postgresql

## EDB设定
Oracle中，默认情况下事务中有异常的SQL时，异常SQL前执行的正常SQL对数据库产生的应用会继续保留，并且可以继续执行SQL。提交时正常执行SQL产生的影响都会被提交。

PostgreSQL中，默认情况下，事务中只有有任意SQL异常，都会导致整个事务回滚，默认为事务原子性。(但是PG可以通过开启SAVEPOINT实现ORACLE一样的效果，PPAS则通过这个参数控制。)

Oracle 兼容模式(开启它有性能影响，注意)：

设定文件
```
/db/pgdata/data/postgresql.conf
```

修改内容
```
#edb_stmt_level_tx = off                # allow continuing on errors instead
```
修改为
```
edb_stmt_level_tx = on                # allow continuing on errors instead
```

修改后切换DBA用户
```
su - enterprisedb
```
重启DB即可
```
/usr/edb/as14/bin/pg_ctl reload
```

## pgAdmin4里面格式化SQL快捷键
Ctrl + Shift + k

