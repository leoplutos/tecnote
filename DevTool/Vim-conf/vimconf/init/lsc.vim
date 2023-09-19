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

  "LSP命令设定
  let g:lsc_server_commands = {}

  "C/C++(clangd)设定
  "在这里下载 https://github.com/clangd/clangd/releases/
  let g:lsc_server_commands.c = {
            \ 'name': 'clangd',
            \ 'command': 'clangd --background-index --clang-tidy -j=12 --all-scopes-completion --completion-style=detailed --header-insertion=iwyu --pch-storage=memory --fallback-style=Google --function-arg-placeholders --enable-config --query-driver=gcc',
            \ 'enabled': v:true,
            \ 'suppress_stderr': v:true,
            \ 'message_hooks': {
            \     'initialize': {
            \         'initializationOptions': {},
            \         'rootUri': {method, params -> lsc#uri#documentUri(GetProjectRoot())},
            \     },
            \ },
            \ 'notifications': {
            \     '$/analyzerStatus': function('<SID>HandleStatus'),
            \ },
            \ 'workspace_config': {},
            \}
  let g:lsc_server_commands.pc = g:lsc_server_commands.c
  let g:lsc_server_commands.cpp = g:lsc_server_commands.c
  let g:lsc_server_commands.objc = g:lsc_server_commands.c
  let g:lsc_server_commands.objcpp = g:lsc_server_commands.c

  "Python(pylsp)设定
  "Windows7：使用anakin-language-server（推荐） 或者 jedi-language-server
  "    安装命令：pip install -i https://pypi.tuna.tsinghua.edu.cn/simple anakin-language-server
  "    安装命令：pip install -U jedi-language-server -i https://pypi.tuna.tsinghua.edu.cn/simple
  "Windows10以后：使用python-lsp-server
  "    安装命令：pip install -i https://pypi.tuna.tsinghua.edu.cn/simple "python-lsp-server[all]"

  if (g:g_python_lsp_type == 0)
    "0：使用pylsp
    "设定参数参照这里
    "https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md

  let g:lsc_server_commands.python = {
            \ 'name': 'pylsp',
            \ 'command': 'pylsp',
            \ 'enabled': v:true,
            \ 'suppress_stderr': v:true,
            \ 'message_hooks': {
            \     'initialize': {
            \         'initializationOptions': {},
            \         'rootUri': {method, params -> lsc#uri#documentUri(GetProjectRoot())},
            \     },
            \ },
            \ 'notifications': {
            \     '$/analyzerStatus': function('<SID>HandleStatus'),
            \ },
            \ 'workspace_config': {'pylsp': {
            "\     'configurationSources': ['flake8'],
            \     'configurationSources': ['pycodestyle'],
            \     'plugins': {
            \         'autopep8': {'enabled': v:false},
            \         'flake8': {'enabled': v:false},
            \         'pylint': {'enabled': v:false},
            \         'pycodestyle': {'enabled': v:true},
            \         'jedi': {
            \             'auto_import_modules': ['gi'],
            \             'extra_paths': ['src', 'src/com', 'com'],
            \         },
            \         'jedi_completion': {
            \             'enabled': v:true,
            \             'include_params': v:true,
            \             'include_class_objects': v:false,
            \             'include_function_objects': v:false,
            \             'fuzzy': v:false,
            \             'eager': v:false,
            \         },
            \         'jedi_definition': {
            \             'follow_imports': v:true,
            \             'follow_builtin_imports': v:true
            \         },
            \         'jedi_hover': {'enabled': v:true},
            \         'jedi_references': {'enabled': v:true},
            \         'jedi_signature_help': {'enabled': v:true},
            \         'jedi_symbolss': {'enabled': v:true},
            \     }
            \ }},
            \}

  endif

  if (g:g_python_lsp_type == 1)
    "1：使用jedi-language-server
    "设定参数参照这里
    "https://github.com/pappasam/jedi-language-server

  let g:lsc_server_commands.python = {
            \ 'name': 'jedi-language-server',
            \ 'command': 'jedi-language-server',
            \ 'enabled': v:true,
            \ 'suppress_stderr': v:true,
            \ 'message_hooks': {
            \   'initialize': { 'initializationOptions': {
            \     'codeAction': {
            \         'nameExtractVariable': 'jls_extract_var',
            \         'nameExtractFunction': 'jls_extract_def',
            \     },
            \     'completion': {
            \         'disableSnippets': v:false,
            \         'resolveEagerly': v:false,
            \         'ignorePatterns': [],
            \     },
            \     'diagnostics': {
            \         'enable': v:true,
            \         'didOpen': v:true,
            \         'didChange': v:true,
            \         'didSave': v:true,
            \     },
            \     'hover': {
            \         'enable': v:true,
            \         'disable': {},
            \     },
            \     'jediSettings': {
            \         'autoImportModules': ['gi'],
            \         'caseInsensitiveCompletion': v:true,
            \         'debug': v:false,
            \     },
            \     'markupKindPreferred': 'markdown',
            \     'workspace': {
            \         'extraPaths': ['src', 'src/com', 'com'],
            "\         'environmentPath': '/path/to/venv/bin/python',
            \         'symbols': {
            \             'ignoreFolders': ['__pycache__', 'venv'],
            "\             'maxSymbols': 20,
            \         },
            \     },
            \     },
            \     'rootUri': {method, params -> lsc#uri#documentUri(GetProjectRoot())},
            \   },
            \ },
            \ 'notifications': {
            \     '$/analyzerStatus': function('<SID>HandleStatus'),
            \ },
            \ 'workspace_config': {},
            \}

  endif

  if (g:g_python_lsp_type == 2)
    "2：使用anakin-language-server
    "设定参数参照这里
    "https://github.com/muffinmad/anakin-language-server

  let g:lsc_server_commands.python = {
            \ 'name': 'anakinls',
            \ 'command': 'anakinls',
            \ 'enabled': v:true,
            \ 'suppress_stderr': v:true,
            \ 'message_hooks': {
            \     'initialize': {
            \         'initializationOptions': {
            "\             'venv': 'path/to/virtualenv'
            \         },
            \         'rootUri': {method, params -> lsc#uri#documentUri(GetProjectRoot())},
            \     },
            \ },
            \ 'notifications': {
            \     '$/analyzerStatus': function('<SID>HandleStatus'),
            \ },
            \ 'workspace_config': {'anakinls': {
            \     'help_on_hover': v:true,
            \     'completion_fuzzy': v:false,
            \     'diagnostic_on_open': v:true,
            \     'diagnostic_on_change': v:true,
            \     'diagnostic_on_save': v:true,
            \     'pycodestyle_config': '',
            \     'mypy_enabled': v:false,
            \     'yapf_style_config': 'pep8',
            \     'jedi_settings': {
            \         'add_bracket_after_function': v:true,
            \         'auto_import_modules': ['gi'],
            \     },
            \ }},
            \}

  endif

  "Java(eclipse.jdt.ls)设定
  "在这里下载 https://download.eclipse.org/jdtls/milestones/
  let g:lsc_server_commands.java = {
            \ 'name': 'eclipse.jdt.ls',
            \ 'command': 'java -Declipse.application=org.eclipse.jdt.ls.core.id1 -Dosgi.bundles.defaultStartLevel=4 -Declipse.product=org.eclipse.jdt.ls.core.product -Dlog.level=ALL -Dfile.encoding=UTF-8 -Xmx1G --add-modules=ALL-SYSTEM --add-opens java.base/java.util=ALL-UNNAMED --add-opens java.base/java.lang=ALL-UNNAMED -jar D:/Tools/WorkTool/Java/lsp/jdt-language-server-1.26.0-202307271613/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar -configuration D:/Tools/WorkTool/Java/lsp/jdt-language-server-1.26.0-202307271613/config_win -data D:/WorkSpace/Java',
            \ 'enabled': v:true,
            \ 'suppress_stderr': v:true,
            \ 'message_hooks': {
            \     'initialize': {
            \         'initializationOptions': {},
            \         'rootUri': {method, params -> lsc#uri#documentUri(GetProjectRoot())},
            \     },
            \ },
            \ 'notifications': {
            \     '$/analyzerStatus': function('<SID>HandleStatus'),
            \ },
            \ 'workspace_config': {},
            \}

  "Rust(rust-analyzer)设定
  "安装命令：rustup component add rust-analyzer
  "设定参数参照这里
  "https://rust-analyzer.github.io/manual.html#configuration
  let g:lsc_server_commands.rust = {
            \ 'name': 'rust-analyzer',
            \ 'command': 'rust-analyzer',
            \ 'enabled': v:true,
            \ 'suppress_stderr': v:true,
            \ 'message_hooks': {
            \   'initialize': { 'initializationOptions': {
            \     'cargo': {
            \         'buildScripts': {
            \             'enable': v:true,
            \         },
            \     },
            \     'procMacro': {
            \         'enable': v:true,
            \     },
            \     'lens': { 'enable': v:true, },
            \     'check': {
            \         'command': 'clippy',
            \         'extraArgs': ['--', '-A', 'clippy::needless_return'],
            \     },
            \     'diagnostics': {
            \         'enable': v:true,
            \         'experimental': { 'enable': v:true, },
            \     },
            \   },
            \   'rootUri': {method, params -> lsc#uri#documentUri(GetProjectRoot())},
            \   },
            \ },
            \ 'notifications': {
            \     '$/analyzerStatus': function('<SID>HandleStatus'),
            \ },
            \ 'workspace_config': {},
            \}

  "Go(gopls)设定
  "安装命令：go install golang.org/x/tools/gopls@latest
  "设定参数参照这里
  "https://github.com/golang/tools/blob/master/gopls/doc/settings.md
  let g:lsc_server_commands.go = {
            \ 'name': 'gopls',
            \ 'command': 'gopls -remote=auto',
            \ 'enabled': v:true,
            \ 'suppress_stderr': v:true,
            \ 'message_hooks': {
            \   'initialize': { 'initializationOptions': {
            "\     'formatting.gofumpt': v:true,
            \     'analyses': {
            \         'ST1000': v:false,
            \         'ST1003': v:false,
            \         'SA5001': v:false,
            \         'nilness': v:true,
            \         'unusedwrite': v:true,
            \         'unusedparams': v:true,
            \         'fieldalignment': v:false,
            \         'shadow': v:false,
            \         'composites': v:false,
            \     },
            \     'ui.codelenses': {
            \         'generate': v:true,
            \         'regenerate_cgo': v:true,
            \         'test': v:true,
            \         'vendor': v:true,
            \         'tidy': v:true,
            \         'upgrade_dependency': v:true,
            \         'gc_details': v:true
            \     },
            \     'ui.diagnostic.annotations': {
            \         'bounds': v:true,
            \         'inline': v:true,
            \         'escape': v:false,
            \         'nil': v:false
            \     },
            \     'ui.diagnostic.staticcheck': v:true,
            \     'ui.completion.usePlaceholders': v:true,
            \     'ui.navigation.importShortcut': 'Definition',
            \     'ui.completion.matcher': 'Fuzzy',
            \     'ui.navigation.symbolMatcher': 'Fuzzy',
            \     'ui.navigation.symbolStyle': 'Dynamic',
            \     'ui.completion.completionBudget': '500ms',
            \     'ui.semanticTokens': v:true,
            \     'build.directoryFilters': [
            \         '-node_modules',
            \         '-data'
            \     ],
            \   },
            \   'rootUri': {method, params -> lsc#uri#documentUri(GetProjectRoot())},
            \   },
            \ },
            \ 'notifications': {
            \     '$/analyzerStatus': function('<SID>HandleStatus'),
            \ },
            \ 'workspace_config': {},
            \}
  let g:lsc_server_commands.gomod = g:lsc_server_commands.go
  let g:lsc_server_commands.gohtmltmpl = g:lsc_server_commands.go
  let g:lsc_server_commands.gotexttmpl = g:lsc_server_commands.go

  "Vue(vls)设定
  "安装命令：npm install vls -g
  let g:lsc_server_commands.vue = {
            \ 'name': 'vls',
            \ 'command': 'vls.cmd --stdio',
            \ 'enabled': v:true,
            \ 'suppress_stderr': v:true,
            \ 'message_hooks': {
            \     'initialize': {
            \         'initializationOptions': {},
            \         'rootUri': {method, params -> lsc#uri#documentUri(GetProjectRoot())},
            \     },
            \ },
            \ 'notifications': {
            \     '$/analyzerStatus': function('<SID>HandleStatus'),
            \ },
            \ 'workspace_config': {},
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
      \ 'Rename': '<Space>rn',
      \ 'ShowHover': '<Space>h',
      \ 'DocumentSymbol': '<Space>gs',
      \ 'WorkspaceSymbol': '<Space>gS',
      \ 'SignatureHelp': '<Space>gm',
      \ 'Completion': 'completefunc',
      \}
  nnoremap <Space>p  :LSClientWorkspaceSymbol<CR>
  nnoremap <F2>      :LSClientRename<CR>
  nnoremap <C-]>     :LSClientGoToDefinition<CR>
  nnoremap <Space>lo :LSClientWindowDiagnostics<CR><C-w>w
  nnoremap <Space>lc :lclose<CR>
  nnoremap <C-j>     :lnext<CR>
  nnoremap <C-k>     :lprevious<CR>
  nnoremap <Space>pd :lbefore<CR>
  nnoremap <Space>nd :lafter<CR>
  "nnoremap <C-S-f> :LSClientFormat<CR>
  "vnoremap <C-S-f> :LSClientRangeFormat<CR>
  nnoremap <C-F2>   :echo LSCServerStatus()<CR>

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
