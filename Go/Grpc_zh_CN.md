# gRPC

## 简介
RPC，全称 Remote Procedure Call，中文译为远程过程调用。通俗地讲，使用 RPC 进行通信，调用远程函数就像调用本地函数一样， RPC 底层会做好数据的序列化与传输，从而能使我们更轻松地创建分布式应用和服务

``gRPC`` 是 RPC 的一种，它是免费且开源的，由谷歌出品。使用 gRPC ，我们只需要定义好每个 API 的 Request 和 Response ，剩下的 gRPC 这个框架会帮我们自动搞定

另外，gRPC 的典型特征就是使用 ``protobuf``（全称protocol buffers）作为其接口定义语言（Interface Definition Language，缩写IDL），同时底层的消息交换格式也是使用 protobuf

## 通信流程

 1. gRPC通信的第一步是定义IDL，即我们的接口文档（后缀为.proto）

 2. 编译proto文件，得到存根（stub）文件

 3. 服务端（gRPC Server）实现第一步定义的接口并启动，这些接口的定义在存根文件里面

 4. 客户端借助存根文件调用服务端的函数，虽然客户端调用的函数是由服务端实现的，但是调用起来就像是本地函数一样。

以上就是 gRPC 的基本流程，由于我们的 proto 文件的编译支持多种语言（Go、Java、Python等），所以 gRPC 也是 **跨语言的**

## gRPC官方支持的语言
 - C# / .NET
 - C++
 - Dart
 - Go
 - Java
 - Kotlin
 - Node
 - Objective-C
 - PHP
 - Python
 - Ruby

