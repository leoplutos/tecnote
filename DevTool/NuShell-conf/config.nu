# 设定提示符
# =============================
# 常量
# =============================
let STR_LINE1_PRE = "╭"
let STR_LINE2_PRE = "╰"
let STR_TIME_ICON = ""
let STR_WIN_ICON = ""
let STR_USER_ICON = ""
let STR_IP_ICON = ""
let STR_DIRECTORY_ICON = ""

# =============================
# Prompt 主题开关
# =============================
# 可在当前 Nushell 会话中执行：
#   $env.PROMPT_THEME = "light"
#   $env.PROMPT_THEME = "dark"
#
# 如果没有设定 PROMPT_THEME，则默认使用 dark。
# 如希望启动时固定为亮色，可取消下一行注释：
# $env.PROMPT_THEME = "light"

if (($env.PROMPT_THEME? | default "") | is-empty) {
    $env.PROMPT_THEME = "dark"
}

# =============================
# Prompt 配色
# =============================
# 注意：这里只切换颜色，不改变原 Prompt 的分隔符/连接方式。
def get-prompt-theme [] {
    let theme = ($env.PROMPT_THEME? | default "dark" | str downcase)

    if $theme == "light" {
        {
            line: "#7A4FA3"

            time_fg: "#176B87"
            time_bg: "#DCE6EB"

            shell_fg: "#3D3A28"
            shell_bg: "#F3DF8D"

            user_fg: "#51459A"
            user_bg: "#D8D5F2"

            ip_fg: "#176B68"
            ip_bg: "#BFE8E3"

            path_fg: "#34495E"
            path_bg: "#D8E2EA"

            git_repo_fg: "#563D66"
            git_repo_bg: "#E4D4ED"
            git_dirty_fg: "#6A5420"
            git_dirty_bg: "#F1DDA8"
            git_clean_fg: "#365B31"
            git_clean_bg: "#CFE4C8"
        }
    } else {
        {
            line: "magenta"

            time_fg: "cyan"
            time_bg: "dark_gray"

            shell_fg: "black"
            shell_bg: "yellow"

            user_fg: "white"
            user_bg: "blue"

            ip_fg: "black"
            ip_bg: "light_cyan"

            path_fg: "yellow"
            path_bg: "dark_gray"

            git_repo_fg: "black"
            git_repo_bg: "#c678dd"
            git_dirty_fg: "black"
            git_dirty_bg: "#e5c07b"
            git_clean_fg: "black"
            git_clean_bg: "#98c379"
        }
    }
}

let RESET = (ansi reset)

# =============================
# IP
# =============================
def get-ip [] {
    (powershell -Command "(Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -like '*Wi-Fi*' -and $_.AddressState -eq 'Preferred'} | Select-Object -First 1 -ExpandProperty IPAddress)" | str trim)
}

let MY_IP = (get-ip)

