scriptencoding utf-8
"statusbar_pure.vim

"-----------------------------------------------"
"               Tab栏设置                       "
"-----------------------------------------------"
" 设置结果为[3]file.txt [+]
function! Tabline()
  let resultStr = ''
  for i in range(tabpagenr('$'))
    let tab = i + 1
    let winnr = tabpagewinnr(tab)
    let buflist = tabpagebuflist(tab)
    let bufnr = buflist[winnr - 1]
    let bufname = bufname(bufnr)
    let bufmodified = getbufvar(bufnr, "&mod")

    let resultStr .= '%' . tab . 'T'
    let resultStr .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    "let resultStr .= ' ' . tab .':'
    let resultStr .= ' [' . tab .']'
    let resultStr .= (bufname != '' ? ''. fnamemodify(bufname, ':t') . ' ' : '[NoName] ')

    if bufmodified
      let resultStr .= '[+] '
    endif
  endfor

  let resultStr .= '%#TabLineFill#'
  if (exists("g:tablineclosebutton"))
    let resultStr .= '%=%999XX'
  endif
  return resultStr
endfunction
set tabline=%!Tabline()

"-----------------------------------------------"
"               状态栏设置                      "
"-----------------------------------------------"
" 设置仿照lightline
function! Statusline()
  let l:show_mode_map={
      \ 'n'  : 'NORMAL',
      \ 'i'  : 'INSERT',
      \ 'r'  : 'CONFIRM',
      \ 'R'  : 'REPLACE',
      \ 'v'  : 'VISUAL',
      \ 'V'  : 'V-LINE',
      \ "\<C-v>"  : 'V-BLOCK',
      \ 'c'  : 'COMMAND',
      \ '!'  : 'COMMAND',
      \ 's'  : 'SELECT',
      \ 'S'  : 'S-LINE',
      \ "\<C-s>"  : 'S-BLOCK',
      \ 't'  : 'TERMINAL'
      \}
  let l:currentMode = mode()
  let l:showMode = ''
  if (has_key(show_mode_map, currentMode))
    let l:showMode .= show_mode_map[currentMode]
  else
    let l:showMode .= 'NORMAL'
  endif
  let l:lspMsgLable = 'LSP :'
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
  let l:resultStr = ''                              " 初始化
  let l:resultStr .= '%1* ' . showMode . ' '        " 显示当前编辑模式，高亮为用户组1
  let l:resultStr .= '%2* %F'                       " 显示当前文件，高亮为用户组2 (%f 相对文件路径, %F 绝对文件路径, %t 文件名)
  let l:resultStr .= '%3* %m%r%h%w %*%='            " 显示当前文件标记(mrhw)，高亮为用户组3，之后用=开始右对齐
  let l:resultStr .= '%4* ' . lspMsgLable . ''      " 显示LSP标签，高亮为用户组4
  let l:resultStr .= '%5* ' . lspMsgContent . '  '   " 显示LSP状态，高亮为用户组5
  let l:resultStr .= '%* %{&ff} | %{"".(""?&enc:&fenc).((exists("+bomb") && &bomb)?"+":"").""} | %Y '        " 显示换行符，编码，文件类型，高亮为默认（ LF | utf-8 | fomart ）
  let l:resultStr .= '%2* [%l:%v] '                 " 显示当前行，列，高亮为用户组2
  let l:resultStr .= '%1* %p%% %LL '                " 显示百分比，总行数，高亮为用户组4
  return resultStr
endfunction
set statusline=%!Statusline()

" 模式变换时的函数
function! RestUserColor(pmode)
  if a:pmode == 'ModeChanged'
    let l:currentMode = mode()
    if (currentMode == 'i')                "插入模式配色
      hi User1        term=bold,reverse cterm=bold ctermfg=16 ctermbg=226 gui=bold guifg=#000010 guibg=#ffff00
    elseif (currentMode == 'n')            "普通模式配色
      hi User1        term=bold,reverse cterm=bold ctermfg=16 ctermbg=111 gui=bold guifg=#000010 guibg=#78a2f3
    elseif (currentMode == 'v' || currentMode == 'V' || currentMode == "\<C-v>" || currentMode == "\<C-vs>")      "可视模式配色
      hi User1        term=bold,reverse cterm=bold ctermfg=16 ctermbg=48 gui=bold guifg=#000010 guibg=#00ff87
    elseif (currentMode == 'R')            "替换模式配色
      hi User1        term=bold,reverse cterm=bold ctermfg=231 ctermbg=160 gui=bold guifg=#ffffff guibg=#d70000
    elseif (currentMode == 'c' || currentMode == '!')       "命令模式配色
      hi User1        term=bold,reverse cterm=bold ctermfg=231 ctermbg=201 gui=bold guifg=#ffffff guibg=#ff00ff
    elseif (currentMode == 's' || currentMode == 'S' || currentMode == "\<C-s>")      "选择模式配色
      hi User1        term=bold,reverse cterm=bold ctermfg=16 ctermbg=178 gui=bold guifg=#000010 guibg=#d7af00
    elseif (currentMode == 't')            "终端模式配色
      hi User1        term=bold,reverse cterm=bold ctermfg=231 ctermbg=31 gui=bold guifg=#ffffff guibg=#2472c8
    elseif (currentMode == 'r')            "确认模式配色
      hi User1        term=bold,reverse cterm=bold ctermfg=16 ctermbg=177 gui=bold guifg=#000010 guibg=#d787ff
    else            "默认普通模式配色
      hi User1        term=bold,reverse cterm=bold ctermfg=16 ctermbg=111 gui=bold guifg=#000010 guibg=#78a2f3
    endif
  elseif a:pmode == 'InsertEnter'
    hi User1        term=bold,reverse cterm=bold ctermfg=16 ctermbg=226 gui=bold guifg=#000010 guibg=#ffff00
  elseif a:pmode == 'InsertLeave'
    hi User1        term=bold,reverse cterm=bold ctermfg=16 ctermbg=111 gui=bold guifg=#000010 guibg=#78a2f3
  endif
