--tree.lua
--配置路径为 %LOCALAPPDATA%\nvim\lua
--nvim-tree.lua插件设置
--https://github.com/nvim-tree/nvim-tree.lua
--https://github.com/nvim-tree/nvim-web-devicons

-- 加载nvim-tree插件
vim.cmd('packadd nvim-tree.lua')
-- 加载nvim-web-devicons插件
vim.cmd('packadd nvim-web-devicons')

-- 禁用netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- 创建nvim-tree缓冲区时运行的函数
local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- 自定义快捷键
  vim.keymap.set('n', '<CR>', api.node.open.tab,        opts('Open: New Tab'))
  vim.keymap.set('n', 't',    api.node.open.tab,        opts('Open: New Tab'))
  vim.keymap.set('n', 'v',    api.node.open.edit,       opts('Open'))
  vim.keymap.set('n', '<C-l>',  api.tree.reload,       opts('Refresh'))

  -- 添加事件Event.TreeRendered(每次nvim-tree重绘的时候运行的命令)
  local Event = api.events.Event
  api.events.subscribe(Event.TreeRendered, function(data)
    vim.cmd([[
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
    ]])
  end)

end

-- 加载nvim-tree参数
require('nvim-tree').setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
    icons = {
      show = {
        --file = false,
        file = true,
        --folder = false,
        folder = true,
        folder_arrow = true,
        git = false,
        modified = false,
      },
      glyphs = {
        --bookmark = "=",
        --folder = {
        --  arrow_closed = "⏵",
        --  arrow_open = "⏷",
        --},
      },
    },
  },
  filters = {
    -- dotfiles = true,
    dotfiles = false,
  },
  git = {
    enable = false,
  },
  on_attach = my_on_attach,
})

--nvim-tree.lua插件的高亮设定
vim.cmd([[
hi clear NvimTreeNormal
hi! link NvimTreeNormal FileExplorerNormal
hi clear NvimTreeRootFolder
hi! link NvimTreeRootFolder Statement
]])

--nvim-tree.lua插件的快捷键绑定
vim.cmd([[
nnoremap <Leader>e :NvimTreeToggle<CR>
]])
