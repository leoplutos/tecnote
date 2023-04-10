# Java相关

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

---

## 二.Jar/War相关
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
得到的内容找[Major Version]，去下表查询  
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
