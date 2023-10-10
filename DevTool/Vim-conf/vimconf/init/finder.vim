scriptencoding utf-8
"finder.vim
"加载LeaderF插件
"https://github.com/Yggdroot/LeaderF
packadd LeaderF

" 不显示帮助
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 0
let g:Lf_CursorBlink = 0
let g:Lf_DefaultMode = 'Regex'
let g:Lf_ShowHidden = 1
"let g:Lf_WindowHeight = 0.30
"let g:Lf_PopupWidth = 0.5
" 弹出菜单模式
let g:Lf_WindowPosition = 'popup'
"let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2"}
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }
" 设置忽略文件
let g:Lf_WildIgnore = {
        \ 'dir': ['.svn','.git','.hg','.cache','.vscode','bin','build','lib','obj','target'],
        \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]','*.a','*.obj','*.dll','*.bin','*.out','*.jar','*.pak''*.class','*.zip','*gz','*.xz','*.bz2','*.7z','*.lha','*.deb','*.rpm','*.pdf','*.png','*.jpg','*.gif','*.bmp','*.doc*','*.xls*','*.ppt*','tags']
        \}

let g:Lf_MruWildIgnore = {
        \ 'dir': ['.svn','.git','.hg','.cache','.vscode','bin','build','lib','obj','target'],
        \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]','*.a','*.obj','*.dll','*.bin','*.out','*.jar','*.pak''*.class','*.zip','*gz','*.xz','*.bz2','*.7z','*.lha','*.deb','*.rpm','*.pdf','*.png','*.jpg','*.gif','*.bmp','*.doc*','*.xls*','*.ppt*','tags']
        \}
let g:Lf_MruFileExclude = ['*.so']
let g:Lf_StlColorscheme = 'default'
let g:Lf_PopupColorscheme = 'default'
if (g:g_use_nerdfont == 0)
else
  let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2" }
endif
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_RootMarkers = ['.git', '.svn', '.project', '.root', '.hg']
"let g:Lf_Rg = 'D:\Tools\WorkTool\Search\ripgrep\bin\rg.exe'
let g:Lf_RgConfig = [
    \ "--color=never",
    \ "--no-heading",
    \ "--with-filename",
    \ "--line-number",
    \ "--column",
    \ "--smart-case",
    \ "--hidden",
    \ "--trim",
    \ "--glob=!.git/* --glob=!.svn/* --glob=!.vscode/* --glob=!bin/* --glob=!build/* --glob=!lib/* --glob=!obj/* --glob=!target/* --glob=!.cache/*",
\ ]

"添加快捷键绑定
let g:Lf_ShortcutF = "<leader>ff"
let g:Lf_ShortcutB = "<leader>fb"
nnoremap <leader>f  <Nop>
nnoremap <silent><unique> <leader>ff :<C-U>LeaderfFile<CR>
nnoremap <leader>fg :Leaderf rg<CR>
nnoremap <silent><unique> <leader>fb :<C-U>LeaderfBuffer<CR>
"\fo再次打开搜索结果
nnoremap <leader>fo :<C-U>Leaderf! rg --recall<CR>

"F1表示outline列表
noremap <F1> :LeaderfFunction!<CR>

"高亮设定
hi clear Lf_hl_popup_window
hi! link Lf_hl_popup_window FinderNormal
hi clear Lf_hl_popupBorder
hi! link Lf_hl_popupBorder FinderBorder
hi clear Lf_hl_popup_cursor
hi! link Lf_hl_popup_cursor Cursor
hi clear Lf_hl_popup_inputText
hi! link Lf_hl_popup_inputText FinderInputText
hi clear Lf_hl_cursorline
hi! link Lf_hl_cursorline CursorLine
hi clear Lf_hl_match
hi! link Lf_hl_match PmenuMatch
hi clear Lf_hl_match0
hi! link Lf_hl_match0 PmenuMatch
hi clear Lf_hl_match1
hi! link Lf_hl_match1 PmenuMatch
hi clear Lf_hl_match2
hi! link Lf_hl_match2 PmenuMatch
hi clear Lf_hl_match3
hi! link Lf_hl_match3 PmenuMatch
hi clear Lf_hl_match4
hi! link Lf_hl_match4 PmenuMatch
hi clear Lf_hl_rgFileName
"hi! link Lf_hl_rgFileName Directory
hi! link Lf_hl_rgFileName FinderFileName
hi clear Lf_hl_rgLineNumber
hi! link Lf_hl_rgLineNumber FinderLineNumber
hi clear Lf_hl_rgColumnNumber
hi! link Lf_hl_rgColumnNumber FinderColumnNumbe


"noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
"noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
"noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
"noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
"noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
"noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
" 在选择模式下的查找
"xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
"noremap go :<C-U>Leaderf! rg --recall<CR>
" 使用gtags的设定
"let g:Lf_GtagsAutoGenerate = 0
"let g:Lf_Gtagslabel = 'native-pygments'
"noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
"noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
"noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
"noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
"noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>
