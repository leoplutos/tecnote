scriptencoding utf-8
"whichkey.vim

"vim-which-key（键绑定帮助）
"https://github.com/liuchengxu/vim-which-key
packadd vim-which-key

nnoremap <silent> <Leader> :<c-u>WhichKey '\'<CR>
"nnoremap <silent> <localleader> :<c-u>WhichKey ','<CR>
nnoremap <silent> <Space> :<c-u>WhichKey '<Space>'<CR>

"高亮设定
hi link WhichKey          WhichKeyShowKey
hi link WhichKeySeperator WhichKeyShowSeperator
hi link WhichKeyGroup     WhichKeyShowGroup
hi link WhichKeyDesc      String
hi link WhichKeyFloating  FinderNormal

