# 字体

## 开启 Windows 的 Clear Type
Windows键 + s 打开搜索输入 Clear 会看到 “调整ClearType文本”。  
在第一个画面选择【启用 ClearType】，然后下一步,  
后面会有5步选项，每步选择你看起来更清晰更舒服的即可。

## 字体测试网站
* [programmingfonts](https://www.programmingfonts.org/)

## 程序员字体

* [Inconsolata](https://github.com/googlefonts/Inconsolata/releases)  
 Inconsolata 是最为漂亮的等宽字体之一。从 2006 年开始它便一直是一款开源和可免费获取的字体。

* [JetBrains Mono](https://www.jetbrains.com/lp/mono/)  
 JetBrains推出的一款专门为了开发人员设计的字体

* [更纱黑体(Sarasa Gothic)](https://github.com/be5invis/Sarasa-Gothic)  
* [更纱黑体-清华源](https://mirrors.tuna.tsinghua.edu.cn/github-release/be5invis/Sarasa-Gothic/)  

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

* [Hack](https://github.com/source-foundry/Hack)  
 Hack 字体基于 DejaVu Sans Mono，字如其名，为程序员编码而设计。它的数字零采用了纵向的 slashed zero，更利于显示器清晰渲染，小写字母 i 仿照了小写字母 L 的设计，底部向右弯，明显的跟数字 1 区分开来，且沿袭了字母 L 小写形式的优雅。

* [UbuntuMono](https://github.com/powerline/fonts/tree/master/UbuntuMono)  


## Nerd字体
Nerd font是针对已有的字体打 patch，把一些 icon 字符插入进去。  
不过 Nerd font 就比较厉害了，是一个“集大成者”，他几乎把目前市面上主流的 icon 字符全打进去了，包括 powerline icon 字符以及 Font Awesome 等几千个 icon 字符。

* [官网](https://www.nerdfonts.com/#home)
* [github](https://github.com/ryanoasis/nerd-fonts)

#### 一些Nerd font
* [Cascadia Code Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.1/CascadiaCode.zip)
* [Fantasque Sans Mono Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.1/FantasqueSansMono.zip)
* [Inconsolata Go Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.1/InconsolataGo.zip)
* [Inconsolata LGC Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.1/InconsolataLGC.zip)

## 字体安装
* Windows 和 Mac  
  双击 ttf 文件，点击安装即可
* Linux  
  将字体解压缩到 ~/.local/share/fonts（或 /usr/share/fonts，这个是系统全局路径）后，执行
```bash
fc-cache -f -v
```

## 其他字体
终端建议首选更纱黑体，有连字，中英通吃而且2:1严格等宽，偶尔需要在终端中显示cjk字符时效果非常好。其他的中文字体还有思源黑体比较不错。

## 字体映射(Fontlink)

* [通过字体映射 Fontlink 美化中文显示](https://zhuanlan.zhihu.com/p/205133009)
