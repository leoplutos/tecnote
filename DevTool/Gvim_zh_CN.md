# Gvim

## 下载
gvim是vim的图形前端。  
下载地址：
* 安装版  
https://www.vim.org/download.php

* 绿色版  
https://ftp.nluug.nl/pub/vim/pc/  
绿色版需要下载2个zip文件，然后解压缩到一个路径下即可。  
基础运行时：vim90rt.zip  
和右边其中任意一个：gvim90.zip or gvim90ole.zip


## gvimrc的加载顺序
gvim优先加载\~/.vimrc，然后加载\~/.gvimrc，所以只需要在~下放入2个文件即可

## gvim主题
下载主题文件（比如：Tomorrow-Night.vim）到vim安装路径的colors文件夹下。  
然后rc文件中加入
```
colorscheme Tomorrow-Night
```
即可

## 笔者的gvimrc
和其他的 vimrc 一起放在 \~ 即可
* [.gvimrc](.gvimrc) ： gvim专用文件
* [.vimrc](.vimrc) ： 主文件
* [vim-color-16-rc.vim](vim-color-16-rc.vim) - 不支持256色的颜色设置
* [vim-color-256-rc.vim](vim-color-256-rc.vim) - 支持256色的颜色设置（暗色系）
* [vim-color-256-rc-light.vim](vim-color-256-rc-light.vim) - 支持256色的颜色设置（亮色系）
* [apc.vim](apc.vim) - 自动补全

