# Java相关

## JDK相关
OpenJDK 各种版本的介绍  
https://mp.weixin.qq.com/s/ke6ZSZt-CMoVg2t3YY_rIQ

推荐使用 ``AdoptOpenJDK / Eclipse Temurin`` 或者 ``Liberica JDK`` 或者 ``Microsoft Build of OpenJDK™``  
官网：  
https://adoptium.net  
https://bell-sw.com/libericajdk/  
https://www.microsoft.com/openjdk  


## Eclipse和VSCode用的忽略问题设定文件（老旧工程用）

- [org.eclipse.jdt.core.prefs](.settings/org.eclipse.jdt.core.prefs)
- [官方文档](https://help.eclipse.org/neon/topic/org.eclipse.jdt.doc.isv/reference/api/org/eclipse/jdt/core/JavaCore.html)  


## 使用 JMH 进行基准测试
JMH（Java Microbenchmark Harness）是由OpenJDK团队开发的一个用于Java微基准测试工具套件  
https://github.com/openjdk/jmh  

### 一个例子（这个例子也是一个多模块的例子）
 - [JavaMavenModule](./JavaMavenModule)

``jmh-test`` 子工程即为 JMH 测试工程

## 一.Wildfly

### 1.使用jconcole/jvisualvm连接wildfly

#### 1-1.新建一个wildfly用户(如果有则不必)
```bash
./add-user.sh
```
#### 1-2.修改配置文件
standalone.xml / domain.xml / hotst.xml  
具体修改哪个需要看运行模式
```xml
<subsystem xmlns="urn:jboss:domain:jmx:1.3">
    <remoting-connector use-management-endpoint="true"/>
</subsystem>
```
#### 1-3.将服务器wildfly的jboss-cli-client.jar复制到本地，然后运行
```bash
jvisualvm --cp:a D:/lib/jboss-cli-client.jar
```
```bash
jconsole -J-Djava.class.path=$JAVA_HOME/lib/tools.jar;$JAVA_HOME/lib/jconsole.jar;D:/lib/jboss-cli-client.jar
```

#### 1-4.添加远程链接
使用步骤1的用户和密码  
选择不使用SSL链接  
端口为wildfly管理画面的端口
```url
service:jmx:remote+http://IPAddress:9999
```

---

### 2.wildfly远程调试

#### 2-1.修改配置文件
standalone.xml / domain.xml / hotst.xml  
添加jvm参数
```bash
JAVA_OPTS="$JAVA_OPTS -agentlib:jdwp=transport=dt_socket,address=8787,server=y,suspend=n"
```
具体修改哪个需要看运行模式，添加完如下
```xml
<jvm name="default">
    <heap size="64m" max-size="256m"/>
    <jvm-options>
        <option value="-server"/>
        <option value="-XX:MetaspaceSize=96m"/>
        <option value="-XX:MaxMetaspaceSize=256m"/>
        <option value="-agentlib:jdwp=transport=dt_socket,address=8787,server=y,suspend=n"/>
    </jvm-options>
</jvm>
```
#### 2-2.Eclipse
Run → Debug As → Remote Java application   
Connection Properties如下填写：  
> Host：服务器IP  
Port：8787（默认端口）


## 二.Tomcat绿色版

#### Tomcat各个版本和JDK的对应关系
https://tomcat.apache.org/whichversion.html


#### 普通模式启动
在tomcat的bin路径下新建 tomat_startup.cmd ，内容如下
```
set CATALINA_HOME=D:\Tools\WorkTool\Java\apache-tomcat-9.0.76
set JAVA_HOME=D:\Tools\WorkTool\Java\jdk17.0.6
set JRE_HOME=D:\Tools\WorkTool\Java\jdk17.0.6
%CATALINA_HOME%\bin\startup.bat
```
然后双击tomat_startup.cmd即可启动。

#### 远程Debug模式启动
在tomcat的bin路径下新建 tomat_startup-debug.cmd ，内容如下
```
set CATALINA_HOME=D:\Tools\WorkTool\Java\apache-tomcat-9.0.76
set JAVA_HOME=D:\Tools\WorkTool\Java\jdk17.0.6
set JRE_HOME=D:\Tools\WorkTool\Java\jdk17.0.6
%CATALINA_HOME%\bin\catalina.bat jpda start
```
然后双击tomat_startup-debug.cmd即可启动。（默认8000端口）

#### 端口冲突解决办法
**确认端口是否有冲突**  
```
netstat -nao | find "8080"
```

#### 修改端口的设定文件
```
tomcathome/conf/server.xml
```

#### 有时候启动后控制台会闪退，这时看log即可
```
tomcathome/logs/catalina.log
```

#### 控制台乱码解决办法
```
tomcathome/conf/logging.properties
```
```
#java.util.logging.ConsoleHandler.encoding = UTF-8
#java.util.logging.ConsoleHandler.encoding = GBK
java.util.logging.ConsoleHandler.encoding = SJIS
```

#### 添加用户
```
tomcathome/conf/tomcat-users.xml
```
```
<user username="admin" password="admin" roles="manager-gui,manager-script,manager-jmx,manager-status"/>
```

#### 配置工程
```
tomcathome/conf/Catalina/localhost/JavaWebProject.xml
```
```
<Context path="/JavaWebProject" docBase="D:\Work\WorkSpace\Java\JavaWebProject\WebContent" workDir="D:\Work\WorkSpace\Java\JavaWebProject\Work" />
```



## 三.Jar/War相关
#### war确认
```bash
jar tf lib.war
```

#### 导出
```bash
jar -xvf lib.jar com/spring/net
```

#### 导入
```bash
jar -ufv lib.jar com/spring/net
```

#### class版本确认
```bash
javap -v com/spring/net/a.class
```
得到的内容找 ``Major Version``，去下表查询  
| Java version | Major Version | Hex Code |
|--------------|---------------|----------|
| Java SE 19   | 63            | (0x3F)   |
| Java SE 18   | 62            | (0x3E)   |
| Java SE 17   | 61            | (0x3D)   |
| Java SE 16   | 60            | (0x3C)   |
| Java SE 15   | 59            | (0x3B)   |
| Java SE 14   | 58            | (0x3A)   |
| Java SE 13   | 57            | (0x39)   |
| Java SE 12   | 56            | (0x38)   |
| Java SE 11   | 55            | (0x37)   |
| Java SE 10   | 54            | (0x36)   |
| Java SE 9    | 53            | (0x35)   |
| Java SE 8    | 52            | (0x34)   |
| Java SE 7    | 51            | (0x33)   |
| Java SE 6    | 50            | (0x32)   |
| Java SE 5    | 49            | (0x31)   |
| JDK 1.4      | 48            | (0x30)   |
| JDK 1.3      | 47            | (0x2F)   |
| JDK 1.2      | 46            | (0x2E)   |
| JDK 1.1      | 45            | (0x2D)   |  

## Java 的虚拟线程例子（需要 Java 21 以上）
 - [App.java](./JavaMavenBatProject/src/main/java/my/mavenbatsample/App.java)

## Java 的异步例子
 - [AsyncExample.java](./JavaMavenBatProject/src/main/java/my/mavenbatsample/AsyncExample.java)

## Java 工厂模式的例子
 - [FactoryMode.java](./JavaMavenBatProject/src/main/java/my/mavenbatsample/FactoryMode.java)

## JDK 自带的 Document + XPath 解析 XML
 - [ParseXmlUtil.java](./JavaMavenBatProject/src/main/java/my/mavenbatsample/ParseXmlUtil.java)

## Spring WS的例子
 - [SpringWsTest](./SpringWsTest)

## OkHTTP,Moshi,Soap通信,JAXB,XSD解析,JUnit等例子
 - [OkHttpTest](./OkHttpTest)

## XSD解析
JAXB (Java Architecture for XML Binding) 是一个业界的标准，是一项可以根据 XML Schema 产生 Java 类的技术

### 使用 XSD 生成 Java 类
最简单的方式为在 pom.xml 中使用 ``jaxb2-maven-plugin`` 插件, 例子可以看 [pom.xml](./OkHttpTest/pom.xml)

默认情况下，将 XSD 文件放在 ``src/main/xsd`` 中，即可在 ``target/generated-sources/jaxb`` 生成 Java 类

### 使用 Java 类生成 XML

```java
// 创建自动生成的类的实例并设置属性
CodeDescriptionPair shipmentType = new CodeDescriptionPair();
shipmentType.setCode("SHI");
Shipment shipment = new Shipment();
shipment.setShipmentType(shipmentType);
UniversalShipmentData data = new com.cargowise.schemas.universal._2011._11.ObjectFactory().createUniversalShipmentData();
data.setShipment(shipment);
// 这里一定要用ObjectFactory来生成跟节点, 不然报错缺少@XmlRootElement
JAXBElement<UniversalShipmentData> root = new com.cargowise.schemas.universal._2011._11.ObjectFactory().createUniversalShipment(data);
// 使用 JAXB 来生成 XML
JAXBContext context = JAXBContext.newInstance(UniversalShipmentData.class);
Marshaller mar = context.createMarshaller();
mar.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
mar.setProperty(Marshaller.JAXB_ENCODING, "UTF-8");
mar.marshal(root, new File("./output.xml"));
```

## 其他

### MapStruct-对象属性复制
 - [官网](https://mapstruct.org/)
 - [Github](https://github.com/mapstruct/mapstruct)

### Java SSH服务端的例子
Apache MINA
 - [Github](https://github.com/kaneuchi-0202/apache_mina_test)

### Hutool
Hutool是一个Java工具包，它旨在减少代码冗余、提高开发效率，并且简化了Java开发中的很多常见操作
- [Github](https://github.com/dromara/hutool)
