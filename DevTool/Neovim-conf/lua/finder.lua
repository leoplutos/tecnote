--finder.lua
--配置路径为 %LOCALAPPDATA%\nvim\lua
--telescope.nvim插件设置
--https://github.com/nvim-telescope/telescope.nvim
--https://github.com/nvim-lua/plenary.nvim
--https://github.com/nvim-telescope/telescope-ui-select.nvim

-- 加载telescope.nvim插件
vim.cmd('packadd plenary.nvim')
vim.cmd('packadd telescope.nvim')
vim.cmd('packadd telescope-ui-select.nvim')

--使用telescope.nvim需要修改ambiwidth
--进入Telescope之前执行的命令：set ambiwidth=single
--关闭Telescope执行的命令：set ambiwidth=double
vim.cmd([[
  set ambiwidth=single

  augroup UserTelescopeGroup
    autocmd!
    "autocmd User TelescopeFindPre set ambiwidth=single
    "autocmd FileType TelescopePrompt autocmd BufLeave <buffer> set ambiwidth=double
    "设定Previewer的行号
    autocmd User TelescopePreviewerLoaded setlocal number
  augroup END
]])

--此函数从工程根路径查找内容
function vim.find_files_from_project_root()
  local function get_root_dir()
    local dot_root_path = vim.fn.finddir(".root", ".;")
    return vim.fn.fnamemodify(dot_root_path, ":h")
  end
  local find_opts = {
    cwd = get_root_dir(),
    hidden = true,
  }
  require("telescope.builtin").find_files(find_opts)
end

--此函数从工程根路径grep内容
function vim.grep_files_from_project_root()
  local function get_root_dir()
    local dot_root_path = vim.fn.finddir(".root", ".;")
    return vim.fn.fnamemodify(dot_root_path, ":h")
  end
  local grep_opts = {
    cwd = get_root_dir(),
  }
  require("telescope.builtin").live_grep(grep_opts)
end

--添加快捷键绑定
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', '<Nop>', {})
--vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>ff', vim.find_files_from_project_root, {})
--vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fg', vim.grep_files_from_project_root, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>fr', builtin.resume, {})

require('telescope').setup{
  defaults = {
    --border = true,
    --borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
    --borderchars = { "-", "│", "-", "│", "╭", "╮", "╯", "╰" },
    --winblend = 10,
    layout_config = {
    },
    mappings = {
      i = {
        ["<C-h>"] = "which_key"
      }
    },
    history = false,
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--trim",
      -- "--glob=!.git/* --glob=!.svn/* --glob=!.vscode/* --glob=!bin/* --glob=!build/* --glob=!lib/* --glob=!obj/* --glob=!target/*",
      -- "--glob=!.git\\* --glob=!.svn\\* --glob=!.vscode\\* --glob=!bin\\* --glob=!build\\* --glob=!lib\\* --glob=!obj\\* --glob=!target\\*",
    },
    file_ignore_patterns = {
      --忽略文件夹设定
      "^.git/",
      "^.svn/",
      "^.vscode/",
      "^.cache/",
      "^bin/",
      "^build/",
      "^lib/",
      "^obj/",
      "^target/",
      "^node_modules/",
      "^.git\\",
      "^.svn\\",
      "^.vscode\\",
      "^.cache\\",
      "^bin\\",
      "^build\\",
      "^lib\\",
      "^obj\\",
      "^target\\",
      "^node_modules\\",
      --忽略文件设定
      "%.o",
      "%.so",
      "%.pyc",
      "%.pyo",
      "%.a",
      "%.obj",
      "%.dll",
      "%.bin",
      "%.out",
      "%.jar",
      "%.pak",
      "%.class",
      "%.zip",
      "%.gz",
      "%.deb",
      "%.pdf",
      "%.png",
      "%.jpg",
      "%.gif",
      "%.bmp",
      "%.doc",
      "%.xls",
      "%.ppt",
    }
  },
  pickers = {
    --find_files = {
    --  find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
    --},
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        layout_strategy = "vertical",
        layout_config = {
          prompt_position = "bottom",
          vertical = {
            width = 0.6,
            height = 100,
          },
        },
      },
      specific_opts = {
        codeactions = false,
      }
    }
  }
}
--载入telescope-ui-select.nvim
require('telescope').load_extension('ui-select')

--telescope.nvim插件的高亮设定
vim.cmd([[
hi clear TelescopeNormal
hi! link TelescopeNormal FinderNormal
"hi clear TelescopePromptNormal
"hi! link TelescopePromptNormal FinderInputText
hi clear TelescopeTitle
hi! link TelescopeTitle Title
hi clear TelescopeBorder
hi! link TelescopeBorder FinderBorder
hi clear TelescopePromptCounter
hi! link TelescopePromptCounter ThinTitle
hi clear TelescopeMatching
hi! link TelescopeMatching PmenuMatch
"hi TelescopePromptPrefix   guifg=red
]])
