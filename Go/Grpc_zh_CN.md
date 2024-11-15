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

示例的语言：Java / Python / Rust / Golang / NodeJs / C#  
C语言弄环境有些麻烦，笔者偷懒没有写例子，可以了解一下这两个仓库 [Juniper-grpc-c](https://github.com/Juniper/grpc-c) 和 [lixiangyun-grpc-c](https://github.com/lixiangyun/grpc-c)

**代码**在 [这里](./Grpc)  

## 构建体系

``Java`` 的 Maven插件， ``.NET`` 平台， ``Rust`` 的 ``tonic_build`` 集成了自动生成存根的功能，除了这3个语言，之外的可以按需要如下选择工具链

### 方式1：使用 ``Buf`` 工具链（推荐）

从 proto 文件 文件编译成存根每次都需要运行命令编译，使用起来会比较繁琐，可以使用 ``Buf`` 工具链

``Buf`` 是一个 一体化 Protobuf 的工具链，使用起来非常方便，开启远程插件的情况下，本地只需要一个 ``buf.exe`` 即可
 - [Github](https://github.com/bufbuild/buf)
 - [官网](https://buf.build/product/cli)
 - [Docker Hub](https://hub.docker.com/r/bufbuild/buf)

在 ``Github`` 的下载页，下载 ``buf-Windows-x86_64.exe`` 二进制，放到 ``%PATH%``，并重命名为 ``buf.exe`` 后确认
```bash
buf --version
```

也可以选择 npm 下载
```bash
npm install @bufbuild/buf
```

### 方式2：使用 ``protobuf`` 命令行

安装 protobuf

#### Windows
到 protobuf 的 github 页面下载二进制文件
 - [protobuf github](https://github.com/protocolbuffers/protobuf/releases)  
笔者下载的为 ``protoc-25.0-win64.zip``

#### MacOS
```bash
brew install protoc
```

#### Linux
```bash
sudo apt install protobuf-compiler
```

#### 确认
```bash
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

## Go语言示例

官方 [Github](https://github.com/grpc/grpc-go) 仓库  
官方示例 [Github](https://github.com/grpc/grpc-go/tree/master/examples) 仓库  
OpenTelemetry监测实现 [Github](https://github.com/grpc/grpc-go/tree/master/examples/features/opentelemetry) 仓库

首先先确认 ``%GOPATH%`` 在 ``%PAH%`` 中

### 方式1：使用 ``Buf`` 工具链

```bash
cd D:\WorkSpace\Grpc\go
go mod tidy
# 生成存根
buf generate
# 编译服务端
go build -o ./bin/server.exe ./product/server/main.go
# 编译客户端
go build -o ./bin/client.exe ./product/client/main.go
```

### 方式2：直接使用命令行编译

安装Go语言所需工具
```bash
# go install github.com/golang/protobuf/protoc-gen-go@latest
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
```
```bash
ll %GOPATH%\bin
```
确认是否有 ``protoc-gen-go.exe`` 和 ``protoc-gen-go-grpc.exe``

编译proto文件，得到存根（stub）文件
```bash
cd D:\WorkSpace\Grpc
# 生成message的定义，message => struct
protoc --go_out=./go/product --go_opt=paths=source_relative  ProductInfo.proto

# 生成service的定义
protoc --go-grpc_out=./go/product  --go-grpc_opt=paths=source_relative  ProductInfo.proto
```
导入程序所需第三方库
```bash
cd D:\WorkSpace\Grpc\go
# go get -u github.com/gofrs/uuid
go get -u github.com/google/uuid
go get -u google.golang.org/grpc
```
运行程序（方式1：直接实时运行）
```bash
cd D:\WorkSpace\Grpc\go
# 运行服务端
go run ./product/server/main.go
cd D:\WorkSpace\Grpc\go
# 运行客户端
go run ./product/client/main.go
```
运行程序（方式2：编译后运行）
```bash
cd D:\WorkSpace\Grpc\go
go build -o ./bin/server.exe ./product/server/main.go
go build -o ./bin/client.exe ./product/client/main.go
```

## Python语言示例

官方 [Github](https://github.com/grpc/grpc/tree/master/src/python/grpcio) 仓库  
官方示例 [Github](https://github.com/grpc/grpc/tree/master/examples/python) 仓库  
OpenTelemetry监测实现 [Github](https://github.com/grpc/grpc/tree/master/examples/python/observability) 仓库

### 方式1：使用 ``Buf`` 工具链

```bash
cd D:\WorkSpace\Grpc\python
poetry install
# 生成存根
buf generate
# 编译服务端
poetry run python src\server.py
# 编译客户端
poetry run python src\client.py
```

### 方式2：直接使用命令行编译

安装Python语言所需工具
```bash
# Python的gRPC源码包
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple grpcio
# gRPC的proto生成python源代码的工具
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple grpcio-tools
#pip install -i https://pypi.tuna.tsinghua.edu.cn/simple googleapis-common-protos
```

编译proto文件，得到存根（stub）文件
```bash
cd D:\WorkSpace\Grpc
python -m grpc_tools.protoc --python_out=./python --grpc_python_out=./python -I. ProductInfo.proto
```

运行程序
```bash
cd D:\WorkSpace\Grpc\python
#运行服务端
python server.py
cd D:\WorkSpace\Grpc\python
#运行客户端
python client.py
```

### ModuleNotFoundError错误

如果使用生成的代码时发生了 ``ModuleNotFoundError: No module named 'ProductInfo_pb2'``，如下修改即可

#### 解决方案1
在目录下新建 ``__init__.py`` ，内容参照 [这里](./Grpc/python/src/stub/__init__.py)

相关讨论可以看 [这里](https://github.com/protocolbuffers/protobuf/issues/881)

#### 解决方案2
将
```python
import ProductInfo_pb2 as ProductInfo__pb2
```
修改为
```python
from . import ProductInfo_pb2 as ProductInfo__pb2
```
相关讨论可以看 [这里](https://github.com/protocolbuffers/protobuf/issues/1491)

### 一个Python的负载均衡实现
https://github.com/flagman/grpc-load-balancer

## Java语言示例（已实现客户端负载均衡）

官方 [Github](https://github.com/grpc/grpc-java) 仓库  
官方示例 [Github](https://github.com/grpc/grpc-java/tree/master/examples) 仓库  
OpenTelemetry监测实现 [Github](https://github.com/grpc/grpc-java/tree/master/examples/example-opentelemetry) 仓库  
OpenTelemetry的零代码实现 [Github](https://github.com/open-telemetry/opentelemetry-java-instrumentation/tree/main/instrumentation/grpc-1.6/library) 仓库


### Java实现的存根(Stub)
在 Java 的实现中 gRPC 默认提供了三种 ``stub``，``stub`` 有点类似 http 的 client，grpc 默认提供了几种 stub 实现

 - xxxBlockingStub：同步阻塞式
 - xxxFutureStub：批量式（可同步可异步，基于 Future-Listener 机制）
 - xxxStub：异步（基于 Reactive 的响应式编程模式）

#### 不同 stub 支持的模式
| name            | 描述      | 1v1 | 1vN | Nv1 | NvN |
|-----------------|-----------|-----|-----|-----|-----|
| xxxBlockingStub | 同步/阻塞 | ✔   | ✔   | ❌   | ❌   |
| xxxFutureStub   | 批量      | ✔   | ❌   | ❌   | ❌   |
| xxxStub         | 异步      | ✔   | ✔   | ✔   | ✔   |

#### 主类说明
 - ServerMain - 服务端
 - ClientMain - 客户端（xxxBlockingStub：阻塞式，实现了客户端负载均衡）
 - ClientAsyncMain - 客户端（xxxStub：异步方式，实现了客户端负载均衡）
 - ServerStopMain - 向服务器发送停止服务的客户端（xxxFutureStub：异步方式）


#### 方式1：在Maven项目中集成proto和gprc的自动编译
参考 [java](./Grpc/java) 工程下的 ``pom.xml`` 即可  
用这种方式时，proto文件放在 ``src/main/proto`` 和 ``src/test/proto``  
更多可以看 [这里](https://www.xolstice.org/protobuf-maven-plugin/usage.html)

运行程序
```bash
cd D:\WorkSpace\Grpc\java
mvn compile

#运行服务端
mvn exec:java -Dexec.mainClass="javagrpc.main.ServerMain" -Dprotoc.skip=true

#运行客户端（同步式）
mvn exec:java -Dexec.mainClass="javagrpc.main.ClientMain" -Dexec.cleanupDaemonThreads=false -Dprotoc.skip=true

#运行客户端（异步式）
mvn exec:java -Dexec.mainClass="javagrpc.main.ClientAsyncMain" -Dexec.cleanupDaemonThreads=false -Dprotoc.skip=true

#发送停止服务端请求
mvn exec:java -Dexec.mainClass="javagrpc.main.ServerStopMain" -Dexec.args="127.0.0.1 50051" -Dexec.cleanupDaemonThreads=false -Dprotoc.skip=true
```

#### 方式2：直接使用命令行编译
在这个仓库 [protoc-gen-grpc-java](https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/) 找到二进制，笔者使用的为 ``1.59.0/protoc-gen-grpc-java-1.59.0-windows-x86_64.exe``  
下载后和 ``protoc.exe`` 放在同路径下
```
D:\Tools\WorkTool\Go\protoc-25.0-win64\bin
```

编译proto文件，得到存根（stub）文件
```bash
set JAVA_TOOL_OPTIONS=-Duser.language=en

cd D:\WorkSpace\Grpc
protoc --java_out=./java/src/main/java ProductInfo.proto

# protoc --plugin=protoc-gen-grpc-java=protoc-gen-grpc-java-1.59.0-windows-x86_64.exe --grpc-java_out=./java/src/main/java ProductInfo.proto
protoc --plugin=protoc-gen-grpc-java=D:/Tools/WorkTool/Go/protoc-25.0-win64/bin/protoc-gen-grpc-java-1.59.0-windows-x86_64.exe --grpc-java_out=./java/src/main/java ProductInfo.proto
```

#### 下面这个仓库有很多示例
https://github.com/saturnism/grpc-by-example-java

#### Java中和SpringBoot集成
可以参考 [这里](https://zhuanlan.zhihu.com/p/464658805) 的 ``方式二``

## Rust语言示例

需要Rust版本大于 ``1.71``  
这里主要使用 ``tonic`` 库 [Github地址](https://github.com/hyperium/tonic)&nbsp;&nbsp;[Crate地址](https://docs.rs/tonic/latest/tonic/)  
通过 ``tonic_build`` 来自动生成存根的功能，详见 [这里](https://docs.rs/tonic-build/latest/tonic_build)  
官方示例 [Github](https://github.com/hyperium/tonic/tree/master/examples) 仓库  


创建工程 → 下载第三方库并且编译
```bash
cd D:\WorkSpace\Grpc
#cargo new rust
cd rust
cargo build
```

运行程序
```bash
cd D:\WorkSpace\Grpc\rust
#运行服务端
cargo run --bin rustserver

cd D:\WorkSpace\Grpc\rust
#运行客户端
cargo run --bin rustclient
```

### 一些 Rust 的例子
https://github.com/rthomas/rust-tonic-jaeger-example  

## TypScript语言+Node.js示例

官方 [Github](https://github.com/grpc/grpc-node) 仓库  
官方示例 [Github](https://github.com/grpc/grpc-node/tree/master/examples) 仓库  

### 官方实现
在 Node.js 中有如下几个实现

- [@grpc/grpc-js](https://www.npmjs.com/package/@grpc/grpc-js)  
  静态编译版本，纯 JavaScript 实现，使用工具来生成存根

- ~~[grpc](https://www.npmjs.com/package/grpc)~~  
  C 语言内核实现，只支持到 Node.js 14，不推荐使用

- [@grpc/proto-loader](https://www.npmjs.com/package/@grpc/proto-loader)  
  动态加载实现，在 Node.js 启动时动态加载并处理 proto 定义，然后使用一些抽象封装来实现

### 存根生成工具链
- ``Buf`` 工具链
- [grpc-tools](https://www.npmjs.com/package/grpc-tools) 工具链  

### 笔者推荐 - 下面2选1即可
- ``Buf`` 工具链 + [@grpc/grpc-js](https://www.npmjs.com/package/@grpc/grpc-js) 实现
- [@grpc/proto-loader](https://www.npmjs.com/package/@grpc/proto-loader) 动态加载实现

### 方式1：使用 ``Buf`` 工具链 + ``@grpc/grpc-js``（推荐）
```bash
cd D:\WorkSpace\Grpc\node
# 生成存根
bun run generate
# 编译
bun run build
# bun 暂时不支持 HTTP 2.0，所以用node运行
# 运行服务端
node dist/server.js
# 运行客户端
node dist/client.js
```

### 方式2：使用 ``grpc-tools``  + ``@grpc/grpc-js`` （不推荐）
安装所需构筑工具和第三方库
```bash
cd D:\WorkSpace\Grpc\node
#npm install --save-dev grpc-tools grpc_tools_node_protoc_ts @grpc/grpc-js @types/node @types/node-uuid @types/uuid uuid
npm install
```
编译proto文件，得到存根（stub）文件
```bash
cd D:\WorkSpace\Grpc
set PATH=%PATH%;D:\WorkSpace\Grpc\node\node_modules\.bin
#grpc_tools_node_protoc --plugin=protoc-gen-ts=D:/WorkSpace/Grpc/node/node_modules/.bin/protoc-gen-ts --js_out=import_style=commonjs,binary:./node/src --grpc_out=grpc_js:./node/src --ts_out=service=grpc-node,mode=grpc-js:./node/src ProductInfo.proto
#生成到src
grpc_tools_node_protoc --js_out=import_style=commonjs,binary:./node/src --grpc_out=grpc_js:./node/src --ts_out=service=grpc-node,mode=grpc-js:./node/src ProductInfo.proto
#生成到dist
grpc_tools_node_protoc --js_out=import_style=commonjs,binary:./node/dist --grpc_out=grpc_js:./node/dist --ts_out=service=grpc-node,mode=grpc-js:./node/dist ProductInfo.proto
```

运行程序
```bash
cd D:\WorkSpace\Grpc\node
tsc -p tsconfig.json
#运行服务端
npm run server

cd D:\WorkSpace\Grpc\node
#运行客户端
npm run client
```

### 方式3：动态加载版本 ``@grpc/proto-loader``
安装所需第三方库
```bash
cd D:\WorkSpace\Grpc\node_dynamic
#npm install --save-dev @grpc/proto-loader @grpc/grpc-js @types/node @types/node-uuid @types/uuid uuid
npm install
```
NOTE：动态版本不需要编译proto文件

运行程序
```bash
cd D:\WorkSpace\Grpc\node_dynamic
tsc -p tsconfig.json
#运行服务端
npm run server

cd D:\WorkSpace\Grpc\node_dynamic
#运行客户端
npm run client
```

## C#语言示例

目前，在.NET上有两种官方实现
- [Grpc.Core](https://github.com/grpc/grpc/tree/v1.46.x/src/csharp/) ：这个是原来的gRPC C#库，它基于原生gPRC（C-Core）核心库实现，已经进入到了维护模式
- [grpc-dotnet](https://github.com/grpc/grpc-dotnet) ：这是新的库，完全使用C#编写实现，没有原生依赖，基于.NET Core 3.0

如果是新项目，推荐用后者；如果是老项目（比如还在用.netframework的老项目），可以考虑用前者。在 Grpc.Examples 文件夹下可以找到示例

### 新版 .NET Core 示例
官方 [Github](https://github.com/grpc/grpc-dotnet) 仓库  
官方示例 [Github](https://github.com/grpc/grpc-dotnet/tree/master/examples) 仓库  
微软官方 [示例](https://learn.microsoft.com/zh-cn/aspnet/core/tutorials/grpc/grpc-start?view=aspnetcore-8.0&tabs=visual-studio)  

#### 项目说明
- netcore - 主工程（.NET Core 8）
    - netcoreServer - 服务端（grpc-dotnet实现）
    - netcoreClient - 客户端（grpc-dotnet实现，异步式和阻塞式都有）

创建命令
```bash
cd D:\WorkSpace\Grpc
mkdir netcore
cd netcore
# 创建sln文件
dotnet new sln -n netcore
# 创建服务端项目
dotnet new grpc -o netcoreServer --framework net8.0
# 创建客户端项目
dotnet new console -o netcoreClient --framework net8.0
# 将项目添加到解决方案
dotnet sln add netcoreServer/netcoreServer.csproj
dotnet sln add netcoreClient/netcoreClient.csproj
# 添加服务端依赖（无）
# 添加客户端依赖
cd netcoreClient
dotnet add package Grpc.Net.Client
dotnet add package Google.Protobuf
dotnet add package Grpc.Tools
cd ..
# 运行服务端
dotnet run --project netcoreServer
# 运行客户端
dotnet run --project netcoreClient -- Sync
dotnet run --project netcoreClient -- Async
```

或者下载笔者的工程后运行命令
```bash
cd D:\WorkSpace\Grpc\netcore
# 运行服务端
dotnet run --project netcoreServer
# 运行客户端
dotnet run --project netcoreClient -- Sync
dotnet run --project netcoreClient -- Async
```

### 旧版 .NET Framework 示例（已实现客户端负载均衡）

#### 项目说明
- netframework - 主工程（.NET Framework 4.8）
    - netframeworkServer - 服务端（Grpc.Core实现）
    - netframeworkClient - 客户端（Grpc.Core实现，阻塞式，有客户端负载均衡）
    - netframeworkClientAsync - 客户端（Grpc.Core实现，异步式，有客户端负载均衡）

#### 工程创建方式（Grpc.Core实现）
1. 参考 [这里](../Dotnet/Dotnet_zh_CN.md) 安装 ``Visual Studio Express 2017``
2. 使用 VS 打开 [netframework](./Grpc/netframework/) 工程
3. 鼠标右键 -> ``管理 NuGet 程序包`` -> 将 [Grpc](https://www.nuget.org/packages/Grpc/) 添加为依赖项
4. 将 [Grpc.Tools](https://www.nuget.org/packages/Grpc.Tools/) 添加为依赖项，此包提供将proto文件编译为存根（stub）文件
5. 将 [Google.Protobuf](https://www.nuget.org/packages/Google.Protobuf/) 添加为依赖项
6. 将工程的C#版本修改为 ``7.1`` 以上，笔者使用的为 ``7.3``（``右键工程`` -> ``属性`` -> ``生成`` -> 最下面的``高级`` -> ``语言版本``）
7. 参照 [这里](https://github.com/grpc/grpc/blob/v1.46.x/src/csharp/BUILD-INTEGRATION.md)，将 ``.proto`` 文件放到2个子工程的根路径，单击 ``显示所有文件`` 按钮 -> ``包括在项目中``，然后在 ``属性`` 窗口下拉列表中将 ``.proto 文件`` 的 ``Build Action`` 更改为 ``Protobuf``
8. （可选）如果需要 ``Grpc.HealthCheck``的话，选择项目，菜单栏的 ``工具`` -> ``NuGet 包管理器`` -> ``包管理器控制台``，输入下面的命令安装，从 2.47.0 开始此包将作为 grpc-dotnet 版本的一部分发布
    ```
    Install-Package Grpc.HealthCheck -Version 2.46.6
    ```

**Note1**：导入工程后如果发生 ``Google.Protobuf.Tools proto compilation is only supported by default in a C# project`` 这个错误，删除 ``.vs`` 文件夹后重启 Visual Studio 即可  
**Note2**：可以在 ``解决方案资源管理器`` 中右键 -> ``还原 NuGet 包`` 以随时还原包


#### 关于.Net Framework工程中使用grpc-dotnet实现
在 [微软官方网站](https://learn.microsoft.com/zh-cn/aspnet/core/grpc/netstandard?view=aspnetcore-8.0#net-framework) 有前提说明
因为需要 ``Wndows 11 +``，所以笔者测试报错了，结论就是老老实实用 ``Grpc.Core`` 实现吧
```
System.InvalidOperationException: The channel configuration isn't valid on this operating system. The channel is configured to use WinHttpHandler and the current version of Windows doesn't support HTTP/2 features required by gRPC. Windows Server 2022 or Windows 11 or later is required. For more information, see https://aka.ms/aspnet/grpc/netframework.
```

#### 下面这个仓库有很多示例
https://github.com/wicharypawel/net-core-grpc-load-balance

## 关于Web方面
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

## 官方文档
https://grpc.io/docs/guides/

## 配置通道凭据

通道必须知道是否使用传输安全性发送了 gRPC 调用。 http 和 https 不再是地址的一部分，方案现在指定一个解析程序，使得在使用负载均衡时必须对通道选项配置 Credentials。

 - ``ChannelCredentials.SecureSsl`` - gRPC 调用使用 ``ChannelCredentials.SecureSsl`` 进行保护。 等同于 ``https`` 地址。

 - ``ChannelCredentials.Insecure`` - gRPC 调用不使用传输安全性。 等同于 ``http`` 地址。

## gRPC 客户端负载均衡

#### 微软提供的教程
https://learn.microsoft.com/zh-cn/aspnet/core/grpc/loadbalancing

#### 例子
1. 我们分别启动4个服务端
 - Java服务端：50051，50052
 - netframework服务端：50053，50054

启动命令：
```bash
mvn exec:java -Dexec.mainClass="javagrpc.main.ServerMain"
mvn exec:java -Dexec.mainClass="javagrpc.main.ServerMain" -Dexec.args="50052"
.\netframeworkServer.exe 50053
.\netframeworkServer.exe 50054
```
2. 启动C#客户端来进行验证
```bash
.\netframeworkClientAsync.exe
```

## 通信模式
gRPC 包含四种基础的通信模式：
 - 一元模式（Unary RPC）  
    客户端向服务器发送单个请求并获得 单次响应，就像普通的函数调用一样
    ```
    rpc SayHello(HelloRequest) returns (HelloResponse);
    ```

 - 服务器端流 RPC（Server Sreaming RPC）  
    服务器流式处理 RPC，服务器在收到客户端的请求后，可能会发送多个响应的序列
    ```
    rpc LotsOfReplies(HelloRequest) returns (stream HelloResponse);
    ```

 - 客户端流 RPC（Client Streaming RPC）
    客户端流式处理 RPC，客户端会发送多个请求给服务端，服务端会发送一条响应到客户端
    ```
    rpc LotsOfGreetings(stream HelloRequest) returns (HelloResponse);
    ```

 - 双向流 RPC（Bidirectional Streaming RPC）
    双向流式处理 RPC，客户端和服务端流 RPC 的组合，客户端以消息流的方式发送数据，服务端也已消息流的方式响应数据
    ```
    rpc BidiHello(stream HelloRequest) returns (stream HelloResponse);
    ```

笔者写的示例为 ``一元模式``  
更多可以看 [这里](https://zhuanlan.zhihu.com/p/360355222)

## 拦截器、截止、取消
关于这部分内容可以看 [这里](https://zhuanlan.zhihu.com/p/361913816)

## 多路复用、元数据、负载均衡
关于这部分内容可以看 [这里](https://zhuanlan.zhihu.com/p/364325400)

## gRPC服务监测
gRPC [提供 OpenTelemetry](https://grpc.io/docs/guides/opentelemetry-metrics/) 的监测，不过gRPC自己的各个语言实现还没有全部完成

OpenTelemetry 也提供了SDK为各个框架提供支持，[这里](https://github.com/open-telemetry/opentelemetry-java-instrumentation/blob/main/docs/supported-libraries.md) 有列表

笔者在 java 的示例中，使用 [grpc-1.6](https://github.com/open-telemetry/opentelemetry-java-instrumentation/tree/main/instrumentation/grpc-1.6/library) 来提供一个例子，也可以看 [官方例子](https://github.com/open-telemetry/opentelemetry-java-examples/tree/main/grpc)

**笔者示例的启动方式** 
1. 运行 ``StartGRPCServerWithOtel.cmd``
2. 访问 [这里](https://www.jaegertracing.io/download/) 下载Windows下的 ``Jaeger`` 二进制，然后解压缩
3. 运行 ``jaeger-all-in-one.exe``
4. 访问 Jaeger UI   ``http://localhost:16686/`` 即可看到数据

原理就是我们自己写的程序会向 ``jaeger`` 进程 ``http://localhost:4318/`` 访问，发布监控数据

## awesome-grpc
https://github.com/grpc-ecosystem/awesome-grpc
