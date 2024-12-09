# Chrome相关

## 离线版下载地址
https://www.google.cn/chrome/?standalone=1&platform=win64&extra=stablechannel

- ``standalone=1`` : 指离线安装包
- ``platform=win64`` : 指64位Windows版本

只加 standalone=1 则会下载32位的Chrome离线包  
用 mac 替换 win ，就可以下载 Mac版本  

## 官方网站
#### Google网页开发课程
https://web.developers.google.cn/

#### Chrome开发者帮助
https://developer.chrome.google.cn/

## 颜色吸管工具
按下 ``F12`` 进入开发者模式，在 ``Elements`` 标签中找一个 ``HEX`` 颜色码的项目，比如
```
color: #333;
```
在 ``HEX`` 颜色码处有颜色选取工具，进入即可看到 ``吸管工具`` （图标是一个吸管）


## Vim模式插件 Vimium

谷歌插件商店地址：[Vimium](https://chrome.google.com/webstore/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb)  
github项目地址：[Vimium](https://github.com/philc/vimium)  

#### 安装方式1：从谷歌商店安装

#### 安装方式2：从源代码安装（推荐）
1. 在 ``github`` 上将项目下载 [下载地址](https://github.com/philc/vimium/archive/refs/tags/v1.67.7.zip)  
1. 打开 ``Chrome``
2. 访问 ``chrome://extensions``
3. 打开 ``开发者模式``（Developer Mode）
4. 点击 ``加载已解压的扩展程序``（Load Unpacked Extension）
5. 选择从 github 下载的 ``源码文件夹``

参考：https://github.com/philc/vimium/blob/master/CONTRIBUTING.md#installing-from-source

#### 快捷键
```
?       显示帮助对话框
h       向左滚动
j       向下滚动
k       向上滚动
l       向右滚动
gg      到顶部
G       到底部
d       向下滚动半页
u       向上滚动半页
f       在当前tab打开链接
F       在新tab打开链接
r       重新加载
gs      查看源代码
i       进入插入模式
yy      复制当前网址到剪切板
yf      复制一个链接网址到剪切板
gf      循环前进到下一个框体
gF      焦距主框体

o       打开 链接, 书签, 或者历史
O       在新tab打开 链接, 书签, 或者历史
b       打开书签
B       在新tab打开书签

/       进入查找模式（输入回车搜索，Esc取消）
n       循环前进到下一个查找匹配项
N       循环前进到上一个查找匹配项

H       后退（历史）
L       前进（历史）

J, gT   焦距到左边的tab
K, gt   焦距到右边的tab
g0      转到第0个tab
g$      转到最后1个tab
^       访问以前访问过的tab
t       新建tab
yt      复制当前tab
x       关闭当前tab
X       恢复关闭的tab
T       搜索打开的tab
W       移动当前tab到新窗口
<a-p>   固定/取消固定当前选项卡

]], [[  点击标有“下一个”或“>”（“上一个”或“<”）的链接
<a-f>   在tab中打开多个链接
gi      聚焦页面上的第一个（或第 N 个）文本输入框。用于<tab>循环切换选项
gu      在 URL 层次结构中上升一级
gU      上升到 URL 层次结构的根
ge      编辑当前网址
gE      编辑当前 URL 并在新tab中打开
zH      一直向左滚动
zL      一直向右滚动
v       进入选择模式
V       进入行选择模式
```

## 阅读模式插件 - reader-view
屏蔽广告等掉多余的内容，像看书一样看网页。  
因为github上没有提供下载，所以笔者使用crx4chrome下载使用

谷歌插件商店地址：[reader-view](https://chrome.google.com/webstore/detail/reader-view/ecabifbgmdmgdllomnfinbmaellmclnh)  
github项目地址：[reader-view](https://github.com/rNeomy/reader-view)  
官网：[官网](https://webextension.org/listing/chrome-reader-view.html)  
crx4chrome地址：[crx4chrome](https://www.crx4chrome.com/extensions/ecabifbgmdmgdllomnfinbmaellmclnh/)  

#### 推荐设置
1. 打开 ``Show "Open in Reader View" context-menu item``
2. 在 ``Custom styling (reader view)``处，修改如下设定
```
pre code {
    background-color: #f6f8fa;
    color: #1f2328;
    font-family: monospace;
    display: block;
    padding: 5px 10px;
}
```
```
/* CSS for "sepia" theme */
body[data-mode=sepia] {
    color: #34363a;
    background-color: #dcf8df;
}
```

## 预览MarkDown插件（推荐）

可以使用浏览器渲染 ``markdown`` 文件，以便在浏览器里直接打印生成 ``pdf``  
谷歌插件商店地址：[Markdown Preview Plus](https://chrome.google.com/webstore/detail/markdown-preview-plus/febilkbfcbhebfnokafefeacimjdckgl)  
github项目地址：[Markdown Preview Plus](https://github.com/volca/markdown-preview)  
github下载地址：[v0.8.0.zip](https://github.com/volca/markdown-preview/archive/refs/tags/v0.8.0.zip)  

#### 权限设置
需要打开 ``允许访问文件网址`` 权限（默认就是打开的）

#### 插件设置
1. 开启 ``Mermaid & KaTeX support inline``
2. ``Themes`` 可以选择主题，[lch_Chrome.css](./markdown/lch_Chrome.css) 是一个笔者使用的主题

## EDGE版的预览MarkDown插件（推荐）
EDGE插件商店地址：[Markdown Preview Plus](https://microsoftedge.microsoft.com/addons/detail/markdown-preview-plus/dhinnjfkfmhehkbhcblbocdcpmlnkhbh)  

#### 权限设置
需要打开 ``允许访问文件 URL`` 权限（默认没有打开）

#### 插件设置
1. 开启 ``Mermaid & KaTeX support inline``
2. ``Themes`` 可以选择主题，[lch_EDGE.css](./markdown/lch_EDGE.css) 是一个笔者使用的主题

## 翻译插件 - Immersive Translate（推荐）
Immersive Translate（沉浸式翻译），支持沉浸式双语网页翻译扩展 , 支持输入框翻译， 鼠标悬停翻译， PDF, Epub, 字幕文件, TXT 文件翻译

- [Github仓库](https://github.com/immersive-translate/immersive-translate)
- [Chrome插件商店](https://chrome.google.com/webstore/detail/immersive-translate/bpoadfkcbjbfhfodiogcnhhhpibjhbnh?utm_source=zip)
- [Chrome插件本地安装指南](https://immersivetranslate.com/manual-chrome-extension/)
- [Edge插件商店](https://microsoftedge.microsoft.com/addons/detail/%E6%B2%89%E6%B5%B8%E5%BC%8F%E7%BF%BB%E8%AF%91-%E7%BD%91%E9%A1%B5%E7%BF%BB%E8%AF%91%E6%8F%92%E4%BB%B6-pdf%E7%BF%BB%E8%AF%91-/amkbmndfnliijdhojkpoglbnaaahippg?hl=zh-CN)

## 下载插件 - cat-catch（猫抓 浏览器资源嗅探扩展)
- [Github仓库](https://github.com/xifangczy/cat-catch)
- [Chrome插件商店](https://chrome.google.com/webstore/detail/jfedfbgedapdagkghmgibemcoggfppbb)
- [Edge插件商店](https://microsoftedge.microsoft.com/addons/detail/oohmdefbjalncfplafanlagojlakmjci)

## 替换 Google CDN 为国内源 ``ReplaceGoogleCDN``
在国内访问 https://stackoverflow.com/ 的时候，因为使用了 Google CDN，所以会出现访问过慢的情况

- [Github仓库](https://github.com/justjavac/ReplaceGoogleCDN)
- [Chrome插件商店](https://chrome.google.com/webstore/detail/replace-google-cdn/kpampjmfiopfpkkepbllemkibefkiice)
- [Edge插件商店](https://microsoftedge.microsoft.com/addons/detail/replace-google-cdn/cojepngjobmaiajphkijbdcdjnnjhpjc)

安装插件以后访问 https://stackoverflow.com/  
起飞！！！

## 音乐下载插件 声海盗
https://github.com/seekerlee/SoundPirate

## 本地文件跨域错误
具体错误信息为
```
Access to script at 'file:///path/to/App.js' from origin 'null' has been blocked by CORS policy: Cross origin requests are only supported for protocol schemes: http, data, isolated-app, chrome-extension, chrome, https, chrome-untrusted.
```
因为本地文件用浏览器打开是 ``file`` 协议，``file:///***.html`` 如果有跨域请求，会在控制台报错  

#### 解决方法1：
新建 Chrome 快捷方式  
目标处为：
```
"C:\Program Files\Google\Chrome\Application\chrome.exe" --allow-file-access-from-files
```
将所有Chrome关闭后，用新的快捷方式重新启动即可

#### 解决方法2：
新建一个批处理内容如下
```
"C:\Program Files\Google\Chrome\Application\chrome.exe" --allow-file-access-from-files
```
将所有Chrome关闭后，用新的批处理重新启动即可

## 本地文件跨域错误（Edge）
解决方式和 Chrome 一致，命令为
```
"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" --disable-web-security --user-data-dir=D:\Download\EdgeTmp
```