# =============================
# 提示符
# =============================
$env.PROMPT_COMMAND = {||
    let theme = (get-prompt-theme)

    let time = (date now | format date "%H:%M:%S")
    let user = $env.USERNAME
    let host = (hostname)
    let path = (pwd)

    let C_TIME = (ansi { fg: $theme.time_fg bg: $theme.time_bg })
    let C_SHELL = (ansi { fg: $theme.shell_fg bg: $theme.shell_bg })
    let C_USER = (ansi { fg: $theme.user_fg bg: $theme.user_bg })
    let C_IP = (ansi { fg: $theme.ip_fg bg: $theme.ip_bg })
    let C_PATH = (ansi { fg: $theme.path_fg bg: $theme.path_bg })

    let line1 = [
        $"(ansi {fg: $theme.line})($STR_LINE1_PRE)"

        $"(ansi {fg: $theme.time_bg})"
        $"($C_TIME) ($STR_TIME_ICON) ($time) "

        # 与原版完全一致：这里只切换 ANSI 前景/背景，不插入分隔符字符
        $"(ansi {fg: $theme.shell_bg bg: $theme.time_bg})"
        $"($C_SHELL) ($STR_WIN_ICON) NuShell "

        $"(ansi {fg: $theme.user_bg bg: $theme.shell_bg})"
        $"($C_USER) ($STR_USER_ICON) ($user)@($host) "

        $"(ansi {fg: $theme.ip_bg bg: $theme.user_bg})"
        $"($C_IP) ($STR_IP_ICON) ($MY_IP) "

        $"(ansi {fg: $theme.path_bg bg: $theme.ip_bg})"
        $"($C_PATH) ($STR_DIRECTORY_ICON) ($path) "

        $"($RESET)"
        $"(ansi {fg: $theme.path_bg})"
        $"($RESET)"
    ] | str join ""

    let line2 = $"(ansi {fg: $theme.line})($STR_LINE2_PRE)(ansi blue)(ansi reset)"

    $"($line1)\n($line2) "
}
$env.PROMPT_INDICATOR = {||
    let theme = ($env.PROMPT_THEME? | default "dark" | str downcase)

    if $theme == "light" {
        $"(ansi blue)# (ansi reset)"
    } else {
        # Dark 模式保持原来的颜色不变
        "# "
    }
}
def git-prompt-right [] {
    let result = (
        do -i {
            git status --porcelain=v2 --branch
        }
        | complete
    )

    if $result.exit_code != 0 {
        return ""
    }

    let lines = ($result.stdout | lines)

    #
    # Repository Name
    #
    let repo = (
        do -i {
            git rev-parse --show-toplevel
        }
        | complete
        | get stdout
        | str trim
        | path basename
    )

    #
    # Branch
    #
    let branch = (
        do -i {
            git branch --show-current
        }
        | complete
        | get stdout
        | str trim
    )

    let branch = if ($branch | is-empty) {
        (
            do -i {
                git rev-parse --short HEAD
            }
            | complete
            | get stdout
            | str trim
        )
    } else {
        $branch
    }

    #
    # staged / modified / untracked
    #
    mut staged = 0
    mut modified = 0
    mut untracked = 0

    for line in $lines {
        if ($line | str starts-with "? ") {
            $untracked += 1
            continue
        }

        if (
            ($line | str starts-with "1 ")
            or ($line | str starts-with "2 ")
        ) {
            let xy = ($line | split row " " | get 1)

            if (($xy | str substring 0..1) != ".") {
                $staged += 1
            }

            if (($xy | str substring 1..2) != ".") {
                $modified += 1
            }
        }
    }

    #
    # ahead / behind
    #
    mut ahead = 0
    mut behind = 0

    let ab = (
        $lines
        | where {|x| $x | str starts-with "# branch.ab "}
    )

    if ($ab | length) > 0 {
        let parsed = (
            $ab
            | first
            | parse "# branch.ab +{ahead} -{behind}"
            | first
        )

        $ahead = ($parsed.ahead | into int)
        $behind = ($parsed.behind | into int)
    }

    #
    # Colors
    #
    let theme = (get-prompt-theme)
    let purple = (ansi { fg: $theme.git_repo_fg bg: $theme.git_repo_bg })
    let yellow = (ansi { fg: $theme.git_dirty_fg bg: $theme.git_dirty_bg })
    let green = (ansi { fg: $theme.git_clean_fg bg: $theme.git_clean_bg })
    let reset = (ansi reset)

    #
    # Build status text
    #
    mut items = []

    if $staged > 0 {
        $items = ($items | append $"+($staged)")
    }

    if $modified > 0 {
        $items = ($items | append $"~($modified)")
    }

    if $untracked > 0 {
        $items = ($items | append $"?($untracked)")
    }

    if $ahead > 0 {
        $items = ($items | append $"↑ ($ahead)")
    }

    if $behind > 0 {
        $items = ($items | append $"↓ ($behind)")
    }

    let status = ($items | str join " ")

    #
    # Clean
    #
    if ($items | length) == 0 {
        return (
            $"(ansi {fg: $theme.git_repo_bg})" +
            $"($purple)  ($repo)   ($branch) " +
            $"(ansi {fg: $theme.git_clean_bg bg: $theme.git_repo_bg})" +
            $"($green) ✓ " +
            $"($reset)(ansi {fg: $theme.git_clean_bg})($reset)"
        )
    }

    #
    # Dirty
    #
    (
        $"(ansi {fg: $theme.git_repo_bg})" +
        $"($purple)  ($repo)   ($branch) " +
        $"(ansi {fg: $theme.git_dirty_bg bg: $theme.git_repo_bg})" +
        $"($yellow) ($status) " +
        $"($reset)(ansi {fg: $theme.git_dirty_bg})($reset)"
    )
}

