scriptencoding utf-8
"languageclient.vim

"-----------------------------------------------"
"        LanguageClient-neovim设置              "
"-----------------------------------------------"

if (g:g_i_osflg == 1 || g:g_i_osflg == 2)

  "设定runtimepath
  "exec "set runtimepath+=" . g:g_s_rcfilepath . '/vimconf/pack/vendor/opt/LanguageClient-neovim'

  "加载LanguageClient-neovim
  "https://github.com/autozimu/LanguageClient-neovim/
  packadd LanguageClient-neovim

  "设定log
  "let g:LanguageClient_serverStderr = expand('~/LanguageClient-neovim_serverStderr.log')
  "let g:LanguageClient_loggingFile = expand('~/LanguageClient-neovim.log')

  "设定LSP服务命令
  let g:LanguageClient_serverCommands = {
    \  'c': [
    \      'clangd',
    \      '--background-index',
    \      '--clang-tidy',
    \      '--clang-tidy-checks=*',
    \      '--all-scopes-completion',
    \      '--completion-style=detailed',
    \      '--header-insertion=iwyu',
    \      '--function-arg-placeholders',
    \      '--enable-config',
    \  ],
    \  'python': [
    \      'pylsp',
    \  ],
    \  'vue': [
    \      'vls.cmd',
    \      '--stdio',
    \  ],
    \}

  set completefunc=LanguageClient#complete
  set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()
  let g:LanguageClient_selectionUI = 'quickfix'
  let g:LanguageClient_rootMarkers = ['.git', '.svn', '.project', '.root', '.hg']

  "快捷键绑定
  nnoremap <Space>me <Plug>(lcn-menu)
  nnoremap <Space>ca <Plug>(lcn-code-action)
  nnoremap <Space>gd <Plug>(lcn-definition)
  nnoremap <Space>gs <Plug>(lcn-symbols)
  nnoremap <Space>gr <Plug>(lcn-references)
  nnoremap <Space>gi <Plug>(lcn-implementation)
  nnoremap <Space>gt <Plug>(lcn-type-definition)
  nnoremap <Space>rn <Plug>(lcn-rename)
  nnoremap <F2>      <Plug>(lcn-rename)
  nnoremap <Space>[g <Plug>(lcn-diagnostics-prev)
  nnoremap <Space>]g <Plug>(lcn-diagnostics-next)
  nnoremap <Space>h  <Plug>(lcn-hover)
  nnoremap <Space>nd <Plug>(lcn-diagnostics-next)
  nnoremap <Space>pd <Plug>(lcn-diagnostics-prev)

  "设定错误提示
  let diagnosticsDisplaySettings={
    \      '1': {
    \          'name': 'Error',
    \          'texthl': 'LspErrorHighlight',
    \          'signText': '❌',
    \          'signTexthl': 'LspErrorText',
    \          'virtualTexthl': 'LspErrorVirtualText',
    \      },
    \      '2': {
    \          'name': 'Warning',
    \          'texthl': 'LspWarningHighlight',
    \          'signText': '🆖',
    \          'signTexthl': 'LspWarningText',
    \          'virtualTexthl': 'LspWarningVirtualText',
    \      },
    \      '3': {
    \          'name': 'Information',
    \          'texthl': 'LspInformationHighlight',
    \          'signText': '❗',
    \          'signTexthl': 'LspInformationText',
    \          'virtualTexthl': 'LspInformationVirtualText',
    \      },
    \      '4': {
    \          'name': 'Hint',
    \          'texthl': 'LspHintHighlight',
    \          'signText': '❓',
    \          'signTexthl': 'LspHintText',
    \          'virtualTexthl': 'LspHintVirtualText',
    \      },
    \}
  let g:LanguageClient_diagnosticsDisplay=diagnosticsDisplaySettings

endif
