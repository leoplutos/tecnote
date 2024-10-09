return {
  -- https://github.com/nvim-tree/nvim-tree.lua
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    --true:启用、false:禁用
    enabled = true,
    priority = 48,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    init = function()
      -- 禁用 netrw
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    config = function()
      --加载插件
      require("nvim-tree").setup {
        --reload_on_bufenter = true,
        respect_buf_cwd = true,
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 37,
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
        filesystem_watchers = {
          enable = true,
          debounce_delay = 50,
          ignore_dirs = {
            "/.git",
            "/.svn",
            "/bin",
            "/obj",
            "/target",
            "/build",
            "/.vs",
            "/.settings",
            "/.metadata",
            "/.venv",
            "/__pycache__",
            "/node_modules",
            "/dist",
            "/.zig-cache",
            "/zig-out",
          },
        },
        on_attach = function(bufnr)
          -- 创建nvim-tree缓冲区时运行的函数
          local api = require "nvim-tree.api"
          local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end
          -- default mappings
          api.config.mappings.default_on_attach(bufnr)
          -- 自定义快捷键
          --vim.keymap.set('n', '<CR>', api.node.open.tab,        opts('Open New Tab'))
          vim.keymap.set('n', 't',    api.node.open.tab,        opts('Open New Tab'))
          vim.keymap.set('n', 'v',    api.node.open.edit,       opts('Open'))
          vim.keymap.set('n', '<C-l>',  api.tree.reload,        opts('Refresh'))
          vim.keymap.set('n', 'p',    api.node.open.preview,    opts('Open Preview'))
          --删除默认的TAB键绑定
          vim.keymap.del('n', '<Tab>', { buffer = bufnr })
          -- 添加事件Event.TreeRendered(每次nvim-tree重绘的时候运行的命令)
          local Event = api.events.Event
          api.events.subscribe(Event.TreeRendered, function(data)
            --vim.cmd([[]])
          end)
        end,
      }

      --高亮设定
      vim.cmd([[
      hi clear NvimTreeNormal
      hi! link NvimTreeNormal FileExplorerNormal
      hi clear NvimTreeRootFolder
      hi! link NvimTreeRootFolder Statement
      ]])

    end,
    keys = {
      --快捷键绑定
      { "<leader>e", mode = { "n" }, "<cmd>NvimTreeToggle<cr>", noremap = true, silent = true, nowait = true, desc = "nvim-tree:Toggle NvimTree" },
    },
  }
}
