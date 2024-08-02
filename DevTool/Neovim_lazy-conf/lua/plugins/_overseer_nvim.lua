return {
  --https://github.com/stevearc/overseer.nvim
  {
    "stevearc/overseer.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()

      --加载插件
      local overseer = require('overseer')
      overseer.setup({
        strategy = "toggleterm",
        use_shell = true,
        on_create = function(term)
        end,
      })

      -- Add an environment variable for all go tasks in a specific dir
      overseer.add_template_hook({ name = "^go .*" }, function(task_defn, util)
        task_defn.env = vim.tbl_extend('force', task_defn.env or {}, {
          GO111MODULE = "on"
        })
      end)

    end,
    keys = {
      --快捷键绑定
      { "<leader>ts", mode = { "n" }, "<cmd>OverseerRun<cr>", noremap = true, silent = true, nowait = true, desc = "overseer: Open Tasks In Telescope" },
      { "<leader>tt", mode = { "n" }, "<cmd>OverseerToggle<cr>", noremap = true, silent = true, nowait = true, desc = "overseer: Toggle Tasks" },
    },
  }
}
