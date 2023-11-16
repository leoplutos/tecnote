scriptencoding utf-8
"lsp.vim

"-----------------------------------------------"
"               vim-lsp设置                     "
"-----------------------------------------------"
"https://github.com/prabirshrestha/vim-lsp
"https://github.com/prabirshrestha/asyncomplete.vim
"https://github.com/prabirshrestha/asyncomplete-lsp.vim
"https://github.com/prabirshrestha/asyncomplete-buffer.vim
"未使用https://github.com/prabirshrestha/asyncomplete-file.vim
"https://github.com/koturn/asyncomplete-dictionary.vim
"https://github.com/skywind3000/vim-dict
"https://github.com/hrsh7th/vim-vsnip
"https://github.com/hrsh7th/vim-vsnip-integ
"加载vim-lsp和自动完成asyncomplete.vim
packadd vim-lsp
packadd asyncomplete.vim
packadd asyncomplete-lsp.vim
packadd asyncomplete-buffer.vim
"packadd asyncomplete-file.vim
packadd asyncomplete-dictionary.vim
"加载vim-vsnip插件（代码片段）
packadd vim-vsnip
packadd vim-vsnip-integ
"加载vim-dict（自动补全词典）给没有LSP的语言使用
exec 'source ' . g:g_s_rcfilepath . '/vimconf/init/vim_dict.vim'
" 设定词典路径和匹配方式
let s:vim_dict_path = g:g_s_rcfilepath . '/vimconf/dict'
let g:vim_dict_dict = [s:vim_dict_path, '',]
let g:vim_dict_config = {'css':'css,css3', 'html':'html,javascript,css,css3', 'markdown':'text'}

"根据OS设定LSP服务命令
if (g:g_i_osflg == 1 || g:g_i_osflg == 2 || g:g_i_osflg == 3)
  let s:lsp_pyright_langserver_cmd = 'pyright-langserver.cmd'
  let s:lsp_jdtls_jar_path = 'D:/Tools/WorkTool/Java/lsp/jdt-language-server-1.26.0-202307271613/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar'
  let s:lsp_jdtls_config_path = 'D:/Tools/WorkTool/Java/lsp/jdt-language-server-1.26.0-202307271613/config_win'
  let s:java_maven_setting_path = 'D:/Tools/WorkTool/Java/apache-maven-3.9.4/conf/settings.xml'
  let s:lsp_vue_lsp_cmd = 'vue-language-server.cmd'
  let s:lsp_typescript_tsdk_path = 'D:/Tools/WorkTool/NodeJs/node-v18.17.1-win-x64/node_global/node_modules/typescript/lib'
  let s:lsp_cobol_lsp_jar_path = 'D:/Tools/WorkTool/Cobol/cobol-language-support-1.2.1/extension/server/jar/server.jar'
  let s:lsp_kotlin_lsp_cmd = 'kotlin-language-server.bat'
  let s:custom_snippet_dir = expand('~/AppData/Roaming/Code/User/snippets')
  let s:lsp_angularls_cmd = 'ngserver.cmd'
  let s:lsp_angularls_ngProbeLocations = 'D:/Tools/WorkTool/NodeJs/node-v18.17.1-win-x64/node_global/node_modules/@angular/language-server/bin'
else
  let s:lsp_pyright_langserver_cmd = 'pyright-langserver'
  let s:lsp_jdtls_jar_path = '/home/lchuser/work/lch/tool/lsp/jdtls/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar'
  let s:lsp_jdtls_config_path = '/home/lchuser/work/lch/tool/lsp/jdtls/config_linux'
  let s:java_maven_setting_path = '/usr/local/maven/apache-maven-3.9.4/conf/settings.xml'
  let s:lsp_vue_lsp_cmd = 'vue-language-server'
  let s:lsp_typescript_tsdk_path = '/usr/lib/node_modules/typescript/lib'
  let s:lsp_cobol_lsp_jar_path = '/home/lchuser/work/lch/tool/lsp/cobol-language-support-1.2.1/extension/server/jar/server.jar'
  let s:lsp_kotlin_lsp_cmd = 'kotlin-language-server'
  let s:custom_snippet_dir = expand('~/work/lch/rc/snippets')
  let s:lsp_angularls_cmd = 'ngserver'
  let s:lsp_angularls_ngProbeLocations = '/usr/lib/node_modules/@angular/language-server/bin'
