# PowerShell 7 Profile
# Converted from the latest confirmed Nushell config.nu.
# Prompt layout, theme colors, Git status, environment variables and helper commands
# are kept as close as possible to the Nushell version.

# =============================
# Prompt constants
# =============================
$script:STR_LINE1_PRE      = '╭'
$script:STR_LINE2_PRE      = '╰'
$script:STR_TIME_ICON      = ''
$script:STR_WIN_ICON       = ''
$script:STR_USER_ICON      = ''
$script:STR_IP_ICON        = ''
$script:STR_DIRECTORY_ICON = ''
$script:ESC                = [char]27
$script:RESET              = "$($script:ESC)[0m"

# =============================
# Prompt theme switch
# =============================
# Change theme in the current PowerShell session with:
#   $env:PROMPT_THEME = 'light'
#   $env:PROMPT_THEME = 'dark'
#
# If PROMPT_THEME is not set, dark is used by default.
# To always start in light mode, uncomment the following line:
# $env:PROMPT_THEME = 'light'

if ([string]::IsNullOrWhiteSpace($env:PROMPT_THEME)) {
    $env:PROMPT_THEME = 'dark'
}

# =============================
# ANSI helpers
# =============================
function ConvertTo-AnsiColorCode {
    param(
        [Parameter(Mandatory)]
        [string]$Color,

        [Parameter(Mandatory)]
        [ValidateSet('Foreground', 'Background')]
        [string]$Layer
    )

    if ($Color -match '^#([0-9A-Fa-f]{6})$') {
        $hex = $Matches[1]
        $r = [Convert]::ToInt32($hex.Substring(0, 2), 16)
        $g = [Convert]::ToInt32($hex.Substring(2, 2), 16)
        $b = [Convert]::ToInt32($hex.Substring(4, 2), 16)
        $prefix = if ($Layer -eq 'Foreground') { '38;2' } else { '48;2' }
        return "$prefix;$r;$g;$b"
    }

    $fg = @{
        black      = 30
        red        = 31
        green      = 32
        yellow     = 33
        blue       = 34
        magenta    = 35
        cyan       = 36
        white      = 37
        dark_gray  = 90
        light_cyan = 96
    }

    if (-not $fg.ContainsKey($Color)) {
        throw "Unsupported ANSI color: $Color"
    }

    $code = [int]$fg[$Color]
    if ($Layer -eq 'Background') {
        # 30-37 -> 40-47, 90-97 -> 100-107
        $code += 10
    }

    return [string]$code
}

function Get-AnsiColor {
    param(
        [string]$Foreground,
        [string]$Background
    )

    $codes = [System.Collections.Generic.List[string]]::new()

    if ($Foreground) {
        $codes.Add((ConvertTo-AnsiColorCode -Color $Foreground -Layer Foreground))
    }

    if ($Background) {
        $codes.Add((ConvertTo-AnsiColorCode -Color $Background -Layer Background))
    }

    if ($codes.Count -eq 0) {
        return ''
    }

    return "$($script:ESC)[$($codes -join ';')m"
}

function Get-VisibleLength {
    param([string]$Text)

    if ([string]::IsNullOrEmpty($Text)) {
        return 0
    }

    # Strip ANSI CSI sequences before measuring the terminal width.
    $plain = [regex]::Replace($Text, "`e\[[0-9;?]*[ -/]*[@-~]", '')
    return $plain.Length
}

# =============================
# Prompt colors
# =============================
# Only colors change between themes. Prompt separators/layout stay unchanged.
function Get-PromptTheme {
    $theme = if ($env:PROMPT_THEME) { $env:PROMPT_THEME.ToLowerInvariant() } else { 'dark' }

    if ($theme -eq 'light') {
        return [pscustomobject]@{
            line          = '#7A4FA3'

            time_fg       = '#176B87'
            time_bg       = '#DCE6EB'

            shell_fg      = '#3D3A28'
            shell_bg      = '#F3DF8D'

            user_fg       = '#51459A'
            user_bg       = '#D8D5F2'

            ip_fg         = '#176B68'
            ip_bg         = '#BFE8E3'

            path_fg       = '#34495E'
            path_bg       = '#D8E2EA'

            git_repo_fg   = '#563D66'
            git_repo_bg   = '#E4D4ED'
            git_dirty_fg  = '#6A5420'
            git_dirty_bg  = '#F1DDA8'
            git_clean_fg  = '#365B31'
            git_clean_bg  = '#CFE4C8'
        }
    }

    return [pscustomobject]@{
        line          = 'magenta'

        time_fg       = 'cyan'
        time_bg       = 'dark_gray'

        shell_fg      = 'black'
        shell_bg      = 'yellow'

        user_fg       = 'white'
        user_bg       = 'blue'

        ip_fg         = 'black'
        ip_bg         = 'light_cyan'

        path_fg       = 'yellow'
        path_bg       = 'dark_gray'

        git_repo_fg   = 'black'
        git_repo_bg   = '#c678dd'
        git_dirty_fg  = 'black'
        git_dirty_bg  = '#e5c07b'
        git_clean_fg  = 'black'
        git_clean_bg  = '#98c379'
    }
}

