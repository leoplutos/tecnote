# NodeJs相关

## 下载
https://nodejs.org/zh-cn/download  

选择 Windows 二进制文件 (.zip)  
https://nodejs.org/dist/v18.17.1/node-v18.17.1-win-x64.zip

#### 确认
解压缩后运行命令确认
```
node --version
npm --version
```

## 配置命令

查看默认配置
```
npm config ls -ls
```

设置全局安装路径
```
npm config set prefix "D:\Tools\WorkTool\NodeJs\node-v18.17.1-win-x64\node_global"
```

设置缓存路径
```
npm config set cache "D:\Tools\WorkTool\NodeJs\node-v18.17.1-win-x64\node_cache"
```

## 设置国内源
```
npm config set registry https://npmreg.proxy.ustclug.org/
npm info underscore
```
※这个只是为了检验上面的设置命令是否成功，若成功，会返回指定包的信息  

使用命令临时指定
```
npm --registry https://npmreg.proxy.ustclug.org/ info underscore
```
※npm info underscore依然是为了检验是否设置成功

## 安装第三方包

安装第三方包到本地（模块下载到当前命令行所在目录）
```
npm --registry https://npmreg.proxy.ustclug.org/ install <packagename>
```

安装第三方包到全局（-g参数，模块将被下载安装到全局目录）
```
npm instal <packagename> -g
```

卸载全局包
```
npm uninstall -g <package>
```


