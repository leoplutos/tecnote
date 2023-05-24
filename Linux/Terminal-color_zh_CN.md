# 终端颜色
原文：  
https://github.com/termstandard/colors

人们普遍对终端颜色感到困惑。这就是我们现在所拥有的：

- 纯 ASCII
- ANSI 转义码：16 种颜色代码，粗体/斜体和背景
- 256 色调色板：216 种颜色 + 16 种 ANSI + 24 种灰色（颜色为 24 位）
- 24 位真彩色：“888”色（又名 1600 万）

要快速检查您的终端，请运行：

```bash
printf "\x1b[38;2;255;100;0mTRUECOLOR\x1b[0m\n"
```
如果它理解 Xterm 样式的真彩色转义，它将以棕色打印TRUECOLOR 。

要进行更彻底的测试，请运行：

```bash
awk 'BEGIN{
    s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
    for (colnum = 0; colnum<77; colnum++) {
        r = 255-(colnum*255/76);
        g = (colnum*510/76);
        b = (colnum*255/76);
        if (g>255) g = 510-g;
        printf "\033[48;2;%d;%d;%dm", r,g,b;
        printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
        printf "%s\033[0m", substr(s,colnum+1,1);
    }
    printf "\n";
}'
```

## 真彩色检测

很多终端都通过放置COLORTERM=truecolor在 shell 用户 shell 的环境中来宣传真彩色支持。
我们只要把下面这个放在个人的bashrc中即可
```bash
export COLORTERM=truecolor
```

## 输出设备中的真彩色支持

#### 终端仿真器
- iTerm2 [分隔符：冒号、分号] - 从 v3 版本开始
- Tera Term [分隔符：冒号、分号] - Windows 平台
- mintty [分隔符：分号] 自2.0.1版以来的Cygwin 和 MSYS/MSYS2 - Windows 平台
- MobaXterm Windows 平台——闭源（运行lscolors查看真彩色测试）
