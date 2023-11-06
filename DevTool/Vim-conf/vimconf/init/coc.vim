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
  if (g:g_nvim_flg == 0 && g:g_i_osflg == 1)
    "Windows-Gvim下的设定，因为ambiwidth=single的问题，这里不用NerdFont（这里的设定会覆盖coc-settings.json）
    let g:coc_user_config = {}
    let g:coc_user_config['diagnostic.virtualTextPrefix'] = ' -> '
    let g:coc_user_config['diagnostic.errorSign'] = '❌'
    let g:coc_user_config['diagnostic.warningSign'] = '🆖'
    let g:coc_user_config['diagnostic.infoSign'] = '❗'
    let g:coc_user_config['diagnostic.hintSign'] = '🗝'
    let g:coc_user_config['list.indicator'] = ' -> '
  endif
else
  let g:coc_node_path = '/usr/bin/node'
  let g:coc_config_home = expand('~/work/lch/rc/vimrc/vimconf/coc_config')
  let g:coc_data_home = expand('~/work/lch/tool/coc_extension_data')
endif
"let g:coc_node_args = ['--nolazy', '--inspect-brk=6045']
"自动安装的插件
let g:coc_global_extensions = ['coc-explorer', 'coc-snippets']

"加载coc.nvim
packadd coc.nvim

"设置内容
set nobackup
set nowritebackup
set ambiwidth=single
set updatetime=300
set signcolumn=yes
"设定tags
set tagfunc=CocTagFunc
"设定文件类型绑定
let g:coc_filetype_map = {
    \ 'pc': 'c',
    \ 'javascript.jsx': 'javascriptreact',
    \ 'typescript.jsx': 'typescriptreact',
    \ 'typescript.tsx': 'typescriptreact',
    \ 'tex': 'latex',
\}
"let g:coc_status_error_sign = ''
"let g:coc_status_warning_sign = ''

"使用<Ctrl+j><Ctrl+k>选择补全菜单
inoremap <silent><expr> <C-j>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<C-j>" :
      \ coc#refresh()
inoremap <expr><C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
"使用回车确定补全菜单
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"TAB支持选择补全菜单和Snippet
"inoremap <silent><expr> <TAB>
"  \ coc#pum#visible() ? coc#_select_confirm() :
"  \ coc#expandableOrJumpable() ?
"  \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"  \ CheckBackspace() ? "\<TAB>" :
"  \ coc#refresh()
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
"TAB和Shift-TAB补全代码段
let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<s-tab>'
"Ctrl+i显示智能提示
inoremap <C-i> <Tab>
"inoremap <silent><expr> <C-i> coc#refresh()

nmap <silent> <Space>gd <Plug>(coc-definition)
nmap <silent> <Space>gt <Plug>(coc-type-definition)
nmap <silent> <Space>gi <Plug>(coc-implementation)
nmap <silent> <Space>gr <Plug>(coc-references)
nnoremap <silent> <Space>ic :call CocAction('showIncomingCalls')<CR>
nnoremap <silent> <Space>oc :call CocAction('showOutgoingCalls')<CR>
xmap <Space>cs  <Plug>(coc-codeaction-selected)
nmap <Space>cs  <Plug>(coc-codeaction-selected)
nmap <Space>cc  <Plug>(coc-codeaction-cursor)
nmap <Space>cs  <Plug>(coc-codeaction-source)
nmap <silent> <Space>cr <Plug>(coc-codeaction-refactor)
xmap <silent> <Space>rs  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <Space>rs  <Plug>(coc-codeaction-refactor-selected)
nmap <Space>cl  <Plug>(coc-codelens-action)
nmap <Space>fc  <Plug>(coc-fix-current)
nmap <silent> <Space>gn <Plug>(coc-diagnostic-next)
nmap <silent> <Space>gp <Plug>(coc-diagnostic-prev)
" Search workspace symbols
nmap <silent><nowait> <Space>gS  :<C-u>CocList -I symbols<cr>
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
" Show all diagnostics
nnoremap <silent><nowait> <Space>q  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <Space>le  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <Space>lc  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <Space>lo  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <F1> :call ToggleOutline()<CR>
function! ToggleOutline() abort
  let winid = coc#window#find('cocViewId', 'OUTLINE')
  if winid == -1
    call CocActionAsync('showOutline', 1)
  else
    call coc#window#close(winid)
  endif
