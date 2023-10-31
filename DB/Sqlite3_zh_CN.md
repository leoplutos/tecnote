# Sqlite3

## Sqlite3简介
SQLite 的一个重要的特性是零配置的，这意味着不需要复杂的安装或管理

## 下载安装
* [官方网站](https://www.sqlite.org/index.html)  

进入Download页面，找到这2个文件下载
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
```
sqlite3 --version
```

## 一些命令

### 创建数据库
```
sqlite3 D:\WorkSpace\DB\Sqlite3\sl3test.db

.database

.quit
```

### 创建表
```
sqlite3 D:\WorkSpace\DB\Sqlite3\sl3test.db

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
```
INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (1, 'Paul', 32, 'California', 20000.00 );

INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (2, 'Allen', 25, 'Texas', 15000.00 );
```

### 查询数据
```
.header on

.mode column

SELECT * FROM COMPANY;
```
