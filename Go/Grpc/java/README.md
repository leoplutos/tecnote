## 程序打包发布说明

### 打包命令

**编译命令**（开发环境，测试环境，商用环境）
```
mvn clean compile -P dev
mvn clean compile -P it
mvn clean compile -P prd
```

**打包命令**（开发环境，测试环境，商用环境）
```
mvn clean package -P dev
mvn clean package -P it
mvn clean package -P prd
```
打包后
 - 在 ``target`` 文件夹下生成 jar 文件
 - 在 ``target/lib`` 文件夹下生成 依赖的 jar 文件
 - 在 ``target/classes`` 文件夹下可以找到设定文件（比如 ``log4j2.xml``）

此项目打包时不会将设定文件（比如 ``log4j2.xml``）打到jar内，需要手动发布

### 发布

#### 发布目录

假定要发布的目录为 ``D:\GRPCBatch``

```
GRPCBatch
├─bin
│     StartGRPCServer.cmd
├─conf
│     config.properties
│     log4j2.xml
└─lib
       这里放所有的jar
```

运行 ``StartGRPCServer.cmd`` 即可启动服务