endif

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
  nnoremap <buffer> <Space>lo :LspDocumentDiagnostics<CR><C-w>W
  nnoremap <buffer> <Space>lc :lclose<CR>
  nnoremap <buffer> <Space>q :LspDocumentDiagnostics<CR><C-w>W:lclose<CR>:LeaderfLocList<CR>
  nnoremap <buffer> <C-j> :lnext<CR>
  nnoremap <buffer> <C-k> :lprevious<CR>
  nnoremap <buffer> <Space>ca <plug>(lsp-code-action-float)
  nnoremap <buffer> <Space>gd <plug>(lsp-definition)
  "nnoremap <buffer> <C-]>     <plug>(lsp-definition)
  nnoremap <buffer> <Space>gs <plug>(lsp-document-symbol-search)
  nnoremap <buffer> <Space>gS <plug>(lsp-workspace-symbol-search)
  nnoremap <buffer> <Space>p <plug>(lsp-workspace-symbol-search)
  nnoremap <buffer> <Space>gr <plug>(lsp-references)
  nnoremap <buffer> <Space>gi <plug>(lsp-implementation)
  nnoremap <buffer> <Space>gt <plug>(lsp-type-definition)
  nnoremap <buffer> <Space>rn <plug>(lsp-rename)
  nnoremap <buffer> <F2> <plug>(lsp-rename)
  "nnoremap <buffer> <Space>[g <plug>(lsp-previous-diagnostic)
  "nnoremap <buffer> <Space>]g <plug>(lsp-next-diagnostic)
  nnoremap <buffer> <Space>gn <plug>(lsp-next-diagnostic)
  nnoremap <buffer> <Space>gp <plug>(lsp-previous-diagnostic)
  nnoremap <buffer> <Space>h  <plug>(lsp-hover-float)
  nnoremap <buffer> <C-UP>    <plug>(lsp-previous-reference)
  nnoremap <buffer> <C-Down>  <plug>(lsp-next-reference)
  nnoremap <buffer> <Space>fm :LspDocumentFormat<CR>
  vnoremap <buffer> <Space>fr :LspDocumentRangeFormat<CR>
  nnoremap <buffer> <expr><C-d> lsp#scroll(+4)
  nnoremap <buffer> <expr><C-u> lsp#scroll(-4)

  let g:lsp_format_sync_timeout = 1000
  "autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
  let g:lsp_log_verbose = 0
  "let g:lsp_log_file = expand('~/vim-lsp.log')
  let g:lsp_log_file = ''

  "hi clear Structure
  "hi link Structure Statement
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
  hi clear LspSemanticAnnotation
  hi link LspSemanticAnnotation Annotation
  hi clear LspSemanticIdentifier
  hi link LspSemanticIdentifier Identifier
  hi clear LspSemanticPunctuation
  hi link LspSemanticPunctuation Special
  hi clear LspSemanticMacro
  hi link LspSemanticMacro Macro
  hi clear LspSemanticGlobalScopeMacro
  hi link LspSemanticGlobalScopeMacro Macro
  hi clear LspSemanticDeclarationGlobalScopeMacro
  hi link LspSemanticDeclarationGlobalScopeMacro Macro
  hi clear LspSemanticGeneric
  hi link LspSemanticGeneric Property
  hi clear LspSemanticBuiltinType
  hi link LspSemanticBuiltinType Statement
  hi clear LspSemanticLifetime
  hi link LspSemanticLifetime Lifetime
  "废弃/过时的高亮组加上取消线
  hi clear LspSemanticDeprecatedGenericPublicMethod
  hi link LspSemanticDeprecatedGenericPublicMethod Deprecated
  hi clear LspSemanticDeprecatedPublicInterface
  hi link LspSemanticDeprecatedPublicInterface Deprecated
  hi clear LspSemanticDeprecatedPublicClass
  hi link LspSemanticDeprecatedPublicClass Deprecated
  hi clear LspSemanticConstructorDeprecatedPublicClass
  hi link LspSemanticConstructorDeprecatedPublicClass Deprecated
  hi clear LspSemanticDeprecatedPublicReadonlyStaticProperty
  hi link LspSemanticDeprecatedPublicReadonlyStaticProperty Deprecated
  hi clear LspSemanticDeclarationDeprecatedPublicClass
  hi link LspSemanticDeclarationDeprecatedPublicClass Deprecated
  hi clear LspSemanticDeprecatedProtectedProperty
  hi link LspSemanticDeprecatedProtectedProperty Deprecated
  hi clear LspSemanticDeprecatedPublicMethod
  hi link LspSemanticDeprecatedPublicMethod Deprecated
  hi clear LspSemanticAbstractDeprecatedPublicMethod
  hi link LspSemanticAbstractDeprecatedPublicMethod Deprecated

