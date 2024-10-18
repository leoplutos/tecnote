# Web相关

## Web Framework性能对比
https://www.techempower.com/benchmarks/#section=data-r22&hw=ph&test=composite

### 2023-10-17(Round 22) 结果
- 10.axum（Rust）
- 13.actix（Rust）
- 15.asp.net core（C#）
- 78.gin（Golang）
- 86.fastapi（Python）
- 88.spring（Java）
- 102.fastify（NodeJs）

**NOTE**: ``Sanic``（Python）没有上榜，估计是没有提交测试，在 [这里](https://klen.github.io/py-frameworks-bench/) 的对比中可以看到是比fastapi快的

## WebSocket

WebSocket 使得客户端和服务器之间的数据交换变得更加简单，允许服务端主动向客户端推送数据。在 WebSocket API 中，浏览器和服务器只需要完成一次握手，两者之间就可以创建持久性的连接，并进行双向数据传输

Websocket 使用 ``ws`` 或 ``wss`` 的统一资源标志符（URI），其中 ``wss`` 表示使用了 ``TLS`` 的 Websocket。

```
ws://echo.websocket.org
wss://echo.websocket.org
```

WebSocket 与 ``HTTP`` 和 ``HTTPS`` 使用相同的 ``TCP`` 端口（即 ``80`` 和 ``443``），可以绕过大多数防火墙的限制

一个 WebSocket 客户端示例
 - [WebSocketClient.html](WebSocketClient.html)

## CSS 开源 UI 框架 - Pico.css

#### Pico.css 框架的特点

- 去 class 以及原生语义化的代码。Pico.css 尽可能使用原生的 HTML 元素的标签名称来定义样式，整个框架使用的 class 名称不到10个

- 纯 CSS 实现。所有组件都由一个 10KB（压缩后）的 CSS 文件实现，无包管理，没有依赖和外部文件，甚至连 javascript 代码都没有

- 响应式布局。内置响应式的栅格系统，在 PC / 手机 / 平板等不同屏幕大小的设备上排版美观一致

- 支持深色主题。附带两个漂亮的颜色主题，根据用户喜好一键启用

- 专为最新的稳定 Chrome、Firefox、Edge 和 Safari 版本而设计和测试。不支持任何版本的 IE，包括 IE 11

#### 官网

- [Github](https://github.com/picocss/pico)
- [官网](https://picocss.com/)
- [笔者的一个例子](./Picocss/picocss.html)


## 公共API速查表
https://github.com/public-apis/public-apis

## 其他
- [前端如何防止接口重复提交](https://mp.weixin.qq.com/s/bANThYgp1iqg9Bf8mVJNAQ)
- [音视频流-WebRTC 技术介绍](https://mp.weixin.qq.com/s/01Lw-8sRyHYQV3_ICrR7ng)
- [仿 Excel效果的表格插件](https://mp.weixin.qq.com/s/V9XPAVZ9hMSsYEr6r8AGkw)
