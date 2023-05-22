# 这是一个gitbash用的.bash_profile，放置路径为C:\Users\xxx

MINGW_HOME=/d/Tools/WorkTool/C/codeblocks-20.03mingw-nosetup/MinGW/bin
RUST_HOME=/d/Tools/WorkTool/Rust/Rust_gnu_1.69/bin
JAVA_HOME=/d/Tools/WorkTool/Java/jdk17.0.6/bin
PYTHON_HOME=/d/Tools/WorkTool/Python/Python38-32
VSCODE_HOME=/d/Tools/WorkTool/Text/VSCode-win32-x64-1.77.1
CMAKE_HOME=/d/Tools/WorkTool/C/cmake-3.26.1-windows-x86_64/bin
NINJA_HOME=/d/Tools/WorkTool/C/ninja-win
GVIM_HOME=/d/Tools/WorkTool/Text/vim90
CTAGS_HOME=/d/Tools/WorkTool/C/ctags_6.0_x64
PATH=$PATH:$MINGW_HOME:$RUST_HOME:$JAVA_HOME:$PYTHON_HOME:$VSCODE_HOME:$CMAKE_HOME:$NINJA_HOME:$GVIM_HOME:$CTAGS_HOME
export PATH

#export CDPATH=.:/d/WorkSpace:/d/Tools

#export PS1="\e[1;35m\u@\h\e[0m:\e[33m\W\e[0m\e[34m\\$\e[0m "
export app=/d/WorkSpace/Rust/RustTest
export bin=/d/WorkSpace/Rust/RustTest/target/debug
export log=/d/WorkSpace/Rust/RustTest/log

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
