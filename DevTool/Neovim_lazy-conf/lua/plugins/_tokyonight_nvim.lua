return {
  -- https://github.com/folke/tokyonight.nvim
  {
    "folke/tokyonight.nvim",
    version = "*",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    --true:启用、false:禁用
    enabled = false,
    priority = 9999, -- 插件加载优先度
    config = function()
      -- load the colorscheme here
      vim.cmd.colorscheme("tokyonight")
    end,
  },
}
