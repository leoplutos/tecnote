scriptencoding utf-8
"startmenu.vim

"vim-startify（启动页导航）
"https://github.com/mhinz/vim-startify
packadd vim-startify
"设置显示列表
let g:startify_lists = [
  "\    { 'type': 'files',     'header': ['   MRU']            },
  "\    { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
  "\    { 'type': 'sessions',  'header': ['   Sessions']       },
  \    { 'type': 'bookmarks', 'header': ['   ProjectList']      },
  "\    { 'type': 'commands',  'header': ['   Commands']       },
  \]
"设置工程书签
if (g:g_i_osflg == 1 || g:g_i_osflg == 2 || g:g_i_osflg == 3)
  let g:startify_bookmarks = [
    \    'D:/WorkSpace/C/CSampleProject',
    \    'D:/WorkSpace/Java/JavaMavenBatProject',
    \    'D:/WorkSpace/Python/PythonSampleProject',
    \    'D:/WorkSpace/Rust/minigrep',
    \    'D:/WorkSpace/Go/GoSampleProject',
    \    'D:/WorkSpace/Dotnet/DotnetSampleProject',
    \    'D:/WorkSpace/Kotlin/KotlinSampleProject',
    \    'D:/WorkSpace/Vue/VueTS',
    \    'D:/WorkSpace/Angular/AngularTS',
    \    'D:/WorkSpace/React/ReactTS',
    \    'D:/WorkSpace/TypeScript/TSSampleProject',
    \    'D:/WorkSpace/Test/LanguagTest',
  \]
else
  let g:startify_bookmarks = [
    \    '~/work/lch/workspace/c/CSampleProject',
    \    '~/work/lch/workspace/java/JavaMavenBatProject',
    \    '~/work/lch/workspace/python/PythonSampleProject',
    \    '~/work/lch/workspace/rust/minigrep',
    \    '~/work/lch/workspace/go/GoSampleProject',
    \    '~/work/lch/workspace/kotlin/KotlinSampleProject',
    \    '~/work/lch/workspace/vue/VueTS',
    \    '~/work/lch/workspace/angular/AngularTS',
    \    '~/work/lch/workspace/react/ReactTS',
    \    '~/work/lch/workspace/typescript/TSSampleProject',
    \    '~/work/lch/workspace/test/LanguagTest',
  \]
endif
"起始页显示的列表长度
let g:startify_files_number = 20
"自动加载session
"let g:startify_session_autoload = 1
"过滤列表，支持正则表达式
"let g:startify_skiplist = [
"  \    '^/tmp',
"\]
"自定义Header和Footer
let g:startify_custom_header = [
  \ ' ⠀⠀⠀⠀⠀⠀⢀⣀⡠⠤⠤⠴⠶⠶⠶⠶⠦⠤⠤⢄⣀⡀⠀⠀⠀⠀⠀⠀⠀',
  \ ' ⠀⠀⠀⣠⠖⢛⣩⣤⠂⠀⠀⠀⣶⡀⢀⣶⠀⠀⠀⠐⣤⣍⡛⠲⣄⠀⠀⠀⠀',
  \ ' ⢀⡴⢋⣴⣾⣿⣿⣿⠀⠀⠀⠀⣿⣿⣿⣿⠀⠀⠀⠀⣿⣿⣿⣷⣦⡙⢦⡀⠀',
  \ ' ⡞⢠⣿⣿⣿⣿⣿⣿⣷⣤⣤⣴⣿⣿⣿⣿⣦⣤⣤⣾⣿⣿⣿⣿⣿⣿⡆⢳⠀',
  \ ' ⡁⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢈⠆',
  \ ' ⢧⡈⢿⣿⣿⣿⠿⠿⣿⡿⠿⠿⣿⣿⣿⣿⠿⠿⢿⣿⠿⠿⣿⣿⣿⡿⢁⡼⠀',
  \ ' ⠀⠳⢄⡙⠿⣇⠀⠀⠈⠁⠀⠀⠈⢿⡿⠁⠀⠀⠈⠁⠀⠀⣸⠿⢋⡠⠞⠀⠀',
  \ ' ⠀⠀⠀⠉⠲⢤⣀⡀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⢀⣀⡤⠖⠉⠀⠀⠀⠀',
  \ ' ⠀⠀⠀⠀⠀⠀⠈⠉⠉⠐⠒⠒⠒⠒⠒⠒⠒⠒⠒⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀',
\]
let g:startify_custom_footer = [
  \ '',
  \ ' 🚀 Sharp tools make good work.',
  \ '',
\]

"高亮设定
hi clear StartifyHeader
hi! link StartifyHeader StartMenuHeader
hi clear StartifySelect
hi! link StartifySelect StartMenuHeader
hi clear StartifyFooter
hi! link StartifyFooter StartMenuFooter
hi clear StartifySection
hi! link StartifySection StartMenuProjectTitle
hi clear StartifyNumber
hi! link StartifyNumber StartMenuProjectIcon
hi clear StartifyPath
hi! link StartifyPath StartMenuFiles
hi clear StartifyFile
hi! link StartifyFile StartMenuFiles
hi clear StartifySlash
hi! link StartifySlash StartMenuFiles
"StartifyBracket xxx links to Delimiter
"StartifySpecial xxx links to Comment
"StartifyVar    xxx links to StartifyPath

"按下Ctrl+F1表示启动页导航
noremap <C-F1> :Startify<CR>
noremap <Leader>me :Startify<CR>