# =============================
# IP address
# =============================
function Get-PromptIpAddress {
    try {
        # Avoid Get-NetIPAddress here. Its first call auto-loads the NetTCPIP
        # module and can add 1-2 seconds to PowerShell startup.
        # Use .NET directly instead, which is much lighter for prompt startup.
        foreach ($adapter in [System.Net.NetworkInformation.NetworkInterface]::GetAllNetworkInterfaces()) {
            if ($adapter.NetworkInterfaceType -ne [System.Net.NetworkInformation.NetworkInterfaceType]::Wireless80211) {
                continue
            }

            if ($adapter.OperationalStatus -ne [System.Net.NetworkInformation.OperationalStatus]::Up) {
                continue
            }

            foreach ($address in $adapter.GetIPProperties().UnicastAddresses) {
                if ($address.Address.AddressFamily -eq [System.Net.Sockets.AddressFamily]::InterNetwork) {
                    return $address.Address.IPAddressToString
                }
            }
        }

        return ''
    }
    catch {
        return ''
    }
}

# Same behavior as the Nushell version: resolve once when the profile is loaded.
$script:MY_IP = Get-PromptIpAddress

# =============================
# Git right prompt
# =============================
function Get-GitPromptRight {
    $oldErrorActionPreference = $ErrorActionPreference
    $ErrorActionPreference = 'SilentlyContinue'

    try {
        $statusLines = @(& git status --porcelain=v2 --branch 2>$null)
        if ($LASTEXITCODE -ne 0) {
            return ''
        }

        $topLevel = (& git rev-parse --show-toplevel 2>$null | Select-Object -First 1)
        if ($LASTEXITCODE -ne 0 -or [string]::IsNullOrWhiteSpace($topLevel)) {
            return ''
        }
        $topLevel = $topLevel.Trim()
        $repo = Split-Path -Leaf $topLevel

        [string]$branch = (& git branch --show-current 2>$null | Select-Object -First 1)
        $branch = $branch.Trim()
        if ([string]::IsNullOrWhiteSpace($branch)) {
            [string]$branch = (& git rev-parse --short HEAD 2>$null | Select-Object -First 1)
            $branch = $branch.Trim()
        }

        $staged = 0
        $modified = 0
        $untracked = 0
        $ahead = 0
        $behind = 0

        foreach ($line in $statusLines) {
            if ($line.StartsWith('? ')) {
                $untracked++
                continue
            }

            if ($line.StartsWith('1 ') -or $line.StartsWith('2 ')) {
                $parts = $line -split ' '
                if ($parts.Count -gt 1) {
                    $xy = $parts[1]
                    if ($xy.Length -ge 2) {
                        if ($xy[0] -ne '.') { $staged++ }
                        if ($xy[1] -ne '.') { $modified++ }
                    }
                }
            }

            if ($line -match '^# branch\.ab \+(\d+) -(\d+)$') {
                $ahead = [int]$Matches[1]
                $behind = [int]$Matches[2]
            }
        }

        $items = [System.Collections.Generic.List[string]]::new()
        if ($staged    -gt 0) { $items.Add("+$staged") }
        if ($modified  -gt 0) { $items.Add("~$modified") }
        if ($untracked -gt 0) { $items.Add("?$untracked") }
        if ($ahead     -gt 0) { $items.Add("↑ $ahead") }
        if ($behind    -gt 0) { $items.Add("↓ $behind") }

        $theme = Get-PromptTheme
        $purple = Get-AnsiColor -Foreground $theme.git_repo_fg  -Background $theme.git_repo_bg
        $yellow = Get-AnsiColor -Foreground $theme.git_dirty_fg -Background $theme.git_dirty_bg
        $green  = Get-AnsiColor -Foreground $theme.git_clean_fg -Background $theme.git_clean_bg

        $leftCap = "$(Get-AnsiColor -Foreground $theme.git_repo_bg)"
        $repoPart = "$purple  $repo   $branch "

        if ($items.Count -eq 0) {
            $transition = Get-AnsiColor -Foreground $theme.git_clean_bg -Background $theme.git_repo_bg
            $rightCap = "$(Get-AnsiColor -Foreground $theme.git_clean_bg)$($script:RESET)"
            return "$leftCap$repoPart$transition$green ✓ $($script:RESET)$rightCap"
        }

        $statusText = $items -join ' '
        $transition = Get-AnsiColor -Foreground $theme.git_dirty_bg -Background $theme.git_repo_bg
        $rightCap = "$(Get-AnsiColor -Foreground $theme.git_dirty_bg)$($script:RESET)"
        return "$leftCap$repoPart$transition$yellow $statusText $($script:RESET)$rightCap"
    }
    finally {
        $ErrorActionPreference = $oldErrorActionPreference
    }
}

