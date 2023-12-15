# Java-Gradle相关

## 下载
去 [主页](https://gradle.org/releases/) 下载解压缩后即可使用  
笔者下载的为 [gradle-8.5-all.zip](https://github.com/gradle/gradle-distributions/releases/download/v8.5.0/gradle-8.5-all.zip)

#### 环境变量配置
需要配置3个环境变量
 - JAVA_HOME ： JDK路径
 - GRADLE_HOME ： Gradle路径
 - GRADLE_USER_HOME（可选） ： 本地仓库路径，默认路径为 ``$USER_HOME/.gradle``

示例
```
set JAVA_HOME=D:\Tools\WorkTool\Java\jdk17.0.6
set PATH=%PATH%;%JAVA_HOME%\bin
set GRADLE_HOME=D:\Tools\WorkTool\Java\gradle-8.5
set PATH=%PATH%;%GRADLE_HOME%\bin
```

更多看 [这里](https://docs.gradle.org/8.5/userguide/build_environment.html#sec:gradle_environment_variables)

## 安装后确认
```
gradle -v
```

## 修改设定使用阿里云源
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

### 关于init.gradle

``init.gradle`` 文件在 build 开始之前执行，可以在这个文件配置一些你想预先加载的操作，例如：指定仓库的地址、build日志输出，机器信息（比如jdk安装目录），build时所必需的个人信息（比如仓库或者数据库的认证信息）

### 启用init.gradle文件的方法
 1. 在命令行指定文件，例如：``gradle –init-script yourdir/init.gradle -q taskName`` 你可以多次输入此命令来指定多个init文件
 2. 把 ``init.gradle`` 文件放到 ``$USER_HOME/.gradle`` 目录下.
 3. 把 ``以.gradle结尾的文件`` 放到 ``$USER_HOME/.gradle/init.d/`` 目录下.
 4. 把 ``以.gradle结尾的文件`` 放到 ``$GRADLE_HOME/init.d/`` 目录下.

如果存在上面的4种方式的2种以上，gradle会按上面的1-4序号依次执行这些文件，如果给定目录下存在多个init脚本，会按拼音a-z顺序执行这些脚本

## Gradle命令

#### 创建工程
命令为
```
gradle init
```
依次选择
 - 2: application
 - 3: Java
 - no
 - 1: Kotlin
 - 1: JUnit 4

其他根据偏好选择，不知道该选什么就直接回车用默认  

示例
```
cd D:\WorkSpace\Java
mkdir JavaGradleProject
cd JavaGradleProject
gradle init
```

#### 修改 Gradle Wrapper 引用本地的发布包
构建好工程之后，在 ``.\gradle\wrapper`` 目录下有一个 ``gradle-wrapper.properties`` 文件  
修改 ``distributionUrl`` 内容，改为使用国内源
```
distributionUrl=https\://services.gradle.org/distributions/gradle-8.5-bin.zip
```
为
```
distributionUrl=https\://mirrors.cloud.tencent.com/gradle/gradle-8.5-bin.zip
```

如果不使用VSCode，也可以直接用本地下载好的文件（VSCode无法这样设定）
```
distributionUrl=file\:/D:/ToolInstall/Java/gradle-8.5-all.zip
```

#### 编译工程
有 2 种方式编译工程  
 1. 通过本机安装好的 ``gradle`` 命令编译
 2. 通过当前项目根目录下的 ``gradlew`` 命令编译（官方推荐的使用方式）
```
gradlew build
```
第一次运行会有些慢，稍等一下即可


#### 运行工程
确认运行任务
```
gradlew tasks
```
运行工程
```
gradlew run
```

#### 运行测试
```
gradlew test
```
测试的结果报告在 ``.\app\build\reports\tests\test\index.html``

## 工程设定文件
设定文件为 ``.\app\build.gradle.kts``

#### 依赖库设定
```
dependencies {
    testImplementation(libs.junit)
    implementation(libs.guava)
}
```

#### Java版本设定
```
java {
    toolchain {
        languageVersion.set(JavaLanguageVersion.of(17))
    }
}
```

#### 工程入口设定
```
application {
    mainClass.set("javagradleproject.App")
}
```

#### 添加编译参数选项
```
tasks.compileJava {
    options.encoding = "UTF-8"
}
tasks.compileTestJava {
    options.encoding = "UTF-8"
}
```

## 使用VSCode开发
使用插件为： [Gradle for Java](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-gradle)  
VSCode的设定文件看 [JavaGradleProject](./JavaGradleProject/)  