endfunction
nnoremap <silent><nowait> <Space>gs  :<C-u>CocList outline<cr>
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
nmap <Space>rn <Plug>(coc-rename)
nmap <F2> <Plug>(coc-rename)
xmap <Space>fr  <Plug>(coc-format-selected)
nmap <Space>fr  <Plug>(coc-format-selected)

xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
"开启/关闭InlayHint
nnoremap <Space>ih :CocCommand document.toggleInlayHint<CR>
nnoremap <C-UP> :CocCommand document.jumpToPrevSymbol<CR>
nnoremap <C-Down> :CocCommand document.jumpToNextSymbol<CR>

augroup MyCocGroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  " autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  autocmd CursorHold * silent call CocActionAsync('highlight')
  "java-debug设置
  autocmd FileType java nnoremap <F5> <Cmd>call JavaStartDebug()<CR>
augroup end
"Java调试启动回调
function! JavaStartDebugCallback(err, port)
  execute "cexpr! 'Java debug started on port: " . a:port . "'"
  call vimspector#LaunchWithSettings({ "configuration": "Java Attach", "AdapterPort": a:port })
endfunction
"Java调试启动
"运行前需要在终端运行
"--ant工程
"cd D:\WorkSpace\Java\JavaBatchProject\build_result
"java -Xdebug -Xrunjdwp:server=y,transport=dt_socket,address=5005,suspend=y -jar JavaBatchProject-20231019.jar
"--maven工程
"cd D:\WorkSpace\Java\JavaMavenBatProject
"SET MAVEN_DEBUG_ADDRESS=5005
"mvnDebug exec:java -Dexec.mainClass="my.mavenbatsample.App" -Dexec.args="arg0 arg1 arg2"
"--maven工程运行test
"mvn -Dmaven.surefire.debug="-agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=localhost:5005" test
function JavaStartDebug()
  call CocActionAsync('runCommand', 'vscode.java.startDebugSession', function('JavaStartDebugCallback'))
endfunction

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
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"给状态栏设置的调用函数（返回LSP状态显示到状态栏）
function! GetLspStatus() abort
  let lspStatus = '❌'
  if exists('g:coc_service_initialized')
    if (g:coc_service_initialized == 1)
      let cocLspServers = CocAction('services')
      for element in cocLspServers
        "{'id': 'pyright', 'state': 'running', 'languageIds': ['python']}
        if (index(element['languageIds'], &ft) >= 0 && element['state'] == 'running')
          let lspStatus = 'running'
        endif
      endfor
    endif
  endif
  return lspStatus
endfunction

"-----------------------------------------------"
"            coc-explorer设置                   "
"-----------------------------------------------"
"coc-explorer快捷键绑定
nnoremap <Leader>e <Cmd>CocCommand explorer --toggle --sources=buffer+,file+ --root-strategies workspace<CR>
"进入路径的时候自动打开coc-explorer
augroup MyCocExplorerGroup
  autocmd!
  autocmd VimEnter * sil! au! FileExplorer *
  autocmd BufEnter * let d = expand('%') | if isdirectory(d) | silent! bd | exe 'CocCommand explorer' | endif
augroup END

