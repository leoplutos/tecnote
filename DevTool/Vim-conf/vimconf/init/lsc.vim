scriptencoding utf-8
"lsc.vim

"-----------------------------------------------"
"               vim-lsc设置                     "
"-----------------------------------------------"

if (g:g_i_osflg == 1 || g:g_i_osflg == 2)

  "加载vim-lsc
  "https://github.com/natebosch/vim-lsc
  packadd vim-lsc

  set shortmess-=F
  let g:lsc_auto_completeopt='menu,menuone,noinsert,noselect'

  let g:lsc_server_commands = {
      \ 'c': {
          \ 'command': 'clangd --background-index --clang-tidy --all-scopes-completion --completion-style=detailed --header-insertion=iwyu --function-arg-placeholders --enable-config',
          \ 'suppress_stderr': v:true
      \},
      \ 'python': {
          \ 'command': 'pylsp',
          \ 'suppress_stderr': v:true,
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
      \ 'vue': {
          \ 'command': 'vls.cmd --stdio',
          \ 'suppress_stderr': v:true
      \},
  \}

  let g:lsc_auto_map = {
      \ 'GoToDefinition': '<Space>gd',
      \ 'GoToDefinitionSplit': ['<C-W>]', '<C-W><C-]>'],
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