# =============================
# PowerShell prompt
# =============================
function global:prompt {
    $theme = Get-PromptTheme

    $time = Get-Date -Format 'HH:mm:ss'
    $user = $env:USERNAME
    $hostName = [System.Net.Dns]::GetHostName()
    $path = (Get-Location).Path

    $C_TIME  = Get-AnsiColor -Foreground $theme.time_fg  -Background $theme.time_bg
    $C_SHELL = Get-AnsiColor -Foreground $theme.shell_fg -Background $theme.shell_bg
    $C_USER  = Get-AnsiColor -Foreground $theme.user_fg  -Background $theme.user_bg
    $C_IP    = Get-AnsiColor -Foreground $theme.ip_fg    -Background $theme.ip_bg
    $C_PATH  = Get-AnsiColor -Foreground $theme.path_fg  -Background $theme.path_bg

    # Keep the original Nushell connection style: no extra separator character
    # is inserted between the colored blocks.
    $line1 = @(
        "$(Get-AnsiColor -Foreground $theme.line)$($script:STR_LINE1_PRE)"
        "$(Get-AnsiColor -Foreground $theme.time_bg)"
        "$C_TIME $($script:STR_TIME_ICON) $time "

        "$(Get-AnsiColor -Foreground $theme.shell_bg -Background $theme.time_bg)"
        "$C_SHELL $($script:STR_WIN_ICON) PowerShell 7 "

        "$(Get-AnsiColor -Foreground $theme.user_bg -Background $theme.shell_bg)"
        "$C_USER $($script:STR_USER_ICON) $user@$hostName "

        "$(Get-AnsiColor -Foreground $theme.ip_bg -Background $theme.user_bg)"
        "$C_IP $($script:STR_IP_ICON) $($script:MY_IP) "

        "$(Get-AnsiColor -Foreground $theme.path_bg -Background $theme.ip_bg)"
        "$C_PATH $($script:STR_DIRECTORY_ICON) $path "

        $script:RESET
        "$(Get-AnsiColor -Foreground $theme.path_bg)"
        $script:RESET
    ) -join ''

    $line2 = "$(Get-AnsiColor -Foreground $theme.line)$($script:STR_LINE2_PRE)$($script:RESET)"

    # Match the final Nushell behavior:
    # light theme -> blue '#'; dark theme -> keep the original/default '#' color.
    $indicator = if (($env:PROMPT_THEME ?? 'dark').ToLowerInvariant() -eq 'light') {
        "$(Get-AnsiColor -Foreground 'blue')# $($script:RESET)"
    }
    else {
        '# '
    }

    $leftPrompt = "$line2$indicator"
    $rightPrompt = Get-GitPromptRight

    if ([string]::IsNullOrEmpty($rightPrompt)) {
        return "$line1`n$leftPrompt"
    }

    # PowerShell has no native right-prompt API like Nushell's PROMPT_COMMAND_RIGHT.
    # Draw the Git prompt at the right edge, then restore the cursor to the input point.
    try {
        $bufferWidth = $Host.UI.RawUI.BufferSize.Width
    }
    catch {
        $bufferWidth = 0
    }

    $leftWidth = Get-VisibleLength $leftPrompt
    $rightWidth = Get-VisibleLength $rightPrompt

    if ($bufferWidth -le 0 -or ($leftWidth + $rightWidth + 1) -ge $bufferWidth) {
        return "$line1`n$leftPrompt"
    }

    $rightColumn = $bufferWidth - $rightWidth + 1
    $saveCursor = "$($script:ESC)[s"
    $restoreCursor = "$($script:ESC)[u"
    $moveToRight = "$($script:ESC)[$($rightColumn)G"

    return "$line1`n$leftPrompt$saveCursor$moveToRight$rightPrompt$restoreCursor"
}

