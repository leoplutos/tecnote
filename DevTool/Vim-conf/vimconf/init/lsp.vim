scriptencoding utf-8
"lsp.vim

"-----------------------------------------------"
"               vim-lsp设置                     "
"-----------------------------------------------"

if (g:g_i_osflg == 1 || g:g_i_osflg == 2)

  function! s:on_lsp_buffer_enabled() abort
    "if (g:g_use_lsp == 2)
      "因为jedi安装后出现问题，所以python时候默认的补全
    "else
      setlocal omnifunc=lsp#complete
    "endif
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nnoremap <buffer> <Space>lo :LspDocumentDiagnostics<CR><C-w>w
    nnoremap <buffer> <Space>lc :lclose<CR>
    nnoremap <buffer> <C-j> :lnext<cr>
    nnoremap <buffer> <C-k> :lprevious<cr>
    nnoremap <buffer> <Space>ca <plug>(lsp-code-action-float)
    nnoremap <buffer> <Space>gd <plug>(lsp-definition)
    nnoremap <buffer> <Space>gs <plug>(lsp-document-symbol-search)
    nnoremap <buffer> <Space>gS <plug>(lsp-workspace-symbol-search)
    nnoremap <buffer> <Space>gr <plug>(lsp-references)
    nnoremap <buffer> <Space>gi <plug>(lsp-implementation)
    nnoremap <buffer> <Space>gt <plug>(lsp-type-definition)
    nnoremap <buffer> <Space>rn <plug>(lsp-rename)
    nnoremap <buffer> <F2> <plug>(lsp-rename)
    nnoremap <buffer> <Space>[g <plug>(lsp-previous-diagnostic)
    nnoremap <buffer> <Space>]g <plug>(lsp-next-diagnostic)
    nnoremap <buffer> <Space>h  <plug>(lsp-hover-float)
    nnoremap <buffer> <C-UP>    <plug>(lsp-previous-reference)
    nnoremap <buffer> <C-Down>  <plug>(lsp-next-reference)
    nnoremap <buffer> <Space>nd <plug>(lsp-next-diagnostic)
    nnoremap <buffer> <Space>pd <plug>(lsp-previous-diagnostic)
    "nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    "nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    "autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    let g:lsp_log_verbose = 0
    "let g:lsp_log_file = expand('~/vim-lsp.log')
    let g:lsp_log_file = ''

    hi clear Structure
    hi link Structure Statement
    hi clear LspSemanticNamespace
    hi link LspSemanticNamespace Property
    hi clear LspSemanticType
    hi link LspSemanticType Struct
    hi clear LspSemanticClass
    hi link LspSemanticClass Struct
    hi clear LspSemanticEnum
    hi link LspSemanticEnum Struct
    hi clear LspSemanticInterface
    hi link LspSemanticInterface Interface
    hi clear LspSemanticStruct
    hi link LspSemanticStruct Struct
    hi clear LspSemanticTypeParameter
    hi link LspSemanticTypeParameter Parameter
    hi clear LspSemanticParameter
    hi link LspSemanticParameter Parameter
    hi clear LspSemanticVariable
    hi link LspSemanticVariable Normal
    hi clear LspSemanticProperty
    hi link LspSemanticProperty Property
    hi clear LspSemanticEnumMember
    hi link LspSemanticEnumMember EnumMember
    hi clear LspSemanticEvents
    hi link LspSemanticEvents Struct
    hi clear LspSemanticFunction
    hi link LspSemanticFunction Function
    hi clear LspSemanticMethod
    hi link LspSemanticMethod Function
    hi clear LspSemanticKeyword
    hi link LspSemanticKeyword Statement
    hi clear LspSemanticModifier
    hi link LspSemanticModifier Statement
    hi clear LspSemanticComment
    hi link LspSemanticComment Comment
    hi clear LspSemanticString
    hi link LspSemanticString String
    hi clear LspSemanticNumber
    hi link LspSemanticNumber Number
    hi clear LspSemanticRegexp
    hi link LspSemanticRegexp Regexp
    hi clear LspSemanticOperator
    hi link LspSemanticOperator Special
    hi clear LspSemanticMacro
    hi link LspSemanticMacro Macro
    hi clear LspSemanticGlobalScopeMacro
    hi link LspSemanticGlobalScopeMacro Macro
    hi clear LspSemanticDeclarationGlobalScopeMacro
    hi link LspSemanticDeclarationGlobalScopeMacro Macro

  endfunction

  augroup lsp_install
    autocmd!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
  augroup END

  " 使用GetProjectRoot()函数找到跟目录
  let g:g_s_projectrootpath = GetProjectRoot()

  if (g:g_use_lsp == 1)
    "使用LSP 1：C/C++(clangd)

    if executable('clangd')
        au User lsp_setup call lsp#register_server({
            \ 'name': 'clangd',
            \ 'cmd': {server_info->[
            \     'clangd',
            \     '--background-index',
            \     '--clang-tidy',
            "\     '--compile-commands-dir=build',
            \     '-j=12',
            \     '--all-scopes-completion',
            \     '--completion-style=detailed',
            \     '--header-insertion=iwyu',
            \     '--pch-storage=memory',
            \     '--fallback-style=Google',
            \     '--function-arg-placeholders',
            \     '--enable-config',
            \     '--query-driver=gcc',
            \     ]},
            \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.root'))},
            \ 'whitelist': ['c', 'pc', 'cpp', 'objc', 'objcpp'],
            \ })
    endif

  elseif (g:g_use_lsp == 2)
    "使用LSP 2：Python(pylsp)

    if executable('pylsp')
        "设定参数参照这里
        "https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
        au User lsp_setup call lsp#register_server({
            \ 'name': 'pylsp',
            \ 'cmd': {server_info->['pylsp']},
            \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.root'))},
            \ 'whitelist': ['python'],
            \ 'workspace_config': {'pylsp': {
            \     'configurationSources': ['flake8'],
            \     'plugins': {
            \         'flake8': {'enabled': v:false},
            \         'pylint': {'enabled': v:false},
            \         'pycodestyle': {'enabled': v:false},
            \         'jedi_definition': {
            \             'follow_imports': v:true,
            \             'follow_builtin_imports': v:true
            \         },
            \     }
            \ }}
            \ })
    endif

  elseif (g:g_use_lsp == 3)
    "使用LSP 3：Java(eclipse.jdt.ls)

    if executable('java') && filereadable('D:/Tools/WorkTool/Java/lsp/jdt-language-server-1.26.0-202307271613/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar')
        au User lsp_setup call lsp#register_server({
            \ 'name': 'eclipse.jdt.ls',
            \ 'cmd': {server_info->[
            \     'java',
            \     '-Declipse.application=org.eclipse.jdt.ls.core.id1',
            \     '-Dosgi.bundles.defaultStartLevel=4',
            \     '-Declipse.product=org.eclipse.jdt.ls.core.product',
            \     '-Dlog.level=ALL',
           "\     '-noverify',
            \     '-Dfile.encoding=UTF-8',
            \     '-Xmx1G',
            \     '--add-modules=ALL-SYSTEM',
            \     '--add-opens',
            \     'java.base/java.util=ALL-UNNAMED',
            \     '--add-opens',
            \     'java.base/java.lang=ALL-UNNAMED',
            \     '-jar',
           "\     expand('~/lsp/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_1.5.600.v20191014-2022.jar'),
            \     'D:/Tools/WorkTool/Java/lsp/jdt-language-server-1.26.0-202307271613/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar',
            \     '-configuration',
           "\     expand('~/lsp/eclipse.jdt.ls/config_win'),
            \     'D:/Tools/WorkTool/Java/lsp/jdt-language-server-1.26.0-202307271613/config_win',
            \     '-data',
           "\     getcwd()
           "\     g:g_s_projectrootpath.'/.lsp'
            \     'D:/WorkSpace/Java',
            \ ]},
            \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.root'))},
            \ 'whitelist': ['java'],
            \ })
    endif

  elseif (g:g_use_lsp == 4)
    "使用LSP 4：Rust(rust-analyzer)

    if executable('rustup')
        au User lsp_setup call lsp#register_server({
            \ 'name': 'rust-analyzer',
            \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rust-analyzer']},
            \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.root'))},
            \ 'allowlist': ['rust'],
            \ })
    endif

  elseif (g:g_use_lsp == 5)
    "使用LSP 5：Go(gopls)

    if executable('gopls')
        au User lsp_setup call lsp#register_server({
            \ 'name': 'gopls',
            \ 'cmd': {server_info->['gopls', '-remote=auto']},
            \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.root'))},
            \ 'allowlist': ['go', 'gomod', 'gohtmltmpl', 'gotexttmpl'],
            \ 'workspace_config': {'gopls': {
            \     'analyses': {
            \         'nilness': v:true,
            \         'unusedwrite': v:true,
            \         'unusedparams': v:true,
            \     },
            \     'ui.diagnostic.annotations': {
            \         'bounds': v:true,
            \         'inline': v:true,
            \         'escape': v:true,
            \     },
            \     'ui.diagnostic.staticcheck': v:true,
            \     'ui.semanticTokens': v:true,
            \ }}
            \ })
        "autocmd BufWritePre *.go
        "    \ call execute('LspDocumentFormatSync') |
        "    \ call execute('LspCodeActionSync source.organizeImports')
    endif

  elseif (g:g_use_lsp == 6)
    "使用LSP 6：Vue(vls)

    if executable('vls')
        au User lsp_setup call lsp#register_server({
            \ 'name': 'vls',
            \ 'cmd': {server_info->['vls.cmd', '--stdio']},
            \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.root'))},
            \ 'allowlist': ['vue'],
            \ })
    endif

  endif

  "https://github.com/prabirshrestha/vim-lsp
  "https://github.com/prabirshrestha/asyncomplete.vim
  "https://github.com/prabirshrestha/asyncomplete-lsp.vim
  "加载vim-lsp
  packadd vim-lsp
  "if (g:g_use_lsp == 2)
  "  "因为jedi安装后出现问题，所以python时候默认的补全
  "  exec 'source ' . g:g_s_rcfilepath . '/vimconf/init/apc.vim'
  "  let g:apc_enable_ft = {'*':1}
  "else
    packadd asyncomplete.vim
    packadd asyncomplete-lsp.vim
  "endif

  "vim-lsp
  "let g:lsp_diagnostics_float_cursor = 1
  let g:lsp_inlay_hints_enabled = 1
  let g:lsp_semantic_enabled = 1
  let g:lsp_completion_documentation_delay = 0
  let g:lsp_completion_resolve_timeout = 0
  if has('gui_running')
    let g:lsp_diagnostics_signs_enabled = 1
    let g:lsp_diagnostics_signs_error = {"text": "❌"}
    let g:lsp_diagnostics_signs_warning = {"text": "🆖"}
    let g:lsp_diagnostics_signs_information = {"text": "❗"}
    let g:lsp_diagnostics_signs_hint = {"text": "❓"}
    let g:lsp_document_code_action_signs_enabled = 1
    let g:lsp_document_code_action_signs_hint = {"text": "💡"}
    let g:lsp_diagnostics_virtual_text_prefix = " > "
  endif

  "asyncomplete.vim
  let g:asyncomplete_auto_popup = 1
  let g:asyncomplete_auto_completeopt = 1
  let g:asyncomplete_popup_delay = 200
  let g:asyncomplete_matchfuzzy = 1
  "let g:asyncomplete_log_file = expand('~/asyncomplete.log')

  "TAB键选择补全内容，回车键选择
  inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
  inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

  "给状态栏设置的调用函数（返回LSP状态显示到状态栏）
  function! GetLspStatus() abort
    let lspServerName = ''
    if (&ft=='c') || (&ft=='pc') || (&ft=='cpp') || (&ft=='objc') || (&ft=='objcpp')
      let lspServerName = 'clangd'
    elseif (&ft=='python')
      let lspServerName = 'pylsp'
    elseif (&ft=='java')
      let lspServerName = 'eclipse.jdt.ls'
    elseif (&ft=='rust')
      let lspServerName = 'rust-analyzer'
    elseif (&ft=='go')
      let lspServerName = 'gopls'
    elseif (&ft=='vue')
      let lspServerName = 'vls'
    endif
    let lspStatus = lsp#get_server_status(lspServerName)
    if (lspStatus == '') || (lspStatus == 'unknown server')
      let lspStatus = '❌'
    endif
    return lspStatus
  endfunction

endif
