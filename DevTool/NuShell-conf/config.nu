# 设定提示符
# =============================
# 常量
# =============================
let STR_LINE1_PRE = "╭"
let STR_LINE2_PRE = "╰"
let STR_LEFT_SEMICIRCLE = ""
let STR_RIGHT_SEMICIRCLE = ""
let STR_LEFT_ARROW = ""
let STR_WIN_ICON = ""
let STR_TERMINAL_ICON = ""
let STR_TIME_ICON = ""
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

        $"(ansi {fg: 'dark_gray'})($STR_LEFT_SEMICIRCLE)"
        $"($C_TIME) ($STR_TIME_ICON) ($time) "

        $"(ansi {fg: 'yellow' bg: 'dark_gray'})"
        $"($C_SHELL) ($STR_WIN_ICON) NuShell "

        $"(ansi {fg: 'blue' bg: 'yellow'})"
        $"($C_USER) ($STR_USER_ICON) ($user)@($host) "

        $"(ansi {fg: 'light_cyan' bg: 'blue'})"
        $"($C_IP) ($STR_IP_ICON) ($MY_IP) "

        $"(ansi {fg: 'dark_gray' bg: 'light_cyan'})"
        $"($C_PATH) ($STR_DIRECTORY_ICON)  ($path) "

        $"($RESET)"
        $"(ansi {fg: 'dark_gray'})($STR_LEFT_ARROW)"
        $"($RESET)"
    ] | str join ""

    let line2 = $"(ansi magenta)($STR_LINE2_PRE)"

    $"($line1)\n($line2)"
}

$env.PROMPT_INDICATOR = {||
    $"(ansi blue)# (ansi reset)"
}

# 设定环境变量
# C
$env.path ++= ["D:\\Tools\\WorkTool\\C\\MinGW64\\bin"]
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
$env.GOROOT = "D:\\Tools\\WorkTool\\Go\\go1.22.5.windows-amd64"
$env.GOPATH = "D:\\Tools\\WorkTool\\Go\\go_global"
$env.PATH ++= [
    ($env.GOROOT | path join "bin")
    ($env.GOPATH | path join "bin")
]
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
$env.path ++= ["C:\\Liang\\Tools\\WorkTool\\Web\\node"]
$env.path ++= ["C:\\Liang\\Tools\\WorkTool\\Web\\node\\node_global"]

# 设定别名
alias ll = ls
alias lla = ls -l -a
def env [keyword?: string] {
    let data = $env | transpose key value
    if $keyword == null {
        $data
    } else {
        $data | where key =~ $keyword
    }
}
