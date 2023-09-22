# Kotlin相关

## Kotlin简介
1. ``Kotlin`` 是一个基于JVM 的新的编程语言，由 JetBrains 开发
2. ``Kotlin`` 可以编译成Java字节码，也可以编译成JavaScript，方便在没有JVM的设备上运行
3. ``Kotlin`` 已正式成为Android官方支持开发语言

#### 相对于Java的优势：
1. 比Java更安全，能够静态检测常见的陷阱。如：引用空指针
2. 比Java更简洁
3. 源代码开源

## 中文教程
Kotlin中文教程：  
https://book.kotlincn.net/  
https://www.kotlincn.net/docs/tutorials/  
https://www.kotlincn.net/docs/reference/  

## 下载
可以从 GitHub Releases 页下载最新版本。
https://github.com/JetBrains/kotlin/releases/download/v1.9.10/kotlin-compiler-1.9.10.zip

## 配置环境变量
1. 配置 ``KOTLIN_HOME`` 和 ``JAVA_HOME``
2. ``PATH`` 下追加 ``%KOTLIN_HOME%\bin`` 和 ``%JAVA_HOME%\bin``
```
set JAVA_HOME=D:\Tools\WorkTool\Java\jdk17.0.6
set PATH=%PATH%;%JAVA_HOME%\bin
set KOTLIN_HOME=D:\Tools\WorkTool\Kotlin\kotlin-compiler-1.9.10
set PATH=%PATH%;%KOTLIN_HOME%\bin
```

## 确认版本
```
java -version
kotlin -version
kotlinc -version
```

## 编译命令
```
kotlinc hello.kt -include-runtime -d hello.jar
```
   - ``-d`` 选项指示生成的类文件的输出路径，可以是目录文件，也可以是.jar文件  
   - ``-include-runtime`` 选项通过在其中包含 Kotlin 运行时库，使生成的.jar文件自包含且可运行，**如果开发的是第三方库的话无需这个参数**  

## 运行程序
方式1：
```
java -jar hello.jar
```

方式2：
```
kotlin -classpath hello.jar HelloKt
```

## LSP服务器和DAP服务器
- LSP：  
https://github.com/fwcd/kotlin-language-server  
https://github.com/fwcd/kotlin-language-server/releases/download/1.3.5/server.zip  
- DAP：  
https://github.com/fwcd/kotlin-debug-adapter  
https://github.com/fwcd/kotlin-debug-adapter/releases/download/0.4.3/adapter.zip  

## 使用 VSCode
使用插件为  [**Kotlin**](https://marketplace.visualstudio.com/items?itemName=fwcd.kotlin) 和 [Code Runner](https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner) （Code Runer可选）  
这个插件并没有 ``kotlin`` 编译器的设置项目，如果条件不允许修改环境变量，可以用如下方式解决：  
新建 ``VSCode_Kotlin.cmd``  
内容如下  
```
set VSCODE_HOME=D:\Tools\WorkTool\Text\VSCode-win32-x64-1.81.1
set PATH=%PATH%;%VSCODE_HOME%
set JAVA_HOME=D:\Tools\WorkTool\Java\jdk17.0.6
set PATH=%PATH%;%JAVA_HOME%\bin
set KOTLIN_HOME=D:\Tools\WorkTool\Kotlin\kotlin-compiler-1.9.10
set PATH=%PATH%;%KOTLIN_HOME%\bin
start /b code
```
运行 ``VSCode_Kotlin.cmd`` 启动 ``VSCode`` 即可

#### VSCode下Kotlin项目的settings.json
```
{
	"kotlin.java.home": "D:\\Tools\\WorkTool\\Java\\jdk17.0.6",
	"kotlin.languageServer.enabled": true,
	"kotlin.languageServer.path": "D:\\Tools\\WorkTool\\Kotlin\\lsp\\server\\bin\\kotlin-language-server.bat",
	"kotlin.debugAdapter.enabled": true,
	"kotlin.debugAdapter.path": "D:\\Tools\\WorkTool\\Kotlin\\dap\\adapter\\bin\\kotlin-debug-adapter.bat",
}
```

## 使用 Vim
下载LSP服务端后，使用 ``vim-lsp`` 即可
