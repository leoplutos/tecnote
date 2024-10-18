# CMD命令

### doskey别名

**生成doskey**
```cmd
doskey 别名=对应命令 $*
```
$*代表后面可以续接参数。

**确认doskey**
```cmd
doskey /macros
```

### 确认端口
```
netstat -nao | find "8080"
```

# 修改cmd的提示符
``cmd`` 的提示符是在 ``PROMPT`` 环境变量中设置的，使用下面的命令可以确认  
1. Session 级别的设定(作用当前Session，不需要重启cmd)
```
set PROMPT
PROMPT=$P$G
```
2. 系统级别的设定(作用全局，需要重启cmd，不推荐)
```
setx prompt $P$G
```
默认设置为 ``$P$G``  

注意：  
Windows10之前的Windows：控制台上没有对 ANSI 颜色的支持  
Windows10及更高：支持ANSI颜色  

下面是2个设定例子
```
set PROMPT=$E[36m%computername%:$E[0m$E[33m$P$E[0m$E[35m#$E[0m 
```
```
set PROMPT=[%computername%] $d$s$t$_$p$_$_$+$g
```
参数说明：
- $E = Escape code (ASCII code 27)，可以设置颜色
- $P = 当前目录的路径
- $_ = 回车
- $+ = PUSHD/POPD 堆栈中每个级别的加号。

输入下面的命令可以查看参数说明
```
PROMPT /?
```

笔者的设定文件 [cmdautorun.cmd](cmdautorun.cmd)

灵感来自
- [prompt](https://learn.microsoft.com/zh-cn/windows-server/administration/windows-commands/prompt)
- [bash-prompt-generator.org](https://bash-prompt-generator.org/)
- [my-new-bash-prompt.html](https://www.mikekasberg.com/blog/2021/06/28/my-new-bash-prompt.html)
- [nerdps1](https://github.com/joknarf/nerdps1/)

# 设定启动cmd的默认命令

## 方法1：修改注册表

#### 1.在任意路径新建 cmdautorun.cmd ，
比如新建在 ``D:\Tools\WorkTool\Cmd\cmdautorun.cmd ``  
内容如下
* [cmdautorun.cmd](cmdautorun.cmd)

#### 2.定义AutoRun
``win + r`` 键入 ``regedit`` 打开注册表  
**Win10路径**  
```
计算机\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Command Processor
```
**Win7之前路径**  
```
计算机\HKEY_CURRENT_USER\Software\Microsoft\Command Processor
```
在右侧空白处，按下鼠标右键 → 新建 → 字符串值 → 输入 ``AutoRun``  
数值数据中，输入cmd的路径 ``D:\Tools\WorkTool\Cmd\cmdautorun.cmd ``  
重新打开一个cmd，输入 ``ll`` 确认

## 方法2：使用快捷方式（不推荐）
有些时候，无法修改注册表，可以将上面的文件建立一个快捷方式，用快捷方式启动即可。  
注意这个方式要把最下面一行的 ``@cmd /k`` 注释打开

## 方法3：使用快捷方式（推荐）
新建快捷方式，内容如下
```
cmd.exe /k "D:\Tools\WorkTool\Cmd\cmdautorun.cmd"
```

# Windows下一些变量

```
%USERPROFILE% =C:\Users\用户名
%SystemRoot% =C:\WINDOWS
%SystemDrive% =C:
%APPDATA% =C:\Users\用户名\AppData\Roaming
%LOCALAPPDATA% =C:\Users\用户名\AppData\Local
%windir% =C:\WINDOWS
%Path% =C:\Windows\system32;C:\Windows; 
%ProgramData% =C:\ProgramData
%ProgramFiles% =C:\Program Files
%ProgramFiles(x86)% =C:\Program Files (x86)
%ALLUSERSPROFILE% =C:\ProgramData
%CommonProgramFiles% =C:\Program Files\Common Files
%CommonProgramFiles(x86)% =C:\Program Files (x86)\Common Files
%CommonProgramW6432% =C:\Program Files\Common Files
%COMPUTERNAME% =MyPC
%ComSpec% =C:\WINDOWS\system32\cmd.exe
%HOMEDRIVE% =C:
%HOMEPATH% =\Users\用户名
%LOGONSERVER% =\\MicrosoftAccount
%OS% =Windows_NT
%ProgramW6432% =C:\Program Files  
%PUBLIC% =C:\Users\Public 
%TEMP% =C:\Users\用户名\AppData\Local\Temp
%TMP% =C:\Users\用户名\AppData\Local\Temp
%USERDOMAIN% =MyPC 
%USERNAME% =用户名
```

