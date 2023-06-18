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

## 方法2：使用快捷方式
有些时候，无法修改注册表，可以将上面的文件建立一个快捷方式，用快捷方式启动即可。  
注意这个方式要把最下面一行的 ``cmd`` 注释打开

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

