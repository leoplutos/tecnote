# 其他

## 程序员字体

* [Inconsolata](https://github.com/googlefonts/Inconsolata/releases)  
 Inconsolata 是最为漂亮的等宽字体之一。从 2006 年开始它便一直是一款开源和可免费获取的字体。

* [JetBrains Mono](https://www.jetbrains.com/lp/mono/)  
 JetBrains推出的一款专门为了开发人员设计的字体

* [RictyDiminished](https://github.com/edihbrandon/RictyDiminished)  
 Inconsolata 和 Circle M+ 1m 合成的日文字体

* [Myrica](https://github.com/tomokuni/Myrica/blob/master/product/Myrica.md)  
 Inconsolata 和 源真ゴシック(或者Mgen+) 合成的日文字体

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

## 护眼色

#### 护眼1-绿色：
RGB
```
背景：202 234 206
```
HEX
```
背景：#caeace
```

#### 护眼2-浅绿色（Sakura Editor）：
RGB
```
背景：255 251 240
```
HEX
```
背景：#fffbf0
```

#### 终端用黑色：
RGB
```
背景：0 0 0
文字：191 191 191
```

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


## 字体映射(Fontlink)

* [通过字体映射 Fontlink 美化中文显示](https://zhuanlan.zhihu.com/p/205133009)

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
