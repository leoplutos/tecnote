return {
  --https://github.com/johnfrankmorgan/whitespace.nvim
  {
    "johnfrankmorgan/whitespace.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()

      --加载插件
      local whitespace = require('whitespace-nvim')
      whitespace.setup({
        -- 行尾空格高亮
        highlight = 'ExtraWhitespace',
        -- 忽略文件类型
        ignored_filetypes = {
          'lspinfo',
          'checkhealth',
          'help',
          'man',
          'gitcommit',
          'TelescopePrompt',
          'startify',
          'netrw',
          'ctrlp',
          'nerdtree',
          'VimspectorPrompt',
          'NvimTree',
          'cmp_menu',
          'cmp_docs',
          'Outline',
          'toggleterm',
          'flash_prompt',
          'dashboard',
          'mason',
          'which_key',
          'Trouble',
        },
        -- 忽略终端缓冲区
        ignore_terminal = true,
        -- 返回到上一个修剪空格后的位置
        return_cursor = true,
      })

    end,
    keys = {
      --快捷键绑定
      { "<leader>tw", mode = { "n" }, function() require('whitespace-nvim').trim() end, noremap = true, silent = true, nowait = true, desc = "Delete Trailing Whitespace" },
    },
  }
}
