# .zshrc for MacOS

# 设定命令提示符
prompt-cust() {
    local STR_EXIT_STATUS="%?"
    # echo $STR_EXIT_STATUS
    local PS1=""
    local STR_LINE1_PRE='╭'
    local STR_LINE2_PRE='╰'
    local STR_LEFT_SEMICIRCLE=''
    local STR_RIGHT_SEMICIRCLE=''
    local STR_LEFT_ARROW=''
    local STR_MAC_ICON=''
    local STR_DOCKER_ICON='󰡨'
    local STR_ERROR_ICON=''
    local STR_TIME_ICON=''
    local STR_USER_ICON=''
    local STR_IP_ICON='󰩠'
    local STR_DIRECTORY_ICON=''
    local STR_IP=$(ipconfig getifaddr en0)
    local STR_OS=$(echo "$(sw_vers -productName)$(sw_vers -productVersion)")
    # 左侧线
    PS1="${PS1}%F{#BC3FBC}${STR_LINE1_PRE}%f"
    # 左半圆
    PS1="${PS1}%F{#243C4F}${STR_LEFT_SEMICIRCLE}%f"
    # 判断上一个命令执行结果
    #if [[ $? -eq 0 ]]; then
        # 左半圆
        #PS1="${PS1}%F{#243C4F}${STR_LEFT_SEMICIRCLE}%f"
    #else
        # 左半圆带错误密码
        #PS1="${PS1}%F{#F14C4C}${STR_LEFT_SEMICIRCLE}%f%F{#E5E5E5}%K{#2472C8} ${STR_ERROR_ICON} $STR_EXIT_STATUS %k%f"
    #fi
    # 时间ICON和时间戳 %*
    PS1="${PS1}%F{#11A8CD}%K{#243C4F}${STR_TIME_ICON} %* %k%f"
    # OS信息
    PS1="${PS1}%F{#000000}%K{#E5E510} ${STR_MAC_ICON} ${STR_OS} %k%f"
    # 登陆用户信息
    PS1="${PS1}%F{#E5E5E5}%K{#2472C8} ${STR_USER_ICON} %n@%m %k%f"
    # IP信息
    PS1="${PS1}%F{#000000}%K{#11A8CD} ${STR_IP_ICON} ${STR_IP} %k%f"
    # 当前目录
    PS1="${PS1}%F{#E5E510}%K{#243C4F} ${STR_DIRECTORY_ICON} %~ %k%f"
    # 右箭头
    PS1="${PS1}%F{#243C4F}${STR_LEFT_ARROW}%f"
    # 换行
    PS1="${PS1}\n"
    # 第2行-左侧线
    PS1="${PS1}%F{#BC3FBC}${STR_LINE2_PRE}%f"
    # 第2行-用户类型
    PS1="${PS1}%F{#2472C8}%#%f "
    echo $PS1
}
PROMPT=`prompt-cust`

# 设定别名
alias ll='ls -lhT --color=auto'
alias lg='lazygit'
alias dk='docker'
alias dki='docker images'
alias dkc='docker ps -a'
alias dkl='docker logs -ft --tail ?'
alias dke='func_docker_exec() { docker exec -it $1 /bin/bash; }; func_docker_exec'
alias dkr='docker run -it --entrypoint /bin/bash'
alias dka='docker attach'
alias dc='docker compose'
