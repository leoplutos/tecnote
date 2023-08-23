scriptencoding utf-8
"lsp.vim

"-----------------------------------------------"
"               vim-lsp设置                     "
"-----------------------------------------------"

if (v:version > 799)

  function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
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
    nnoremap <buffer> <Space>h <plug>(lsp-hover)
    "nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    "nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    "autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    let g:lsp_log_verbose = 0
    "let g:lsp_log_file = expand("~/vim-lsp.log")
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
            \ 'cmd': {server_info->['clangd', '-background-index']},
            \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
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
            \    'pydocstyle': {'enabled': v:true},
            \    'jedi_definition': {
            \      'follow_imports': v:true,
            \      'follow_builtin_imports': v:true
            \     },
            \ }}}
            \ })
    endif

  elseif (g:g_use_lsp == 3)
    "使用LSP 3：Java(eclipse.jdt.ls)

    if executable('java') && filereadable('D:/Tools/Java/lsp/xxxx.jar')
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
            \      'xxxx.jar',
            \     '-configuration',
            "\     expand('~/lsp/eclipse.jdt.ls/config_win'),
            \   'xxxxx/config_win',
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
  packadd asyncomplete.vim
  packadd asyncomplete-lsp.vim

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
  "let g:asyncomplete_log_file = expand("~/asyncomplete.log")

endif
