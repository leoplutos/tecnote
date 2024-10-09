# Java-Maven相关

## 下载
1. 去 apache 主页下载  
https://maven.apache.org/download.cgi  

2. 下载之后解压缩配置到Path
```bash
set MAVEN_HOME=D:\Tools\WorkTool\Java\apache-maven-3.9.4
set PATH=%PATH%;%MAVEN_HOME%\bin
```

3. 命令确认
```bash
mvn --version
```

## Maven的配置文件
Maven的配置文件分为 ``全局`` 和 ``用户``
- 全局配置文件 ``Maven安装路径/conf/settings.xml``
- 用户配置文件
    - Windows：``%USERPROFILE%\.m2\settings.xml``
    - Linux：``~/.m2/settings.xml``

### 配置优先级
**用户配置优先于全局配置**

配置优先级从高到低：``pom.xml`` -> ``用户配置`` > ``全局配置``

## Maven配置

1. (可选)创建本地仓库存放路径
```bash
D:\Tools\WorkTool\Java\m2\repo
```

2. 创建用户配置文件 ``settings.xml``，文件内容如下
```xml
<?xml version="1.0" encoding="UTF-8"?>

<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">

    <!-- 1. 配置本地仓库目录 -->
    <!--
    <localRepository>D:/Tools/WorkTool/Java/m2/repo</localRepository>
    -->

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

### 详细的设定例子
 - [java工程](../Go/Grpc/java)

### 多模块的例子
 - [JavaMavenModule](./JavaMavenModule)

### Maven工程的 ``pom.xml`` 文件例子
```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
	<modelVersion>4.0.0</modelVersion>
	<groupId>my.mavenbatsample</groupId>
	<artifactId>OkHttpTest</artifactId>
	<packaging>jar</packaging>
	<version>1.0-SNAPSHOT</version>
	<name>OkHttpTest</name>
	<url>http://maven.apache.org</url>

	<properties>
		<maven.compiler.source>21</maven.compiler.source>
		<maven.compiler.target>21</maven.compiler.target>
		<project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
		<project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
	</properties>

	<dependencies>
		<!--okhttp 依赖-->
		<dependency>
			<groupId>com.squareup.okhttp3</groupId>
			<artifactId>okhttp</artifactId>
			<version>4.12.0</version>
		</dependency>
        <!--junit 依赖-->
		<dependency>
			<groupId>junit</groupId>
			<artifactId>junit</artifactId>
			<version>4.13.2</version>
			<scope>test</scope>
		</dependency>
	</dependencies>
</project>
```

### Maven导入本地jar包
假设在工程的lib文件夹内有 ``jar-1.0.0.jar``

```xml
<dependency>
    <groupId>aa.bb</groupId>
    <artifactId>aa-bb-api</artifactId>
    <version>1.0.0</version>
    <scope>system</scope>
    <systemPath>${basedir}/lib/jar-1.0.0.jar</systemPath>
</dependency>
```

## Maven命令

#### 创建maven-batch项目
```bash
cd D:\WorkSpace\Java
mvn archetype:generate "-DgroupId=my.mavenbatsample" "-DartifactId=JavaMavenBatProject" "-DarchetypeArtifactId=maven-archetype-quickstart" "-DinteractiveMode=false"
```

#### 创建maven-web项目
```bash
cd D:\WorkSpace\Java
mvn archetype:generate "-DgroupId=my.mavenwebsample" "-DartifactId=JavaMavenWebProject" "-DarchetypeArtifactId=maven-archetype-webapp" "-DinteractiveMode=false"
```

#### 编译工程
```bash
mvn compile
```

#### 运行工程
```bash
mvn exec:java -Dexec.mainClass="my.mavenbatsample.App" -Dexec.args="arg0 arg1 arg2"
```

#### 运行测试
```bash
mvn test
```
默认情况下，运行测试后 surfire 插件将在 ``{base-dir}/target/surfire-reports`` 中创建 XML 和 txt 文件报告，并不会生成 ``html`` 报告  
生成 HTML 报告，可以使用
```bash
mvn surefire-report:report-only
```
运行后即可在 ``{base-dir}/target/site`` 中看到 ``html`` 报告  

[Test Runner for Java](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-test) 也是一个非常好用的插件

## Maven 打包时自定义变量的使用
Maven打包时，如果有一些变量在多个地方使用，可以使用 ``-D`` 的方式或者 ``properties`` 的方式

#### Properties属性

使用命令行设置Properties属性 ``-D``的正确方法是
```bash
mvn -DpropertyName=propertyValue clean package
```
- 如果 ``propertyName`` 不存在 ``pom.xml`` 中，它将被设置
- 如果 ``propertyName`` 已经存在 ``pom.xml`` 中，其值将被作为参数传递的-D值覆盖

如果你的 ``pom.xml`` 如下
```xml
<properties>
    <theme>myDefaultTheme</theme>
