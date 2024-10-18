return {
  --https://github.com/nvim-neo-tree/neo-tree.nvim
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    --true:启用、false:禁用
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
      --加载插件
      require("neo-tree").setup()
    end,
    keys = {
      --快捷键绑定
      { "<leader>e", "<cmd>Neotree toggle<cr>", noremap = true, silent = true, nowait = true, desc = "neo-tree: Toggle NeoTree" },
      --{ "<leader>ew", "<cmd>Neotree D:/WorkSpace<cr>", noremap = true, silent = true, nowait = true, desc = "neo-tree: Toggle NeoTree" },
    },
  }
}
