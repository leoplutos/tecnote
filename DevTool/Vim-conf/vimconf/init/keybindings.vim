scriptencoding utf-8
"keybindings.vim

let mapleader='\'                    " 设定前缀为 \
nnoremap <Leader>e :Lexplore<CR>:vertical resize 30<CR><C-w>w|     " [普通模式]\e：打开或关闭目录树，并且让左侧目录树尺寸为30，并且让光标回到编译器
nnoremap <Leader>< :30winc > <CR>|    " [普通模式]\<：屏幕分割线左移30
nnoremap <Leader>> :30winc < <CR>|    " [普通模式]\>：屏幕分割线左移30
" [普通模式]\rl：重新载入.vimrc
nnoremap <Leader>rl :source $MYVIMRC<cr>
" [普通模式]\rc：编辑.vimrc
nnoremap <Leader>rc :e $MYVIMRC<cr>
noremap J 10j|                        " [普通模式/选择模式]大写J，向下10行
noremap K 10k|                        " [普通模式/选择模式]大写K，向上10行
" 插入模式下的光标移动
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-l> <right>
inoremap <C-h> <left>
" 插入模式下的移动
inoremap <C-e> <end>
inoremap <C-a> <C-o>^
inoremap <C-f> <C-o>w
inoremap <C-b> <C-o>b
inoremap <C-d> <C-o>dd
vnoremap <C-d> <del>
" 选择模式下使用Ctrl+上/Ctrl+下移动所选代码
vnoremap <C-UP> dkPV`]
vnoremap <C-Down> dpV`]
" 插入模式下Ctrl+i：打开omni补全（代码智能补全，在omnifunc设置）
inoremap <C-i> <C-x><C-o>
" 撤销
inoremap <C-z> <C-o>u
noremap <C-z> u
" 设置括号匹配
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap < <><left>
cnoremap ( ()<left>
cnoremap [ []<left>
cnoremap { {}<left>
cnoremap < <><left>
inoremap " ""<left>
inoremap ' ''<left>
" 命令模式移动
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
" TAB/窗口移动快捷键
nnoremap <leader>tn :tabnew<cr>|          " [普通模式]tab+n：新建一个tab
nnoremap <TAB>w <C-w>w|               " [普通模式]tab+w：移动窗口
nnoremap <TAB>h <C-w><left>|          " [普通模式]tab+h：移动到左边窗口
nnoremap <TAB>l <C-w><right>|         " [普通模式]tab+l：移动到右边窗口
nnoremap <TAB>k <C-w><up>|            " [普通模式]tab+k：移动到上边窗口
nnoremap <TAB>j <C-w><down>|          " [普通模式]tab+j：移动到下边窗口
nnoremap <Leader>v <C-w>v|            " [普通模式]\+v：左右分割
"nnoremap <Leader>n <C-w>n|            " [普通模式]\+n：水平分割
" [普通模式][tags]\]：在预览窗口打开定义-右侧打开
nnoremap <Leader>] :execute "vertical ptag " . expand("<cword>")<CR>
" [普通模式][tags]\c：关闭预览窗口
nnoremap <Leader>c :pclose<CR>
" [普通模式][tags]F3/F4：不切换窗口的前提下，滚动另一个窗口
noremap  <F3> <C-w><C-w><C-e><C-w><C-w>
noremap  <F4> <C-w><C-w><C-y><C-w><C-w>
" [普通模式]\=：格式化缩进
noremap  <Leader>= gg=G
" [普通模式]\ff：模糊查找（在新tab打开find结果）
nnoremap <Leader>ff :tabfind *
" [普通模式]\FF：模糊查找（在当前tab打开find结果）
nnoremap <Leader>FF :find *
" [普通模式]\fg：grep查找（在新tab打开find结果）
nnoremap <Leader>fg 1gt:tabnew<CR>:vim // **/*<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
" [普通模式]\cq：清空QuickFix内容
nmap <leader>cq :call setqflist([])<CR>
" 使用方向键切换buffer
noremap <Leader><left> :bp<CR>|       " [普通模式/选择模式]\+左：上一个buffer
noremap <Leader><right> :bn<CR>|      " [普通模式/选择模式]\+右：下一个buffer
" [普通模式][tags]\s：保存,\q：退出
noremap <Leader>s :w<CR>|             " [普通模式/选择模式]\+s：保存文件
noremap <Leader>q :q<CR>|             " [普通模式/选择模式]\+q：退出
" 通过Leader-y复制到系统剪切板
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y
cnoremap <Leader>y "+y
" 复制所有到系统剪切板
nnoremap <Leader>ca ggVG"+y
" 通过Leader-p粘贴系统剪切板
nnoremap <Leader>p "*p
" 在编程中经常要复制粘贴一些内容。为了解决寄存器混乱的问题，这里如下定义
" [选择模式]Ctrl+y  复制到字母寄存器c
vnoremap <C-y> "cy
" [普通模式]Ctrl+p  从字母寄存器c中粘贴内容
nnoremap <C-p> "cp
nnoremap <C-p> "cP
" [普通模式]\ll：重新绘制当前的屏幕，并且取消字符的高亮
nnoremap <leader>ll :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>
" [普通模式]\rd：在只读和可写之间切换
nnoremap <silent> <leader>rd :if &modifiable \| setl nomodifiable \| echo 'Current buffer is set readonly complete ' \| else \| setl modifiable \| echo 'Current buffer is cancel readonly complete ' \| endif<CR>
" [普通模式]\rp：replease替换
nnoremap <leader>rp :%s///gc<LEFT><LEFT><LEFT><LEFT>
" [普通模式]\oe：在OS打开当前文件的路径，快捷键 空格+e+空格
nnoremap <leader>oe :!start .<CR>
" [普通模式]\ds：删除行尾空格
"nnoremap <silent><nowait> <leader>ds :%s/ *$//g<cr>:noh<cr><c-o>
nnoremap <silent><nowait> <leader>ds <Cmd>call RemovveTrailingWhitespace()<CR>
function! RemovveTrailingWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\(\%u0009\|\%u000A\|\%u000B\|\%u000C\|\%u000D\|\%u0020\|\%u0085\|\%u00A0\|\%u1680\|\%u2000\|\%u2001\|\%u2002\|\%u2003\|\%u2004\|\%u2005\|\%u2006\|\%u2007\|\%u2008\|\%u2009\|\%u200A\|\%u2028\|\%u2029\|\%u202F\|\%u205F\|\%u3000\)\+$//e
    call winrestview(l:save)
endfunction
" [普通模式]\df：差分另一个文件
nnoremap <leader>df :vert diffsplit |
" [普通模式]\dt：差分左右2个文件
nnoremap <leader>dt :windo diffthis<CR>
" [普通模式]\do：关闭差分
nnoremap <leader>do :windo diffoff<CR>
" [普通模式]\hi：进入16进制编辑器并开启高亮
nnoremap <leader>hi :%!xxd<CR>:set ft=xxd<CR>
" [普通模式]\ho：退出16进制编辑器
nnoremap <leader>ho :%!xxd -r<CR>
" [普通模式]\td：载入暗色系配置
nnoremap <leader>td :call <SID>setColorscheme(0)<CR>
" [普通模式]\tl：载入亮色系配置
nnoremap <leader>tl :call <SID>setColorscheme(1)<CR>
" [普通模式]\tq：载入亮色系配置
nnoremap <leader>tq :call <SID>setColorscheme(2)<CR>
" [普通模式]\t16：载入16色配置
nnoremap <leader>t16 :exec 'source ' . g:g_s_rcfilepath . '/vimconf/colors/lch-16.vim'<CR>
function! s:setColorscheme(colorFlg)
  if (a:colorFlg == 0)
    exec 'source ' . g:g_s_rcfilepath . '/vimconf/colors/lch-dark.vim'
  elseif (a:colorFlg == 1)
    exec 'source ' . g:g_s_rcfilepath . '/vimconf/colors/lch-light.vim'
  elseif (a:colorFlg == 2)
    exec 'source ' . g:g_s_rcfilepath . '/vimconf/colors/qy-light.vim'
  endif
  if exists('*LightlineSetColor')
    "如果存在LightlineSetColor函数则调用（lightline.vim更新颜色）
    call LightlineSetColor()
  endif
  if exists('*lightline#colorscheme')
    "如果存在lightline#colorscheme函数则调用（lightline.vim更新颜色）
    call lightline#colorscheme()
  endif
endfunction
" [普通模式]\@：复制命令模式回显消息
"nnoremap <leader>@ :<C-U><C-R>=printf("redir @* | hi SpecialKey | redir END", "")
"redir > $HOME/vimoutput.txt
"command
"redir END
" [普通模式]:按照百分比快速移动
noremap <Space>1 10%
noremap <Space>2 20%
noremap <Space>3 30%
noremap <Space>4 40%
noremap <Space>5 50%
noremap <Space>6 60%
noremap <Space>7 70%
noremap <Space>8 80%
noremap <Space>9 90%

if (exists(':tnoremap') > 0)
  if (g:g_nvim_flg == 0)
    " [vim][终端模式]Shift+Insert：粘贴
    tnoremap <S-Insert> <C-W>"+
    " [vim][终端模式]Ctrl+o：使用gvim打开文件（需要自己输入文件名）
    tnoremap <C-o> gvim --remote-tab 
  else
    " [neovim][终端模式]Shift+Insert：粘贴
    tnoremap <S-Insert> <C-\><C-n>"+pa
  endif
  " [终端模式]Ctrl+n：进入普通模式
  tnoremap <C-n> <C-\><C-n>
endif

" [普通模式]QuickFix快捷键
nnoremap <C-n> :cnext<cr>
nnoremap <C-m> :cprevious<cr>
nnoremap <Leader>j :<C-u>cfirst<CR>
nnoremap <Leader>k :<C-u>clast<CR>
"nnoremap <C-q> :cclose<cr>
"nnoremap =q :copen<cr>
"按下<Leader>z打开/关闭QuickFix
command! -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 20
    let g:qfix_win = bufnr("$")
  endif
endfunction
nnoremap <silent> <Leader>z :QFix<CR>

" 选中参数
onoremap <silent>aa :<c-u>call <sid>GetArgs('a')<cr>
onoremap <silent>ia :<c-u>call <sid>GetArgs('i')<cr>
xnoremap <silent>aa :<c-u>call <sid>GetArgs('a')<cr>
xnoremap <silent>ia :<c-u>call <sid>GetArgs('i')<cr>
func! s:GetArgs(model)
  let model=a:model
  let line=line('.')|let col=col('.')|let i=col-1|let now=getline('.')
  let begin=-1|let end=-1|let pos0=-1|let pos1=-1
  let buket=0|let flag=0
  while i>0
    let temp=now[i]|let flag=0
    if temp==')'|let buket+=1|endif
    if temp=='('|let buket-=1|let flag=1|endif
    if (buket>0)||(buket==0&&flag)|let i-=1|continue|endif
    if temp=='('|| temp==','|let begin=temp|let pos0=i|break|endif
    let i-=1
  endwhile
  let i=col|let buket=0|let flag=0
  while i<col('$')
    let temp=now[i]|let flag=0
    if temp=='('|let buket+=1|endif
    if temp==')'|let buket-=1|let flag=1|endif
    if (buket>0)||(buket==0&&flag)|let i+=1|continue|endif
    if temp==')'|| temp==','|let end=temp|let pos1=i|break|endif
    let i+=1
  endwhile
  if model=='i'
    let pos0+=1|let pos1-=1
  else
    if begin=='('|let pos0+=1|else|let pos1-=1|endif
  endif
  call cursor([line,pos0+1])
  let pos1-=pos0|echom end
  execute "normal! v".pos1."l"
endfunc

" 以下和VSCode一致
" [插入模式]shift+space -> s:触发建议
inoremap <S-Space>s <C-n>
" [普通模式]ctrl+w:关闭tab
"nnoremap <C-w> :q<CR>
" [普通模式]shift+space -> ctrl+w:关闭其他tab
nnoremap <S-Space><C-w> :tabonly<CR>
" [插入模式]ctrl+d:删除行
" [普通模式]shift+alt+r:在资源管理器中显示
nnoremap <S-A-r> :!start .<CR>
" shift+space -> t:运行任务
" shift+space -> q:最大化终端面板
" shift+space -> ctrl+u:转换大写（选中后按U即可）
" shift+space -> ctrl+l:转换小写（选中后按u即可）
" [插入模式]shift+space -> ctrl+s:将缩进转换为空格
inoremap <S-Space><C-s> <Esc>:set expandtab<CR>:retab<CR>
" [插入模式]shift+space -> ctrl+t:将缩进转换为制表符
inoremap <S-Space><C-t> <Esc>:set noexpandtab<CR>:%retab!<CR>
" [插入模式]shift+space -> ctrl+e:切换换行符
inoremap <S-Space><C-e> <Esc>:if (&fileformat == "unix") \| set fileformat=dos \| else \| set fileformat=unix \| endif<CR>
" [插入模式]shift+space -> ctrl+d:按降序排列行
inoremap <S-Space><C-d> <Esc>:sort<CR>
" [插入模式]shift+space -> ctrl+a:按升序排列行
inoremap <S-Space><C-a> <Esc>:sort!<CR>
" [插入模式]shift+space -> ctrl+x:删除重复行（需要选中内容）
inoremap <S-Space><C-x> <Esc>:sort u<CR>
" [普通模式]shift+space -> ctrl+r:在只读和可写之间切换
nnoremap <silent> <S-Space><C-r> :if &modifiable \| setl nomodifiable \| echo 'Current buffer is set readonly complete ' \| else \| setl modifiable \| echo 'Current buffer is cancel readonly complete ' \| endif<CR>
" [普通模式]shift+space -> z:禅模式
nnoremap <silent> <S-Space>z :call <SID>enterZenMode()<CR>
" [普通模式]shift+space -> ctrl+m:在深色主题和浅色主题之间切换
nnoremap <silent> <S-Space><C-m> :if (g_i_colorflg == 1) \| exec 'source ' . g:g_s_rcfilepath . '/vimconf/colors/lch-light.vim' \| else \| exec 'source ' . g:g_s_rcfilepath . '/vimconf/colors/lch-dark.vim' \| endif<CR>
" [普通模式]\\\mg sj sc -> 切换字体
nnoremap <silent> <leader><leader><leader>mg :call <SID>setFontMSGothic()<CR>
nnoremap <silent> <leader><leader><leader>sj :call <SID>setFontSarasaGothicJ()<CR>
nnoremap <silent> <leader><leader><leader>sc :call <SID>setFontSarasaGothicSC()<CR>

function! s:enterZenMode()
  leftabove vnew
  wincmd l
  execute "vertical resize " . ((winwidth(0) * 2) - 40)
  "hi VertSplit guifg=bg guibg=bg
  hi NonText guifg=bg
endfunction

function! s:setFontMSGothic()
  if has('gui_running')
    set guifont=ＭＳ_ゴシック:h12:cANSI:qDRAFT,MS_Gothic:h12:cANSI:qDRAFT
    set guifontwide=ＭＳ_ゴシック:h12:cSHIFTJIS:qDRAFT,MS_Gothic:h12:cSHIFTJIS:qDRAFT
  endif
endfunction

function! s:setFontSarasaGothicJ()
  if has('gui_running')
    set guifont=更紗等幅ゴシック_J_Nerd_Font_light:h12:cANSI:qDRAFT
    set guifontwide=更紗等幅ゴシック_J_Nerd_Font_light:h12:cSHIFTJIS:qDRAFT
  endif
endfunction

function! s:setFontSarasaGothicSC()
  if has('gui_running')
    set guifont=等距更纱黑体_SC_Nerd_Font_light:h12:cANSI:qDRAFT
    set guifontwide=等距更纱黑体_SC_Nerd_Font_light:h12:cGB2312:qDRAFT
  endif
endfunction
