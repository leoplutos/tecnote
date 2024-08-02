return {
  -- https://github.com/jay-babu/mason-nvim-dap.nvim
  {
    "jay-babu/mason-nvim-dap.nvim",
    version = "*",
    event = "VeryLazy",
    priority = 100,
    opts = {
    },
    config = function()
      --加载插件
      require("mason-nvim-dap").setup({
        --ensure_installed = { "python", "delve" },
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          function(config)
            -- all sources with no handler get passed here
            -- Keep original functionality
            require('mason-nvim-dap').default_setup(config)
          end,
        },
      })

    end,
    keys = {
      --快捷键绑定
    },
  }
}
