# 适用于 macOS / WSL / Linux 的 .zshrc

# ============================================================
# Prompt 常量
# ============================================================

readonly STR_LINE1_PRE='╭'
readonly STR_LINE2_PRE='╰'
readonly STR_LEFT_SEMICIRCLE=''
readonly STR_RIGHT_SEMICIRCLE=''
readonly STR_LEFT_ARROW=''
readonly STR_MAC_ICON=''
readonly STR_UBUNTU_ICON=''
readonly STR_TIME_ICON=''
readonly STR_USER_ICON=''
readonly STR_IP_ICON='󰩠'
readonly STR_DIRECTORY_ICON=''
readonly STR_REPO_ICON=''
readonly STR_BRANCH_ICON=''

# 原始 Prompt 配色
readonly C_MAGENTA='#BC3FBC'
readonly C_DARK='#243C4F'
readonly C_CYAN='#11A8CD'
readonly C_YELLOW='#E5E510'
readonly C_BLUE='#2472C8'
readonly C_WHITE='#E5E5E5'
readonly C_BLACK='#000000'

# Git Prompt 配色 - 与 config.nu 保持一致
readonly C_GIT_PURPLE='#c678dd'
readonly C_GIT_YELLOW='#e5c07b'
readonly C_GIT_GREEN='#98c379'

# ============================================================
# 平台辅助函数
# ============================================================

prompt_platform() {
    if [[ "$(uname -s 2>/dev/null)" == "Darwin" ]]; then
        print -r -- 'macos'
        return
    fi

    if [[ -r /proc/sys/kernel/osrelease ]] && grep -qi microsoft /proc/sys/kernel/osrelease 2>/dev/null; then
        print -r -- 'wsl'
        return
    fi

    print -r -- 'linux'
}

# macOS 刻意保持原始 .zshrc 的行为不变。
# WSL/Linux 从 /etc/os-release 读取发行版 ID。
prompt_os_name() {
    local platform="$1"

    if [[ "$platform" == 'macos' ]]; then
        print -r -- "$(sw_vers -productName 2>/dev/null)$(sw_vers -productVersion 2>/dev/null)"
        return
    fi

    if [[ -r /etc/os-release ]]; then
        # 只使用发行版 ID（例如 Debian、Ubuntu），
        # 不使用完整的 PRETTY_NAME / 版本信息。
        local distro_id
        distro_id="$(sed -n 's/^ID=//p' /etc/os-release | head -n 1)"
        distro_id="${distro_id#\"}"
        distro_id="${distro_id%\"}"

        if [[ -n "$distro_id" ]]; then
            # ID 通常为小写（debian、ubuntu 等）。
            # 显示在 Prompt 时仅将首字母大写。
            print -r -- "${(C)distro_id}"
            return
        fi
    fi

    print -r -- 'Linux'
}

prompt_os_icon() {
    local platform="$1"

    if [[ "$platform" == 'macos' ]]; then
        print -r -- "$STR_MAC_ICON"
    else
        # 按用户偏好：WSL 和 Linux 都使用 Ubuntu 图标。
        print -r -- "$STR_UBUNTU_ICON"
    fi
}

prompt_get_ip() {
    local platform="$1"
    local ip_addr=''

    if [[ "$platform" == 'macos' ]]; then
        # 保持原始 macOS 行为不变。
        ip_addr="$(ipconfig getifaddr en0 2>/dev/null)"
    else
        # 优先使用 Linux 路由表选择的源 IP 地址。
        if command -v ip >/dev/null 2>&1; then
            ip_addr="$(ip -4 route get 1.1.1.1 2>/dev/null | awk '{for (i=1; i<=NF; i++) if ($i == "src") {print $(i+1); exit}}')"

            # 如果 route get 没有返回 src，则使用备用方式获取 IP。
            if [[ -z "$ip_addr" ]]; then
                ip_addr="$(ip -o -4 addr show scope global 2>/dev/null | awk '{split($4,a,"/"); print a[1]; exit}')"
            fi
        fi

        # 如果系统没有 iproute2，则使用最后的备用方式。
        if [[ -z "$ip_addr" ]] && command -v hostname >/dev/null 2>&1; then
            ip_addr="$(hostname -I 2>/dev/null | awk '{print $1}')"
        fi
    fi

    print -r -- "${ip_addr:-N/A}"
}

# 转义 '%'，因为 zsh 会将其识别为 Prompt 转义字符。
prompt_escape() {
    print -r -- "${1//\%/%%}"
}

