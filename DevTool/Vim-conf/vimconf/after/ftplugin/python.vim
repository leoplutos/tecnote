scriptencoding utf-8
"after/ftplugin/python.vim

if(g:g_i_osflg==1 || g:g_i_osflg==2)

  " [普通模式]F9：格式化当前函数
  "nmap <buffer> <F9> [[v][Vgq

endif

setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
let g:indentLine_enabled = 1
let b:match_words = '\<if\>:\<elif\>:\<else\>,'
    \ . '\<while\>:\<continue\>:\<break\>,'
    \ . '\<try\>:\<except\>:\<finally\>'
