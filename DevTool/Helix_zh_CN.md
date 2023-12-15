# Helix

## 简介
Helix 由 Rust 编写, 高度基于 vim 与 kakoune , 努力在前辈们的肩膀上, 修正\/改进它们的编辑模式  
Helix 整合了一些原本在 vim 中属于插件的功能, 创造了一个真正意义上开箱即用的现代编辑器

## 官网
 - [官网](https://docs.helix-editor.com/)
 - [github](https://github.com/helix-editor/helix)

## 安装

#### Windows
在github下载二进制，添加进环境变量即可  
[helix-23.10-x86_64-windows.zip](https://github.com/helix-editor/helix/releases/download/23.10/helix-23.10-x86_64-windows.zip)

#### Linux
Ubuntu
```
sudo add-apt-repository ppa:maveonair/helix-editor
sudo apt update
sudo apt install helix
```
更多看 [这里](https://docs.helix-editor.com/install.html#linux)

#### 安装后确认
```
hx --version
hx --health
```

## 配置文件位置
 - Linux and Mac: ``~/.config/helix/config.toml``
 - Windows: ``%AppData%\helix\config.toml``

## 笔者的设定文件
 * [helix_conf](./helix_conf)  

NOTE：因为笔者已经熟悉了 vim 的键绑定，所以这个配置是 ``vim like`` 的键绑定