endfunction

function! s:register_completion_source() abort
  " 注册词典插件asyncomplete-dictionary.vim的源(使用LSP的就不使用词典)
  call asyncomplete#register_source(asyncomplete#sources#dictionary#get_source_options({
      \ 'name': 'dictionary',
      \ 'allowlist': ['*'],
      \ 'blocklist': [
      \     'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto',
      \     'python',
      \     'java',
      \     'rust',
      \     'go', 'gomod', 'gohtmltmpl', 'gotexttmpl', 'gowork', 'gotmpl',
      \     'vue',
      \     'cs', 'solution',
      \     'cobol',
      \     'javascript', 'javascript.jsx', 'javascriptreact', 'typescript', 'typescript.tsx', 'typescriptreact',
      \     'kotlin',
      \ ],
      \ 'priority': 10,
      \ 'completor': function('asyncomplete#sources#dictionary#completor'),
      \ }))
  " 注册Buffer插件asyncomplete-buffer.vim的源(使用LSP的就不使用Bufer)
  call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
      \ 'name': 'buffer',
      \ 'allowlist': ['*'],
      \ 'blocklist': [
      \     'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto',
      \     'python',
      \     'java',
      \     'rust',
      \     'go', 'gomod', 'gohtmltmpl', 'gotexttmpl', 'gowork', 'gotmpl',
      \     'vue',
      \     'cs', 'solution',
      \     'cobol',
      \     'javascript', 'javascript.jsx', 'javascriptreact', 'typescript', 'typescript.tsx', 'typescriptreact',
      \     'kotlin',
      \ ],
      \ 'priority': 9,
      \ 'completor': function('asyncomplete#sources#buffer#completor'),
      \ 'config': {
      \    'max_buffer_size': 5000000,
      \  },
      \ }))
endfunction

augroup lsp_install
  autocmd!
  " call s:on_lsp_buffer_enabled only for languages that has the server registered.
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
  " 注册自动补全的源
  autocmd User asyncomplete_setup call s:register_completion_source()
augroup END

"更多语言的设定参照这里：https://github.com/mattn/vim-lsp-settings

"C/C++(clangd)
"在这里下载 https://github.com/clangd/clangd/releases/
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
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto'],
        \ })
endif

"Python(pylsp)
"Windows7：使用anakin-language-server（推荐） 或者 jedi-language-server
"    安装命令：pip install -i https://pypi.tuna.tsinghua.edu.cn/simple anakin-language-server
"    安装命令：pip install -U jedi-language-server -i https://pypi.tuna.tsinghua.edu.cn/simple
"Windows10以后：使用pyright 或者 python-lsp-server
"    安装命令：npm install -g pyright
"    安装命令：pip install -i https://pypi.tuna.tsinghua.edu.cn/simple "python-lsp-server[all]"
if (g:g_python_lsp_type == 0)
  "0：使用pylsp

  if executable('pylsp')
      "设定参数参照这里
      "https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
      au User lsp_setup call lsp#register_server({
          \ 'name': 'pylsp',
          \ 'cmd': {server_info->['pylsp']},
          \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.root'))},
          \ 'whitelist': ['python'],
          \ 'workspace_config': {'pylsp': {
          "\     'configurationSources': ['flake8'],
          \     'configurationSources': ['pycodestyle'],
          \     'plugins': {
          \         'autopep8': {'enabled': v:false},
          \         'flake8': {'enabled': v:false},
          \         'pylint': {'enabled': v:false},
          \         'pycodestyle': {
          \             'enabled': v:true,
          \             'ignore': ['E401', 'E402', 'E501'],
          \         },
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
          \ }}
          \ })
  endif
