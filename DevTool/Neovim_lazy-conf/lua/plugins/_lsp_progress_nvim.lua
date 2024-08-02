return {
  -- https://github.com/linrongbin16/lsp-progress.nvim
  {
    "linrongbin16/lsp-progress.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      --加载插件
      require('lsp-progress').setup({
        --具体设定在_lualine_nvim.lua
      })

      -- listen lsp-progress event and refresh lualine
      vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
      vim.api.nvim_create_autocmd("User", {
        group = "lualine_augroup",
        pattern = "LspProgressStatusUpdated",
        callback = require("lualine").refresh,
      })
    end,
  }
}
