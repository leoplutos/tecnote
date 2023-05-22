# 其他

## 程序员字体

* [Inconsolata](https://github.com/googlefonts/Inconsolata/releases)  
 Inconsolata 是最为漂亮的等宽字体之一。从 2006 年开始它便一直是一款开源和可免费获取的字体。

* [JetBrains Mono](https://www.jetbrains.com/lp/mono/)  
 JetBrains推出的一款专门为了开发人员设计的字体

* [RictyDiminished](https://github.com/edihbrandon/RictyDiminished)  
 Inconsolata 和 Circle M+ 1m 合成的日文字体

* [SourceHanSansHWSC](https://gitee.com/coderfei126/davids-hybird-fonts)  
 Inconsolata的中文合成字体  
 SourceHanSansHWSC-Ligconsolata-Regular（字体名为：SourceHanSansHWSC-Ligconsolata）字体不包含合字字符。  
 SourceHanHWSC-Ligconsolata-FiraCode-liga-Regular（字体名为：SourceHanHWSC-Hybird-liga）包含了13个合字字符（->, =>, ::, ++, ==，!=, ===， !==， <=， >=, /, /, //）。

* [Cascadia Code](https://github.com/microsoft/cascadia-code)  
 Cascadia 是微软出品的一款开源等宽字体，Windows Terminal 中的默认字体就是它。目前有四个变种，Mono 表示不连字，PL 表示 PowerLine。

* [Fira Code](https://github.com/tonsky/FiraCode/releases)  
 Fira 是 Mozilla 主推的字体系列，Fira Code 是基于 Fira Mono 等宽字体的一个扩展，主要特点是加入了编程连字特性（ligatures）

#### 字体安装
* Windows和Mac  
  双击ttf文件，点击安装即可
* Linux  
  将字体解压缩到 ~/.local/share/fonts（或 /usr/share/fonts，这个是系统全局路径）后，执行
```bash
fc-cache -f -v
```

## 护眼色(RGB)

#### 护眼1-绿色：
RGB
```
背景：202 234 206
```
HEX
```
背景：#caeace
```

#### 护眼2-浅绿色：
RGB
```
背景：255 251 240
```
HEX
```
背景：#fffbf0
```

#### 黑色：
RGB
```
背景：0 0 0
文字：191 191 191
```

## 正则表达式

#### 1.正则表达式测试网站
https://regexr.com/  
这个网站的特点是可以将自己的文章段落贴到网站上，然后实时地修改正则表达式，在网站上看到相应的匹配。同时该网站还是一个正则表达式库，可以在里面查找Cheatsheet，还可以点击任何正则表达，查看其对应类型。

#### 2.正则表达式30分钟入门教程
* [正则表达式30分钟入门](https://deerchao.cn/tutorials/regex/regex.htm)

#### 3.从左括号开始直到最后
```Reg
\(.*
```
