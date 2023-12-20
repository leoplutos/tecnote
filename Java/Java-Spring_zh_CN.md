# Java-Spring相关

关于 Spring 笔者就不多介绍了，逛了一下 Spring 的官网，发现很多内容都与老版本有了很大的区别，在构建上也更方便了，甚至 Spring boot 都已经不推荐使用 JSP 作为模板了，于是重新学习一下，在这里记录一下步骤  

Spring Boot 默认支持的模板引擎有4种，分别是：FreeMarker、Groovy、Thymeleaf、Mustache，此文所有内容基于 ``Mustache`` 模板

参考官网的 [使用Kotlin构建Spring Boot](https://spring.io/guides/tutorials/spring-boot-kotlin/) 和 [quickstart](https://spring.io/quickstart/) 还有 [这里](https://spring.io/guides/gs/spring-boot/)

操作环境是在 ``Windows10``，可以运行 ``curl`` 和 ``7-zip``

## 创建Java-Maven工程

### 使用命令行获得工程脚手架
curl命令的参数的含义为
 - 使用Java语言
 - 使用maven构建工具
 - 依赖库：web,mustache,jpa,h2,devtools
 - java包名：com.example.spring
 - 工程名：SpringBootJava
 - 输出文件：SpringBootJava.zip
```
cd D:\WorkSpace\Java
mkdir SpringBootJava

curl https://start.spring.io/starter.zip -d language=java -d type=maven-project -d dependencies=web,mustache,jpa,h2,devtools -d packageName=com.example.spring -d name=SpringBootJava -o SpringBootJava.zip

7z x SpringBootJava.zip -oD:\WorkSpace\Java\SpringBootJava
del SpringBootJava.zip
```

### 查看所有参数
```
curl -H 'Accept: application/json' https://start.spring.io
```

### 修改 Maven Wrapper 国内源
在 ``工程根路径`` 下打开 ``.mvn\wrapper\maven-wrapper.properties``  
修改内容
```
distributionUrl=https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.9.5/apache-maven-3.9.5-bin.zip
wrapperUrl=https://repo.maven.apache.org/maven2/org/apache/maven/wrapper/maven-wrapper/3.2.0/maven-wrapper-3.2.0.jar
```
为
```
distributionUrl=https://mirrors.cloud.tencent.com/apache/maven/maven-3/3.9.5/binaries/apache-maven-3.9.5-bin.zip
wrapperUrl=https://repo.maven.apache.org/maven2/org/apache/maven/wrapper/maven-wrapper/3.2.0/maven-wrapper-3.2.0.jar
```

### 修改工程 pom.xml 为国内源
因为使用的是 Maven Wrapper，所以要修改指定国内源
在 ``工程根路径`` 下打开 ``pom.xml``  
修改内容
```
<project>
	<artifactId>SpringBootJava</artifactId>
	<description>SpringBootJava project for Spring Boot</description>

    <dependencies>
      <!-- 依赖 -->
    </dependencies>

    <!-- 在此配置国内源 -->
    <repositories>
        <repository>
            <id>tencent</id>
            <url>https://mirrors.cloud.tencent.com/nexus/repository/maven-public/</url>
        </repository>
    </repositories>
    <pluginRepositories>
        <pluginRepository>
            <id>tencent</id>
            <url>https://mirrors.cloud.tencent.com/nexus/repository/maven-public/</url>
        </pluginRepository>
    </pluginRepositories>
</project>
```

### 修改Spring设定文件
编码修改为UTF-8，避免乱码  
``src/main/resources/application.properties``
```
spring.http.encoding.force=true
spring.http.encoding.enabled=true
spring.http.encoding.charset=UTF-8
server.tomcat.uri-encoding=UTF-8
server.servlet.encoding.charset=UTF-8
server.servlet.encoding.force-response=true
```

### 新建一个简单的Controller
新建文件 ``src/main/java/com/example/spring/HelloController.java``，绑定URL ``/hello``  
内容如下
```
package com.example.spring;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HelloController {

	@GetMapping("/hello")
	public String hello(@RequestParam(name="message", required=false, defaultValue="World") String message, Model model) {
		model.addAttribute("title", "在HelloController设定的title");
		model.addAttribute("message", message);
		return "hello";
	}
}
```

### 新建前端的Mustache模板

#### 分别新建5个文件
``src/main/resources/templates/header.mustache``  
```
<html>
<head>
  <title>{{title}}</title>
  <link rel="stylesheet" href="css/style.css" />
  <script src="js/main.js"></script>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
</head>
<body>
<h1>这是header.mustache</h1>
<hr />
```

``src/main/resources/templates/footer.mustache``  
```
<hr />
<h1>这是footer.mustache</h1>
</body>
</html>
```

``src/main/resources/templates/hello.mustache``  
```
{{> header}}

<h1>这是hello.mustache</h1>
<p>title：{{title}}</p>
<p>message：{{message}}</p>
<button onclick="aletMessage()">测试按钮</button>

{{> footer}}
```

``src/main/resources/static/css/style.css``  
```
h1 {
	color: #005f5f
}
p {
	color: blue
}
```

``src/main/resources/static/js/main.js``  
```
function aletMessage() {
  alert("测试按钮已按下");
}
```

### 启动工程
```
cd D:\WorkSpace\Java\SpringBootJava
mvnw spring-boot:run
```

使用浏览器访问  
http://localhost:8080/hello  
http://localhost:8080/hello?message=mytest  

### VSCode配置
工程配置文件参考 [SpringBootJava](./SpringBootJava/)  
Mustache的高亮插件 [mustache](https://marketplace.visualstudio.com/items?itemName=dawhite.mustache)

### 其他
#### 编译jar文件
```
cd D:\WorkSpace\Java\SpringBootJava
mvnw clean package
```
#### 编译war文件
看 [这里](https://springdoc.cn/spring-boot-war-packaged/)

## 创建Kotlin-Gradle工程

### 使用命令行获得工程脚手架
curl命令的参数的含义为
 - 使用Kotlin语言
 - 使用Gradle构建工具
 - 依赖库：web,mustache,jpa,h2,devtools
 - 包名：com.example.spring
 - 工程名：SpringBootKotlin
 - 输出文件：SpringBootKotlin.zip
```
cd D:\WorkSpace\Java
mkdir SpringBootKotlin

curl https://start.spring.io/starter.zip -d language=kotlin -d type=gradle-project-kotlin -d dependencies=web,mustache,jpa,h2,devtools -d packageName=com.example.spring -d name=SpringBootKotlin -o SpringBootKotlin.zip

7z x SpringBootKotlin.zip -oD:\WorkSpace\Java\SpringBootKotlin
del SpringBootKotlin.zip
```

### 查看所有参数
```
curl -H 'Accept: application/json' https://start.spring.io
```

### 修改 Gradle Wrapper 国内源
在 ``工程根路径`` 下打开 ``gradle\wrapper\gradle-wrapper.properties``  
修改内容
```
distributionUrl=https\://services.gradle.org/distributions/gradle-8.5-bin.zip
```
为
```
distributionUrl=https\://mirrors.cloud.tencent.com/gradle/gradle-8.5-bin.zip
```

## 修改Gradle使用阿里云源
在 ``$USER_HOME/.gradle`` 路径内新建文件 ``init.gradle``  
内容如下
```
allprojects {
    repositories {
        mavenLocal()
        maven { name 'aligradle' ; url 'https://maven.aliyun.com/repository/public/' }
        maven { name 'alicentral' ; url 'https://maven.aliyun.com/repository/central' }
        mavenCentral()
    }
    buildscript {
        repositories {
            maven { name 'aligradle' ; url 'https://maven.aliyun.com/repository/public/' }
            maven { name 'alicentral' ; url 'https://maven.aliyun.com/repository/central' }
            maven { name 'M2' ; url 'https://plugins.gradle.org/m2/' }
        }
    }
}
```

### 修改Spring设定文件
编码修改为UTF-8，避免乱码  
``src/main/resources/application.properties``
```
spring.http.encoding.force=true
spring.http.encoding.enabled=true
spring.http.encoding.charset=UTF-8
server.tomcat.uri-encoding=UTF-8
server.servlet.encoding.charset=UTF-8
server.servlet.encoding.force-response=true
```

### 新建一个简单的Controller
新建文件 ``src/main/kotlin/com/example/spring/HelloController.kt``，绑定URL ``/hello``  
内容如下
```
package com.example.spring

import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.ui.set
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestParam

@Controller
class HelloController {

    @GetMapping("/hello")
    fun hello(@RequestParam(name = "message", required = false, defaultValue = "World") message: String, model: Model): String {
        model["title"] = "在HelloController设定的title"
        model["message"] = message
        return "hello"
    }
}
```

### 新建前端的Mustache模板

#### 分别新建5个文件
此处和 ``Java-Maven工程`` 的5个文件一致，省略

### 修改工程名
修改工程根路径下的 ``settings.gradle.kts``
```
rootProject.name = "SpringBootKotlin"
```

### 启动工程
```
cd D:\WorkSpace\Java\SpringBootKotlin
gradlew bootRun
```

使用浏览器访问  
http://localhost:8080/hello  
http://localhost:8080/hello?message=mytest  

### VSCode配置
工程配置文件参考 [SpringBootKotlin](./SpringBootKotlin/)  

### 其他
#### 编译jar文件
```
cd D:\WorkSpace\Java\SpringBootKotlin
gradlew bootJar
```
#### 编译war文件
修改工程根路径下的 ``build.gradle.kts`` ，在 ``plugins`` 结点下新增 ``war``
```
plugins {
	war
	id("org.springframework.boot") version "3.2.0"
	id("io.spring.dependency-management") version "1.1.4"
	kotlin("jvm") version "1.9.20"
	kotlin("plugin.spring") version "1.9.20"
	kotlin("plugin.jpa") version "1.9.20"
}
```
然后运行命令
```
cd D:\WorkSpace\Java\SpringBootKotlin
gradlew war
```
