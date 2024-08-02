return {
  -- https://github.com/folke/which-key.nvim
  {
    "folke/which-key.nvim",
    version = "*",
    event = "VeryLazy",
    opts = {
    },
    config = function()
      --加载插件
      require('which-key').setup({
        win = {
          border = "rounded",
        }
      })
      
      --高亮设定
      --vim.cmd.highlight({ "WhichKey", "term=none cterm=none gui=none guifg=#e6e6fa" })
      --vim.cmd.highlight({ "WhichKeyBorder", "term=none cterm=none gui=none guifg=#4678a4 guibg=#252526" })
      --vim.cmd.highlight({ "WhichKeyNormal", "term=none cterm=none gui=none guibg=#1e2030" })
      vim.cmd.highlight({ "WhichKeyTitle", "term=none cterm=none gui=none guifg=#f39c12 guibg=#252526" })
      --vim.cmd.highlight({ "link", "WhichKeyTitle", "FloatTitle" })
    end,
    keys = {
      --快捷键绑定
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        noremap = true,
        --silent = true,
        --nowait = true,
        desc = "which-key: Buffer Local Keymaps",
      },
    },
  },
}
