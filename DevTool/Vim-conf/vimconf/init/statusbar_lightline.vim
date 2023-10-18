scriptencoding utf-8
"statusbar_lightline.vim

"-----------------------------------------------"
"           状态栏和Buffer设置                  "
"-----------------------------------------------"
"加载lightline.vim插件
"https://github.com/itchyny/lightline.vim
"https://github.com/mengelbrecht/lightline-bufferline

"lightline-bufferline设定
let g:lightline#bufferline#unnamed = '[NoName]'
let g:lightline#bufferline#unicode_symbols = 0
let g:lightline#bufferline#show_number = 2
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#enable_nerdfont = 1
let g:lightline#bufferline#filter_by_tabpage = 1
let g:lightline#bufferline#icon_position = 'right'
function LightlineBufferlineFilter(buffer)
  return getbufvar(a:buffer, '&buftype') !=# 'terminal'
endfunction
let g:lightline#bufferline#buffer_filter = "LightlineBufferlineFilter"

"加载插件
packadd lightline.vim
packadd lightline-bufferline

"设定（custfilename，lspstatus为自定义内容）
let g:lightline = {
      \ 'colorscheme': 'lchtheme',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      "\             [ 'readonly', 'filename', 'modified' ] ],
      "\             [ 'absolutepath', 'readonly', 'modified' ] ],
      \             [ 'custfilename'] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ],
      \              [ 'lspstatus' ] ],
      \ },
      \ 'inactive': {
      \   'left': [ [ 'filename' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ] ],
      \ },
      \ 'component': {
      \   'custfilename': '%#LightlineCustfilenameColor#%{LightlineCustfilename()} %#LightlineCustfileStatusColor#%{LightlineCustfileStatus()}',
      \   'lineinfo': '%3l:%-2v%<',
      \   'lspstatus': '%#LightlineLspLableColor#%{LightlineLspLable()}%#LightlineLspContentColor#%{LightlineLspContent()}',
      \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ ['close'] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ },
      \ 'component_function': {
      \   'filetype': 'NerdFontIconFiletype',
      \   'fileformat': 'NerdFontIconFileformat',
      \ },
      \ }

"定制内容的高亮组
hi LightlineCustfilenameColor term=none cterm=none ctermfg=189 ctermbg=236 gui=none guifg=#c3cef7 guibg=#292e41
hi LightlineCustfileStatusColor term=none cterm=none ctermfg=226 ctermbg=236 gui=none guifg=#ffff00 guibg=#292e41
hi LightlineLspLableColor term=none cterm=none ctermfg=231 ctermbg=60 gui=none guifg=#f7f7f0 guibg=#545c7c
hi LightlineLspContentColor term=none cterm=none ctermfg=226 ctermbg=60 gui=none guifg=#ffff00 guibg=#545c7c
"定制文件名
function! LightlineCustfilename()
  return expand('%:p') !=# '' ? expand('%:p') : '[No Name]'
endfunction
"定制文件状态（只读，修改）
function! LightlineCustfileStatus()
  let l:fileReadOnly = &ft !~? 'help' && &readonly ? '[RO]' : ''
  let l:fileModified = &ft ==# 'help' ? '' : &modified ? '[+]' : &modifiable ? '' : '[-]'
  return fileReadOnly . fileModified
endfunction
"定制LSP标签
function! LightlineLspLable()
  let l:lspMsgLable = ' LSP : '
  return l:lspMsgLable
endfunction
"定制LSP内容
function! LightlineLspContent()
  let l:lspMsgContent = ''
  if exists('*GetLspStatus')
    let l:lspMsgContent = GetLspStatus()
    if (g:g_use_nerdfont == 0)
    else
      if (l:lspMsgContent == 'running')
        let l:lspMsgContent = g:lspStatusOk
      else
        "
      endif
    endif
  else
    if (g:g_use_nerdfont == 0)
      let l:lspMsgContent = '❌'
    else
      let l:lspMsgContent = g:lspStatusNg
    endif
  endif
  return l:lspMsgContent
endfunction
"定制显示文件类型NerdFont的icon
function! NerdFontIconFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction
"定制显示文件格式NerdFont的icon
function! NerdFontIconFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

"设定分隔符
if (g:g_use_nerdfont == 0)
  let g:lightline.separator = { 'left': '', 'right': '' }
  let g:lightline.subseparator = { 'left': '|', 'right': '|' }
else
  let g:lightline.separator = { 'left': g:statusTabLineSeparatorLeft, 'right': ' ' }
  let g:lightline.subseparator = { 'left': g:statusTabLineSubseparatorLeft, 'right': g:statusTabLineSubseparatorRight }
endif
let g:lightline.tabline_separator = g:lightline.separator
let g:lightline.tabline_subseparator = g:lightline.subseparator

