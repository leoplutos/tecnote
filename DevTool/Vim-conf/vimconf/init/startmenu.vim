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
  \    { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
  "\    { 'type': 'commands',  'header': ['   Commands']       },
  \]
"设置工程书签
let g:startify_bookmarks = [
  \    'D:/WorkSpace/C/CSampleProject',
  \    'D:/WorkSpace/Java/JavaBatchProject',
  \    'D:/WorkSpace/Java/JavaMavenBatProject',
  \    'D:/WorkSpace/Python/PythonSampleProject',
  \    'D:/WorkSpace/Rust/minigrep',
  \    'D:/WorkSpace/Go/GoSampleProject',
  \    'D:/WorkSpace/Vue/VueTestProject',
  \    'D:/WorkSpace/Dotnet/DotnetSampleProject',
  \    'D:/WorkSpace/Test/LanguagTest',
\]
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
"let g:startify_custom_footer = [
"  \ '+------------------------------+',
"  \ '| Do one thing and do it well. |',
"  \ '+------------------------------+',
"\]
"按下Ctrl+F1表示启动页导航
noremap <C-F1> :Startify<CR>
