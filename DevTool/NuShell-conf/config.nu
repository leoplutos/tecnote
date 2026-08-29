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
# 颜色
# =============================
let C_TIME = (ansi { fg: "cyan" bg: "dark_gray" })
let C_SHELL = (ansi { fg: "black" bg: "yellow" })
let C_USER = (ansi { fg: "white" bg: "blue" })
let C_IP = (ansi { fg: "black" bg: "light_cyan" })
let C_PATH = (ansi { fg: "yellow" bg: "dark_gray" })
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
    let time = (date now | format date "%H:%M:%S")
    let user = $env.USERNAME
    let host = (hostname)
    let path = (pwd)

    let line1 = [
        $"(ansi magenta)($STR_LINE1_PRE)"

        $"(ansi {fg: 'dark_gray'})"
        $"($C_TIME) ($STR_TIME_ICON) ($time) "

        $"(ansi {fg: 'yellow' bg: 'dark_gray'})"
        $"($C_SHELL) ($STR_WIN_ICON) NuShell "

        $"(ansi {fg: 'blue' bg: 'yellow'})"
        $"($C_USER) ($STR_USER_ICON) ($user)@($host) "

        $"(ansi {fg: 'light_cyan' bg: 'blue'})"
        $"($C_IP) ($STR_IP_ICON) ($MY_IP) "

        $"(ansi {fg: 'dark_gray' bg: 'light_cyan'})"
        $"($C_PATH) ($STR_DIRECTORY_ICON) ($path) "

        $"($RESET)"
        $"(ansi {fg: 'dark_gray'})"
        $"($RESET)"
    ] | str join ""

    let line2 = $"(ansi magenta)($STR_LINE2_PRE)(ansi blue)(ansi reset)"

    $"($line1)\n($line2) "
}
$env.PROMPT_INDICATOR = {|| "# " }
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
    let purple = (ansi { fg: "black" bg: "#c678dd" })
    let yellow = (ansi { fg: "black" bg: "#e5c07b" })
    let green = (ansi { fg: "black" bg: "#98c379" })
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
            $"(ansi {fg:'#c678dd'})" +
            $"($purple)  ($repo)   ($branch) " +
            $"(ansi {fg:'#98c379' bg:'#c678dd'})" +
            $"($green) ✓ " +
            $"($reset)(ansi {fg:'#98c379'})($reset)"
        )
    }

    #
    # Dirty
    #
    (
        $"(ansi {fg:'#c678dd'})" +
        $"($purple)  ($repo)   ($branch) " +
        $"(ansi {fg:'#e5c07b' bg:'#c678dd'})" +
        $"($yellow) ($status) " +
        $"($reset)(ansi {fg:'#e5c07b'})($reset)"
    )
}

$env.PROMPT_COMMAND_RIGHT = {||
    git-prompt-right
}
$env.config.render_right_prompt_on_last_line = true
# 关闭 Nushell 的 OSC 133 Shell Integration。
$env.config.shell_integration.osc133 = false
# yazi设定
$env.YAZI_FILE_ONE = 'C:\Program Files\Git\usr\bin\file.exe'

# 设定环境变量
# C
$env.path ++= ["C:\\qiao\\00_Tools\\C\\mingw64\\bin"]
# Rust
$env.CARGO_HOME = "D:\\Tools\\WorkTool\\Rust\\Rust_gnu_1.79"
$env.RUSTUP_HOME = "D:\\Tools\\WorkTool\\Rust\\Rust_gnu_1.79"
$env.RUST_SRC_PATH = "D:\\Tools\\WorkTool\\Rust\\Rust_gnu_1.79\\toolchains\\stable-x86_64-pc-windows-gnu\\lib\\rustlib\\src\\rust\\src"
$env.RUSTUP_DIST_SERVER = "https://rsproxy.cn"
$env.RUSTUP_UPDATE_ROOT = "https://rsproxy.cn/rustup"
$env.BINARYEN_HOME = "D:\\Tools\\WorkTool\\Rust\\binaryen"
$env.PATH ++= [
    ($env.CARGO_HOME | path join "bin")
    ($env.BINARYEN_HOME | path join "bin")
]
# Go
$env.GO111MODULE = "on"
$env.GOROOT = "C:\\qiao\\00_Tools\\Go\\go"
$env.GOPATH = "C:\\qiao\\00_Tools\\Go\\go_global"
$env.PATH ++= [
    ($env.GOROOT | path join "bin")
    ($env.GOPATH | path join "bin")
]
# Java
$env.JAVA_HOME = "C:\\qiao\\00_Tools\\Java\\jdk21.0.8_9_amazon-corretto"
$env.PATH ++= [
    ($env.JAVA_HOME | path join "bin")
]
# Python
$env.PYTHON_HOME = "C:\\qiao\\00_Tools\\Python\\Python313"
$env.PATH ++= [
    $env.PYTHON_HOME
    ($env.PYTHON_HOME | path join "Scripts")
]
# NodeJs
$env.path ++= ["C:\\qiao\\00_Tools\\Web\\node"]
$env.path ++= ["C:\\qiao\\00_Tools\\Web\\node\\node_global"]

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

# 其他
# zoxide
source ~/.zoxide.nu
