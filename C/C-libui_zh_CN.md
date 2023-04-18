# libui

## libui简介
libui是一个 C 语言编写，简单且可移植（但并非不灵活）的 GUI 库，它使用每个平台原生的GUI技术进行绘制。

## 1.使用前需要先安装Meson
libui需要meson构建，meson的具体安装方法详见：  
[Meson笔记](../BuildTool/Meson_zh_CN.md)

## 2.下载libui代码
libui的github网址如下：  
https://github.com/andlabs/libui

## 3.根据README的说明进行构建

```bash
PATH=$PATH:/D/tool/ninja-win
echo $PATH
ninja --version

cd /d/workspace/libui

/D/python/python.exe /d/meson/meson.py setup --cross-file windows-mingw-w64-64bit.txt build --default-library=static

ninja -C build
```

在build/meson-out路径下会生成结果

## 4.所需链接的库
在使用libui的过程中至少需要链接以下库
```
user32.lib
kernel32.lib
gdi32.lib
comctl32.lib
uxtheme.lib
msimg32.lib
comdlg32.lib
d2d1.lib
dwrite.lib
ole32.lib
oleaut32.lib
oleacc.lib
uuid.lib
windowscodecs.lib
libui.a
```

## 5.静态库的使用
静态库在使用时还需要在项目中加入资源文件，下面的 文件 选择其中之一即可
* static.manifest
* resources.res


## 6.简单例子
```c
#include <stdio.h>
#include "ui.h"

int onClosing(uiWindow* w, void* data)
{
	uiQuit();
	return 1;
}

int main(void)
{
	uiInitOptions o = { 0 };
	const char* err;
	uiWindow* window;

	// 初始化ui
	err = uiInit(&o);
	if (err != NULL) {
		fprintf(stderr, u8"初始化错误: %s\n", err);
		uiFreeInitError(err);
		return 1;
	}

	// 创建一个新窗口
	window = uiNewWindow("Hello World!", 300, 300, 0);
	uiWindowOnClosing(window, onClosing, NULL);

	// 显示窗口
	uiControlShow(uiControl(window));

	// 启动主循环
	uiMain();

	// 释放内存空间
	uiUninit();

	return 0;
}
```

## 7.控件介绍
#### 1. 容器控件
uiWindow
一个代表顶层窗口的控件，可包含其他控件。

uiBox
一个容纳一组控件的盒状容器。

uiTab
一个多页面控制界面容器，一次显示一个页面。

uiGroup
向所包含的子控件添加标签的控件容器。

uiForm
将包含的控件组织为带标签的字段的控件容器。

uiGrid
要在网格中排列的包含控件的控件容器。

#### 2. 数据输入
uiCheckbox
带有用户可选框并带有文本标签的控件。

uiEntry
具有单行文本输入字段的控件。

uiSpinbox
通过文本字段或 +/- 按钮显示和修改整数值的控件。

uiSlider
通过用户可拖动的滑块显示和修改整数值的控件。

uiCombobox
通过下拉菜单从预定义项目列表中选择一项的控件。

uiEditableCombobox
用于从预定义的项目列表中选择一个项目或输入自己的项目的控件。

uiRadioButtons
复选按钮的多选控件，一次只能从中选择一个。

uiDateTimePicker
输入日期和/或时间的控件。

uiMultilineEntry
具有多行文本输入字段的控件。

uiFontButton
单击时打开字体选择器的类似按钮的控件。

uiColorButton
带有颜色指示器的控件，单击时会打开颜色选择器。

uiTable
以表格方式显示数据的控件。

#### 3. 静态控件
uiLabel
显示非交互式文本的控件。

uiProgressBar
通过水平条的填充级别可视化任务进度的控件。

uiSeparator
用于在视觉上水平或垂直分隔控件的控件。

uiMenuItem
与uiMenu结合使用的菜单项。

uiMenu
应用程序级菜单栏。

uiImage
要在屏幕上显示的图像的容器。

#### 4. 按钮控件
uiButton  
uiFontButton  
uiColorButton
