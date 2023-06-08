# Github访问

## 前言
因为国内DNS污染等问题，访问github是非常不稳定的。这里介绍几个笔者使用的方法。

## 方法1：使用steamcommunity302加速github访问（推荐）
由羽翼城开发，用来加速steam等游戏领域的软件，它也是可以加速github的  
软件可以直接到大佬博客上进行下载：  
https://www.dogfight360.com/blog/686/

### 使用方法
* 打开软件，点击设置
* 在左下角的本地反代服务选择的框框里勾选“github访问” → 保存设置
* 然后软件会启动服务，打开github就能流畅访问了！

注：有时候steamcommunity会挂掉，连接不上时打开底部侧边栏看看它是否还在运行，没有运行的话重新启动就好了。


## 方法2：使用UsbEAm Hosts Editor修改hosts文件
也是由羽翼城开发，本来是用于改善 Steam、暴雪、育碧、Microsoft Store 等游戏平台的访问与下载速度，但顺便也有支持 Github。

软件可以直接到大佬博客上进行下载：  
https://www.dogfight360.com/blog/475/

### 使用方法
* 打开软件，点击软件左下角，选择准备修改 hosts 的网站
* 选择[developer - 开发者相关] → github.com
* 检测延迟 → 选择延迟最低的IP地址 → 应用选中

然后再去访问 Github.com 就会快很多


## 方法3：手动修改hosts文件
有些时候有一些使用软件的限制，可以从下面挑选1个可以ping通过的ip手动添加到hosts文件中。（**注意备份**）
#### hosts文件所在路径
```
C:\Windows\System32\drivers\etc
```
```
20.27.177.113 github.com
20.205.243.166 github.com
20.248.137.48 github.com
140.82.114.4 github.com
140.82.113.3 github.com
140.82.121.3 github.com
104.244.46.165 github.com
```
