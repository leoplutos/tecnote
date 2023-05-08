# Windows下Git使用WinMerge作为difftool

## 前言
对一个使用命令行的人来说，使用 git diff 来展示差异对比已经完全足够，可在某些需要解决冲突的场合，命令行就显得有点力不从心。这里记录配置 difftool 为 WinMerge 的方法。

## 1.下载WinMerge
官网：  
https://winmerge.org/

## 2.修改配置文件
文件为：C:/Users/User/.gitconfig  
加入如下内容
```
[diff]
    tool = winmerge
[difftool]
    prompt = false
[difftool "winmerge"]
    name = WinMerge
    trustExitCode = true
#    cmd = '/d/Tools/WorkTool/Text/WinMerge-2.16.30-x64/WinMergeU.exe' -u -e $LOCAL $REMOTE
#    cmd = '/d/Tools/WorkTool/Text/WinMerge-2.16.30-x64/WinMergeU.exe' -e -ub -dl "Base" -dr "Mine" $LOCAL $REMOTE
#    cmd = '/d/Tools/WorkTool/Text/WinMerge-2.16.30-x64/WinMergeU.exe' -r -ub -dl "Remote" -dr "Local" $LOCAL $REMOTE
    cmd = '/d/Tools/WorkTool/Text/WinMerge-2.16.30-x64/WinMergeU.exe' -e -r -u -x -wl -wr -dl \"Remote-/$MERGED\" -dr \"Local-/$MERGED\" \"$LOCAL\" \"$REMOTE\"

[merge]
    tool = winmerge
[mergetool]
    prompt = false
    keepBackup = false
    keepTemporaries = false
[mergetool "winmerge"]
    name = WinMerge
    trustExitCode = true
#    cmd = '/d/Tools/WorkTool/Text/WinMerge-2.16.30-x64/WinMergeU.exe' -u -e -fm -wl -dl "Local" -wr -dr "Remote" $LOCAL $MERGED $REMOTE
    cmd = '/d/Tools/WorkTool/Text/WinMerge-2.16.30-x64/WinMergeU.exe' -e -u -fr -ar -wl -wm -dl \"Base File\" -dm \"Theirs File\" -dr \"Mine File\" \"$BASE\" \"$REMOTE\" \"$LOCAL\" -o \"$MERGED\"
```

## 3.比较工具启动（difftool）
比较文件夹
```bash
git difftool -d
或者
git difftool --dir-diff
```
比较指定文件
```bash
git difftool file
```
比较所有文件
```bash
git difftool
```
为方便操作，可以使用别名
```bash
alias diffdir='git difftool --dir-diff'
diffdir
```

## 4.合并工具启动（mergetool）
```bash
git mergetool
```

## 5.比较利用的WinMerge启动参数
| 参数 | 说明                           |
|------|--------------------------------|
| -e   | 按下ESC退出                    |
| -r   | 比较所有的子文件夹下的所有文件 |
| -u   | 不添加到最近打开               |
| -x   | 比较的是同一个文件的话直接退出 |
| -wl  | 左侧为只读模式                 |
| -wr  | 右侧为只读模式                 |
| -dl  | 设定左侧标题                   |
| -dr  | 设定右侧标题                   |

## 6.合并利用的WinMerge启动参数
| 参数 | 说明                                         |
|------|----------------------------------------------|
| -fr  | 光标放在右侧                                 |
| -ar  | 在右侧自动merge（merge在中间没有冲突的变更） |

使用 -ar 参数，让 WinMerge 自动merge