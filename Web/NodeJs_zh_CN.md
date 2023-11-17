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

## 官方教程
https://dev.nodejs.cn/learn/

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

## 前端工程开发

#### 使用NodeJs内置库
新建一个工程后，默认并不附带NodeJS中的对象库（比如 http），要使用这些对象的API，需要安装到本地
```
npm i --save-dev @types/node
```
``--save-dev`` 选项为 添加条目到 package.json 文件中的开发依赖

## 几个实用的第三方包

#### prettier格式化
安装命令
```
npm install -g --save-dev --save-exact prettier
```
确认命令
```
prettier.cmd --version
```

#### sql-formatter格式化
安装命令
```
npm install -g sql-formatter
```
确认命令
```
sql-formatter.cmd --version
```