"-----------------------------------------------"
"                    高亮设定                   "
"-----------------------------------------------"
hi clear CocFloating
hi! link CocFloating FinderNormal
hi clear CocFloatThumb
hi! link CocFloatThumb Visual
hi clear CocFloatSbar
hi! link CocFloatSbar FinderNormal
hi clear CocFloatingBorder
hi! link CocFloatingBorder FinderBorder
hi clear CocFloatDividingLine
hi! link CocFloatDividingLine FinderDividingLine
hi clear CocFloatActive
"hi! link CocFloatActive PmenuSelBg
hi clear CocPumSearch
hi! link CocPumSearch PmenuMatch
hi clear CocPumShortcut
hi! link CocPumShortcut Regexp
hi clear CocErrorFloat
hi! link CocErrorFloat LspErrorFloatText
hi clear CocWarningFloat
hi! link CocWarningFloat LspWarningFloatText
hi clear CocInfoFloat
hi! link CocInfoFloat LspInformationFloatText
hi clear CocHintFloat
hi! link CocHintFloat LspHintFloatText
hi clear CocMenuSel
hi! link CocMenuSel PmenuSelBg
hi clear CocInlayHint
hi! link CocInlayHint lspInlayHintsType
hi clear CocHighlightText
hi! link CocHighlightText lspReference
hi clear CocStrikeThrough
hi! link CocStrikeThrough PmenuDeprecated
hi clear CocFadeOut
hi! link CocFadeOut SpecialKey
hi clear CocErrorSign
hi! link CocErrorSign LspErrorText
hi clear CocWarningSign
hi! link CocWarningSign LspWarningText
hi clear CocInfoSign
hi! link CocInfoSign LspInformationText
hi clear CocHintSign
hi! link CocHintSign LspHintText
hi clear CocErrorVirtualText
hi! link CocErrorVirtualText LspErrorVirtualText
hi clear CocWarningVirtualText
hi! link CocWarningVirtualText LspWarningVirtualText
hi clear CocInfoVirtualText
hi! link CocInfoVirtualText LspInformationVirtualText
hi clear CocHintVirtualText
hi! link CocHintVirtualText LspHintVirtualText
hi clear CocErrorHighlight
hi! link CocErrorHighlight LspErrorHighlight
hi clear CocWarningHighlight
hi! link CocWarningHighlight LspWarningHighlight
hi clear CocInfoHighlight
hi! link CocInfoHighlight LspInformationHighlight
hi clear CocHintHighlight
hi! link CocHintHighlight LspHintHighlight
hi clear CocMarkdownHeader
hi! link CocMarkdownHeader StartMenuHeader

"Semantic高亮
":CocCommand semanticTokens.checkCurrent
"hi clear CocUnusedHighlight
hi clear CocSemUnKnownInvalid
hi clear CocSemUnKnownEndOfStream
hi clear CocSemUnKnownNewLine
hi clear CocSemUnKnownIndent
hi clear CocSemUnKnownDedent
hi clear CocSemString
hi clear CocSemNumber
hi clear CocSemUnKnownIdentifier
hi clear CocSemKeyword
hi clear CocSemOperator
hi clear CocSemColon
hi clear CocSemSemicolon
hi clear CocSemComma
hi clear CocSemParenthesis
hi clear CocSemCloseParenthesis
hi clear CocSemBracket
hi clear CocSemCloseBracket
hi clear CocSemCurlyBrace
hi clear CocSemCloseCurlyBrace
hi clear CocSemEllipsis
hi clear CocSemDot
hi clear CocSemArrow
hi clear CocSemBacktick
hi clear CocSemAnd
hi clear CocSemAs
hi clear CocSemAssert
hi clear CocSemAsync
hi clear CocSemAwait
hi clear CocSemBreak
hi clear CocSemCase
hi clear CocSemClass
hi clear CocSemContinue
hi clear CocSemDebug
hi clear CocSemDef
hi clear CocSemDel
hi clear CocSemElif
hi clear CocSemElse
hi clear CocSemExcept
hi clear CocSemFalse
hi clear CocSemFinally
hi clear CocSemFor
hi clear CocSemFrom
hi clear CocSemGlobal
hi clear CocSemIf
hi clear CocSemImport
hi clear CocSemIn
hi clear CocSemIs
hi clear CocSemLambda
hi clear CocSemMatch
hi clear CocSemNone
hi clear CocSemNonlocal
hi clear CocSemNot
hi clear CocSemOr
hi clear CocSemPass
hi clear CocSemRaise
hi clear CocSemReturn
hi clear CocSemTrue
hi clear CocSemTry
hi clear CocSemType
hi clear CocSemWhile
hi clear CocSemWith
hi clear CocSemYield
hi clear CocSemAlias
hi clear CocSemConst
hi clear CocSemModule
hi clear CocSemMethod
hi clear CocSemFunction
hi clear CocSemProperty
hi clear CocSemVariable
hi clear CocSemDecorator
hi clear CocSemParameter
hi clear CocSemTypeParameter
hi clear CocSemSelfParameter
hi clear CocSemClsParameter
hi clear CocSemMagicFunction
hi clear CocSemTypeAnnotation

