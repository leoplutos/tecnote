# 这是一个gitbash用的.bash_profile，放置路径为C:\Users\xxx

MINGW_HOME=/d/Tools/WorkTool/C/codeblocks-20.03mingw-nosetup/MinGW/bin
export CARGO_HOME=/d/Tools/WorkTool/Rust/Rust_gnu_1.70
export RUSTUP_HOME=/d/Tools/WorkTool/Rust/Rust_gnu_1.70
JAVA_HOME=/d/Tools/WorkTool/Java/jdk17.0.6/bin
PYTHON_HOME=/d/Tools/WorkTool/Python/Python38-32
VSCODE_HOME=/d/Tools/WorkTool/Text/VSCode-win32-x64-1.78.2
CMAKE_HOME=/d/Tools/WorkTool/C/cmake-3.26.1-windows-x86_64/bin
NINJA_HOME=/d/Tools/WorkTool/C/ninja-win
GVIM_HOME=/d/Tools/WorkTool/Text/vim90
CTAGS_HOME=/d/Tools/WorkTool/C/ctags_6.0_x64
ANT_HOME=/d/Tools/WorkTool/Java/apache-ant-1.10.13/bin
PATH=$PATH:$MINGW_HOME:$CARGO_HOME/bin:$JAVA_HOME:$PYTHON_HOME:$VSCODE_HOME:$CMAKE_HOME:$NINJA_HOME:$GVIM_HOME:$CTAGS_HOME:$ANT_HOME
export PATH

#export CDPATH=.:/d/WorkSpace:/d/Tools

#export PS1="\e[1;35m\u@\h\e[0m:\e[33m\W\e[0m\e[34m\\$\e[0m "
export app=/d/WorkSpace/Rust/RustTest
export bin=/d/WorkSpace/Rust/RustTest/target/debug
export log=/d/WorkSpace/Rust/RustTest/log

export COLORTERM=truecolor

alias ll='ls -l --color=auto'
alias lla='ls -al --color=auto'
alias llt='ls -ltr --color=auto'
#alias gdbx='gdb -x /lch/workspace/gdbinit/.gdbinit'
alias cda='cd $app'
alias cdb='cd $bin'
alias cdl='cd $log'
alias python='winpty python'
#在mintty下删除屏幕buffer
alias clearb='echo -e "\ec\e[3J"'
alias tree='winpty tree.com'

# ssh服务器
alias ssh4='ssh -t user@1.2.3.4 -p 22 "/bin/bash --rcfile /lch/workspace/bashrc/.bashrc-personal"'
alias ssho4='ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -oHostKeyAlgorithms=+ssh-dss -t user@1.2.3.4 -p 22 "/bin/bash --rcfile /lch/workspace/bashrc/.bashrc-personal"'

# 修改终端编码为utf8
chcp.com 65001
