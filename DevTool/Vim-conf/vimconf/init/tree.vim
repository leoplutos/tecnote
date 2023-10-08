scriptencoding utf-8
"tree.vim
"nerdtree（文件树）
"https://github.com/preservim/nerdtree
"修改默认快捷键
let g:NERDTreeMapOpenSplit = 'v'
"let g:NERDTreeMapOpenInTab = '<CR>'
let g:NERDTreeMapOpenInTab = 't'
let g:NERDTreeMapOpenInTabSilent = 'T'
let g:NERDTreeMapRefresh = '<C-l>'
"加载
packadd nerdtree

"显示隐藏文件
let NERDTreeShowHidden = 1
let NERDTreeNaturalSort = 1
let NERDTreeChDirMode = 3
let NERDTreeDirArrowCollapsible = '-'
"let NERDTreeDirArrowExpandable = '>'
"let NERDTreeDirArrowCollapsible = 'v'
"let NERDTreeNodeDelimiter = "\x07"
"不显示头部的帮助信息
let NERDTreeMinimalUI = 1

"添加事件init(NerdTree初始化的时候运行的命令)
call g:NERDTreePathNotifier.AddListener("init", "NerdTreeInitListener")
function! NerdTreeInitListener(event)
  "因为使用了vim-startify（启动页导航）插件，所以需要进入每个nvim-tree的时候刷新设置
  " 使用GetProjectRoot()函数找到跟目录
  let g:g_s_projectrootpath = GetProjectRoot()
  " 在工程跟路径下递归查找子文件
  "set path+=**
  exec 'set path='
  exec 'set path+=' . g:g_s_projectrootpath . '/**'
  " 搜索除外内容
  set wildignore=*.o,*.obj,*.dll,*.exe,*.bin,*.so*,*.a,*.out,*.jar,*.pak,*.class,*.zip,*gz,*.xz,*.bz2,*.7z,*.lha,*.deb,*.rpm,*.pdf,*.png,*.jpg,*.gif,*.bmp,*.doc*,*.xls*,*.ppt*,tags,.tags,.hg,.gitignore,.gitattributes,.git/**,.svn/**,.settings/**,.vscode/**
  " 设定环境变量
  let $PYTHONPATH = ''
  let $PYTHONPATH .= g:g_s_projectrootpath
  let $PYTHONPATH .= ';'.g:g_s_projectrootpath.'\src'
  let $PYTHONPATH .= ';'.g:g_s_projectrootpath.'\src\com'
endfunction

"快捷键绑定
nnoremap <Leader>e :NERDTreeToggle<CR>

"高亮设定
hi clear NERDTreeDirSlash
hi! link NERDTreeDirSlash Directory

"defx.nvim（文件树）
"https://github.com/Shougo/defx.nvim
"https://github.com/roxma/nvim-yarp
"https://github.com/roxma/vim-hug-neovim-rpc
"packadd defx.nvim
"packadd nvim-yarp
"packadd vim-hug-neovim-rpc
"
"autocmd FileType defx call s:defx_my_settings()
"function! s:defx_my_settings() abort
"  " Define mappings
"  nnoremap <silent><buffer><expr> <CR> defx#do_action('open')
"  nnoremap <silent><buffer><expr> c    defx#do_action('copy')
"  nnoremap <silent><buffer><expr> m    defx#do_action('move')
"  nnoremap <silent><buffer><expr> p    defx#do_action('paste')
"  nnoremap <silent><buffer><expr> l    defx#do_action('open')
"  nnoremap <silent><buffer><expr> E    defx#do_action('open', 'vsplit')
"  nnoremap <silent><buffer><expr> P    defx#do_action('preview')
"  nnoremap <silent><buffer><expr> o    defx#do_action('open_tree', 'toggle')
"  nnoremap <silent><buffer><expr> K    defx#do_action('new_directory')
"  nnoremap <silent><buffer><expr> N    defx#do_action('new_file')
"  nnoremap <silent><buffer><expr> M    defx#do_action('new_multiple_files')
"  nnoremap <silent><buffer><expr> C    defx#do_action('toggle_columns', 'mark:indent:icon:filename:type:size:time')
"  nnoremap <silent><buffer><expr> S    defx#do_action('toggle_sort', 'time')
"  nnoremap <silent><buffer><expr> d    defx#do_action('remove')
"  nnoremap <silent><buffer><expr> r    defx#do_action('rename')
"  nnoremap <silent><buffer><expr> !    defx#do_action('execute_command')
"  nnoremap <silent><buffer><expr> x    defx#do_action('execute_system')
"  nnoremap <silent><buffer><expr> yy   defx#do_action('yank_path')
"  nnoremap <silent><buffer><expr> .    defx#do_action('toggle_ignored_files')
"  nnoremap <silent><buffer><expr> ;    defx#do_action('repeat')
"  nnoremap <silent><buffer><expr> h    defx#do_action('cd', ['..'])
"  nnoremap <silent><buffer><expr> ~    defx#do_action('cd')
"  nnoremap <silent><buffer><expr> q    defx#do_action('quit')
"  nnoremap <silent><buffer><expr> <Space>   defx#do_action('toggle_select') . 'j'
"  nnoremap <silent><buffer><expr> *    defx#do_action('toggle_select_all')
"  nnoremap <silent><buffer><expr> j    line('.') == line('$') ? 'gg' : 'j'
"  nnoremap <silent><buffer><expr> k    line('.') == 1 ? 'G' : 'k'
"  nnoremap <silent><buffer><expr> <C-l>    defx#do_action('redraw')
"  nnoremap <silent><buffer><expr> <C-g>    defx#do_action('print')
"  nnoremap <silent><buffer><expr> cd   defx#do_action('change_vim_cwd')
"endfunction
