# Netrw

## Netrw简介
Netrw 插件是伴随 Vim 发行的文件浏览器,不需要单独安装,也就是说,你在任意一台安装有 Vim 的计算机上都可以上手使用,不需要做任何配置。

## 文件浏览器netrw基础操作
下边是一些文件浏览器netrw里的一些常用快捷键及命令  

I 显示/隐藏 文件浏览器提示  
F1 在netrw文件浏览器里按F1会打开netrw的帮助信息  
**Enter 在当前窗口打开该文件/目录  
t 在新tab标签页中，打开文件/目录**  
v 在左边垂直拆分窗口，打开文件/目录  
o 在上边水平拆分窗口，打开文件/目录  
p 预览文件  
x 使用关联程序打开文件，用于快速打开非文本型文件，如 word、图片  
**- 浏览上一级目录  
i 在瘦、长、宽和树形方式切换，来展示文件列表  
d 新建目录  
D 删除的文件/目录  
% 新建文件  
s 依次切换选择排序方式：按名字，时间或文件大小**  
S 自定义排序  
r 反向排序列表    
**R 重命名指定的文件/目录**  
Ctrl+h 输入关键字，隐藏文件名相关的文件  
**Ctrl+l 刷新 netrw 目录列表**  
qf 显示文件信息  
cd 使浏览目录为当前目录  
mb 添加当前目录到书签  
mB 取消当前目录作为书签  
gb 跳转到书签目录（3gb跳转到第3个书签）  
qb 列出书签目录和历史目录  
gh 快速隐藏/取消隐藏.开头的文件或目录，如.vim  
gn 进入光标所在目录  
mt 当前浏览的目录作为目标文件夹  
Tb 当书签目录作为目标文件夹  
3Tb 表示第三个书签作为目标文件夹  
Th 当历史目录作为目标文件夹  
3Th 表示第三个历史目录作为目标文件夹  
**mc 复制标记文件到目标文件夹**  
md 对比标记的文件（最多3个）  
me 将标记的文件放入 arglist 并对其进行编辑  
**mf 标记该文件  
mF 取消该文件标记**  
mg 对标记的文件按内容进行vimgrep检索  
**mm 移动标记的文件到目标文件夹**  
mp 打印标记文件（打印机的打印）  
**mr 使用shell风格的正则表达式标记文件**  
mT 应用的 ctags 标记文件  
ma 将标记文件放入 arglist  
mA 将 arglist 中的文件作为标记文件  
cb将标记文件放入 buffer-list 
cB 将 buffer-list 中的文件作为标记文件  
**mu 取消所有标记的文件**  
mv 标记文件应用任意Vim命令  
mx 标记文件应用任意shell命令  
mX 标记文件整块应用任意shell命令  
mz 压缩/解压缩的文件标记  
gd 把远程的符号链接作为目录  
gf 把远程的符号链接作为文件  
C 设置编辑窗口  
O 获得由光标指定的文件（远程文件）  
C-r 使用gvim服务器浏览  
qF 使用quickfix列出标记文件  
qL 使用location-list标记文件  
mh 显示/隐藏 当前目录的标记文件  
**a 显示/隐藏文件**  
隐藏（禁止匹配的文件显示：g:netrw_list_hide）  
显示（只显示匹配的文件：g:netrw_list_hide）  

## 在netrw中删除非空文件夹

在默认设置中，你不能删除非空文件夹，如果想删非空文件夹的话，需要修改如下文件

修改前备份
```bash
cd /usr/share/vim/vim80/autoload
cp -afp netrw.vim netrw.vim_back20230418
```

在netrw.vim中找到如下内容
```
if delete(rmfile,"d")
  call netrw#ErrorMsg(s:ERROR,"unable to delete directory <".rmfile.">!",103)
```

修改为
```
"if delete(rmfile,"d")
if delete(rmfile,"rf")
  call netrw#ErrorMsg(s:ERROR,"unable to delete directory <".rmfile.">!",103)
```
保存文件，然后重新启动vim即可

