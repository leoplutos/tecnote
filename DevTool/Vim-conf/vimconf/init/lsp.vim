scriptencoding utf-8
"lsp.vim

"-----------------------------------------------"
"               vim-lsp设置                     "
"-----------------------------------------------"

if (g:g_i_osflg == 1 || g:g_i_osflg == 2)

  function! s:on_lsp_buffer_enabled() abort
    if (g:g_use_lsp == 2)
      "因为jedi安装后出现问题，所以python时候默认的补全
    else
      setlocal omnifunc=lsp#complete
    endif
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nnoremap <buffer> <Space>lo :LspDocumentDiagnostics<CR><C-w>w
    nnoremap <buffer> <Space>lc :lclose<CR>
    nnoremap <buffer> <Space>ca <plug>(lsp-code-action-float)
    nnoremap <buffer> <Space>gd <plug>(lsp-definition)
    nnoremap <buffer> <Space>gs <plug>(lsp-document-symbol-search)
    nnoremap <buffer> <Space>gS <plug>(lsp-workspace-symbol-search)
    nnoremap <buffer> <Space>gr <plug>(lsp-references)
    nnoremap <buffer> <Space>gi <plug>(lsp-implementation)
    nnoremap <buffer> <Space>gt <plug>(lsp-type-definition)
    nnoremap <buffer> <Space>rn <plug>(lsp-rename)
    nnoremap <buffer> <Space>[g <plug>(lsp-previous-diagnostic)
    nnoremap <buffer> <Space>]g <plug>(lsp-next-diagnostic)
    nnoremap <buffer> <Space>h <plug>(lsp-hover-float)
    "nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    "nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    "autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    let g:lsp_log_verbose = 0
    "let g:lsp_log_file = expand('~/vim-lsp.log')
    let g:lsp_log_file = ''
  endfunction

  augroup lsp_install
    autocmd!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
  augroup END

  if (g:g_use_lsp == 1)
    "使用LSP 1：C/C++(clangd)

    if executable('clangd')
        au User lsp_setup call lsp#register_server({
            \ 'name': 'clangd',
            \ 'cmd': {server_info->[
            \     'clangd',
            \     '--background-index',
            \     '--clang-tidy',
            \     '--all-scopes-completion',
            \     '--completion-style=detailed',
            \     '--header-insertion=iwyu',
            "\     '--enable-config',
            \     ]},
            \ 'whitelist': ['c', 'pc', 'cpp', 'objc', 'objcpp'],
            \ })
    endif

  elseif (g:g_use_lsp == 2)
    "使用LSP 2：Python(pylsp)

    if executable('pylsp')
        au User lsp_setup call lsp#register_server({
            \ 'name': 'pylsp',
            \ 'cmd': {server_info->['pylsp']},
            \ 'whitelist': ['python'],
            \ 'workspace_config': {'pylsp': {'plugins': {
            \     'pydocstyle': {'enabled': v:false},
            \     'jedi_definition': {
            \         'follow_imports': v:true,
            \         'follow_builtin_imports': v:true
            \     },
            \ }}}
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
            \     '-noverify',
            \     '-Dfile.encoding=UTF-8',
            \     '-Xmx1G',
            \     '-jar',
           "\     expand('~/lsp/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_1.5.600.v20191014-2022.jar'),
            \     'D:/Tools/WorkTool/Java/lsp/jdt-language-server-1.26.0-202307271613/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar',
            \     '-configuration',
           "\     expand('~/lsp/eclipse.jdt.ls/config_win'),
            \     'D:/Tools/WorkTool/Java/lsp/jdt-language-server-1.26.0-202307271613/config_win',
            \     '-data',
           "\     getcwd()
            \     g:g_s_projectrootpath.'/.lsp'
            \ ]},
            \ 'whitelist': ['java'],
            \ })
    endif

  endif

  "https://github.com/prabirshrestha/vim-lsp
  "https://github.com/prabirshrestha/asyncomplete.vim
  "https://github.com/prabirshrestha/asyncomplete-lsp.vim
  "加载vim-lsp
  packadd vim-lsp
  if (g:g_use_lsp == 2)
    "因为jedi安装后出现问题，所以python时候默认的补全
    exec 'source ' . g:g_s_rcfilepath . '/vimconf/init/apc.vim'
    let g:apc_enable_ft = {'*':1}
  else
    packadd asyncomplete.vim
    packadd asyncomplete-lsp.vim
  endif

  "vim-lsp
  if has('gui_running')
    let g:lsp_diagnostics_signs_enabled = 1
    let g:lsp_diagnostics_signs_error = {"text": "❌"}
    let g:lsp_diagnostics_signs_warning = {"text": "🆖"}
    let g:lsp_diagnostics_signs_information = {"text": "❗"}
    let g:lsp_diagnostics_signs_hint = {"text": "❓"}
    let g:lsp_document_code_action_signs_enabled = 1
    let g:lsp_document_code_action_signs_hint = {"text": "💡"}
  endif

  "asyncomplete.vim
  let g:asyncomplete_auto_popup = 1
  let g:asyncomplete_auto_completeopt = 1
  let g:asyncomplete_popup_delay = 200
  let g:asyncomplete_matchfuzzy = 1
  "let g:asyncomplete_log_file = expand('~/asyncomplete.log')

endif
