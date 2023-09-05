scriptencoding utf-8
"dap.vim

"-----------------------------------------------"
"               vimspector设置                  "
"-----------------------------------------------"

if (g:g_i_osflg == 1 || g:g_i_osflg == 2)

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

  "自定义断点和高亮组
  sign define vimspectorBP            text=● texthl=BreakPoint
  sign define vimspectorBPCond        text=◆ texthl=BreakPoint
  sign define vimspectorBPLog         text=◆ texthl=SpellRare
  sign define vimspectorBPDisabled    text=● texthl=BreakPointDisabled
  sign define vimspectorPC            text=▶ texthl=ProgramCounter linehl=DebugLine
  sign define vimspectorPCBP          text=▷  texthl=ProgramCounter linehl=DebugLine
  sign define vimspectorNonActivePC   linehl=DiffAdd
  sign define vimspectorCurrentThread text=▶   texthl=ProgramCounter linehl=CursorLine
  sign define vimspectorCurrentFrame  text=▶   texthl=Special    linehl=CursorLine

endif