"高亮设定（自定义的名字为lchtheme）
function! LightlineSetColor()
  let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
  let s:mode_normal_fg   = [ '#000010', 16 ]
  let s:mode_normal_bg   = [ '#78a2f3', 111 ]
  let s:mode_insert_fg   = [ '#000010', 16 ]
  let s:mode_insert_bg   = [ '#ffff00', 226 ]
  let s:mode_visual_fg   = [ '#000010', 16 ]
  let s:mode_visual_bg   = [ '#00ff87', 48 ]
  let s:mode_replace_fg   = [ '#ffffff', 231 ]
  let s:mode_replace_bg   = [ '#d70000', 160 ]
  let s:file_name_fg   = [ '#c3cef7', 189 ]
  let s:file_name_bg   = [ '#292e41', 236 ]
  if (&background == 'light')
    "亮色主题用
    let s:inactive_left_fg   = [ '#fafafa', 255 ]
    let s:inactive_left_bg   = [ '#d0d0d0', 250 ]
    let s:inactive_middle_fg   = [ '#d0d0d0', 250 ]
    let s:inactive_middle_bg   = [ '#f0f0f0', 255 ]
    let s:inactive_right_fg   = [ '#fafafa', 255 ]
    let s:inactive_right_bg   = [ '#d0d0d0', 250 ]
    let s:status_line_fg   = [ '#1c1c1c', 234 ]
    let s:status_line_bg   = [ '#f0f0f0', 255 ]
    let s:error_fg   = [ '#be5046', 168 ]
    let s:error_bg   = [ '#fafafa', 255 ]
    let s:warning_fg   = [ '#e5c07b', 180 ]
    let s:warning_bg   = [ '#fafafa', 255 ]
    let s:tab_left_fg   = [ '#494b53', 238 ]
    let s:tab_left_bg   = [ '#d0d0d0', 250 ]
    let s:tab_tabsel_fg   = [ '#f7f7f0', 231 ]
    let s:tab_tabsel_bg   = [ '#5e74a2', 67 ]
    let s:tab_line_fg   = [ '#8f8391', 102 ]
    let s:tab_line_bg   = [ '#e8e8ef', 254 ]
  else
    "暗色主题用
    let s:inactive_left_fg   = [ '#5c6370', 241 ]
    let s:inactive_left_bg   = [ '#282c34', 235 ]
    let s:inactive_middle_fg   = [ '#5c6370', 241 ]
    let s:inactive_middle_bg   = [ '#2c323d', 235 ]
    let s:inactive_right_fg   = [ '#5c6370', 241 ]
    let s:inactive_right_bg   = [ '#282c34', 235 ]
    let s:status_line_fg   = [ '#dfffe3', 194 ]
    let s:status_line_bg   = [ '#444444', 238 ]
    let s:error_fg   = [ '#be5046', 168 ]
    let s:error_bg   = [ '#282c34', 235 ]
    let s:warning_fg   = [ '#e5c07b', 180 ]
    let s:warning_bg   = [ '#282c34', 235 ]
    let s:tab_left_fg   = [ '#abb2bf', 145 ]
    let s:tab_left_bg   = [ '#3e4452', 240 ]
    let s:tab_tabsel_fg   = [ '#ffffff', 231 ]
    let s:tab_tabsel_bg   = [ '#96b38c', 108 ]
    let s:tab_line_fg   = [ '#a8a8a8', 248 ]
    let s:tab_line_bg   = [ '#444444', 238 ]
  endif

  "模式改变时左侧颜色
  let s:p.normal.left    = [ [ s:mode_normal_fg, s:mode_normal_bg, 'bold' ], [ s:file_name_fg, s:file_name_bg ] ]
  let s:p.insert.left    = [ [ s:mode_insert_fg, s:mode_insert_bg, 'bold' ], [ s:file_name_fg, s:file_name_bg ] ]
  let s:p.visual.left    = [ [ s:mode_visual_fg, s:mode_visual_bg, 'bold' ], [ s:file_name_fg, s:file_name_bg ] ]
  let s:p.replace.left   = [ [ s:mode_replace_fg, s:mode_replace_bg, 'bold' ], [ s:file_name_fg, s:file_name_bg ] ]
  "模式改变时右颜色
  let s:p.normal.right   = [ [ s:mode_normal_fg, s:mode_normal_bg, 'bold' ], [ s:file_name_fg, s:file_name_bg ] ]
  let s:p.insert.right   = [ [ s:mode_insert_fg, s:mode_insert_bg, 'bold' ], [ s:file_name_fg, s:file_name_bg ] ]
  let s:p.visual.right   = [ [ s:mode_visual_fg, s:mode_visual_bg, 'bold' ], [ s:file_name_fg, s:file_name_bg ] ]
  let s:p.replace.right  = [ [ s:mode_replace_fg, s:mode_replace_bg, 'bold' ], [ s:file_name_fg, s:file_name_bg ] ]
  "状态栏中间（等同StatusLine高亮组）
  let s:p.normal.middle  = [ [ s:status_line_fg, s:status_line_bg ] ]
  let s:p.normal.error   = [ [ s:error_fg, s:error_bg ] ]
  let s:p.normal.warning = [ [ s:warning_fg, s:warning_bg ] ]
  "失去焦点时的高亮设定
  let s:p.inactive.left   = [ [ s:inactive_left_fg, s:inactive_left_bg ], [ s:inactive_left_fg, s:inactive_left_bg ] ]
  let s:p.inactive.middle = [ [ s:inactive_middle_fg, s:inactive_middle_bg ] ]
  let s:p.inactive.right  = [ [ s:inactive_right_fg, s:inactive_right_bg ] ]
  "TAB栏设定
  let s:p.tabline.left   = [ [ s:tab_left_fg, s:tab_left_bg ] ]
  let s:p.tabline.tabsel = [ [ s:tab_tabsel_fg, s:tab_tabsel_bg, 'bold' ] ]
  let s:p.tabline.middle = [ [ s:tab_line_fg, s:tab_line_bg ] ]
  let s:p.tabline.right  = copy(s:p.normal.right)

  let g:lightline#colorscheme#lchtheme#palette = lightline#colorscheme#flatten(s:p)
