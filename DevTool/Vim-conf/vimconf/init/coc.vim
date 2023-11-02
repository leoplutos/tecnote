scriptencoding utf-8
"coc.vim
"
"-----------------------------------------------"
"               coc.nvim设置                    "
"-----------------------------------------------"
"https://github.com/neoclide/coc.nvim
"在使用之前需要去插件路径下编译安装
"cd %USERPROFILE%\vimconf\pack\vendor\opt\coc.nvim
"npm ci

"根据OS设定Node命令，coc-settings.json路径，coc插件路径
if (g:g_i_osflg == 1 || g:g_i_osflg == 2 || g:g_i_osflg == 3)
  let g:coc_node_path = 'D:/Tools/WorkTool/NodeJs/node-v18.17.1-win-x64/node.exe'
  let g:coc_config_home = expand('~/vimconf/coc_config')
  let g:coc_data_home = 'D:/Tools/WorkTool/NodeJs/node-v18.17.1-win-x64/coc_extension_data'
else
  let g:coc_node_path = '/usr/bin/node'
  let g:coc_config_home = expand('~/work/lch/rc/vimrc/vimconf/coc_config')
  let g:coc_data_home = expand('~/work/lch/tool/coc_extension_data')
endif

"加载coc.nvim
packadd coc.nvim

"设置内容
set nobackup
set nowritebackup
set ambiwidth=single
set updatetime=100
set signcolumn=yes

"使用<Ctrl+j><Ctrl+k>选择智能提示
inoremap <silent><expr> <C-j>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<C-j>" :
      \ coc#refresh()
inoremap <expr><C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
"使用回车确定智能提示
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
"Ctrl+i显示智能提示
inoremap <silent><expr> <C-i> coc#refresh()


nnoremap <silent> <Space>gd <Plug>(coc-definition)
nnoremap <silent> <Space>gt <Plug>(coc-type-definition)
nnoremap <silent> <Space>gi <Plug>(coc-implementation)
nnoremap <silent> <Space>gr <Plug>(coc-references)
xnoremap <Space>cs  <Plug>(coc-codeaction-selected)
nnoremap <Space>cs  <Plug>(coc-codeaction-selected)
nnoremap <Space>cc  <Plug>(coc-codeaction-cursor)
nnoremap <Space>cs  <Plug>(coc-codeaction-source)
nnoremap <silent> <Space>cr <Plug>(coc-codeaction-refactor)
xnoremap <silent> <Space>rs  <Plug>(coc-codeaction-refactor-selected)
nnoremap <silent> <Space>rs  <Plug>(coc-codeaction-refactor-selected)
nnoremap <Space>cl  <Plug>(coc-codelens-action)
nnoremap <Space>fc  <Plug>(coc-fix-current)
nnoremap <silent> <Space>gn <Plug>(coc-diagnostic-next)
nnoremap <silent> <Space>gp <Plug>(coc-diagnostic-prev)
" Search workspace symbols
nnoremap <silent><nowait> <Space>gS  :<C-u>CocList -I symbols<cr>
nnoremap <silent> <C-s> <Plug>(coc-range-select)
xnoremap <silent> <C-s> <Plug>(coc-range-select)
" Show all diagnostics
nnoremap <silent><nowait> <Space>q  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <Space>le  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <Space>lc  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <Space>lo  :<C-u>CocList outline<cr>
" Do default action for next item
nnoremap <silent><nowait> <Space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <Space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <Space>p  :<C-u>CocListResume<CR>
nnoremap <silent> <Space>h :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
nnoremap <Space>rn <Plug>(coc-rename)
nnoremap <F2> <Plug>(coc-rename)
xnoremap <Space>fr  <Plug>(coc-format-selected)
nnoremap <Space>fr  <Plug>(coc-format-selected)

xnoremap if <Plug>(coc-funcobj-i)
onoremap if <Plug>(coc-funcobj-i)
xnoremap af <Plug>(coc-funcobj-a)
onoremap af <Plug>(coc-funcobj-a)
xnoremap ic <Plug>(coc-classobj-i)
onoremap ic <Plug>(coc-classobj-i)
xnoremap ac <Plug>(coc-classobj-a)
onoremap ac <Plug>(coc-classobj-a)

autocmd CursorHold * silent call CocActionAsync('highlight')
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  " autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

command! -nargs=0 Format :call CocActionAsync('format')
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"高亮设定
hi clear CocFloating
hi! link CocFloating FinderNormal
hi clear CocFloatingBorder
hi! link CocFloatingBorder FinderBorder