$env.PROMPT_COMMAND_RIGHT = {||
    git-prompt-right
}
$env.config.render_right_prompt_on_last_line = true
# 关闭 Nushell 的 OSC 133 Shell Integration。
$env.config.shell_integration.osc133 = false
# yazi设定
# $env.YAZI_FILE_ONE = 'C:\Program Files\Git\usr\bin\file.exe'

# 设定环境变量
# C
# $env.path ++= ["C:\\qiao\\00_Tools\\C\\mingw64\\bin"]
# Rust
# $env.CARGO_HOME = "D:\\Tools\\WorkTool\\Rust\\Rust_gnu_1.79"
# $env.RUSTUP_HOME = "D:\\Tools\\WorkTool\\Rust\\Rust_gnu_1.79"
# $env.RUST_SRC_PATH = "D:\\Tools\\WorkTool\\Rust\\Rust_gnu_1.79\\toolchains\\stable-x86_64-pc-windows-gnu\\lib\\rustlib\\src\\rust\\src"
# $env.RUSTUP_DIST_SERVER = "https://rsproxy.cn"
# $env.RUSTUP_UPDATE_ROOT = "https://rsproxy.cn/rustup"
# $env.BINARYEN_HOME = "D:\\Tools\\WorkTool\\Rust\\binaryen"
# $env.PATH ++= [
    # ($env.CARGO_HOME | path join "bin")
    # ($env.BINARYEN_HOME | path join "bin")
# ]
# Go
# $env.GO111MODULE = "on"
# $env.GOROOT = "C:\\qiao\\00_Tools\\Go\\go"
# $env.GOPATH = "C:\\qiao\\00_Tools\\Go\\go_global"
# $env.PATH ++= [
#     ($env.GOROOT | path join "bin")
#     ($env.GOPATH | path join "bin")
# ]
# Java
$env.JAVA_HOME = "C:\\Liang\\Tools\\WorkTool\\Java\\jdk21.0.8_9_amazon-corretto"
$env.PATH ++= [
    ($env.JAVA_HOME | path join "bin")
]
# Python
$env.PYTHON_HOME = "C:\\Liang\\Tools\\WorkTool\\Python\\Python313"
$env.PATH ++= [
    $env.PYTHON_HOME
    ($env.PYTHON_HOME | path join "Scripts")
]
# NodeJs
# $env.path ++= ["C:\\qiao\\00_Tools\\Web\\node"]
# $env.path ++= ["C:\\qiao\\00_Tools\\Web\\node\\node_global"]

# 设定别名
#alias ll = ls -l
alias ll = cmd /d /c dir
#alias ll = powershell -c ls
alias lla = ls -a
#查看环境变量
def env [keyword?: string] {
    let data = $env | transpose key value
    if $keyword == null {
        $data
    } else {
        $data | where key =~ $keyword
    }
}
#查看日志
def tail [
    file: path               # 日志文件路径
    --lines (-n): int = 200  # 显示最后多少行
    --encoding (-e): string = "UTF8"
] {
    let file_path = $file | path expand
    let escaped_path = $file_path | str replace --all "'" "''"

    ^powershell.exe -NoProfile -Command $"
        Get-Content `
            -LiteralPath '($escaped_path)' `
            -Encoding ($encoding) `
            -Tail ($lines) `
            -Wait
    "
}
# Docker-compatible command using Windows Subsystem for Linux Containers (wslc)
# Examples:
#   docker --version
#   docker ps
#   docker stop web
#   docker run -d --rm -p 8080:80 --name web nginx
#   docker run -d --rm -p 0.0.0.0:8080:80 --name web nginx
def --wrapped docker [...args] {
    ^wslc ...$args
}

# 其他
# zoxide
source ~/.zoxide.nu