endif

if (g:g_python_lsp_type == 1)
  "使用jedi-language-server

  if executable('jedi-language-server')
      "设定参数参照这里
      "https://github.com/pappasam/jedi-language-server
      au User lsp_setup call lsp#register_server({
          \ 'name': 'jedi-language-server',
          \ 'cmd': {server_info->['jedi-language-server']},
          \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.root'))},
          \ 'whitelist': ['python'],
          \ 'workspace_config': {},
          \ 'initialization_options': {
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
          \ },
          \ })
  endif
endif

if (g:g_python_lsp_type == 2)
  "使用anakin-language-server

  if executable('anakinls')
      "设定参数参照这里
      "https://github.com/muffinmad/anakin-language-server
      au User lsp_setup call lsp#register_server({
          \ 'name': 'anakinls',
          \ 'cmd': {server_info->['anakinls']},
          \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.root'))},
          \ 'whitelist': ['python'],
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
          \ 'initialization_options': {
          "\     'venv': 'path/to/virtualenv',
          \ },
          \ })
  endif
endif

if (g:g_python_lsp_type == 3)
  "使用pyright-langserver

  if executable('pyright-langserver')
      "设定参数参照这里
      "https://microsoft.github.io/pyright
      au User lsp_setup call lsp#register_server({
          \ 'name': 'pyright-langserver',
          \ 'cmd': {server_info->[s:lsp_pyright_langserver_cmd, '--stdio']},
          \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.root'))},
          \ 'whitelist': ['python'],
          \ 'workspace_config': {
          \   'python': {
          \     'analysis': {
          \       'autoSearchPaths': v:true,
          \       'useLibraryCodeForTypes': v:true,
          \       'diagnosticMode': 'openFilesOnly',
          \       'typeCheckingMode': 'basic',
          \       'stubPath': 'src/com',
          \     },
          \   },
          \ },
          \ 'initialization_options': {},
          \ })
  endif
endif


"Java(eclipse.jdt.ls)
"在这里下载 https://download.eclipse.org/jdtls/milestones/
"更多设定 https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
if executable('java') && filereadable(s:lsp_jdtls_jar_path)
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
        \     s:lsp_jdtls_jar_path,
        \     '-configuration',
        \     s:lsp_jdtls_config_path,
        \     '-data',
        \     $HOME.'/.cache/vim-lsp-jdtls',
        \ ]},
        \ 'initialization_options': {
        \   'workspaceFolders': $HOME.'/.cache/vim-lsp-jdtls',
        \   'settings': {
        \     'java': {
        \       'configuration': {
        \         'maven': {
        \           'userSettings': s:java_maven_setting_path,
        \           'globalSettings': s:java_maven_setting_path,
        \         },
        \       },
        \       'import': {
        \         'maven': {
        \           'enabled': v:true,
        \         },
        \       },
        \       'inlayhints': {
        \         'parameterNames': {
        \           'enabled': v:true,
        \         },
        \       },
        \     },
        \   },
        \ },
        \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.root'))},
        \ 'whitelist': ['java'],
        \ })
endif

"Rust(rust-analyzer)
"安装命令：rustup component add rust-analyzer
"if executable('rustup')
if executable('rust-analyzer')
    "设定参数参照这里
    "https://rust-analyzer.github.io/manual.html#configuration
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rust-analyzer',
        "\ 'cmd': {server_info->['rustup', 'run', 'stable', 'rust-analyzer']},
        \ 'cmd': {server_info->['rust-analyzer']},
        \ 'initialization_options': {
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
        \ },
        \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.root'))},
        \ 'allowlist': ['rust'],
        \ })
endif