endfunction

" 添加模式变换时的自动命令
augroup lchModeChangedGroup
  autocmd!
  if exists("##ModeChanged")
    "存在ModeChanged自动命令
    autocmd ModeChanged *:* call RestUserColor('ModeChanged')
  else
    "不存在ModeChanged自动命令
    autocmd InsertEnter * call RestUserColor('InsertEnter')
    autocmd InsertLeave * call RestUserColor('InsertLeave')
  endif
  "插入模式中关闭当前行高亮
  "autocmd InsertEnter,WinLeave * set nocursorline
  "autocmd InsertLeave,WinEnter * set cursorline
augroup END

"当前编辑模式
hi User1        term=bold,reverse cterm=bold ctermfg=16 ctermbg=111 gui=bold guifg=#000010 guibg=#78a2f3
"文件名
hi User2        term=none cterm=none ctermfg=189 ctermbg=236 gui=none guifg=#c3cef7 guibg=#292e41
"文件编辑状态
hi User3        term=none cterm=none ctermfg=226 ctermbg=236 gui=none guifg=#ffff00 guibg=#292e41
"LSP服务器标签
hi User4        term=none cterm=none ctermfg=231 ctermbg=60 gui=none guifg=#f7f7f0 guibg=#545c7c
"LSP服务器状态
hi User5        term=none cterm=none ctermfg=226 ctermbg=60 gui=none guifg=#ffff00 guibg=#545c7c

"快捷键绑定
noremap <Leader>q :call CloseTab()<CR>
nnoremap <TAB>1 1gt|                  " [普通模式]tab+1：移动到tab1
nnoremap <TAB>2 2gt|                  " [普通模式]tab+2：移动到tab2
nnoremap <TAB>3 3gt|                  " [普通模式]tab+3：移动到tab3
nnoremap <TAB>4 4gt|                  " [普通模式]tab+4：移动到tab4
nnoremap <TAB>5 5gt|                  " [普通模式]tab+5：移动到tab5
nnoremap <TAB>6 6gt|                  " [普通模式]tab+6：移动到tab6
nnoremap <TAB>7 7gt|                  " [普通模式]tab+7：移动到tab7
nnoremap <TAB>8 8gt|                  " [普通模式]tab+8：移动到tab8
nnoremap <TAB>9 9gt|                  " [普通模式]tab+9：移动到tab9
nnoremap <TAB>0 10gt|
nnoremap <Leader>1 1gt|               " [普通模式]\+1：移动到tab1
nnoremap <Leader>2 2gt|               " [普通模式]\+2：移动到tab2
nnoremap <Leader>3 3gt|               " [普通模式]\+3：移动到tab3
nnoremap <Leader>4 4gt|               " [普通模式]\+4：移动到tab4
nnoremap <Leader>5 5gt|               " [普通模式]\+5：移动到tab5
nnoremap <Leader>6 6gt|               " [普通模式]\+6：移动到tab6
nnoremap <Leader>7 7gt|               " [普通模式]\+7：移动到tab7
nnoremap <Leader>8 8gt|               " [普通模式]\+8：移动到tab8
nnoremap <Leader>9 9gt|               " [普通模式]\+9：移动到tab9
nnoremap <Leader>0 10gt|

"在关闭Tab的同时关闭Buffer，并且关闭所有其他无用的Buffer
function! CloseTab() abort
  if winnr('$') > 1 || getline(1, '$') == [''] && (bufname('%') == '' || bufname('%') == '[NoName]')
    "如果Window数大于1 或者 当前Buffer内容为空并且没有Buffer名字，运行退出
    quit
  else
    bd
  endif
endfunction
