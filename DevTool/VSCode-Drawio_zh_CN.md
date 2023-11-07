# 使用VSCode制作Markdown并且嵌入图片和流程图

## 需要工具
 - VSCode
 - [Draw.io Integration](https://marketplace.visualstudio.com/items?itemName=hediet.vscode-drawio) 插件

## 嵌入图片方法

### 基础写法
MarkDown 支持以 ``base64`` 的方式显示图片  
用 base64转码工具 把图片转成一段字符串，然后把字符串填到基础格式中链接的那个位置即可  
用法
```
![avatar][base64str_sample]

[base64str_sample]:data:image/png;base64,iVBORw0......
```
第一行是 Markdown 正文中需要导入图片的源码，``base64str_sample`` 可以理解为一个变量  
最下面一行是定义一个 ``base64str_sample`` 的变量，它的内容为 ``base64`` 的字符串，因为内容会很长，影响阅读，所以一般写到 Markdown 的最下面

### 使用Python将图片转化为base64字符串
新建 ``imgToBase64.py`` 内容如下
```
import base64
import sys

# 图片绝对路径-通过参数传递
img_file_path = sys.argv[1]
# 二进制方式打开图文件
# img_file = open('D:/Download/linglong.jpg', 'rb')
img_file = open(img_file_path, 'rb')
# 读取文件内容，转换为base64编码
base64code = base64.b64encode(img_file.read())
img_file.close()
# 将base64编码输出到控制台
print(base64code)
# 防止控制台闪退
input("请按任意键继续")
```
新建 ``imgToBase64.cmd`` 内容如下
```
set PYTHON_HOME=D:\Tools\WorkTool\Python\Python38-32
set PATH=%PATH%;%PYTHON_HOME%;%PYTHON_HOME%\Scripts
python D:\WorkSpace\Python\imgToBase64\imgToBase64.py %1
```
之后即可使用这个 cmd 命令来生成 base64  
比如
```
imgToBase64.cmd D:/Download/linglong.jpg
```
当然直接调用python也是可以的
```
python imgToBase64.py D:/Download/linglong.jpg
```
运行后会在控制台打印出如下内容
```
b'/9j/4QAYRXhpZgAASUkqAAgAAAAA...
...
AAAAAAf/Z'
请按任意键继续
```
两个 ``单引号之间`` 的内容即为 ``base64`` 替换到上面 基础写法中即可


### Python中base64字符串转化为图片
这部分代码暂时用不到，贴出来备用
```
import base64
bs='iVBORw0KGgoAAAANSUhEUg....' # 太长了省略
imgdata=base64.b64decode(bs)
file=open('2.jpg','wb')
file.write(imgdata)
file.close()
```

## 嵌入流程图的方法

### SVG 简介
SVG，即可缩放矢量图形(Scalable Vector Graphics)，是一种 XML 应用，可以以一种简洁、可移植的形式表示图形信息。目前，人们对 SVG 越来越感兴趣。大多数现代浏览器都能显示 SVG 图形，并且大多数矢量绘图软件都能导出 SVG 图形。


### 使用 Draw.io 打开一个 svg 文件
可以新建一个空的，扩展名为 ``svg`` 的文件，然后用 VSCode 打开  
使用 Draw.io 插件画图后保存

### 使用文本编辑器打开 svg 文件
打开 ``svg`` 文件之后，可以得到 ``<svg>...</svg>`` 的 xml 代码

### 编辑 Markdown 文件
将上一步得到的 xml 代码直接复制到 md 文件即可

一个Markdown的示例
```
# 这是一个结构导图

<svg host="65bd71144e" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="281px" height="191px" viewBox="-0.5 -0.5 281 191" content="&lt;mxfile&gt;&lt;diagram id=&quot;L-oKvDgklDFbDUm6tSgt&quot; name=&quot;第 1 页&quot;&gt;7VZNj5swEP01vgdICBxDQttDK1XKSj178SxYMhgZE0J+fcdgAoTNalf70UsvwLwZ2+P3ni2It8/P3xUts1+SgSDuip2JdyCu6zjeCl8GaXtkG7o9kCrObNEIHPkFLGjHpTVnUM0KtZRC83IOJrIoINEzjColm3nZkxTzVUuawgI4JlQs0T+c6axHA3c74j+Ap9mwsuOHfSanQ7HdSZVRJpsJ5MXE2yspdf+Vn/cgDHkDL/24b3ey18YUFPo1AyzvJypquzcS+2S3IqFD4g2JDmSHyJZEEQk9kwpjEqxt77odCKkangtaYBRVmiptJcPFvSiTil9koalAxEEgybhgP2kra9OiVgBDMKl9QBizZgIFFb/QRzHEiSngBaiHtgQ7A8JPCNt1HeQxsjsDpeF8lx3nyjmaFWQOWrVYYge4vpWpHfxn42ZU3Q0slk0VDy1IrdPS69yjGPhh9XheG++eNlFI4oAEOxJ02uAzCheSNBnXcCxpYuIGz6GhV+eDCK9ix32RnXBOznrJzZWvKTfrD6Bm/Qw1G7I7EOxpQY3zD7hxb4zjfSE5myU5twQAw/vMhiAeZROPQNQBmDAE8MQc2yk5StYFAzac5VqdusAczErWKoHfoDj2DMoQzIvUJvFaSEHfSU4vDd+0ULBJ1Ldven5ZDdxi18Hs+PTrTmyz1EyBoJqf5rO/RwH/LfZcqvP59nRuL7av9Of2vz/v+NP/HH9iOP5RdLnJf5kX/wU=&lt;/diagram&gt;&lt;/mxfile&gt;">
    <defs/>
    <g>
        <path d="M 0 20 L 0 0 L 280 0 L 280 20" fill="rgb(255, 255, 255)" stroke="rgb(0, 0, 0)" stroke-miterlimit="10" pointer-events="all"/>
        <path d="M 0 20 L 0 190 L 280 190 L 280 20" fill="none" stroke="rgb(0, 0, 0)" stroke-miterlimit="10" pointer-events="none"/>
        <path d="M 0 20 L 280 20" fill="none" stroke="rgb(0, 0, 0)" stroke-miterlimit="10" pointer-events="none"/>
        <g fill="rgb(0, 0, 0)" font-family="Helvetica" font-weight="bold" pointer-events="none" text-anchor="middle" font-size="12px">
            <text x="139.5" y="14.5">
                树形结构
            </text>
        </g>
        <rect x="90" y="40" width="100" height="40" fill="rgb(255, 255, 255)" stroke="rgb(0, 0, 0)" pointer-events="none"/>
        <g transform="translate(-0.5 -0.5)">
            <switch>
                <foreignObject pointer-events="none" width="100%" height="100%" requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility" style="overflow: visible; text-align: left;">
                    <div xmlns="http://www.w3.org/1999/xhtml" style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 98px; height: 1px; padding-top: 60px; margin-left: 91px;">
                        <div data-drawio-colors="color: rgb(0, 0, 0); " style="box-sizing: border-box; font-size: 0px; text-align: center;">
                            <div style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: none; white-space: normal; overflow-wrap: normal;">
                                根节点
                            </div>
                        </div>
                    </div>
                </foreignObject>
                <text x="140" y="64" fill="rgb(0, 0, 0)" font-family="Helvetica" font-size="12px" text-anchor="middle">
                    根节点
                </text>
            </switch>
        </g>
        <rect x="20" y="130" width="100" height="40" fill="rgb(255, 255, 255)" stroke="rgb(0, 0, 0)" pointer-events="none"/>
        <g transform="translate(-0.5 -0.5)">
            <switch>
                <foreignObject pointer-events="none" width="100%" height="100%" requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility" style="overflow: visible; text-align: left;">
                    <div xmlns="http://www.w3.org/1999/xhtml" style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 98px; height: 1px; padding-top: 150px; margin-left: 21px;">
                        <div data-drawio-colors="color: rgb(0, 0, 0); " style="box-sizing: border-box; font-size: 0px; text-align: center;">
                            <div style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: none; white-space: normal; overflow-wrap: normal;">
                                子节点1
                            </div>
                        </div>
                    </div>
                </foreignObject>
                <text x="70" y="154" fill="rgb(0, 0, 0)" font-family="Helvetica" font-size="12px" text-anchor="middle">
                    子节点1
                </text>
            </switch>
        </g>
        <path d="M 140 80 L 140 95 Q 140 105 130 105 L 80 105 Q 70 105 70 114.32 L 70 123.63" fill="none" stroke="rgb(0, 0, 0)" stroke-miterlimit="10" pointer-events="none"/>
        <path d="M 70 128.88 L 66.5 121.88 L 70 123.63 L 73.5 121.88 Z" fill="rgb(0, 0, 0)" stroke="rgb(0, 0, 0)" stroke-miterlimit="10" pointer-events="none"/>
        <rect x="160" y="130" width="100" height="40" fill="rgb(255, 255, 255)" stroke="rgb(0, 0, 0)" pointer-events="none"/>
        <g transform="translate(-0.5 -0.5)">
            <switch>
                <foreignObject pointer-events="none" width="100%" height="100%" requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility" style="overflow: visible; text-align: left;">
                    <div xmlns="http://www.w3.org/1999/xhtml" style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 98px; height: 1px; padding-top: 150px; margin-left: 161px;">
                        <div data-drawio-colors="color: rgb(0, 0, 0); " style="box-sizing: border-box; font-size: 0px; text-align: center;">
                            <div style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: none; white-space: normal; overflow-wrap: normal;">
                                子节点2
                            </div>
                        </div>
                    </div>
                </foreignObject>
                <text x="210" y="154" fill="rgb(0, 0, 0)" font-family="Helvetica" font-size="12px" text-anchor="middle">
                    子节点2
                </text>
            </switch>
        </g>
        <path d="M 140 80 L 140 95 Q 140 105 150 105 L 200 105 Q 210 105 210 114.32 L 210 123.63" fill="none" stroke="rgb(0, 0, 0)" stroke-miterlimit="10" pointer-events="none"/>
        <path d="M 210 128.88 L 206.5 121.88 L 210 123.63 L 213.5 121.88 Z" fill="rgb(0, 0, 0)" stroke="rgb(0, 0, 0)" stroke-miterlimit="10" pointer-events="none"/>
    </g>
    <switch>
        <g requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"/>
        <a transform="translate(0,-5)" xlink:href="https://www.diagrams.net/doc/faq/svg-export-text-problems" target="_blank">
            <text text-anchor="middle" font-size="10px" x="50%" y="100%">
                Text is not SVG - cannot display
            </text>
        </a>
    </switch>
</svg>

# 下一步...
```