"Go(gopls)
"安装命令：go install golang.org/x/tools/gopls@latest
if executable('gopls')
    "设定参数参照这里
    "https://github.com/golang/tools/blob/master/gopls/doc/settings.md
    au User lsp_setup call lsp#register_server({
        \ 'name': 'gopls',
        \ 'cmd': {server_info->['gopls', '-remote=auto']},
        \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.root'))},
        \ 'allowlist': ['go', 'gomod', 'gohtmltmpl', 'gotexttmpl', 'gowork', 'gotmpl'],
        \ 'workspace_config': {},
        \ 'initialization_options': {
        \     'allExperiments': v:true,
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
        \     'ui.hints': {
        \         'assignVariableTypes': v:true,
        \         'compositeLiteralFields': v:true,
        \         'compositeLiteralTypes': v:true,
        \         'constantValues': v:true,
        \         'functionTypeParameters': v:true,
        \         'parameterNames': v:true,
        \         'rangeVariableTypes': v:true,
        \     },
        \     'build.directoryFilters': [
        \         '-node_modules',
        \         '-data'
        \     ],
        \ },
        \ })
    "autocmd BufWritePre *.go
    "    \ call execute('LspDocumentFormatSync') |
    "    \ call execute('LspCodeActionSync source.organizeImports')
endif

"前端LSP判断
if (g:g_front_dev_type == 0 || g:g_front_dev_type == 3)
  "无前端框架 或者 使用React框架 -> 使用tsserver
  "JavaScript和TypeScript（typescript-language-server）设置

  "使用JavaScript和TypeScript（typescript-language-server）
  "安装命令：npm install -g typescript typescript-language-server
  if executable('typescript-language-server')
      "设定参数参照这里
      "https://github.com/prabirshrestha/vim-lsp/wiki/Servers-JavaScript
      au User lsp_setup call lsp#register_server({
          \ 'name': 'typescript-language-server',
          \ 'cmd': {server_info->['typescript-language-server.cmd', '--stdio']},
          \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.root'))},
          \ 'allowlist': ['javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx'],
          \ })
  endif

elseif (g:g_front_dev_type == 1)
  "使用Vue框架 -> 使用volar
  "Vue(volar-language-server)设置

  "Vue(volar-language-server)
  "注：@vue/language-server即是Volar，而下面的vls是Vetur
  "安装命令：npm install -g @vue/language-server
  "          npm install -g typescript
  if executable('vue-language-server')
      "设定参数参照这里
      "https://github.com/vuejs/language-tools
      au User lsp_setup call lsp#register_server({
          \ 'name': 'volar-language-server',
          \ 'cmd': {server_info->[s:lsp_vue_lsp_cmd, '--stdio']},
          \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.root'))},
          \ 'allowlist': ['javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'json'],
          \ 'initialization_options': {
          \     'textDocumentSync': 2,
          \     'typescript': {
          \         'tsdk': s:lsp_typescript_tsdk_path,
          \     },
          \ },
          \ })
  endif

elseif (g:g_front_dev_type == 2)
  "使用Angular框架 -> 使用ngserver(angularls)
  "Angular(ngserver)设置

  "Angular(angular-language-server)
  "安装命令：npm install -g @angular/language-server
  if executable('ngserver')
      au User lsp_setup call lsp#register_server({
          \ 'name': 'angular-language-server',
          \ 'cmd': {server_info->[s:lsp_angularls_cmd, '--stdio', '--tsProbeLocations', s:lsp_typescript_tsdk_path , '--ngProbeLocations', s:lsp_angularls_ngProbeLocations]},
          \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.root'))},
          \ 'allowlist': ['html', 'typescript', 'typescriptreact', 'typescript.tsx'],
          \ 'initialization_options': {
          \ },
          \ })
  endif

endif

"使用CSharp（csharp-ls）
"安装命令 dotnet tool install --global csharp-ls
"if executable('csharp-ls')
"    au User lsp_setup call lsp#register_server({
"        \ 'name': 'csharp-ls',
"        \ 'cmd': {server_info->['csharp-ls']},
"        \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.root'))},
"        \ 'allowlist': ['cs', 'solution'],
"        \ 'initialization_options': {
"        \   'AutomaticWorkspaceInit': v:true,
"        \ },
"        \ })
"endif
"使用CSharp（OmniSharp）
"在这里下载 https://github.com/OmniSharp/omnisharp-roslyn/releases
"遇到出错，删除bin和obj文件夹下所有内容即可
if executable('OmniSharp')
    "设定参数参照这里
    "https://github.com/OmniSharp/omnisharp-roslyn/wiki/Configuration-Options
    au User lsp_setup call lsp#register_server({
        \ 'name': 'OmniSharp',
        \ 'cmd': {server_info->['OmniSharp', '-z', '--languageserver', '--encoding', 'utf-8', 'DotNet:enablePackageRestore=false']},
        \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.root'))},
        \ 'allowlist': ['cs', 'solution'],
        \ 'initialization_options': {
        \ },
        \ })
