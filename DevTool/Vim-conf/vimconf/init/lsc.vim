scriptencoding utf-8
"lsc.vim

"-----------------------------------------------"
"               vim-lsc设置                     "
"-----------------------------------------------"

if (g:g_i_osflg == 1 || g:g_i_osflg == 2)

  "加载vim-lsc
  "https://github.com/natebosch/vim-lsc
  packadd vim-lsc

  "使用neovim时，抑制来自此插件的错误消息
  if has('nvim')
    set shortmess-=F
  endif

  "let g:lsc_auto_completeopt='menu,menuone,noinsert,noselect'
  let g:lsc_auto_completeopt='menu,menuone,noselect'
  let g:lsc_autocomplete_length = 2
  "let g:lsc_popup_syntax = v:true
  "set omnifunc=lsc#complete#complete
  let g:lsc_block_complete_triggers = ['{', '<']

  "TAB键选择补全内容，回车键选择
  inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
  inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

  "给状态栏设置的调用函数（返回LSP状态显示到状态栏）
  function! GetLspStatus() abort
      let lspStatus = LSCServerStatus()
      if lspStatus == ''
        let lspStatus = '❌'
      endif
      return lspStatus
  endfunction

  "未使用
  function! s:HandleStatus(method, params) abort
    let g:dart_server_status = a:params.isAnalyzing
  endfunction

  let g:lsc_server_commands = {
      \ 'c': {
          \ 'name': 'clangd',
          \ 'command': 'clangd --background-index --clang-tidy -j=12 --all-scopes-completion --completion-style=detailed --header-insertion=iwyu --pch-storage=memory --fallback-style=Google --function-arg-placeholders --enable-config --query-driver=gcc',
          \ 'enabled': v:true,
          \ 'suppress_stderr': v:true,
          \ 'message_hooks': {
          \     'initialize': {
          \         'initializationOptions': {'foo': 'bar'},
          \         'rootUri': {method, params -> lsc#uri#documentUri(GetProjectRoot())},
          \     },
          \ },
          \ 'notifications': {
          \     '$/analyzerStatus': function('<SID>HandleStatus'),
          \ },
          \ 'workspace_config': {
          \     'clippy_preference': 'on',
          \ },
      \},
      \ 'python': {
          \ 'name': 'pylsp',
          \ 'command': 'pylsp',
          \ 'suppress_stderr': v:true,
          \ 'message_hooks': {
          \     'initialize': {
          \         'initializationOptions': {'foo': 'bar'},
          \         'rootUri': {method, params -> lsc#uri#documentUri(GetProjectRoot())},
          \     },
          \ },
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
      \},
      \ 'java': {
          \ 'name': 'eclipse.jdt.ls',
          \ 'command': 'java -Declipse.application=org.eclipse.jdt.ls.core.id1 -Dosgi.bundles.defaultStartLevel=4 -Declipse.product=org.eclipse.jdt.ls.core.product -Dlog.level=ALL -Dfile.encoding=UTF-8 -Xmx1G --add-modules=ALL-SYSTEM --add-opens java.base/java.util=ALL-UNNAMED --add-opens java.base/java.lang=ALL-UNNAMED -jar D:/Tools/WorkTool/Java/lsp/jdt-language-server-1.26.0-202307271613/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar -configuration D:/Tools/WorkTool/Java/lsp/jdt-language-server-1.26.0-202307271613/config_win -data D:/WorkSpace/Java',
          \ 'suppress_stderr': v:true,
          \ 'message_hooks': {
          \     'initialize': {
          \         'initializationOptions': {'foo': 'bar'},
          \         'rootUri': {method, params -> lsc#uri#documentUri(GetProjectRoot())},
          \     },
          \ },
          \ 'workspace_config': {'eclipse.jdt.ls': {
          \     'clippy_preference': 'on',
          \ }}
      \},
      \ 'rust': {
          \ 'name': 'rust-analyzer',
          "\ 'command': 'rustup run stable rust-analyzer',
          \ 'command': 'rust-analyzer',
          \ 'suppress_stderr': v:true,
          \ 'message_hooks': {
          \     'initialize': {
          \         'initializationOptions': {'foo': 'bar'},
          \         'rootUri': {method, params -> lsc#uri#documentUri(GetProjectRoot())},
          \     },
          \ },
          \ 'workspace_config': {'rust-analyzer': {
          \     'clippy_preference': 'on',
          \ }}
      \},
      \ 'go': {
          \ 'name': 'gopls',
          \ 'command': 'gopls -remote=auto',
          \ 'suppress_stderr': v:true,
          \ 'message_hooks': {
          \     'initialize': {
          \         'initializationOptions': {'foo': 'bar'},
          \         'rootUri': {method, params -> lsc#uri#documentUri(GetProjectRoot())},
          \     },
          \ },
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
      \},
      \ 'vue': {
          \ 'command': 'vls.cmd --stdio',
          \ 'suppress_stderr': v:true,
          \ 'message_hooks': {
          \     'initialize': {
          \         'initializationOptions': {'foo': 'bar'},
          \         'rootUri': {method, params -> lsc#uri#documentUri(GetProjectRoot())},
          \     },
          \ },
      \},
  \}

  "快捷键映射
  let g:lsc_auto_map = {
      \ 'GoToDefinition': '<Space>gd',
      "\ 'GoToDefinitionSplit': ['<C-W>]', '<C-W><C-]>'],
      \ 'FindReferences': '<Space>gr',
      \ 'NextReference': '<C-Down>',
      \ 'PreviousReference': '<C-UP>',
      \ 'FindImplementations': '<Space>gi',
      \ 'FindCodeActions': '<Space>ca',
      \ 'Rename': '<F2>',
      \ 'ShowHover': '<Space>h',
      \ 'DocumentSymbol': '<Space>gs',
      \ 'WorkspaceSymbol': '<Space>gS',
      \ 'SignatureHelp': '<Space>gm',
      \ 'Completion': 'completefunc',
      \}
  "nnoremap <Space>lo :LSClientAllDiagnostics<CR><C-w>w
  nnoremap <Space>lo :LSClientWindowDiagnostics<CR><C-w>w
  "nnoremap <Space>lc :cclose<CR>
  nnoremap <Space>lc :lclose<CR>

  "高亮设置
  hi clear lscReference
  hi link lscReference lspReference
  hi clear lscDiagnosticError
  hi link lscDiagnosticError LspErrorHighlight
  hi clear lscDiagnosticWarning
  hi link lscDiagnosticWarning LspWarningHighlight
  hi clear lscDiagnosticInfo
  hi link lscDiagnosticInfo LspInformationHighlight
  hi clear lscDiagnosticHint
  hi link lscDiagnosticHint LspHintHighlight
  hi clear lscCurrentParameter
  hi link lscCurrentParameter Parameter

endif
