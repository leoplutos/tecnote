# 高效命令行工具

## 下载说明
Windows 平台推荐用 `winget` 下载  
用 `winget` 下载后的保存位置为
```
%LOCALAPPDATA%\Microsoft\WinGet
```

## ripgrep(rg)
比 grep 更快的代码/文本搜索工具

https://github.com/BurntSushi/ripgrep

#### Windows
```bash
# 安装
winget install BurntSushi.ripgrep.MSVC
# 确认
rg --version
```

#### VSCode自带
如果你有 ``VS Code``，那么就不用安装了，在 ``VS Code`` 的安装目录搜索 ``rg.exe`` 即可找到路径  
笔者的路径为
```
D:\Tools\WorkTool\Text\VSCode-win32-x64-1.81.1\resources\app\node_modules.asar.unpacked\@vscode\ripgrep\bin
```

## zoxide

一个更智能的 cd 命令，会根据你常用的目录自动学习和排序，让你只需输入几个关键词就能快速跳转到目标目录

https://github.com/ajeetdsouza/zoxide

#### macOS
```bash
brew install zoxide
```

#### Linux / WSL
```bash
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
```

#### Windows
```bash
winget install ajeetdsouza.zoxide
```

### 设定

#### Bash
把下面这一行添加到 `~/.bashrc` 的末尾
```bash
eval "$(zoxide init bash)"
```

#### Zsh
把下面这一行添加到 `~/.zshrc` 的末尾
```bash
eval "$(zoxide init zsh)"
```

#### Nushell

先查看 env 文件路径：
```bash
$nu.env-path
```

打开这个文件，在末尾加入：
```bash
zoxide init nushell | save -f ~/.zoxide.nu
```

再查看 config 文件路径：
```bash
$nu.config-path
```

打开这个文件，在末尾加入：
```bash
source ~/.zoxide.nu
```

重启 Nushell，或者重新加载配置后即可使用 zoxide。

## fd
比 find / dir 更好用的文件搜索工具

https://github.com/sharkdp/fd

#### Windows
```bash
# 安装
winget install sharkdp.fd
# 确认
fd --version
```

## fzf
模糊搜索器，可以和 rg、fd 等组合使用

https://github.com/junegunn/fzf

#### Windows
```bash
# 安装
winget install fzf
# 确认
fzf --version
```

