--配置路径为 %LOCALAPPDATA%\nvim\lua
-- 定义NerdFonts图标

--LSP状态栏图标
--Title - \uf085
vim.g.lspTitleIcon = ""
--\uf287
vim.g.lspStatusOk = "󱄙"
--\uf05e
vim.g.lspStatusNg = ""

--文件只读
--\ue0a2
vim.g.fileReadOnlyIcon = ""

--错误提示图标
--Error - \ueab8
vim.g.diagnosticsErrorIcon = ""
--Warning - \uea6c
vim.g.diagnosticsWarnIcon = ""
--Information - \ue66a
vim.g.diagnosticsInfoIcon = ""
--Hint - \ueb11
vim.g.diagnosticsHintrIcon = ""
--Ok - \ueba4
vim.g.diagnosticsOkIcon = ""
--CodeAction - \uea61
vim.g.codeActionHintIcon = ""

--虚拟文本提示前缀 - \udb81\udc43
vim.g.virtualTextPrefixIcon = "・"

--Debug图标
--断点 - \uf111
vim.g.debugBreakPointIcon = ""
--条件断点 - \uf10c
vim.g.debugBreakPointCondIcon = ""
--日志断点 - \uf261
vim.g.debugBreakPointLogIcon = "󰆤"
--禁用断点 - \uf28d
vim.g.debugBreakPointDisabledIcon = ""
--运行标尺 - \ueb8b
vim.g.debugProgramCounterIcon = ""
--在断点处的运行标尺 - \ueb89
vim.g.debugProgramCounterBPIcon = ""
--堆栈跟踪视图中的焦点线程 - \ueb91
vim.g.debugCurrentThreadIcon = "󰣿"
--堆栈跟踪视图中的当前堆栈帧 - \ueb91
vim.g.debugCurrentFrameIcon = "󰣿"
--停止调试 - \uf04d
vim.g.debugDebugStopIcon = ""
--继续 - \ueacf
vim.g.debugDebugContinueIcon = "󰐎"
--暂停 - \uead1
vim.g.debugDebugPauseIcon = ""
--单步 - \uead6
vim.g.debugDebugStepOverIcon = "󰆷"
--单步进入 - \uead4
vim.g.debugDebugStepIntoIcon = "󰆹"
--单步跳出 - \uead5
vim.g.debugDebugStepOutIcon = "󰆸"
--重启调试 - \uead2
vim.g.debugDebugRestartIcon = "󰑓"
--退出调试 - \uf00d
vim.g.debugDebugExitIcon = ""
--\uf188
vim.g.debugRejectedIcon = ""

--文件数
--关闭 - \uf460
vim.g.treeArrowClosedIcon = ""
--打开 - \uf47c
vim.g.treeArrowOpenIcon = ""

--状态栏/TAB栏分隔符
--\ue0b0
vim.g.statusTabLineSeparatorLeft = ""
--\ue0b2
vim.g.statusTabLineSeparatorRight = ""
--\ue0b1
vim.g.statusTabLineSubseparatorLeft = ""
--\ue0b3
vim.g.statusTabLineSubseparatorRight = ""

--\ue0b4
vim.g.statusTabLineSeparatorBubbleLeft = ""
--\ue0b6
vim.g.statusTabLineSeparatorBubbleRight = ""

--telescope
vim.g.telescope_prompt_prefix = "🔍 "
vim.g.telescope_selection_caret = " "
