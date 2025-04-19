# Jmeter

## Jmeter
Apache JMeter ，是一个 100% 纯 Java 的开源软件，旨在加载测试功能行为和测量性能。它最初设计用于测试Web应用程序，但后来扩展到其他测试功能。

相较于世面上一些其他性能测试工具， Jmeter 是为数不多的既好用又开源免费的测试工具。

## 下载安装

### 下载
去 [官网](https://jmeter.apache.org/) 下载二进制

### 安装
解压后，会在 ``bin`` 路径下找到 ``jmeter.bat``

其中会发现下面的部分
```
rem Get standard environment variables
if exist "%JMETER_HOME%\bin\setenv.bat" call "%JMETER_HOME%\bin\setenv.bat"
```
即如果存在 ``setenv.bat`` 的话它会调用

我们在 ``bin`` 路径下新建 ``setenv.bat`` 内容如下
```
set JVM_ARGS=-Xms512m -Xmx512m -XX:MaxMetaspaceSize=512m
set JAVA_HOME=D:\Tools\WorkTool\Java\jdk-21.0.3+9
set PATH=%PATH%;%JAVA_HOME%\bin
```
即可配置 ``JVM堆内存`` 和 ``Java运行时``

**NOTE:** Linux环境下为 ``setenv.sh``

都配置好以后运行 ``jmeter.bat`` 即可打开画面

如果不习惯英文界面，可以在 ``Options`` → ``Choose Language`` 来修改

## Jmeter主要元件
1. 测试计划：是使用 JMeter 进行测试的起点，它是其它 JMeter测试元件的容器

2. 线程组：代表一定数量的用户，它可以用来模拟用户并发发送请求。实际的请求内容在Sampler中定义，它被线程组包含。

3. 配置元件：维护Sampler需要的配置信息，并根据实际的需要修改请求的内容。

4. 前置处理器：负责在请求之前工作，常用来修改请求的设置

5. 定时器：负责定义请求之间的延迟间隔。

6 .取样器(Sampler)：是性能测试中向服务器发送请求，记录响应信息、响应时间的最小单元，如：HTTP Request Sampler、FTP Request Sample、TCP Request Sample、JDBC Request Sampler等，每一种不同类型的sampler 可以根据设置的参数向服务器发出不同类型的请求。

7. 后置处理器：负责在请求之后工作，常用获取返回的值。

8. 断言：用来判断请求响应的结果是否如用户所期望的。

9. 监听器：负责收集测试结果，同时确定结果显示的方式。

10. 逻辑控制器：可以自定义JMeter发送请求的行为逻辑，它与Sampler结合使用可以模拟复杂的请求序列。

## Jmeter用法

### 新建一个线程组

``Test Plan`` 右键 → ``添加`` → ``线程（用户）`` → ``线程组``

填写内容说明如下

- 名称：任意

- 线程数：即虚拟用户数。设置多少个线程数也就是设置多少虚拟用户数

- Ramp-Up时间(秒)：设置虚拟用户数全部启动的时长。如果线程数为20,准备时长为10秒,那么需要10秒钟启动20个线程。也就是平均每秒启动2个线程。

- 循环次数：每个线程发送请求的个数。如果线程数为20,循环次数为10,那么每个线程发送10次请求。总请求数为20*10=200。如果勾选了“永远”,
那么所有线程会一直发送请求,直到手动点击工具栏上的停止按钮,或者设置的线程时间结束。

在左侧的 ``Test Plan`` 下会看到新建的 ``线程组``

### 新建一个HTTP请求

新建的 ``线程组`` 右键 → ``添加`` → ``取样器`` → ``HTTP请求``

这里填写一些 HTTP 通信的内容  
比如笔者要测试的URL为 https://httpbin.org/anything   
那么就按如下填写

- 名称：``httpbin.org``
- 协议：``HTTPS``
- 服务器名称或IP：``httpbin.org``
- 端口号：``443``
- HTTP请求：``POST``
- 路径：``anything``
- 内容编码：``UTF-8``
- 参数：``不设置``
- 消息体数据：``grant_type=client_credentials``

### 添加HTTP信息头（如需要）
新建的 ``HTTP请求`` 右键 → ``添加`` → ``配置元件`` → ``HTTP信息头管理器`` 添加即可

### 添加合适的响应断言
对响应结果添加合适的断言，下面以响应断言举例

新建的 ``HTTP请求`` 右键 → ``添加`` → ``断言`` → ``响应断言``

因为会返回 JSON 信息，笔者这里设定内容为
```
"url": "https://httpbin.org/anything"
```

### 添加监听器
JMeter 有许多 UI 监听器，可用于直接在 JMeter UI 中查看结果：

- 以树形式查看结果：查看结果树显示所有样本响应的树，允许您查看任何样本的响应。
- 图形结果：图形结果监听器生成一个简单的图形，绘制所有采样时间，
- 聚合报告：聚合报告为测试中的每个不同命名的请求创建一个表行，
- 在表中查看结果：此可视化工具为每个样本结果创建一行。与查看结果树一样，此可视化工具使用大量内存，
- 聚合图：聚合图与聚合报告类似。主要区别在于聚合图提供了一种生成条形图并将图形保存为PNG文件的简便方法，
- 生成摘要结果：此测试元素可以放在测试计划中的任何位置。生成到目前为止测试运行的摘要到日志文件和/或标准输出。显示运行和差异总计

新建的 ``线程组`` 右键 → ``添加`` → ``监听器`` → 选择合适的结果呈现方式，这里我加了 ``查看结果树``、``汇总报告``和``图形结果``

### 启动测试
点击工具栏的 ``播放`` 按钮


## 测试 Soap协议的 WebService

这里拿笔者 [httpYac.http](../DevTool/httpYac.http) 中的 ``eAdaptorSoapWebService.svc`` 举例

请求内容为
```
POST https://localhost/eAdaptorSoapWebService.svc HTTP/1.1
Content-Type: text/xml;charset=UTF-8
SOAPAction: "http://CargoWise.com/eHub/2010/06/eAdapterStreamedService/SendStream"

<soapenv:Envelope>请求内容省略</soapenv:Envelope>
```
### 新建一个线程组

``Test Plan`` 右键 → ``添加`` → ``线程（用户）`` → ``线程组``

### 新建一个HTTP请求

新建的 ``线程组`` 右键 → ``添加`` → ``取样器`` → ``HTTP请求``

- 名称：``Soap-WebService``
- 协议：``HTTPS``
- 服务器名称或IP：``localhost``
- 端口号：``443``
- HTTP请求：``POST``
- 路径：``eAdaptorSoapWebService.svc``
- 内容编码：``UTF-8``
- 参数：``不设置``
- 消息体数据：``<soapenv:Envelope>请求内容省略</soapenv:Envelope>``

### 添加HTTP信息头
新建的 ``HTTP请求`` 右键 → ``添加`` → ``配置元件`` → ``HTTP信息头管理器``
添加 
- Content-Type: ``text/xml;charset=UTF-8``
- SOAPAction: ``"http://CargoWise.com/eHub/2010/06/eAdapterStreamedService/SendStream"``

### 添加响应断言

新建的 ``HTTP请求`` 右键 → ``添加`` → ``断言`` → ``响应断言``

```
s:Envelope
```

### 添加监听器
新建的 ``线程组`` 右键 → ``添加`` → ``监听器``  

依次添加 ``查看结果树``、``汇总报告``和``图形结果``

### 启动测试
点击工具栏的 ``播放`` 按钮


# wrk

wrk 是一款针对 Http 协议的基准测试工具，它能够在单机多核 CPU 的条件下，使用系统自带的高性能 I/O 机制，如 epoll，kqueue 等，通过多线程和事件模式，对目标机器产生大量的负载。

其实，wrk 是复用了 redis 的 ae 异步事件驱动框架，准确来说 ae 事件驱动框架并不是 redis 发明的, 它来至于 Tcl 的解释器 jim, 这个小巧高效的框架, 因为被 redis 采用而被大家所熟知。

- [Github官网](https://github.com/wg/wrk)

## 验证安装

```bash
wrk -v
```

## 简单使用

压力测试
```bash
wrk -t12 -c400 -d30s http://www.baidu.com
```

压力测试并且生成报告
```bash
wrk -t12 -c400 -d30s --latency http://www.baidu.com
```

# Bombardier

Bombardier 是一款专为HTTP(S)性能基准测试设计的工具，该工具基于Go语言开发，并且为了提升性能，特意选择了fasthttp库替代了Go标准库中的http库

- [Github官网](https://github.com/codesenberg/bombardier)
