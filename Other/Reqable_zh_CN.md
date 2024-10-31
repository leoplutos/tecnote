# Reqable

## 简介
代理调试 + 请求测试一站式解决方案  
``Reqable`` = Fiddler + Charles + Postman, 让API调试更快 🚀 更简单 👌

**注意**
``Reqable`` 不是开源项目，但是有 ``社区免费版``


## 官网
 - [官网](https://reqable.com/zh-CN/)
 - [Github](https://github.com/reqable/reqable-app)

## 下载安装

直接在官网下载免安装版本即可

## 使用方法

第一次打开软件后会提示 ``选择配置``和 ``引导安装证书``  
根据提示设置即可


### API 调式
参考 [官方文档](https://reqable.com/zh-CN/docs/capture/)

### API测试
参考 [官方文档](https://reqable.com/zh-CN/docs/rest/)

### 本地流量抓包
参考 [官方文档](https://reqable.com/zh-CN/docs/capture/localhost)

借助 [镜像](https://reqable.com/zh-CN/docs/capture/mirror) 功能对 ``localhost`` 进行映射后，可以将 ``localhost`` 映射成 ``go``，方便的抓包本地流量

比如原URL为
```text
http://localhost:8080/getHello
```

镜像映射设定后，访问
```text
http://go:8080/getHello
```
即可实现本地流量抓包
