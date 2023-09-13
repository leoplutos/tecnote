scriptencoding utf-8
"tab.vim

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
    "let resultStr .= (bufname != '' ? '['. fnamemodify(bufname, ':t') . '] ' : '[No Name] ')
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
"             Tab栏和Buffer管理                 "
"-----------------------------------------------"

"在关闭Tab的同时关闭Buffer，并且关闭所有其他无用的Buffer
function! CloseTab() abort
  "取得当前bufferNo
  let l:current_buffnr = bufnr('%')
  "取得当前tabPageNo
  "let l:current_tabpagenr = tabpagenr()
  "发行q关闭当前窗口
  try
    exec 'q'
  catch
  finally
  endtry
  "发行enew命令将当前窗口内容替换为空Buffer
  "exec 'enew'
  "删除当前buffer
  "取得所有buffer，删除掉空并且没有修改过的
  let l:blist = getbufinfo({'bufloaded': 1, 'buflisted': 1})
  let l:is_split_window = 0
  for l:item in l:blist
    "如果buffer的名字为空，并且没有修改（也就是空buffer没改过），那么删除
    "if empty(l:item.name) || l:item.hidden
    if empty(l:item.name) && (l:item.changed == 0)
      exec 'bd '.l:item.bufnr
    endif
    if (l:item.bufnr == l:current_buffnr) && !empty(l:item.windows)
      "如果当前buffer在分割的多窗口中
      let l:is_split_window = 1
    endif
  endfor
  if (l:is_split_window == 0)
    try
      exec 'bd '.l:current_buffnr
    catch
      exec 'tabnew'
      exec 'b'.l:current_buffnr
    finally
    endtry
  endif
  "调式用
  "echo l:blist
endfunction