endif

"使用Cobol（che-che4z-lsp-for-cobol）
"在这里下载 https://github.com/eclipse-che4z/che-che4z-lsp-for-cobol/releases/download/1.2.1/cobol-language-support-1.2.1.vsix
"需要Java，经过测试：2.0.1至2.0.3使用都有问题，可用版本为1.2.1
if executable('java')
    "设定参数参照这里
    "https://github.com/eclipse-che4z/che-che4z-lsp-for-cobol
    au User lsp_setup call lsp#register_server({
        \ 'name': 'che-che4z-lsp-for-cobol',
        \ 'cmd': {server_info->[
        \     'java',
        \     '--add-opens',
        \     'java.base/java.lang=ALL-UNNAMED',
        \     '-Dline.speparator=\r\n',
        \     '-jar',
        \     s:lsp_cobol_lsp_jar_path,
        \     'pipeEnabled',
        \     ]},
        \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.root'))},
        \ 'allowlist': ['cobol'],
        \ 'languageId': {server_info->'cbl'},
        \ 'initialization_options': {
        \   'hints': {
        \       'typeHints': v:true,
        \       'parameterHints': v:true,
        \       'chainedHints': v:true,
        \   },
        \ },
        \ })
endif

"使用Kotlin（kotlin-language-server）
"在这里下载 https://github.com/fwcd/kotlin-language-server/releases/
if executable('kotlin-language-server')
    "设定参数参照这里
    "https://github.com/prabirshrestha/vim-lsp/wiki/Servers-Kotlin
    au User lsp_setup call lsp#register_server({
        \ 'name': 'kotlin-language-server',
        \ 'cmd': {server_info->[s:lsp_kotlin_lsp_cmd]},
        \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.root'))},
        \ 'allowlist': ['kotlin'],
        \ 'initialization_options': {
        \ },
        \ })
endif

"vim-lsp设定
"let g:lsp_diagnostics_float_cursor = 1
let g:lsp_inlay_hints_enabled = 1
let g:lsp_semantic_enabled = 1
let g:lsp_completion_documentation_delay = 0
let g:lsp_completion_resolve_timeout = 0
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_echo_delay = 0
let g:lsp_diagnostics_float_delay = 0
let g:lsp_diagnostics_highlights_delay = 0
let g:lsp_diagnostics_signs_delay = 0
let g:lsp_diagnostics_virtual_text_delay = 0
let g:lsp_diagnostics_virtual_text_align = 'after'
let g:lsp_diagnostics_virtual_text_wrap = 'truncate'
let g:lsp_document_code_action_signs_delay = 0
let g:lsp_inlay_hints_delay = 0
let g:lsp_document_highlight_delay = 0
let g:lsp_semantic_delay = 0
let g:lsp_text_document_did_save_delay = 0
if (g:g_use_nerdfont == 0)
  let g:lsp_diagnostics_signs_enabled = 1
  let g:lsp_diagnostics_signs_error = {"text": "❌"}
  let g:lsp_diagnostics_signs_warning = {"text": "🆖"}
  let g:lsp_diagnostics_signs_information = {"text": "❗"}
  let g:lsp_diagnostics_signs_hint = {"text": "🗝"}
  let g:lsp_document_code_action_signs_enabled = 1
  let g:lsp_document_code_action_signs_hint = {"text": "💡"}
  let g:lsp_diagnostics_virtual_text_prefix = " > "
else
  let g:lsp_diagnostics_signs_enabled = 1
  let g:lsp_diagnostics_signs_error = {"text": g:diagnosticsErrorIcon}
  let g:lsp_diagnostics_signs_warning = {"text": g:diagnosticsWarnIcon}
  let g:lsp_diagnostics_signs_information = {"text": g:diagnosticsInfoIcon}
  let g:lsp_diagnostics_signs_hint = {"text": g:diagnosticsHintrIcon}
  let g:lsp_document_code_action_signs_enabled = 1
  "let g:lsp_document_code_action_signs_hint = {"text": g:codeActionHintIcon}
  let g:lsp_document_code_action_signs_hint = {"text": "💡"}
  let g:lsp_diagnostics_virtual_text_prefix = " " . g:virtualTextPrefixIcon . " "
