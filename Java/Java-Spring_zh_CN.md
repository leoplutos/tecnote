# Java-Spring相关

关于 Spring 笔者就不多介绍了，逛了一下 Spring 的官网，发现很多内容都与老版本有了很大的区别，在构建上也更方便了，甚至 Spring boot 都已经不推荐使用 JSP 作为模板了，于是重新学习一下，在这里记录一下步骤  

Spring Boot 默认支持的模板引擎有4种，分别是：FreeMarker、Groovy、Thymeleaf、Mustache，此文所有内容基于 ``Mustache`` 模板

参考官网的 [使用Kotlin构建Spring Boot](https://spring.io/guides/tutorials/spring-boot-kotlin/) ， [快速开始](https://spring.io/quickstart/) ， [使用Spring Boot创建应用](https://spring.io/guides/gs/spring-boot/) ， [创建Batch服务](https://spring.io/guides/gs/batch-processing/)

操作环境是在 ``Windows10``，可以运行 ``curl`` 和 ``7-zip``

## 创建Java-Maven-Web工程

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

#### 编译war文件并且发布到Tomcat
有时候我们做的工程需要发布到Tomcat，WildFly等容器内，这时候需要打包成传统的war文件，制作方式如下  

所需文件参考 [SpringBootJava](./SpringBootJava/)  

1. 新建文件 ``src/main/java/com/example/spring/ServletInitializer.java``
```
package com.example.spring;

import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

public class ServletInitializer extends SpringBootServletInitializer {
	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(SpringBootJavaApplication.class);
	}
}
```

2. 新建 ``pom_war.xml``  

- 修改打包方式为war  
```
<packaging>war</packaging>
```

- 修改 内置Tomcat Servlet 容器的 scope
```
<dependency>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-tomcat</artifactId>
	<scope>provided</scope>
</dependency>
```
因为使用外部的 Tomcat，所以需要主动把嵌入式容器 spring-boot-starter-tomcat 依赖的 scope 声明为 ``provided``，表示该依赖只用于编译、测试

- 在 build 节点下添加 finalName 节点来设置打包后的 war 文件的名称
```
<build>
	<finalName>SpringBootJava</finalName>
</build>
```

修改完成，我们做了2个pom.xml文件
 - pom.xml：运行内嵌tomcat，启动工程，用来本地开发
 - pom_war.xml：编译war文件用来部署

编译war文件命令  
```
cd D:\WorkSpace\Java\SpringBootJava
mvnw -f pom_war.xml clean package
```
可在 ``target`` 路径下找到war文件  
将 war 文件复制到外部 Tomcat 的 webapps 目录下即可，服务器启动会自动解压。 war 文件的名称就是应用的 contentPath  
启用外部 tomcat 后使用浏览器访问（NOTE：笔者外部tomcat端口为8081）  
http://localhost:8081/SpringBootJava/hello  
http://localhost:8081/SpringBootJava/hello?message=mytest  

## 创建Kotlin-Gradle-Web工程

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
gradlew clean bootJar
```

#### 编译war文件并且发布到Tomcat
有时候我们做的工程需要发布到Tomcat，WildFly等容器内，这时候需要打包成传统的war文件，制作方式如下  

所需文件参考 [SpringBootKotlin](./SpringBootKotlin/)  

1. 新建文件 ``src/main/kotlin/com/example/spring/ServletInitializer.kt``
```
package com.example.spring

import org.springframework.boot.builder.SpringApplicationBuilder
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer

open class ServletInitializer : SpringBootServletInitializer() {
	override fun configure(application: SpringApplicationBuilder): SpringApplicationBuilder {
		return application.sources(SpringBootKotlinApplication::class.java)
	}
}
```

2. 修改 ``build.gradle.kts``  

- 修改打包方式为war  
```
plugins {
	war
}
```

- 修改 内置Tomcat Servlet 容器的 scope
```
dependencies {
	providedRuntime("org.springframework.boot:spring-boot-starter-tomcat")
}
```
因为使用外部的 Tomcat，所以需要主动把嵌入式容器 spring-boot-starter-tomcat 依赖的 scope 声明为 ``provided``，表示该依赖只用于编译、测试

编译war文件命令  
```
cd D:\WorkSpace\Java\SpringBootKotlin
gradlew clean bootWar
```
可在 ``build/libs`` 路径下找到war文件  
将 war 文件复制到外部 Tomcat 的 webapps 目录下即可，服务器启动会自动解压。 war 文件的名称就是应用的 contentPath  
启用外部 tomcat 后使用浏览器访问（NOTE：笔者外部tomcat端口为8081）  
http://localhost:8081/SpringBootKotlin/hello  
http://localhost:8081/SpringBootKotlin/hello?message=mytest  


## 开启虚拟线程
需要 Spring Boot 3.2 和 Java 21  
``application.properties`` 中加入如下设定
```
spring.threads.virtual.enabled=true
```

## 创建Java-Maven-Batch工程

### Spring Batch 简介
Spring Batch 是一个轻量级、全面的批处理框架，旨在支持开发对企业系统的日常运营至关重要的健壮批处理应用程序。Spring Batch 建立在人们所期望的 Spring Framework 的特性（生产力、基于 POJO 的开发方法和一般易用性）之上，同时使开发人员可以在必要时轻松访问和利用更先进的企业服务。

### 关于Job
BatchCore中会包含基本的Job，用来处理数据的核心。一个Job由多个Step组成，比如：做菜这个Job由洗菜，切菜，炒菜这三个Step组成，我们再业务中也会存在这种复杂多步骤的业务处理流程。  
一个基本的job一般由至少一个Step组成。  
一个Step一般由三部分组成
 1. ItemReader：读取数据
 2. ItemProcessor：处理数据
 3. ItemWriter：写数据

### 关于ItemReader
 - ListItemReader：读取List类型数据，只能读一次
 - ItemReaderAdapter：ItemReader适配器，可以服用现有的读操作
 - FlatFileItemReader：读Flat类型文件
 - StaxEventItemReader：读XML类型文件
 - JdbcCursorItemReader：基于Jdbc游标方式读取数据库
 - HibernateCursorItemReader：基于Hibernate游标方式读取数据库
 - StoredProcedureItemReader：基于存储过程读取数据库
 - IbatisPagingItemReader：基于Ibaties分页读取数据库
 - JpaPagingItemReader：基于Jpa分页读取数据库
 - JdbcPagingItemReader：基于Jdbc分页读取数据库
 - HibernatePagingItemReader：基于Hibernate分页读取数据库
 - JmsItemReader：读取JMS队列
 - IteratorItemReader：迭代方式读组件
 - MultiResourceItemReader：多文件读组件
 - MongoItemReader：基于分布式文件存储的数据库MongoDB读组件
 - Neo4jItemReader：面向网络的数据库Neo4j的读组件
 - ResourcesItemReader：基于批量资源的读组件，每次读取返回资源对象
 - AmqpItemReader：读取AMQP队列组件
 - Repository：基于spring Data的读组件

### 使用命令行获得工程脚手架
curl命令的参数的含义为
 - 使用Java语言
 - 使用maven构建工具
 - 依赖库：batch,h2
 - java包名：com.example.batch
 - 工程名：SpringBootBatch
 - 输出文件：SpringBootBatch.zip
```
cd D:\WorkSpace\Java
mkdir SpringBootBatch

curl https://start.spring.io/starter.zip -d language=java -d type=maven-project -d dependencies=batch,h2 -d packageName=com.example.batch -d name=SpringBootBatch -o SpringBootBatch.zip

7z x SpringBootBatch.zip -oD:\WorkSpace\Java\SpringBootBatch
del SpringBootBatch.zip
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
	<artifactId>SpringBootBatch</artifactId>
	<description>SpringBootBatch project for Spring Boot</description>

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
``src/main/resources/application.properties``
```
spring.datasource.driverClassName=org.h2.Driver
spring.datasource.url=jdbc:h2:mem:test_db;DATABASE_TO_UPPER=false;MODE=PostgreSQL
#Spring Boot 2.5.6以后
spring.sql.init.platform=h2
spring.sql.init.mode=embedded
spring.sql.init.schema-locations=classpath:db/schema.sql
#spring.sql.init.data-locations=classpath:db/data.sql
spring.sql.init.encoding=UTF-8
spring.h2.console.enabled=true
```

### 新建一个简单的入口文件
``src/main/resources/sample-data.csv``
```
1,张三,学生
2,李四,快递员
3,王二,程序猿
4,赵一,工程狮
5,钱五,卖炊饼的
```

### 新建h2内存表
``src/main/resources/db/schema.sql``
```
CREATE TABLE IF NOT EXISTS people(
	person_id INT NOT NULL PRIMARY KEY,
	person_name VARCHAR(20),
	person_career VARCHAR(20)
);
```

### 新建实体类
保证字段属性要和数据库中的数据类型对应  
``src/main/java/com/example/batch/Person.java``
```
package com.example.batch;

public record Person(int personId, String personName, String personCareer) {
}
```

### 新建ItemProcessor的实现用来处理数据
``src/main/java/com/example/batch/PersonItemProcessor.java``
```
package com.example.batch;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.batch.item.ItemProcessor;
import org.springframework.lang.Nullable;

// ItemProcessor，即数据的处理逻辑
public class PersonItemProcessor implements ItemProcessor<Person, Person> {

	private static final Logger log = LoggerFactory.getLogger(PersonItemProcessor.class);

	@Override
	public Person process(@Nullable Person person) {
		if (person != null) {
			final int personId = person.personId() + 10;
			final String personName = person.personName() + "-以处理";
			final String personCareer = person.personCareer() + "-以处理";
			final Person transformedPerson = new Person(personId, personName, personCareer);
			log.info("转换 (" + person + ") 为 (" + transformedPerson + ")");
			return transformedPerson;
		} else {
			return person;
		}
	}
}
```

### 创建SpringBatch的配置类
用来配置Job  
``src/main/java/com/example/batch/BatchConfiguration.java``
```
package com.example.batch;

import javax.sql.DataSource;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.job.builder.JobBuilder;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.batch.core.step.builder.StepBuilder;
import org.springframework.batch.item.database.JdbcBatchItemWriter;
import org.springframework.batch.item.database.builder.JdbcBatchItemWriterBuilder;
import org.springframework.batch.item.file.FlatFileItemReader;
import org.springframework.batch.item.file.builder.FlatFileItemReaderBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;

@Configuration
public class BatchConfiguration {

	// 配置一个ItemReader，即数据的读取逻辑，这里读取sample-data.csv映射到Person.class
	@Bean
	public FlatFileItemReader<Person> reader() {
		return new FlatFileItemReaderBuilder<Person>()
				.name("personItemReader")
				.resource(new ClassPathResource("sample-data.csv"))
				.encoding("UTF-8")
				.delimited()
				.names("personId", "personName", "personCareer")
				.targetType(Person.class)
				.build();
	}

	// 配置ItemProcessor，即数据的处理逻辑
	@Bean
	public PersonItemProcessor processor() {
		return new PersonItemProcessor();
	}

	// 配置ItemWriter，即数据的写出逻辑，这里写出到h2数据库
	@Bean
	public JdbcBatchItemWriter<Person> writer(DataSource dataSource) {
		StringBuffer sql = new StringBuffer();
		sql.append(
				"INSERT INTO people (person_id, person_name, person_career) VALUES (:personId, :personName, :personCareer)");
		return new JdbcBatchItemWriterBuilder<Person>()
				.sql(sql.toString())
				.dataSource(dataSource)
				.beanMapped()
				.build();
	}

	// 配置一个Job
	@Bean
	public Job importUserJob(JobRepository jobRepository, Step step1, JobCompletionNotificationListener listener) {
		return new JobBuilder("importUserJob", jobRepository)
				.listener(listener)
				// 配置该Job的Step
				.start(step1)
				.build();
	}

	// 配置一个Step
	@Bean
	public Step step1(JobRepository jobRepository, DataSourceTransactionManager transactionManager,
			FlatFileItemReader<Person> reader, PersonItemProcessor processor, JdbcBatchItemWriter<Person> writer) {
		return new StepBuilder("step1", jobRepository)
				// chunk(3)，表示每读取到3条数据就执行1次write操作
				.<Person, Person>chunk(3, transactionManager)
				// 配置reader
				.reader(reader)
				// 配置processor
				.processor(processor)
				// 配置writer
				.writer(writer)
				.build();
	}
}
```

### 新建监听器
自定义监听器。在批处理作业在执行前后会调用监听器的方法；执行额外的统一逻辑
``src/main/java/com/example/batch/JobCompletionNotificationListener.java``
```
package com.example.batch;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.core.BatchStatus;
import org.springframework.batch.core.JobExecution;
import org.springframework.batch.core.JobExecutionListener;
import org.springframework.jdbc.core.DataClassRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

@Component
public class JobCompletionNotificationListener implements JobExecutionListener {

	private static final Logger log = LoggerFactory.getLogger(JobCompletionNotificationListener.class);

	private final JdbcTemplate jdbcTemplate;

	private long startTime;

	public JobCompletionNotificationListener(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	/**
	 * 该方法会在job开始前执行
	 */
	@Override
	public void beforeJob(JobExecution jobExecution) {
		startTime = System.currentTimeMillis();
		log.info("JOB 开始前  运行参数：" + jobExecution.getJobParameters());
	}

	/**
	 * 该方法会在job结束后执行
	 */
	@Override
	public void afterJob(JobExecution jobExecution) {
		if (jobExecution.getStatus() == BatchStatus.COMPLETED) {
			log.info("JOB 运行成功，验证运行结果");
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT person_id, person_name, person_career FROM people");
			jdbcTemplate.query(sql.toString(), new DataClassRowMapper<>(Person.class))
					.forEach(person -> log.info("在内存数据库H2中找到 <{{}}> ", person));
		} else if (jobExecution.getStatus() == BatchStatus.FAILED) {
			log.info("JOB 运行失败");
		}
		log.info("JOB 运行时间： {}/ms", (System.currentTimeMillis() - startTime));
	}
}
```

### 修改启动文件
``src/main/java/com/example/batch/SpringBootBatchApplication.java``
```
package com.example.batch;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class SpringBootBatchApplication {

	public static void main(String[] args) {
		System.exit(SpringApplication.exit(SpringApplication.run(SpringBootBatchApplication.class, args)));
	}
}
```

### 运行工程
```
chcp 936
cd D:\WorkSpace\Java\SpringBootBatch

# maven
mvnw spring-boot:run

# gradlew
gradlew bootRun
```

### 编译并运行jar文件
```
cd D:\WorkSpace\Java\SpringBootBatch

# maven
mvnw clean package
java -jar target/SpringBootBatch-0.0.1-SNAPSHOT.jar

# gradlew
gradlew build
java -jar build/libs/SpringBootBatch-0.0.1-SNAPSHOT.jar
```
