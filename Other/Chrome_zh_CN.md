# Chrome相关

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

## 预览MarkDown插件

可以使用浏览器渲染 ``markdown`` 文件，以便在浏览器里直接打印生成 ``pdf``  
谷歌插件商店地址：[Markdown Preview Plus](https://chrome.google.com/webstore/detail/markdown-preview-plus/febilkbfcbhebfnokafefeacimjdckgl)  
github项目地址：[Markdown Preview Plus](https://github.com/volca/markdown-preview)  
github下载地址：[v0.8.0.zip](https://github.com/volca/markdown-preview/archive/refs/tags/v0.8.0.zip)  

## 浏览器请求状态管理 Header Editor

在国内访问 https://stackoverflow.com/ 的时候，会遇到 ``Human verification`` 验证无法通过这个插件就是解决这个问题的  

安装方式：https://blog.azurezeng.com/recaptcha-use-in-china/

## 音乐下载插件 声海盗
https://github.com/seekerlee/SoundPirate