endif

"asyncomplete.vim设定
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 1
let g:asyncomplete_popup_delay = 200
let g:asyncomplete_matchfuzzy = 1
"let g:asyncomplete_log_file = expand('~/asyncomplete.log')

"TAB键选择补全内容，回车键选择
"inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
"Ctrl+F2显示LSP服务器状态
nnoremap <C-F2> :LspStatus<CR>
nnoremap <Leader>ls :LspStatus<CR>
nnoremap <Space>ih :call ToggleLspInlayHints()<CR>
"切换是否显示LSP的InlayHints
function! ToggleLspInlayHints() abort
  if !exists('g:lsp_inlay_hints_enabled')
    let g:lsp_inlay_hints_enabled = 1
  endif
  if (g:lsp_inlay_hints_enabled == 0)
    let g:lsp_inlay_hints_enabled = 1
  else
    let g:lsp_inlay_hints_enabled = 0
    e
  endif
endfunction

"给状态栏设置的调用函数（返回LSP状态显示到状态栏）
function! GetLspStatus() abort
  let lspServerName = ''
  if (&ft=='c') || (&ft=='cpp') || (&ft=='objc') || (&ft=='objcpp') || (&ft=='cuda') || (&ft=='proto')
    let lspServerName = 'clangd'
  elseif (&ft=='python')
    let lspServerName = 'pylsp'
    if (g:g_python_lsp_type == 1)
      let lspServerName = 'jedi-language-server'
    elseif (g:g_python_lsp_type == 2)
      let lspServerName = 'anakinls'
    elseif (g:g_python_lsp_type == 3)
      let lspServerName = 'pyright-langserver'
    endif
  elseif (&ft=='java')
    let lspServerName = 'eclipse.jdt.ls'
  elseif (&ft=='rust')
    let lspServerName = 'rust-analyzer'
  elseif (&ft=='go') || (&ft=='gomod') || (&ft=='gohtmltmpl') || (&ft=='gotexttmpl')
    let lspServerName = 'gopls'
  elseif (&ft=='cs') || (&ft=='solution')
    let lspServerName = 'OmniSharp'
    "let lspServerName = 'csharp-ls'
  elseif (&ft=='cobol')
    let lspServerName = 'che-che4z-lsp-for-cobol'
  elseif (&ft=='javascript') || (&ft=='javascriptreact') || (&ft=='typescript') || (&ft=='typescriptreact')
    if (g:g_front_dev_type == 0) || (g:g_front_dev_type == 3)
      let lspServerName = 'typescript-language-server'
    elseif (g:g_front_dev_type == 1)
      let lspServerName = 'volar-language-server'
    elseif (g:g_front_dev_type == 2)
      let lspServerName = 'angular-language-server'
    endif
  elseif (&ft=='javascript.jsx') || (&ft=='typescript.tsx')
    if (g:g_front_dev_type == 0) || (g:g_front_dev_type == 3)
      let lspServerName = 'typescript-language-server'
    elseif (g:g_front_dev_type == 2)
      let lspServerName = 'angular-language-server'
    endif
  elseif (&ft=='vue') || (&ft=='json')
    if (g:g_front_dev_type == 1)
      let lspServerName = 'volar-language-server'
    endif
  elseif (&ft=='html')
    if (g:g_front_dev_type == 2)
      let lspServerName = 'angular-language-server'
    endif
  elseif (&ft=='kotlin')
    let lspServerName = 'kotlin-language-server'
  endif
  let lspStatus = lsp#get_server_status(lspServerName)
  if (lspStatus == '') || (lspStatus == 'unknown server')
    if (g:g_use_nerdfont == 0)
      let lspStatus = '❌'
    else
      let lspStatus = g:lspStatusNg
    endif
  endif
  return lspStatus
endfunction

"代码片段设定
let g:vsnip_snippet_dir = s:custom_snippet_dir
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript']

" Expand
imap <expr> <C-q>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-q>'
smap <expr> <C-q>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-q>'
" Expand or jump
imap <expr> <C-w>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-w>'
smap <expr> <C-w>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-w>'
" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)