# =============================
# Environment variables
# =============================
function Add-ToPath {
    param([Parameter(Mandatory)][string]$Path)

    if ([string]::IsNullOrWhiteSpace($Path)) {
        return
    }

    $entries = $env:PATH -split ';'
    if ($entries -notcontains $Path) {
        $env:PATH = "$env:PATH;$Path"
    }
}

# C
# Add-ToPath 'C:\qiao\00_Tools\C\mingw64\bin'

# Rust
# $env:CARGO_HOME = 'D:\Tools\WorkTool\Rust\Rust_gnu_1.79'
# $env:RUSTUP_HOME = 'D:\Tools\WorkTool\Rust\Rust_gnu_1.79'
# $env:RUST_SRC_PATH = 'D:\Tools\WorkTool\Rust\Rust_gnu_1.79\toolchains\stable-x86_64-pc-windows-gnu\lib\rustlib\src\rust\src'
# $env:RUSTUP_DIST_SERVER = 'https://rsproxy.cn'
# $env:RUSTUP_UPDATE_ROOT = 'https://rsproxy.cn/rustup'
# $env:BINARYEN_HOME = 'D:\Tools\WorkTool\Rust\binaryen'
# Add-ToPath (Join-Path $env:CARGO_HOME 'bin')
# Add-ToPath (Join-Path $env:BINARYEN_HOME 'bin')

# Go
# $env:GO111MODULE = 'on'
# $env:GOROOT = 'C:\qiao\00_Tools\Go\go'
# $env:GOPATH = 'C:\qiao\00_Tools\Go\go_global'
# Add-ToPath (Join-Path $env:GOROOT 'bin')
# Add-ToPath (Join-Path $env:GOPATH 'bin')

# Java
$env:JAVA_HOME = 'C:\qiao\00_Tools\Java\jdk21.0.8_9_amazon-corretto'
Add-ToPath (Join-Path $env:JAVA_HOME 'bin')

# Python
$env:PYTHON_HOME = 'C:\qiao\00_Tools\Python\Python313'
Add-ToPath $env:PYTHON_HOME
Add-ToPath (Join-Path $env:PYTHON_HOME 'Scripts')

# Node.js
# Add-ToPath 'C:\qiao\00_Tools\Web\node'
# Add-ToPath 'C:\qiao\00_Tools\Web\node\node_global'

# =============================
# Aliases / helper commands
# =============================
function global:ll {
    & cmd.exe /d /c dir @args
}

function global:lla {
    Get-ChildItem -Force @args
}

# Search environment variables. With no keyword, show all variables.
function global:env {
    param([string]$Keyword)

    $data = Get-ChildItem Env: | Sort-Object Name
    if ([string]::IsNullOrEmpty($Keyword)) {
        return $data
    }

    return $data | Where-Object { $_.Name -match $Keyword }
}

# Follow a log file, equivalent to the Nushell tail helper.
function global:tail {
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]$File,

        [Alias('n')]
        [int]$Lines = 200,

        [Alias('e')]
        [string]$Encoding = 'UTF8'
    )

    Get-Content -LiteralPath $File -Encoding $Encoding -Tail $Lines -Wait
}

# docker
# Use "docker" as an alias/wrapper for the wslc command.
# All Docker-style arguments are passed directly to wslc.
#
# Examples:
#   docker --version
#   docker ps
#   docker stop web
#   docker run -d --rm -p 8080:80 --name web nginx
#   docker run -d --rm -p 0.0.0.0:8080:80 --name web nginx
function global:docker {
    & wslc @args
}

# =============================
# zoxide
# =============================
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& zoxide init powershell | Out-String)
}