"hi! link CocUnusedHighlight Number
hi! link CocSemUnKnownInvalid Comment
hi! link CocSemUnKnownEndOfStream Comment
hi! link CocSemUnKnownNewLine Comment
hi! link CocSemUnKnownIndent Comment
hi! link CocSemUnKnownDedent Comment
hi! link CocSemString String
hi! link CocSemNumber Number
hi! link CocSemUnKnownIdentifier Comment
hi! link CocSemKeyword Keyword
hi! link CocSemOperator Operator
hi! link CocSemColon Special
hi! link CocSemSemicolon Special
hi! link CocSemComma Special
hi! link CocSemParenthesis Special
hi! link CocSemCloseParenthesis Special
hi! link CocSemBracket Special
hi! link CocSemCloseBracket Special
hi! link CocSemCurlyBrace Special
hi! link CocSemCloseCurlyBrace Special
hi! link CocSemEllipsis Special
hi! link CocSemDot Special
hi! link CocSemArrow Special
hi! link CocSemBacktick Special
hi! link CocSemAnd Statement
hi! link CocSemAs Statement
hi! link CocSemAssert Statement
hi! link CocSemAsync Statement
hi! link CocSemAwait Statement
hi! link CocSemBreak Statement
hi! link CocSemCase Statement
hi! link CocSemClass Struct
hi! link CocSemContinue Statement
hi! link CocSemDebug Debug
hi! link CocSemDef Statement
hi! link CocSemDel Statement
hi! link CocSemElif Statement
hi! link CocSemElse Statement
hi! link CocSemExcept Statement
hi! link CocSemFalse Special
hi! link CocSemFinally Statement
hi! link CocSemFor Statement
hi! link CocSemFrom Statement
hi! link CocSemGlobal Statement
hi! link CocSemIf Statement
hi! link CocSemImport Statement
hi! link CocSemIn Statement
hi! link CocSemIs Statement
hi! link CocSemLambda Statement
hi! link CocSemMatch Statement
hi! link CocSemNone Special
hi! link CocSemNonlocal Statement
hi! link CocSemNot Statement
hi! link CocSemOr Statement
hi! link CocSemPass Statement
hi! link CocSemRaise Statement
hi! link CocSemReturn Statement
hi! link CocSemTrue Special
hi! link CocSemTry Statement
hi! link CocSemType Statement
hi! link CocSemWhile Statement
hi! link CocSemWith Statement
hi! link CocSemYield Statement
hi! link CocSemAlias Statement
hi! link CocSemConst Constant
hi! link CocSemModule Property
hi! link CocSemMethod Function
hi! link CocSemFunction Function
hi! link CocSemProperty Property
hi! link CocSemVariable PmenuFg
hi! link CocSemDecorator Annotation
hi! link CocSemParameter Parameter
hi! link CocSemTypeParameter Parameter
hi! link CocSemSelfParameter Parameter
hi! link CocSemClsParameter Parameter
hi! link CocSemMagicFunction Function
hi! link CocSemTypeAnnotation Lifetime

"coc-explorer高亮
hi clear CocExplorerDiagnosticError
hi! link CocExplorerDiagnosticError LspErrorFloatText
hi clear CocExplorerDiagnosticWarning
hi! link CocExplorerDiagnosticWarning LspWarningFloatText
