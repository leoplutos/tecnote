# 程序打包发布说明

## 环境说明
- ``pom.xml`` : 本地开发环境用
- ``pom_docker.xml`` : Docker环境打包用

## 本地开发环境

**编译命令**（开发环境，测试环境，商用环境）
```bash
mvn clean compile
mvn clean compile -P dev
mvn clean compile -P it
mvn clean compile -P prd -Dmaven.test.skip=true
```

## Docker环境（实际运行环境）
目标文件为单一的jar文件(使用Spring Boot Maven Plugin打包)，设定文件内置，适用于Docker

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