</properties>
```
那么执行 ``mvn -Dtheme=halloween clean package`` 会覆盖 theme 的值，具有如下效果
```xml
<properties>
    <theme>halloween</theme>
</properties>
```

#### Profiles配置文件
在 ``pom.xml`` 中， ``<profiles>`` 指定的 ``<id>`` 可以通过 ``-P``进行传递或者赋值
如果你的 ``pom.xml`` 如下
```xml
<profiles>
    <profile>
        <id>test</id>
        ...
    </profile>
</profiles>
```
那么执行 ``mvn package -P test`` 会触发配置文件

#### 默认路径
Maven的默认输出路径如下
```xml
<build>
	<directory>${project.basedir}/target</directory>
	<outputDirectory>${project.build.directory}/classes</outputDirectory>
	<testOutputDirectory>${project.build.directory}/test-classes</testOutputDirectory>
	<sourceDirectory>${project.basedir}/src/main/java</sourceDirectory>
	<scriptSourceDirectory>${project.basedir}/src/main/scripts</scriptSourceDirectory>
	<testSourceDirectory>${project.basedir}/src/test/java</testSourceDirectory>  
</build>
```

如果想修改路径，比如输出路径可以使用 ``Profiles`` 配置文件
```xml
<profiles>
	<profile>
		<id>it</id>
		<properties>
			<!--修改编译结果路径为build-->
			<profiles.buildDirectory>build</profiles.buildDirectory>
		</properties>
	</profile>
</profiles>
<build>
	<!--生成路径根据profile的设定变化-->
	<directory>${project.basedir}/${profiles.buildDirectory}</directory>
</build>
```
运行 ``mvn clean compile -P it`` 即可触发配置

## mvnw
``mvnw`` 是 [Maven Wrapper](https://maven.apache.org/wrapper/) 的缩写。因为我们安装Maven时，默认情况下，系统所有项目都会使用全局安装的这个Maven版本。但是，对于某些项目来说，它可能必须使用某个特定的Maven版本，这个时候，就可以使用Maven Wrapper，它可以负责给这个特定的项目安装指定版本的Maven，而其他项目不受影响。

#### 使用Maven Wrapper
安装Maven Wrapper最简单的方式是在项目的根目录（即 ``pom.xml`` 所在的目录）下运行安装命令：
```bash
mvn -N wrapper:wrapper
```
也可以指定 Maven 版本
```bash
mvn -N wrapper:wrapper -Dmaven=3.9.5
```

安装后发现多了 ``mvnw`` 、 ``mvnw.cmd`` 和 ``.mvn目录``，我们只需要把 mvn 命令改成 ``mvnw`` 就可以使用跟项目关联的 Maven。例如：
```bash
./mvnw clean package
```

#### 配置Maven Wrapper

``.mvn/wrapper/maven-wrapper.properties`` 是配置文件，可以配置 Maven 版本

下面是一个使用腾讯云的例子
```
distributionUrl=https://mirrors.cloud.tencent.com/apache/maven/maven-3/3.9.5/binaries/apache-maven-3.9.5-bin.zip
```

## 其他

#### Google Cloud Storage 的镜像
```xml
<settings>
    <mirrors>
        <mirror>
            <id>google-maven-central</id>
            <name>GCS Maven Central mirror</name>
            <url>https://maven-central.storage-download.googleapis.com/maven2/</url>
            <mirrorOf>central</mirrorOf>
        </mirror>
    </mirrors>
</settings>
```

出处  
http://storage-download.googleapis.com/maven-central/index.html
