scriptencoding utf-8
"dap.vim

"-----------------------------------------------"
"               vimspector设置                  "
"-----------------------------------------------"
"加载DAP插件
"https://github.com/puremourning/vimspector
"let g:vimspector_enable_mappings = 'HUMAN'
let g:vimspector_enable_mappings = ''
packadd vimspector

"设定尺寸
let g:vimspector_sidebar_width = 50
let g:vimspector_code_minwidth = 70
let g:vimspector_bottombar_height = 9
let g:vimspector_terminal_minwidth = 9

"F5：开始调试
nnoremap <F5> <Plug>VimspectorContinue
"F6：添加断点
nnoremap <F6> <Plug>VimspectorToggleBreakpoint
"F7：下一步
nnoremap <F7> <Plug>VimspectorStepOver
"F8：运行到光标处
nnoremap <F8> <Plug>VimspectorRunToCursor

if has('nvim')
  "NeoVim下，添加显示光标下变量内容的键绑定
  " for normal mode - the word under the cursor
  nnoremap <Leader>di <Plug>VimspectorBalloonEval
  " for visual mode, the visually selected text
  xnoremap <Leader>di <Plug>VimspectorBalloonEval
endif

"自定义断点和高亮组
if (g:g_use_nerdfont == 0)
  "普通模式
  sign define vimspectorBP            text=● texthl=BreakPoint
  sign define vimspectorBPCond        text=◆ texthl=BreakPoint
  sign define vimspectorBPLog         text=◆ texthl=BreakLogPoint
  sign define vimspectorBPDisabled    text=● texthl=BreakPointDisabled
  sign define vimspectorPC            text=▶ texthl=ProgramCounter linehl=DebugLine
  sign define vimspectorPCBP          text=▷  texthl=ProgramCounter linehl=DebugLine
  sign define vimspectorNonActivePC   linehl=DiffAdd
  sign define vimspectorCurrentThread text=▶   texthl=ProgramCounter linehl=CursorLine
  sign define vimspectorCurrentFrame  text=▶   texthl=Special    linehl=CursorLine
else
  "使用NerdFont
  call sign_define("vimspectorBP", {"text" : g:debugBreakPointIcon, "texthl" : "BreakPoint"})
  call sign_define("vimspectorBPCond", {"text" : g:debugBreakPointCondIcon, "texthl" : "BreakPoint"})
  call sign_define("vimspectorBPLog", {"text" : g:debugBreakPointLogIcon, "texthl" : "BreakLogPoint"})
  call sign_define("vimspectorBPDisabled", {"text" : g:debugBreakPointDisabledIcon, "texthl" : "BreakPointDisabled"})
  call sign_define("vimspectorPC", {"text" : g:debugProgramCounterIcon, "texthl" : "ProgramCounter", "linehl" : "DebugLine"})
  call sign_define("vimspectorPCBP", {"text" : g:debugProgramCounterBPIcon, "texthl" : "ProgramCounter", "linehl" : "DebugLine"})
  call sign_define("vimspectorNonActivePC", {"linehl" : "DiffAdd"})
  call sign_define("vimspectorCurrentThread", {"text" : g:debugCurrentThreadIcon, "texthl" : "ProgramCounter", "linehl" : "CursorLine"})
  call sign_define("vimspectorCurrentFrame", {"text" : g:debugCurrentFrameIcon, "texthl" : "Special", "linehl" : "CursorLine"})

  augroup MyVimspectorUICustomistaion
    autocmd!
    autocmd User VimspectorUICreated call VimspectorCustomiseUI()
  augroup END
endif

function! VimspectorCustomiseUI()
  call win_gotoid( g:vimspector_session_windows.code )
  " Clear the existing WinBar created by Vimspector
  nunmenu WinBar
  " Create our own WinBar
  "exec 'nnoremenu WinBar.' . g:debugDebugStopIcon . ' :call vimspector#Stop( { "interactive": v:true } )<CR>'
  exec 'nnoremenu WinBar.■ :call vimspector#Stop( { "interactive": v:true } )<CR>'
  exec 'nnoremenu WinBar.' . g:debugDebugContinueIcon . ' :call vimspector#Continue()<CR>'
  exec 'nnoremenu WinBar.' . g:debugDebugPauseIcon . ' :call vimspector#Pause()<CR>'
  exec 'nnoremenu WinBar.' . g:debugDebugStepOverIcon . ' :call vimspector#StepOver()<CR>'
  exec 'nnoremenu WinBar.' . g:debugDebugStepIntoIcon . ' :call vimspector#StepInto()<CR>'
  exec 'nnoremenu WinBar.' . g:debugDebugStepOutIcon . ' :call vimspector#StepOut()<CR>'
  exec 'nnoremenu WinBar.' . g:debugDebugRestartIcon . ' :call vimspector#Restart()<CR>'
  exec 'nnoremenu WinBar.' . g:debugDebugExitIcon . ' :call vimspector#Reset()<CR>'
endfunction
