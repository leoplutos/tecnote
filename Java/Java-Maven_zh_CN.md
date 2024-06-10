# Java-Maven相关

## 下载
去 apache 主页下载  
https://maven.apache.org/download.cgi
解压缩后即可使用

## Maven的配置文件
Maven的配置文件分为 ``全局`` 和 ``用户``
- 全局配置文件 ``Maven安装路径/conf/settings.xml``
- 用户配置文件
    - Windows：``%USERPROFILE%\.m2\settings.xml``
    - Linux：``~/.m2/settings.xml``

### 配置优先级
**用户配置优先于全局配置**

配置优先级从高到低：``pom.xml`` -> ``用户配置`` > ``全局配置``

## Maven环境构建

1. 下载好之后配置到Path
```
set MAVEN_HOME=D:\Tools\WorkTool\Java\apache-maven-3.9.4
set PATH=%PATH%;%MAVEN_HOME%\bin
```

2. 命令确认
```
mvn --version
```

3. (可选)创建本地仓库存放路径
```
D:\Tools\WorkTool\Java\m2\repo
```

4. 创建用户配置文件 ``settings.xml``，文件内容如下
```
<?xml version="1.0" encoding="UTF-8"?>

<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">

    <!-- 1. 配置本地仓库目录 -->
    <localRepository>D:/Tools/WorkTool/Java/m2/repo</localRepository>

    <pluginGroups></pluginGroups>
    <proxies></proxies>
    <servers></servers>

    <mirrors>
        <!-- 2. 配置阿里云镜像仓库 -->
        <mirror>
            <id>alimaven</id>
            <name>aliyun maven</name>
            <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
            <mirrorOf>central</mirrorOf>
        </mirror>
    </mirrors>

    <profiles>
        <!-- 3. 配置默认jdk1.8 -->
        <profile>
            <id>jdk-1.8</id>
            <activation>
                <activeByDefault>true</activeByDefault>
                <jdk>1.8</jdk>
            </activation>
            <properties>
                <maven.compiler.source>1.8</maven.compiler.source>
                <maven.compiler.target>1.8</maven.compiler.target>
                <maven.compiler.compilerVersion>1.8</maven.compiler.compilerVersion>
                <maven.compiler.encoding>utf-8</maven.compiler.encoding>
                <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
            </properties>
        </profile>
    </profiles>

</settings>
```

#### Maven工程的 ``pom.xml`` 文件例子
```
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>my.mavenbatsample</groupId>
  <artifactId>JavaMavenBatProject</artifactId>
  <packaging>jar</packaging>
  <version>1.0-SNAPSHOT</version>
  <name>JavaMavenBatProject</name>
  <url>http://maven.apache.org</url>
  <dependencies>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>3.8.1</version>
      <scope>test</scope>
    </dependency>
    <dependency>
      <groupId>log4j</groupId>
      <artifactId>log4j</artifactId>
      <version>1.2.17</version>
    </dependency>
  </dependencies>
</project>
```

## Maven命令

#### 创建maven-batch项目
```
cd D:\WorkSpace\Java
mvn archetype:generate "-DgroupId=my.mavenbatsample" "-DartifactId=JavaMavenBatProject" "-DarchetypeArtifactId=maven-archetype-quickstart" "-DinteractiveMode=false"
```

#### 创建maven-web项目
```
cd D:\WorkSpace\Java
mvn archetype:generate "-DgroupId=my.mavenwebsample" "-DartifactId=JavaMavenWebProject" "-DarchetypeArtifactId=maven-archetype-webapp" "-DinteractiveMode=false"
```

#### 编译工程
```
mvn compile
```

#### 运行工程
```
mvn exec:java -Dexec.mainClass="my.mavenbatsample.App" -Dexec.args="arg0 arg1 arg2"
```

#### 运行测试
```
mvn test
```