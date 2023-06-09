# pdb相关

## pdb简介
Python 的 pdb 模块定义了一个交互式源代码调试器，用于 Python 程序。它支持在源码行间设置（有条件的）断点和单步执行，检视堆栈帧，列出源码列表，以及在任何堆栈帧的上下文中运行任意 Python 代码。它还支持事后调试，可以在程序控制下调用。非常类似 C 的 gdb。  
如果你还主要靠print来调试代码，那值得试试 pdb 这个 Python 自带的 Debug 工具。

## pdb的2种用法

#### 非侵入式方法（不用额外修改源代码，在命令行下直接运行就能调试）
```
python3 -m pdb filename.py
```

#### 侵入式方法（需要在被调试的代码中添加一行代码然后再正常运行代码）
```
import pdb;pdb.set_trace()
```

当你在命令行看到下面这个提示符时，说明已经正确打开了pdb
```
(Pdb) 
```
然后就可以开始输入pdb命令了

## pdb常用命令

和 gdb 几乎一样，看一下 gdb 的命令即可。  
因为 pdb 不带 tui 模块，所以查看代码需要用下面的命令

查看当前位置前后11行源代码（多次会翻页）当前位置在代码中会用-->这个符号标出来
```
(Pdb) l
```

查看当前函数或框架的所有源代码
```
(Pdb) ll
```
