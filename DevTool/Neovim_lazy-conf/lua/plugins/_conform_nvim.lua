return {
  --https://github.com/stevearc/conform.nvim
  {
    "stevearc/conform.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()

      --加载插件
      local conform = require('conform')
      conform.setup({
        -- 定义格式化程序
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "black" },
          -- 当没有其他格式化程序可用时，使用 LSP 格式
          rust = { "rustfmt", lsp_format = "fallback" },
          -- 运行第一个可用的格式化程序
          javascript = { "prettier", "prettierd", stop_after_first = true },
        },
      })

    end,
    keys = {
      --快捷键绑定
      { "<leader>fm", mode = { "n" }, function() require("conform").format({ async = true }) end, noremap = true, silent = true, nowait = true, desc = "Conform Format" },
    },
  }
}