# ============================================================
# 左侧 Prompt
# ============================================================

prompt_build_left() {
    local platform os_name os_icon ip_addr

    platform="$(prompt_platform)"
    os_name="$(prompt_escape "$(prompt_os_name "$platform")")"
    os_icon="$(prompt_os_icon "$platform")"
    ip_addr="$(prompt_escape "$(prompt_get_ip "$platform")")"

    # 此布局刻意保持用户原始 macOS .zshrc 的样式。
    PROMPT=""
    PROMPT+="%F{${C_MAGENTA}}${STR_LINE1_PRE}%f"
    PROMPT+="%F{${C_DARK}}${STR_LEFT_SEMICIRCLE}%f"
    PROMPT+="%F{${C_CYAN}}%K{${C_DARK}}${STR_TIME_ICON} %* %k%f"
    PROMPT+="%F{${C_BLACK}}%K{${C_YELLOW}} ${os_icon} ${os_name} %k%f"
    PROMPT+="%F{${C_WHITE}}%K{${C_BLUE}} ${STR_USER_ICON} %n@%m %k%f"
    PROMPT+="%F{${C_BLACK}}%K{${C_CYAN}} ${STR_IP_ICON} ${ip_addr} %k%f"
    PROMPT+="%F{${C_YELLOW}}%K{${C_DARK}} ${STR_DIRECTORY_ICON} %~ %k%f"
    PROMPT+="%F{${C_DARK}}${STR_LEFT_ARROW}%f"
    PROMPT+=$'\n'
    PROMPT+="%F{${C_MAGENTA}}${STR_LINE2_PRE}%f"
    PROMPT+="%F{${C_BLUE}}%#%f "
}

# ============================================================
# 右侧 Prompt：Git 状态
# 行为和样式与现有 Nushell 配置保持一致。
# ============================================================

