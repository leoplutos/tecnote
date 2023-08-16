scriptencoding utf-8
"after/ftplugin/xml.vim

setlocal smartindent

if(g:g_i_osflg==1 || g:g_i_osflg==2)

  nnoremap <buffer> <F10> :%!python -c "import xml.dom.minidom, sys, io; _stdin = io.TextIOWrapper(sys.stdin.buffer, encoding='utf-8'); reparsed = xml.dom.minidom.parse(_stdin); print('\n'.join([line for line in reparsed.toprettyxml().split('\n') if line.strip()]))"<CR>

endif
