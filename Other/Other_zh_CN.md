# 其他

## 程序员字体
* [JetBrains Mono](https://www.jetbrains.com/lp/mono/)  
 安装 ttf 目录下所有字体即可。(推荐：JetBrainsMono-Regular.ttf)
* [Cascadia Code](https://github.com/microsoft/cascadia-code)  
目前有四个变种，Mono 表示不连字，PL 表示 PowerLine。
如果你不知道用哪个，把四个都装上。
* [Fira Code](https://github.com/tonsky/FiraCode/releases)  
 如果你不知道用哪个，安装 otf 目录下的所有字体即可。

#### 字体安装
* Windows和Mac  
  双击ttf文件，点击安装即可
* Linux  
  将字体解压缩到 ~/.local/share/fonts（或 /usr/share/fonts，这个是系统全局路径）后，执行
```bash
fc-cache -f -v
```

## Sakura Editor设定
将Sakura Editor的关闭tab快捷键，映射成Ctrl + w
```
設定 → 共通設定 → キー割り当て → 
種別：ウィンドウ系
选择左侧的【閉じる】
选择中间的【Ctrl】CheckBox
选择右侧的【Ctrl + W】
点击下面的【割付(B)】按钮
```
完成

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