prompt_build_git_right() {
    RPROMPT=""

    local repo branch
    local is_windows_mount=0

    # WSL 挂载的 Windows 文件系统（/mnt/c、/mnt/d 等）在扫描 Git 工作区时较慢。
    # 在这些目录中完全避免执行 `git status`，只显示仓库名和分支名。
    [[ "$PWD" == /mnt/* ]] && is_windows_mount=1

    if (( is_windows_mount )); then
        git rev-parse --is-inside-work-tree &>/dev/null || return

        repo="$(git rev-parse --show-toplevel 2>/dev/null)" || return
        repo="${repo:t}"

        branch="$(git symbolic-ref --quiet --short HEAD 2>/dev/null)"
        if [[ -z "$branch" ]]; then
            branch="$(git rev-parse --short HEAD 2>/dev/null)" || return
        fi

        repo="$(prompt_escape "$repo")"
        branch="$(prompt_escape "$branch")"

        # 轻量模式：
        #   repo   branch 
        RPROMPT="%F{${C_GIT_PURPLE}}${STR_LEFT_SEMICIRCLE}%f"
        RPROMPT+="%F{${C_BLACK}}%K{${C_GIT_PURPLE}} ${STR_REPO_ICON} ${repo}  ${STR_BRANCH_ICON} ${branch} %k%f"
        RPROMPT+="%F{${C_GIT_PURPLE}}${STR_RIGHT_SEMICIRCLE}%f"
        return
    fi

    # Linux/macOS 原生文件系统保留与 Nushell 等价的完整 Git 状态：
    # staged / modified / untracked / ahead / behind。
    local git_output
    git_output="$(git status --porcelain=v2 --branch 2>/dev/null)" || return

    local line xy
    local staged=0
    local modified=0
    local untracked=0
    local ahead=0
    local behind=0
    local git_status_text=""

    repo="$(git rev-parse --show-toplevel 2>/dev/null)" || return
    repo="${repo:t}"

    branch="$(git branch --show-current 2>/dev/null)"
    if [[ -z "$branch" ]]; then
        branch="$(git rev-parse --short HEAD 2>/dev/null)" || return
    fi

    repo="$(prompt_escape "$repo")"
    branch="$(prompt_escape "$branch")"

    while IFS= read -r line; do
        case "$line" in
            \?\ *)
                (( untracked++ ))
                ;;

            1\ *|2\ *)
                xy="${${(s: :)line}[2]}"
                [[ "${xy[1]}" != "." ]] && (( staged++ ))
                [[ "${xy[2]}" != "." ]] && (( modified++ ))
                ;;

            '# branch.ab '*)
                if [[ "$line" =~ '^# branch\.ab \+([0-9]+) -([0-9]+)$' ]]; then
                    ahead="${match[1]}"
                    behind="${match[2]}"
                fi
                ;;
        esac
    done <<< "$git_output"

    (( staged > 0 ))    && git_status_text+="+${staged} "
    (( modified > 0 ))  && git_status_text+="~${modified} "
    (( untracked > 0 )) && git_status_text+="?${untracked} "
    (( ahead > 0 ))     && git_status_text+="↑ ${ahead} "
    (( behind > 0 ))    && git_status_text+="↓ ${behind} "

    git_status_text="${git_status_text% }"

    if [[ -z "$git_status_text" ]]; then
        RPROMPT="%F{${C_GIT_PURPLE}}${STR_LEFT_SEMICIRCLE}%f"
        RPROMPT+="%F{${C_BLACK}}%K{${C_GIT_PURPLE}} ${STR_REPO_ICON} ${repo}  ${STR_BRANCH_ICON} ${branch} %k%f"
        RPROMPT+="%F{${C_GIT_GREEN}}%K{${C_GIT_PURPLE}}"
        RPROMPT+="%F{${C_BLACK}}%K{${C_GIT_GREEN}} ✓ %k%f"
        RPROMPT+="%F{${C_GIT_GREEN}}${STR_RIGHT_SEMICIRCLE}%f"
    else
        RPROMPT="%F{${C_GIT_PURPLE}}${STR_LEFT_SEMICIRCLE}%f"
        RPROMPT+="%F{${C_BLACK}}%K{${C_GIT_PURPLE}} ${STR_REPO_ICON} ${repo}  ${STR_BRANCH_ICON} ${branch} %k%f"
        RPROMPT+="%F{${C_GIT_YELLOW}}%K{${C_GIT_PURPLE}}"
        RPROMPT+="%F{${C_BLACK}}%K{${C_GIT_YELLOW}} ${git_status_text} %k%f"
        RPROMPT+="%F{${C_GIT_YELLOW}}${STR_RIGHT_SEMICIRCLE}%f"
    fi
}

# 每次显示 Prompt 前重新构建左侧和右侧 Prompt。
autoload -Uz add-zsh-hook
prompt_precmd() {
    prompt_build_left
    prompt_build_git_right
}
add-zsh-hook precmd prompt_precmd

# 加载 .zshrc 时也立即构建一次，方便交互式执行 source 后马上生效。
prompt_build_left
prompt_build_git_right

# ============================================================
# 别名 / 辅助函数
# ============================================================

# BSD ls（macOS）和 GNU ls（Linux/WSL）使用不同的彩色输出参数。
if [[ "$(prompt_platform)" == 'macos' ]]; then
    alias ll='ls -lhG'
else
    alias ll='ls -lh --color=auto'
fi

alias lg='lazygit'
alias dk='docker'
alias dki='docker images'
alias dkc='docker ps -a'
alias dkr='docker run -it --entrypoint /bin/bash'
alias dka='docker attach'
alias dc='docker compose'

# dkl CONTAINER [LINES]
# 持续查看带时间戳的日志，默认显示最后 100 行。
dkl() {
    if (( $# < 1 )); then
        print -u2 -- 'usage: dkl CONTAINER [LINES]'
        return 2
    fi
    docker logs -ft --tail "${2:-100}" "$1"
}

# dke CONTAINER [COMMAND ...]
# 保留原来的 /bin/bash 默认行为，同时避免在 alias 中定义函数。
dke() {
    if (( $# < 1 )); then
        print -u2 -- 'usage: dke CONTAINER [COMMAND ...]'
        return 2
    fi

    local container="$1"
    shift

    if (( $# > 0 )); then
        docker exec -it "$container" "$@"
    else
        docker exec -it "$container" /bin/bash
    fi
}


# ============================================================
# Zsh 补全
# ============================================================
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select

zstyle ':completion:*' matcher-list \
    'm:{a-zA-Z}={A-Za-z}' \
    'r:|[._-]=* r:|=*'

zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'

zstyle ':completion:*:*:*:*:processes' command \
    'ps -u $USER -o pid,user,command -w -w'

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path \
    "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"

# ============================================================
# 其他
# ============================================================
# zoxide 必须在 compinit 后
export PATH="$HOME/.local/bin:$PATH"
eval "$(zoxide init zsh)"

