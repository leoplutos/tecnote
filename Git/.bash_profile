# 这是一个gitbash for windows用的.bash_profile，放置路径为%USERPROFILE%

#设定WIN_ICON=NerdFont的Windows图标实际命令：echo {e70f}
WIN_ICON=`echo  `
PS_IP=`netsh interface ip show address "以太网" | findstr "IP Address" | awk '{print $3}'`
PS_IP=`echo ${PS_IP}`
PS_RED="\e[0;31m"
PS_LIGHT_RED="\e[1;31m"
PS_GREEN="\e[0;32m"
PS_YELLOW="\e[0;33m"
PS_BLUE="\e[0;34m"
PS_MAGENTA="\e[0;35m"
PS_CYAN="\e[0;36m"
PS_CLEAR="\e[0m"
export PS1='`exitStatus=$?;echo -n "\['${PS_YELLOW}${WIN_ICON}[Git-Bash]${PS_CLEAR}${PS_GREEN}[${PS_IP}]${PS_CLEAR}${PS_MAGENTA}'\]""\u@\h""\['${PS_CLEAR}:${PS_YELLOW}'\]""\w""\['${PS_CLEAR}'\]""\n";if [ $exitStatus -ne 0 ];then echo -n "\['${PS_RED}'\]""[""\['${PS_LIGHT_RED}'\]""${exitStatus}""\['${PS_RED}'\]""]";fi;echo -n "\['${PS_CLEAR}${PS_BLUE}'\]""\$""\['${PS_CLEAR}'\]"` '

NVIM_HOME=/d/Tools/WorkTool/Text/nvim-win64/bin
MINGW_HOME=/d/Tools/WorkTool/C/MinGW64/bin
export CARGO_HOME=/d/Tools/WorkTool/Rust/Rust_gnu_1.70
export RUSTUP_HOME=/d/Tools/WorkTool/Rust/Rust_gnu_1.70
JAVA_HOME=/d/Tools/WorkTool/Java/jdk17.0.6/bin
PYTHON_HOME=/d/Tools/WorkTool/Python/Python38-32
VSCODE_HOME=/d/Tools/WorkTool/Text/VSCode-win32-x64
CMAKE_HOME=/d/Tools/WorkTool/C/cmake-3.26.1-windows-x86_64/bin
NINJA_HOME=/d/Tools/WorkTool/C/ninja-win
GVIM_HOME=/d/Tools/WorkTool/Text/vim90
CTAGS_HOME=/d/Tools/WorkTool/C/ctags_6.0_x64
ANT_HOME=/d/Tools/WorkTool/Java/apache-ant-1.10.13/bin
PATH=$PATH:$NVIM_HOME:$MINGW_HOME:$CARGO_HOME/bin:$JAVA_HOME:$PYTHON_HOME:$VSCODE_HOME:$CMAKE_HOME:$NINJA_HOME:$GVIM_HOME:$CTAGS_HOME:$ANT_HOME
export PATH

#export CDPATH=.:/d/WorkSpace:/d/Tools

alias ll='ls -hl --full-time --time-style=long-iso --color=auto'
alias lla='ls -hal --full-time --time-style=long-iso --color=auto'
alias llt='ls -htl --full-time --time-style=long-iso --color=auto'
alias cdw='cd $personal_workspace'
alias cdl='cd $personal_log'
#因为alias无法传递参数，所以用定义函数，然后调用函数的方式，导入参数
alias vimf='func_vimf() { vim -u $1 --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1"; }; func_vimf'
alias vimc='func_vimc() { vim -u $1 --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_lsp_type = 3"; }; func_vimc'
alias vimv='func_vimv() { vim -u $1 --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_front_dev_type = 1"; }; func_vimv'
alias nvimf='func_nvimf() { nvim $1 --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1"; }; func_nvimf'
alias nvimc='func_nvimc() { nvim $1 --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_lsp_type = 3"; }; func_nvimc'
alias nvimv='func_nvimv() { nvim $1 --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_front_dev_type = 1"; }; func_nvimv'
alias lg='lazygit'
alias gu='gitui'

alias clearb='echo -e "\ec\e[3J"'

# ssh服务器
alias ssh4='ssh -t user@1.2.3.4 -p 22 "/bin/bash --rcfile /lch/workspace/bashrc/.bashrc-personal"'
alias ssho4='ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -oHostKeyAlgorithms=+ssh-dss -t user@1.2.3.4 -p 22 "/bin/bash --rcfile /lch/workspace/bashrc/.bashrc-personal"'

# 修改终端编码为utf8
chcp.com 65001

# 默认使用fish shell
exec fish