endfunction
call LightlineSetColor()

"修改快捷键绑定
noremap <Leader>q :call CloseTab()<CR>
nnoremap <leader>tn :enew<cr>
nnoremap <Leader>bd :bd<CR>
nnoremap <TAB>1 <Plug>lightline#bufferline#go(1)
nnoremap <TAB>2 <Plug>lightline#bufferline#go(2)
nnoremap <TAB>3 <Plug>lightline#bufferline#go(3)
nnoremap <TAB>4 <Plug>lightline#bufferline#go(4)
nnoremap <TAB>5 <Plug>lightline#bufferline#go(5)
nnoremap <TAB>6 <Plug>lightline#bufferline#go(6)
nnoremap <TAB>7 <Plug>lightline#bufferline#go(7)
nnoremap <TAB>8 <Plug>lightline#bufferline#go(8)
nnoremap <TAB>9 <Plug>lightline#bufferline#go(9)
nnoremap <TAB>0 <Plug>lightline#bufferline#go(10)
nnoremap <Leader>1 <Plug>lightline#bufferline#go(1)
nnoremap <Leader>2 <Plug>lightline#bufferline#go(2)
nnoremap <Leader>3 <Plug>lightline#bufferline#go(3)
nnoremap <Leader>4 <Plug>lightline#bufferline#go(4)
nnoremap <Leader>5 <Plug>lightline#bufferline#go(5)
nnoremap <Leader>6 <Plug>lightline#bufferline#go(6)
nnoremap <Leader>7 <Plug>lightline#bufferline#go(7)
nnoremap <Leader>8 <Plug>lightline#bufferline#go(8)
nnoremap <Leader>9 <Plug>lightline#bufferline#go(9)
nnoremap <Leader>0 <Plug>lightline#bufferline#go(10)
nnoremap <Leader>d1 <Plug>lightline#bufferline#delete(1)
nnoremap <Leader>d2 <Plug>lightline#bufferline#delete(2)
nnoremap <Leader>d3 <Plug>lightline#bufferline#delete(3)
nnoremap <Leader>d4 <Plug>lightline#bufferline#delete(4)
nnoremap <Leader>d5 <Plug>lightline#bufferline#delete(5)
nnoremap <Leader>d6 <Plug>lightline#bufferline#delete(6)
nnoremap <Leader>d7 <Plug>lightline#bufferline#delete(7)
nnoremap <Leader>d8 <Plug>lightline#bufferline#delete(8)
nnoremap <Leader>d9 <Plug>lightline#bufferline#delete(9)
nnoremap <Leader>d0 <Plug>lightline#bufferline#delete(10)
nnoremap <Leader>bn <Plug>lightline#bufferline#move_next()
nnoremap <Leader>bp <Plug>lightline#bufferline#move_previous()
nnoremap <Leader>bf <Plug>lightline#bufferline#move_first()
nnoremap <Leader>bl <Plug>lightline#bufferline#move_last()
nnoremap <Leader>br <Plug>lightline#bufferline#reset_order()

"在关闭Tab的同时关闭Buffer，并且关闭所有其他无用的Buffer
function! CloseTab() abort
  if winnr('$') > 1 || getline(1, '$') == [''] && (bufname('%') == '' || bufname('%') == '[NoName]')
    "如果Window数大于1 或者 当前Buffer内容为空并且没有Buffer名字，运行退出
    quit
  else
    bd
  endif
endfunction
