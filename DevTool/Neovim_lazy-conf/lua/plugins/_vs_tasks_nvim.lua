return {
  --https://github.com/EthanJWright/vs-tasks.nvim
  {
    "EthanJWright/vs-tasks.nvim",
    version = "*",
    event = "VeryLazy",
    --true:启用、false:禁用
    enabled = false,
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      --加载插件
      require('vstask').setup({
      })
    end,
    keys = {
      --快捷键绑定
      { "<leader>ts", mode = { "n" }, function() require("telescope").extensions.vstask.tasks() end, noremap = true, silent = true, nowait = true, desc = "vs-tasks: Open Tasks In Telescope" },
    },
  }
}
