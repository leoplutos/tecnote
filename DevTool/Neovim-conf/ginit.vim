scriptencoding utf-8
"ginit.vim
"配置路径为 %LOCALAPPDATA%\nvim

"设置字体
GuiFont 等距更纱黑体 SC:h10
"开启连字
GuiRenderLigatures 1
"禁用nvim-qt的TAB栏
GuiTabline 0
"启用滚动条
GuiScrollBar 1
"窗口最大化
call GuiWindowMaximized(1)
"启用鼠标
set mouse=a

"添加快捷键绑定
"Shift+Insert：粘贴
cnoremap <S-Insert> <C-R>+
inoremap <S-Insert> <C-R>+

"鼠标右键菜单
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <ESC>:call GuiShowContextMenu()<CR>
xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv
