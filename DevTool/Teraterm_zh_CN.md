# Teraterm设定

## TeraTerm下载方法
#### 1，官网下载页面确定需要的软件版本号和对应编号
**网址：**  
https://zh.osdn.net/projects/ttssh2/releases/74780

#### 2，该网页下将网址中编号和版本号改为想要下载的版本
**安装版：**  
https://osdn.net/projects/ttssh2/downloads/74780/teraterm-4.106.exe  
**绿色版：**  
https://osdn.net/projects/ttssh2/downloads/74780/teraterm-4.106.zip

## 1.Teraterm的宏脚本

在使用teraterm连接终端的时候，每次都要输入用户名密码很繁琐。这里介绍用宏脚本文件ttl启动的的方法。  

#### 首先，需要新建.ttl脚本文件
※ ttl脚本文件中;为注释  
设定文件例子   
```ttl
;user@192.168.0.3-8122.ttl

;服务器信息
host = '192.168.0.3'
port = '8122'
user = 'user'
pass = 'password123'

;使用ssh连接服务器
COMMAND = host
strconcat COMMAND ':'
strconcat COMMAND port
strconcat COMMAND ' /ssh /2 /auth=password /user='
strconcat COMMAND user
strconcat COMMAND ' /passwd="'
strconcat COMMAND pass
strconcat COMMAND '"'
connect COMMAND

;自动载入keymap文件
loadkeymap 'KEYBOARD.CNF'

;等待服务器的命令提示符（有可能是'%' '$' '#' '>'）
wait '#'

;自定义登录后的发行command
sendln "export log=/aaa/app/log"
;等待服务器的命令提示符%（有可能是'%' '$' '#' '>'）
wait '#'

end
```

#### 然后，使用ttl脚本启动teraterm
* 1.鼠标右键 → 新建 → 快捷方式
* 2.输入
```
"C:\Program Files\teraterm\ttpmacro.exe" "/V" "C:\test.ttl"
```
&nbsp;&nbsp;&nbsp;&nbsp;※ 第一个双引号内容为ttpmacro.exe所在路径  
&nbsp;&nbsp;&nbsp;&nbsp;※ 第三个双引号内容为ttl脚本所在路径
* 3.给快捷方式设定一个名字
* 4.用快捷方式启动teraterm会自动连接上服务器并且发行自定义命令

## 2.Teraterm的自动log记录设定

Setup → Additional settings... → Log（tab）  
#### 2-1.在[Default log file name]中输入如下内容
```
teraterm-%Y%m%d_%H%M%S_&h.log
```
※ 上面的「&h」代表连接的远程主机的名字

#### 2-2.在[Default log save folder]中  
根据需要选择log路径

#### 2-3.选中[Auto start logging]Checkbox

#### 2-4.设置完成之后，需要保存才能生效
Setup → Save setup...

## 3.快捷键自定义

#### 3-1.查找键盘快捷键的Keycode
在teraterm路径下有keycode.exe，打开后按下键盘按键就会告诉你快捷键的Keycode。  
比如一直按住Ctrl + 1，会表示1026

#### 3-2.查找操作的Keycode
在teraterm路径下有teraterm.chm，打开后Reference data → Keycode  
在这里面可以找到操作的Keycode。  
比如Edit菜单下的清空缓存为50260
```
[Edit] Clear buffer                 50260
```

#### 3-3.编辑CNF文件
在teraterm路径下有KEYBOARD.CNF，修改这个文件（注意备份）  
打开到最下面的[User keys]代码块，可以定义用户自定义按键  
定义规则为：
```
<User key name>=<PC key code>,<Control flag>,<String>
```
其中**Control flag**的定义为按下按键的时候<String>如何处理 ，具体参照下表 
| Control flag | String                                                                            |
|--------------|-----------------------------------------------------------------------------------|
| 0            | 发行命令                                                                          |
| 1            | 对\<String\>中包含的中日文和换行符，按照Tera Term的设定进行变换，发行变换后的内容 |
| 2            | 运行名字为\<String\>的宏脚本ttl文件                                               |
| 3            | 菜单操作的Keycode                                                                 |


**例子1：**  
按下Ctrl + 1[1026]，就执行Edit菜单下的清空缓存[50260]
```
User1=1026,3,50260
```

**例子2：**  
按下Ctrl + 2[1027]，运行ttl路径下的lchenv.ttl脚本
```
User2=1027,2,ttl/lchenv.ttl
```

**例子3：**  
按下Ctrl + 3[1028]，就输出[pwd]
```
User3=1028,0,pwd
```

将内容加到[User keys]代码块下面，并保存文件。
```
[User keys]
User1=1026,3,50260
User2=1027,2,ttl/lchenv.ttl
User3=1028,0,pwd
```

#### 3-4.让小键盘的数字和符号生效
同样是KEYBOARD.CNF，找到[VT numeric keypad]代码块，修改
```
Num0=xxx
```
为
```
Num0=off
```
将整个[VT numeric keypad]代码块的内容全部修改为off，并保存文件。
```
[VT numeric keypad]
;Num pad 0 key
Num0=82 → Num0=off
;Num pad 1 key
Num1=79 → Num1=off
...(略)
```

#### 3-5.载入keymap文件
在TeraTerm菜单栏上选择 Setup → Load Key map，弹出的文件选择窗口中选择KEYBOARD.CNF就完成载入了。  
如果想每次启动TeraTerm都自动载入的话，将下面内容加入到[1.Teraterm的宏脚本]的ttl文件中，并且用1的方法启动即可。
```
;自动载入keymap文件
loadkeymap 'KEYBOARD.CNF'
```

## 4.teraterm的ttl脚本命令列表

https://ttssh2.osdn.jp/manual/4/ja/macro/command/

## 5.TeraTerm中文菜单

在TeraTerm安装路径下有lang文件夹，这里有各个语言的lng文件  
* 中文为：Simplified Chinese.lng
* 繁体为：Traditional Chinese.lng  

语言文件的指定在根路径下的**TERATERM.INI**中的**UILanguageFile**

```
;日文
UILanguageFile=lang\Japanese.lng
;中文
;UILanguageFile=lang\Simplified Chinese.lng
;繁体
;UILanguageFile=lang\Traditional Chinese.lng
```

语言包可以在这里下载  
https://github.com/Testato/TeraTerm/tree/master/installer/release/lang

## 6.设定文件的内容

在TeraTerm安装路径下有**TERATERM.INI**，打开并且修改如下

```
;BSKey=BS
BSKey=DEL

;TermType=vt100
TermType=xterm

; Default directory for file transfers
FileDir=D:\Tool\teraterm-4.84

; Clear screen when window is resized
ClearOnResize=off
```

上面的TermType=xterm定义对应着服务器
/etc/DIR_COLORS里面的颜色定义。  
如果不修改设定文件的话也可以把下面命令加到启动ttl脚本里  
比如：
```bash
export TERM=gnome
```

### 相关设定文件
* [user@192.168.0.3-8122.ttl](user@192.168.0.3-8122.ttl)
* [TERATERM.INI](TERATERM.INI)
* [KEYBOARD.CNF](KEYBOARD.CNF)

---

## WinSCP下载

**网址：**  
https://sourceforge.net/projects/winscp/files/WinSCP/5.21.8/
 * WinSCP-5.21.8-Portable.zip

**语言包下载：**  
https://winscp.net/eng/translations.php?v=5.21.8.13000&lang=0409&isinstalled=0&utm_source=winscp&utm_medium=app&utm_campaign=5.21.8  
 * Simplified Chinese
 * Japanese

解压zip得到语言包后放到WinSCP的**子文件夹Translations**内即可。