详见 [这里](https://grpc.io/docs/languages/)

## 简单示例

为了演示 gRPC 的 ``跨语言的`` 优势，这个示例会用同一个接口文档(IDL)，每种语言都会实现服务端和客户端，端口都使用 ``50051`` ，实际项目中需要自行修改一下  

示例的语言：Java / Python / Rust / Golang  
C语言弄环境有些麻烦，笔者偷懒没有写例子，可以了解一下这两个仓库 [Juniper-grpc-c](https://github.com/Juniper/grpc-c) 和 [lixiangyun-grpc-c](https://github.com/lixiangyun/grpc-c)

**代码**在 [这里](./Grpc)  
文件数结构如下
```
Grpc
│   ProductInfo.proto
├───go
│   │   .root
│   │   go.mod
│   │   go.sum
│   └───product
│       ├───client
│       │       main.go
│       └───server
│               main.go
├───java
│   │   .root
│   │   pom.xml
│   └───src
│       └───main
│           └───java
│               └───javagrpc
│                       ClientMain.java
│                       ServerMain.java
├───python
│       .root
│       client.py
│       server.py
└───rust
    │   .root
    │   build.rs
    │   Cargo.toml
    └───src
            client.rs
            main.rs
            server.rs
```

### 安装 protobuf

#### Windows
到 protobuf 的 github 页面下载二进制文件
 - [protobuf github](https://github.com/protocolbuffers/protobuf/releases)  
笔者下载的为 ``protoc-25.0-win64.zip``

#### MacOS
```
brew install protoc
```

#### Linux
```
sudo apt install protobuf-compiler
```

#### 确认
```
protoc --version
```

#### protoc内置支持的语言
**注意：此处为protoc，而不是gRPC**
```
  --cpp_out=OUT_DIR           Generate C++ header and source.
  --csharp_out=OUT_DIR        Generate C# source file.
  --java_out=OUT_DIR          Generate Java source file.
  --kotlin_out=OUT_DIR        Generate Kotlin file.
  --objc_out=OUT_DIR          Generate Objective-C header and source.
  --php_out=OUT_DIR           Generate PHP source file.
  --pyi_out=OUT_DIR           Generate python pyi stub.
  --python_out=OUT_DIR        Generate Python source file.
  --ruby_out=OUT_DIR          Generate Ruby source file.
  --rust_out=OUT_DIR          Generate Rust sources.
```
上面出现的语言参数，说明protoc本身已经内置该语言对应的编译插件，无需安装  
而如果上面没出现的，比如 ``--go_out=`` ，就得自己单独安装语言插件


### 编写 proto 文件 (定义IDL)
所有语言使用同一个定义文件，在工程根路径下，文件名： ``ProductInfo.proto``

### Go语言设置
安装Go语言所需工具
```
#go get -u google.golang.org/protobuf/cmd/protoc-gen-go
#go install google.golang.org/protobuf/cmd/protoc-gen-go
go install github.com/golang/protobuf/protoc-gen-go@latest

go get -u google.golang.org/grpc/cmd/protoc-gen-go-grpc
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc

ll %GOPATH%\bin
#需要有 protoc-gen-go.exe 和 protoc-gen-go-grpc.exe
```

编译proto文件，得到存根（stub）文件
```
cd D:\WorkSpace\Grpc
# 生成message的定义，message => struct
protoc --go_out=./go/product --go_opt=paths=source_relative  ProductInfo.proto

# 生成service的定义
protoc --go-grpc_out=./go/product  --go-grpc_opt=paths=source_relative  ProductInfo.proto
```
导入程序所需第三方库
```
cd D:\WorkSpace\Grpc\go
go get -u github.com/gofrs/uuid
go get -u google.golang.org/grpc
```
运行程序（方式1：直接实时运行）
```
cd D:\WorkSpace\Grpc\go
#运行服务端
go run ./product/server/main.go
cd D:\WorkSpace\Grpc\go
#运行客户端
go run ./product/client/main.go
```
运行程序（方式2：编译后运行）
```
cd D:\WorkSpace\Grpc\go
go build -o ./bin/server.exe ./product/server/main.go
go build -o ./bin/client.exe ./product/client/main.go
```

### Python语言设置
安装Python语言所需工具
```
#Python的gRPC源码包
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple grpcio
# gRPC的proto生成python源代码的工具
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple grpcio-tools
#pip install -i https://pypi.tuna.tsinghua.edu.cn/simple googleapis-common-protos
```

编译proto文件，得到存根（stub）文件
```
cd D:\WorkSpace\Grpc
python -m grpc_tools.protoc --python_out=./python --grpc_python_out=./python -I. ProductInfo.proto
```

运行程序
```
cd D:\WorkSpace\Grpc\python
#运行服务端
python server.py
cd D:\WorkSpace\Grpc\python
#运行客户端
python client.py
```

### Java语言设置

#### 获取protoc-gen-grpc-java插件 - 方式1：命令行
在这个仓库 [protoc-gen-grpc-java](https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/) 找到二进制，笔者使用的为 ``1.59.0/protoc-gen-grpc-java-1.59.0-windows-x86_64.exe``  
下载后和 ``protoc.exe`` 放在同路径下
```
D:\Tools\WorkTool\Go\protoc-25.0-win64\bin
```

#### 获取protoc-gen-grpc-java插件 - 方式2：使用IDE插件
参照 [这里](https://grpc.io/docs/languages/java/generated-code/#codegen) 的 ``Codegen`` 处设定


在Maven的pom.xml中加入定义
```
<dependency>
    <groupId>io.grpc</groupId>
    <artifactId>grpc-netty-shaded</artifactId>
    <version>1.59.0</version>
    <scope>runtime</scope>
</dependency>
<dependency>
    <groupId>io.grpc</groupId>
    <artifactId>grpc-protobuf</artifactId>
    <version>1.59.0</version>
</dependency>
<dependency>
    <groupId>io.grpc</groupId>
    <artifactId>grpc-stub</artifactId>
    <version>1.59.0</version>
</dependency>
<dependency>
    <!-- necessary for Java 9+ -->
    <groupId>org.apache.tomcat</groupId>
    <artifactId>annotations-api</artifactId>
    <version>6.0.53</version>
    <scope>provided</scope>
</dependency>
```

编译proto文件，得到存根（stub）文件
```
cd D:\WorkSpace\Grpc
protoc --java_out=./java/src/main/java ProductInfo.proto

#protoc --plugin=protoc-gen-grpc-java=protoc-gen-grpc-java-1.59.0-windows-x86_64.exe --grpc-java_out=./java/src/main/java ProductInfo.proto
protoc --plugin=protoc-gen-grpc-java=D:/Tools/WorkTool/Go/protoc-25.0-win64/bin/protoc-gen-grpc-java-1.59.0-windows-x86_64.exe --grpc-java_out=./java/src/main/java ProductInfo.proto
```

运行程序
```
cd D:\WorkSpace\Grpc\java
mvn compile
#运行服务端
mvn exec:java -Dexec.mainClass="javagrpc.ServerMain"

cd D:\WorkSpace\Grpc\java
#运行客户端
mvn exec:java -Dexec.mainClass="javagrpc.ClientMain"
```

#### Java中和SpringBoot集成
可以参考 [这里](https://zhuanlan.zhihu.com/p/464658805) 的 ``方式二``

### Rust语言设置

需要Rust版本大于 ``1.39``  
这里主要使用 ``tonic`` [Github地址](https://github.com/hyperium/tonic)&nbsp;&nbsp;[Crate地址](https://docs.rs/tonic/latest/tonic/)  
因为Cargo可以为我们下载所需要的第三方库，所以只要编译一次即可

创建工程 → 下载第三方库并且编译
```
cd D:\WorkSpace\Grpc
#cargo new rust
cd rust
cargo build
```

运行程序
```
cd D:\WorkSpace\Grpc\rust
#运行服务端
cargo run --bin rustserver

cd D:\WorkSpace\Grpc\rust
#运行客户端
cargo run --bin rustclient
```
### TypScript语言+Node.js设置

在 Node.js 中有两个版本的 grpc
- grpc-tools + @grpc/grpc-js  
  静态编译版本，纯 js 实现，使用工具来生成存根

- @grpc/proto-loader + @grpc/grpc-js  
  动态加载版本，在 Node.js 启动时动态加载并处理 proto 定义，然后使用一些抽象封装来实现

笔者觉得动态加载版本比较简单一些，推荐使用

#### 静态编译版本
安装所需构筑工具和第三方库
```
cd D:\WorkSpace\Grpc\node
#npm install --save-dev grpc-tools grpc_tools_node_protoc_ts @grpc/grpc-js @types/node @types/node-uuid @types/uuid uuid
npm install
```
编译proto文件，得到存根（stub）文件
```
cd D:\WorkSpace\Grpc
set PATH=%PATH%;D:\WorkSpace\Grpc\node\node_modules\.bin
#grpc_tools_node_protoc --plugin=protoc-gen-ts=D:/WorkSpace/Grpc/node/node_modules/.bin/protoc-gen-ts --js_out=import_style=commonjs,binary:./node/src --grpc_out=grpc_js:./node/src --ts_out=service=grpc-node,mode=grpc-js:./node/src ProductInfo.proto
#生成到src
grpc_tools_node_protoc --js_out=import_style=commonjs,binary:./node/src --grpc_out=grpc_js:./node/src --ts_out=service=grpc-node,mode=grpc-js:./node/src ProductInfo.proto
#生成到dist
grpc_tools_node_protoc --js_out=import_style=commonjs,binary:./node/dist --grpc_out=grpc_js:./node/dist --ts_out=service=grpc-node,mode=grpc-js:./node/dist ProductInfo.proto
```

运行程序
```
cd D:\WorkSpace\Grpc\node
tsc -p tsconfig.json
#运行服务端
npm run server

cd D:\WorkSpace\Grpc\node
#运行客户端
npm run client
```

#### 动态加载版本
安装所需第三方库
```
cd D:\WorkSpace\Grpc\node_dynamic
#npm install --save-dev @grpc/proto-loader @grpc/grpc-js @types/node @types/node-uuid @types/uuid uuid
npm install
```
NOTE：动态版本不需要编译proto文件

运行程序
```
cd D:\WorkSpace\Grpc\node_dynamic
tsc -p tsconfig.json
#运行服务端
npm run server

cd D:\WorkSpace\Grpc\node_dynamic
#运行客户端
npm run client
```

### 关于Web方面
gRPC原本设想是在纯后端使用的，由于浏览器的限制，不能直接从浏览器发送gRPC请求到后端。如果真的有这种需求的话，有两种对应方法

#### 方式1
```mermaid
graph LR
    浏览器 -- HTTP --> 服务器A;
    服务器A -- gRPC --> 服务器B;
```
使用 [grpc-gateway](https://github.com/grpc-ecosystem/grpc-gateway) 可以自动生成上图 ``服务器A`` 的部分（笔者没有测试）

#### 方式2
```mermaid
graph LR
    浏览器 -- XHR --> 代理服务器proxy;
    代理服务器proxy -- gRPC --> 服务器;
```
使用 [grpc-web](https://github.com/grpc/grpc-web) 可以实现，因为还需要设置代理，笔者也没有测试。 在 [这里](https://grpc.io/docs/platforms/web/basics/) 有官方教程。[这里](https://qiita.com/hedrall/items/9f4c03c3a6518504473a) 的``WEBブラウザから呼び出す``部分有一个例子

## 通信模式
gRPC 包含四种基础的通信模式：
 - 一元模式（Unary RPC）
 - 服务器端流 RPC（Server Sreaming RPC）
 - 客户端流 RPC（Client Streaming RPC）
 - 双向流 RPC（Bidirectional Streaming RPC）

笔者写的示例为 ``一元模式``  
更多可以看 [这里](https://zhuanlan.zhihu.com/p/360355222)

## 拦截器、截止、取消
关于这部分内容可以看 [这里](https://zhuanlan.zhihu.com/p/361913816)

## 多路复用、元数据、负载均衡
关于这部分内容可以看 [这里](https://zhuanlan.zhihu.com/p/364325400)
