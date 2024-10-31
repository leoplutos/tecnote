# 程序打包发布说明

## 环境说明
- ``pom.xml`` : 普通环境打包用
- ``pom_docker.xml`` : Docker环境打包用

## 普通环境
模仿maven的目录结构，设定文件外置

### 打包命令

**编译命令**（开发环境，测试环境，商用环境）
```bash
mvn clean compile -P dev
mvn clean compile -P it
mvn clean compile -P prd -Dmaven.test.skip=true
```

**打包命令**（开发环境，测试环境，商用环境）
```bash
mvn clean package -P dev
mvn clean package -P it
mvn clean package -P prd -Dmaven.test.skip=true
```

打包时不会将设定文件（比如 ``log4j2.xml``）打到jar内，需要手动发布
 - 在 ``target`` 文件夹下生成 jar 文件
 - 在 ``target/lib`` 文件夹下生成 依赖的 jar 文件
 - 在 ``target/classes`` 文件夹下可以找到设定文件（比如 ``log4j2.xml``）

### 发布

假定要发布的目录为 ``D:\GRPCBatch``

```
GRPCBatch
├─bin
│     StartGRPCServer.cmd
├─conf
│     config.properties
│     log4j2.xml
└─lib
│     这里放所有的jar
```

运行 ``StartGRPCServer.cmd`` 即可启动服务

## Docker环境（单文件环境）
目标文件为单一的jar文件，设定文件内置，适用于Docker

### 打包命令

**编译命令**（Docker用）
```bash
mvn -f pom_docker.xml clean compile
```

**打包命令**（Docker用）
```bash
# mvn -f pom_docker.xml clean compile assembly:single -P docker -Dmaven.test.skip=true
mvn -f pom_docker.xml clean package spring-boot:repackage -P docker -Dmaven.test.skip=true
```

打包后在 ``build`` 文件夹下生成包含所有依赖的 jar 文件

### 发布

因为只有一个jar目标文件，所以没有目录限制

启动服务命令
```bash
java -jar javagrpc-1.0.jar
```
