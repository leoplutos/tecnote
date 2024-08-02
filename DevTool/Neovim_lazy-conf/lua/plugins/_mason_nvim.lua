return {
  -- https://github.com/williamboman/mason.nvim
  {
    "williamboman/mason.nvim",
    version = "*",
    event = "VeryLazy",
    priority = 51,
    opts = {
    },
    config = function()
      --加载插件
      require('mason').setup({
        install_root_dir = vim.g.mason_nvim_root,
        github = {
            download_url_template = vim.g.github_url .. "/%s/releases/download/%s/%s",
        },
        pip = {
            upgrade_pip = false,
            install_args = { "-i", vim.g.pip_url },
        },
        ui = {
          border = 'rounded',
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗'
          }
        }
      })
    end,
    keys = {
      --快捷键绑定
      { "<leader>ms", mode = { "n" }, "<Cmd>Mason<CR>", noremap = true, silent = true, nowait = true, desc = "mason: Open Mason.nvim" },
    },
  }
}
