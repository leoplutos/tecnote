# Universal Ctags

## Ctags是什么？
Ctags 可以将代码中的函数，方法，类，变量和其他标识符进行索引，将索引结果进行排序存储在 tags 文件中。  
在该文件中每一行就是一个 tag ，根据语言以及生成时的参数的不同，储存的具体内容也是不同的。  
使用 tags 可以方便的在大型项目中进行导航，在你不熟悉项目时，当你不确定一个方法到底做什么，或者如何使用时，可以直接跳转到方法的定义位置。当然，也可以很方便的跳转回原来的地方。

## Universal Ctags是什么？
Universal Ctags 是来自于 Exuberant-ctags 的分支，后者已经不再更新了。 u-ctags 有很多继承，而且现在还在更新！

## 帮助文档
https://docs.ctags.io/en/latest/man/ctags.1.html

## 安装
Sakura Editor 2.4.0.0 之后的版本都会在安装文件里面自带 Universal Ctags ，
在安装路径下会找到 ctags.exe
如果不用 Sakura Editor 可以在下面的 github 网址下载  
https://github.com/universal-ctags/ctags-win32

这里笔者将 Sakura Editor 的安装路径登录到了 git-bash 的 .bash_profile 中方便命令行使用
```bash
CTAGS_HOME='/c/Program Files (x86)/sakura'
PATH=$PATH:$CTAGS_HOME
export PATH
```
然后重启 git-bash ，确认 ctags 版本
```bash
ctags --version
```

## ctags 四大概念
* fields  
能理解成数据库里的字段概念，就是一条记录由哪些字段组成。主要就是语言对象名称names，所在文件input，正则表达式pattern，行号lines。
* kinds  
字段中语言对象的选择，比如你想要记录的是变量、函数名、或者类名。
* extras  
额外字段
* roles  
这是u-ctags独有的也是重大的发展，就是可以记录语言对象的引用，在哪里用过了。传统的e-ctags是只记录定义的！

## 一些查看命令
查看ctags支持的语言
```bash
ctags --list-languages
```

查看fields（C语言）
```bash
ctags --list-fields=C
```

查看kinds（C语言，Rust语言）
```bash
ctags --list-kinds=C
ctags --list-kinds=Rust
```
显示 [off] 的内容为不生成tags

查看extras（C语言）
```bash
ctags --list-extras=C
```

查看roles（C语言）
```bash
ctags --list-roles=C
```

确认语言映射（文件扩展名与语言的映射）
```bash
ctags --list-maps
```

## ctags 设定文件
universal-ctags的设定文件为
```
$HOME/.ctags.d/configure.ctags
```
或者
```
$HOME/.ctags.d/default.ctags
```

文件例子
* [configure.ctags](configure.ctags)

在文件中加入
```
--append=yes
--recurse=yes
--langmap=C:+.pc
--c-kinds=defghlmstuvxzLD
--output-format=e-ctags
```

| 参数                       | 说明                                                                                                                                    |
|----------------------------|-----------------------------------------------------------------------------------------------------------------------------------------|
| --append=yes               | 如果有tags文件则追加                                                                                                                    |
| --recurse=yes              | 包含子文件夹(和-R相同)                                                                                                                  |
| --langmap=C:+.pc           | 针对C语言追加.pc扩展名(.pc文件会作为C语言做成tags)                                                                                      |
| --c-kinds=defghlmstuvxzLD  | 对象的选择内容的指定（可以用 ctags --list-kinds=C 确认）                                                                                |
| --output-format=e-ctags    | 最新版 universal ctags 调用时需要加一个 --output-format=e-ctags，输出格式才和老的 exuberant ctags 兼容否则会有 windows 下路径名等小问题 |

## 在项目工程中使用ctags
一般在工程的根路径下生成.tags文件
```bash
cd /d/path/to/yourPJ
ctags -R --languages=C -f .tags
```

## 在vim中开启ctags跳转
```
:set tags=./.tags;,.tags
```
前半部分 “./.tags; ”代表在文件的所在目录下（不是 “:pwd”返回的 Vim 当前目录）查找名字为 “.tags”的符号文件，  
后面一个分号代表查找不到的话向上递归到父目录，直到找到 .tags 文件或者递归到了根目录还没找到，  
这样对于复杂工程很友好，源代码都是分布在不同子目录中，而只需要在项目顶层目录放一个 .tags文件即可  
逗号分隔的后半部分 .tags 是指同时在 Vim 的当前目录（“:pwd”命令返回的目录，可以用 :cd ..命令改变）下面查找 .tags 文件。

## 在vim中使用ctags跳转

| 快捷键   | 说明                               |
|----------|------------------------------------|
| Ctrl + ] | 跳转至光标所在对象定义之处         |
| Ctrl + t | 返回跳转前位置                     |
| gd       | 跳转到当前光标所在处局部变量的定义 |
| Ctrl + o | 跳转到之前的地方                   |
| Ctrl + i | 跳转到之后的地方                   |
| {        | 跳转到上一个空行                   |
| }        | 跳转到下一个空行                   |
| :ts      | 显示tag命令选择的列表，并进行跳转  |

## 其他参数
```
--input-encoding=<encoding>
```
```
--output-encoding=<encoding>
```
