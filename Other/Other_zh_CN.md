# 其他

## 常用颜色

#### 取颜色码
* [菜鸟工具-图片取色器](https://c.runoob.com/front-end/6214/)

#### 常用护眼色

**护眼绿色**： RGB（202, 234, 206） ， HEX（#caeace）  
**Sakura Editor背景色**： RGB（255, 251, 240） ， HEX（#fffbf0）  
**终端纯黑**：  
&nbsp;&nbsp;&nbsp;&nbsp;背景：RGB（0, 0, 0） ， HEX（#000000）  
&nbsp;&nbsp;&nbsp;&nbsp;前景：RGB（191, 191, 191） ， HEX（#bfbfbf）  
**终端黑灰**：  
&nbsp;&nbsp;&nbsp;&nbsp;背景：RGB（29, 31, 33） ， HEX（#1d1f21）  
&nbsp;&nbsp;&nbsp;&nbsp;前景：RGB（218, 218, 218） ， HEX（#dadada）  
**One Dark Pro暗色系颜色：**  
&nbsp;&nbsp;&nbsp;&nbsp;紫色 #c678dd  
&nbsp;&nbsp;&nbsp;&nbsp;红色 #dc6b74  
&nbsp;&nbsp;&nbsp;&nbsp;绿色 #98c379  
&nbsp;&nbsp;&nbsp;&nbsp;黄色 #e5c07b  
&nbsp;&nbsp;&nbsp;&nbsp;蓝色 #64afef  
**暗色主题下，色弱用色：**  
&nbsp;&nbsp;&nbsp;&nbsp;注释 #5f6167  
&nbsp;&nbsp;&nbsp;&nbsp;Cyan #00e8c6  
&nbsp;&nbsp;&nbsp;&nbsp;Orange #f39c12  
&nbsp;&nbsp;&nbsp;&nbsp;Skyblue #87cefa  
&nbsp;&nbsp;&nbsp;&nbsp;Pink #ff00aa  
&nbsp;&nbsp;&nbsp;&nbsp;Hot Pink #f92672  
&nbsp;&nbsp;&nbsp;&nbsp;Purple #7cb7ff  
&nbsp;&nbsp;&nbsp;&nbsp;Red #ee5d43  
&nbsp;&nbsp;&nbsp;&nbsp;Green #96E072  

#### 11种能减少眼睛疲劳的护眼色，附颜色代码及RGB值
- 1、绿豆沙 #C7EDCC RGB(199, 237, 204)
- 2、银河白 #FFFFFF RGB(255, 255, 255)
- 3、杏仁黄 #FAF9DE RGB(250, 249, 222)
- 4、秋叶褐 #FFF2E2 RGB(255, 242, 226)
- 5、胭脂红 #FDE6E0 RGB(253, 230, 224)
- 6、海天蓝 #DCE2F1 RGB(220, 226, 241)
- 7、葛巾紫 #E9EBFE RGB(233, 235, 254)
- 8、极光灰 #EAEAEF RGB(234, 234, 239)
- 9、青草绿 #E3EDCD RGB(227, 237, 205)
- 10、电脑管家 #CCE8CF RGB(204, 232, 207)
- 11、WPS护眼色 #6E7B6C RGB(110, 123, 108)

#### **一些Vim颜色码**
[vim-horizon主题](https://github.com/ntk148v/vim-horizon)  
[onedark.vim主题](https://github.com/joshdick/onedark.vim)  

## 邮箱客户端

### markdown-here-revival
fork 自 markdown-here
 - [gitlab](https://gitlab.com/jfx2006/markdown-here-revival)
 - [Thunderbird插件地址](https://addons.thunderbird.net/en-US/thunderbird/addon/markdown-here-revival/)

### markdown-here（已经停止更新）
支持在主流浏览器和Thunderbird中使用 MarkDown 写邮件
 - [github](https://github.com/adam-p/markdown-here)
 - [官网](https://markdown-here.com/)

**设定**  
 - 基本渲染CSS ： 可以参考 [md.css](./markdown/md.css) 设定
 - 语法高亮CSS ： Vs（亮色系），Vs2015/Hybird（暗色系）

#### 自定义颜色（版本 102）
帮助 → 排障信息 → 找到 ``配置文件夹`` 点击右侧的 ``打开文件夹``  
在配置文件夹下新建目录 ``chrome``  
然后在 新建目录 ``chrome`` 下新建文件 ``userChrome.css``  
内容如下
```
#threadTree treechildren::-moz-tree-row(odd) {
    background-color: #f5f7fa;
}
```
重启Thunderbird

#### 自定义颜色（版本 115）
设置 → 常规 → 最下方的 ``配置编辑器``  
搜索 ``toolkit.legacyUserProfileCustomizations.stylesheets``，修改为 ``true``  
帮助 → 排障信息 → 找到 ``配置文件夹`` 点击右侧的 ``打开文件夹``  
在配置文件夹下新建目录 ``chrome``  
然后在 新建目录 ``chrome`` 下新建文件 ``userChrome.css``  
内容如下
```
menubar,
toolbar,
nav-bar,
#TabsToolbar > * {
    background-color: #b7cfda !important;
}

/*
table[is="tree-view-table"] {
    background: #f8f8ff !important;
}
*/
table[is="tree-view-table"] td {
    border-bottom: solid 1px #dddddd !important;
}

#threadPane > tree-view {
    -moz-context-properties: fill;
    fill: currentColor;
    background-color: #f3f3f3 !important;
    color: var(--tree-view-color);
}

#folderPane {
    background-color: #f3f3f3 !important;
}

#titlebar > #toolbar-menubar:-moz-window-inactive,
#titlebar > #tabs-toolbar:-moz-window-inactive {
    background-color: #f8f8ff !important;
}

#unifiedToolbar {
    background: #b7cfda !important;
}

scrollbox,
.scrollbox-clip {
    background: #e8e8e8 !important;
}

/* miscellaneous  menubar on top ; compact header box ; quickfilter background :- if req */
/*
#toolbar-menubar {order: -1 !important;}
.message-header-container {padding-top: 0px !important; padding-bottom: 0px !important;}
.message-header-container, .message-header-extra-container {row-gap: 0px !important;}
#quickFilterBarContainer {background: #b7cfda !important;}
*/

#threadTree tr:nth-of-type(odd) {
    background-color: #f5f7fa;
}
```
重启Thunderbird

## 正则表达式

#### 1.正则表达式测试网站
- https://regexr.com/  
    这个网站的特点是可以将自己的文章段落贴到网站上，然后实时地修改正则表达式，在网站上看到相应的匹配。同时该网站还是一个正则表达式库，可以在里面查找Cheatsheet，还可以点击任何正则表达，查看其对应类型。

- https://regex-vis.com/  

#### 2.正则表达式30分钟入门教程
* [正则表达式30分钟入门](https://deerchao.cn/tutorials/regex/regex.htm)

### 一些常用的正则表达式

从左括号开始直到最后
```Reg
\(.*
```

行尾空格（包括TAB和全角空格）
```
/[\u0009\u000C\u0020\u00A0\u1680\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200A\u2028\u2029\u202F\u205F\u3000]+$/gm
```

## 特殊符号

#### 半角空格（连续显示4个）
U+2E31: ⸱⸱⸱⸱  
U+00B7: ····    (推荐)  
U+23B5: ⎵⎵⎵⎵  
U+2423: ␣␣␣␣  
U+02fd: ˽˽˽˽  

#### TAB
U+005E: ^  
U+2192: →  
U+279D: ➝  
U+27A1: ➡  
U+258F: ▏    (左对齐)  
U+258E: ▎    (左对齐)  
U+258D: ▍    (左对齐)  
U+258C: ▌    (左对齐)  
U+258B: ▋    (左对齐)  
U+258A: ▊    (左对齐)  
U+2589: ▉    (左对齐)  
U+2588: █    (左对齐)  
U+2502: │    (居中，推荐)  
U+2503: ┃    (居中)  
U+2595: ▕    (右对齐)  
U+2590: ▐    (右对齐)  
U+254E: ╎    (居中虚线)  
U+254F: ╏    (居中虚线)  
U+2506: ┆    (居中虚线)  
U+2507: ┇    (居中虚线)  
U+250A: ┊    (居中虚线)  
U+250B: ┃    (居中虚线)  
U+2551: ║    (居中双实线)  

#### 全角空格（连续显示4个）
U+2B1A: ⬚⬚⬚⬚(推荐)  
U+25CC: ◌◌◌◌  
U+26F6: ⛶⛶⛶⛶  

#### 回车（连续显示4个）
U+21B2: ↲↲↲↲(不使用``更纱黑体``时推荐)  
U+2936: ⤶⤶⤶⤶(使用``更纱黑体``时推荐)  
U+16CE: ᛎᛎᛎᛎ(Linux系统换行用)  
U+293E: ⤾⤾⤾⤾  
U+2193: ↓↓↓↓  
U+21E3: ⇣⇣⇣⇣  
U+2199: ↙↙↙↙  
U+21A9: ↩↩↩↩  
U+2938: ⤸⤸⤸⤸  

#### 左右延长符号（连续显示4个）
U+2190: ←←←←  
U+2192: →→→→  
U+21A2: ↢↢↢↢  
U+21A3: ↣↣↣↣  
U+2946: ⥆⥆⥆⥆  
U+2945: ⥅⥅⥅⥅  

#### 所有25个特殊空格的Unicode码

U+0009: 水平制表符(TAB)  
U+000A: 换行符(LF)  
U+000B: 退格符(BS)  
U+000C: 换页符(FF)  
U+000D: 回车符(CR)  
U+0020: 空格(WhiteSpace)  
U+0085: 下一行(NEL)  
U+00A0: 无间断空格(No-Break Space)  
U+1680: Ogham Space Mark  
U+2000: En Quad  
U+2001: Em Quad  
U+2002: En Space  
U+2003: Em Space  
U+2004: Three-Per-Em Space  
U+2005: Four-Per-Em Space  
U+2006: Six-Per-Em Space  
U+2007: Figure Space  
U+2008: Punctuation Space  
U+2009: 瘦空格(Thin Space)  
U+200A: Hair Space  
U+2028: 行分隔符(Line Separator)  
U+2029: 段落分隔符(Paragraph Separator)  
U+202F: 窄无间断空格(Narrow No-Break Space)  
U+205F: Medium Mathematical Space  
U+3000: CJK全角空格(Ideographic Space)  

#### 一个查看特殊符号的网站
https://cn.piliapp.com/symbol/

## 前端框架速度测试
web-frameworks
 - [github](https://github.com/the-benchmarker/web-frameworks)
 - [官网](https://web-frameworks-benchmark.netlify.app/result)

## ChatGPT
 - https://chatgpt.com/
 - https://chat.openai-use.com/  &nbsp;&nbsp;推荐
 - https://chat.askchat.ai/  &nbsp;&nbsp;推荐
 - [免费的 ChatGPT 镜像网站列表](https://github.com/LiLittleCat/awesome-free-chatgpt)
 - https://tw.chatgpt-free.ai/
 - https://www.askchat.ai/?r=317161

## StackOverFlow的搜索
https://yandex.com/

## 开源网络"瑞士军刀"
https://github.com/gchq/CyberChef

## 自我托管的软件列表
https://github.com/awesome-selfhosted/awesome-selfhosted

## Google日本語入力
 - [64bit版](https://dl.google.com/japanese-ime/2.25.3700.0/googlejapaneseinput64.msi)
 - [32bit版](https://dl.google.com/japanese-ime/2.25.3700.0/googlejapaneseinput32.msi)

## GitHub中文排行榜
https://github.com/GrowingGit/GitHub-Chinese-Top-Charts

## 网络障碍模拟工具 Clumsy
https://github.com/jagt/clumsy

## 端口扫描工具 RustScan
https://github.com/RustScan/rustscan

## 无限画布工具 Lorien
https://github.com/mbrlabs/Lorien

## 其他软件

- TVBox
    - [github](https://github.com/liu673cn/box)
    - [github-page](https://raw.liucn.cc/box/)&nbsp;&nbsp;&nbsp;&nbsp;这里也有一些源
    - [俊版 github](https://github.com/roacn/TVBoxOSC)
    - [影视仓 聚玩盒子](https://www.juwanhezi.com/item/246)
- TVBox视频源
    - TVBox俊版用 https://raw.liucn.cc/box/m.json
    - 影视仓用1 https://raw.liucn.cc/box/dc.txt
    - 影视仓用2 http://www.饭太硬.com/tv/
- TVBox直播源
    - IPTV-github https://github.com/leyan1987/iptv
    - 可以直接用的地址 https://mirror.ghproxy.com/https://raw.githubusercontent.com/leyan1987/iptv/main/iptv.txt

- 下载软件
    - [cobalt](https://github.com/imputnet/cobalt)
    - [Gopeed](https://gopeed.com/zh-CN)
    - [mediago](https://github.com/caorushizi/mediago)

## 启动器
https://github.com/Flow-Launcher/Flow.Launcher

## 开源的Google Play商店客户端，无需谷歌框架，可以使用匿名账户登录并下载应用程序
https://mp.weixin.qq.com/s/2QHDHYBUuT-6VBGz1KywRQ



