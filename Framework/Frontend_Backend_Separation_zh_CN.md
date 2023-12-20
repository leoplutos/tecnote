# 前后端分离工程

## 什么是前后端分离？

### 前后端一体工程
只有一个 Web 工程，后端和前端的程序，在一个工程里面。  
部署的时候所有内容部署在同一个容器内。

### 前后端分离工程
前端一个工程，后端一个工程，各自分离，分别部署。前后端交互使用API。  
前后端工程师需要约定交互接口，实现同步开发。  
前端只需要关注页面的样式与动态数据的解析和渲染，而后端专注于具体业务逻辑。

### 为什么要前后端分离？
- 彻底解放前端
- 接口规范化
- 提高工作效率，分工更加明确
- 局部性能提升
- 可维护性更高（降低维护成本）
- 灵活性更强。实现高内聚低耦合，减少后端（应用）服务器的并发/负载压力
- 即使后端服务暂时超时或者宕机了，前端页面也会正常访问，但无法提供数据
- 可以使后台能更好的追求高并发、高可用、高性能，使前端能更好的追求页面表现、速度流畅、兼容性、用户体验等

## 示例工程

### 技术选型
 - 前端：``Vue3.3.11/Vuex4.0.2/Axios1.6.2/element-plus2.4.4/TypeScript5.3.0/NodeJs18.17.1``
 - 后端：``Java17/SpringBoot3.2.0/Maven3.9.5/H2 2.2.224``
 - 开发工具：``VS Code 1.85.0``

### 实现内容
 - 前端：使用``Vuex``管理全局状态，使用``Axios``进行http通信，使用``element-plus``制作UI，实现登录画面和清单画面
 - 后端：使用``SpringSecurity``和``JWT``生成token进行身份认证，使用H2在内存中创建库，表``login``存储用户数据，表``todo``存储清单数据

## 前端工程
参考 [这里](../Web/Vue_zh_CN.md) 新建一个 ``Vue工程``  
```
cd D:\WorkSpace\FBS
npm create vue@latest
cd FrontendVue
```
然后下载笔者的工程 [FrontendVue](./FrontendVue) 覆盖即可

### 前端工程开发VSCode插件
 - [Vue Language Features (Volar)](https://marketplace.visualstudio.com/items?itemName=Vue.volar)
 - [TypeScript Vue Plugin (Volar)](https://marketplace.visualstudio.com/items?itemName=Vue.vscode-typescript-vue-plugin)

## 后端工程
参考 [这里](../Java/Java-Spring_zh_CN.md) 新建一个 ``Java的Srping工程``  
```
cd D:\WorkSpace\FBS
mkdir BackendSpring
curl https://start.spring.io/starter.zip -d language=java -d type=maven-project -d dependencies=web,jpa,h2,devtools -d packageName=com.example.spring -d name=BackendSpring -o BackendSpring.zip
7z x BackendSpring.zip -oD:\WorkSpace\FBS\BackendSpring
del BackendSpring.zip
```
然后下载笔者的工程 [BackendSpring](./BackendSpring) 覆盖即可

### 后端工程开发VSCode插件
 - [Language Support for Java(TM) by Red Hat](https://marketplace.visualstudio.com/items?itemName=redhat.java)
 - [Maven for Java](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-maven)
 - [Project Manager for Java](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-dependency)
 - [Debugger for Java](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-debug)

## 启动命令

### 前端工程启动（端口9500）
```
cd D:\WorkSpace\FBS\FrontendVue
npm --registry https://npmreg.proxy.ustclug.org/ install
npm run dev
```

### 后端工程启动（端口9501）
```
cd D:\WorkSpace\FBS\BackendSpring
mvnw spring-boot:run
```
### 使用浏览器访问确认

#### 前端页面入口
http://localhost:9500/  
登录账号： ``admin / 123``  

#### 后端取得数据接口
认证接口  
http://localhost:9501/login  
取得清单列表接口  
http://localhost:9501/todo/getAll  

#### 后端H2后端控制台
http://localhost:9501/h2-console  
在这个界面中首先将会显示登录界面，在登录界面中适用的登录信息是你在 ``application.properties`` 文件中指定的登录信息，成功连接到控制台后，我们将会看到一个完整的控制台界面
