return {
  -- https://github.com/nvimdev/dashboard-nvim
  {
    "nvimdev/dashboard-nvim",
    version = "*",
    event = 'VimEnter',
    priority = 49,
    config = function()

      --设定目录
      local dashboard_bookmarks = {}
      dashboard_bookmarks[#dashboard_bookmarks + 1] = 'D:/WorkSpace/C/CSampleProject'
      dashboard_bookmarks[#dashboard_bookmarks + 1] = 'D:/WorkSpace/Java/JavaMavenBatProject'
      local custom_center = {}
      for i = 1, #dashboard_bookmarks do
        table.insert(custom_center, i, {
          icon = '󰏓  ',
          icon_hl = 'StartMenuProjectIcon',
          desc = dashboard_bookmarks[i],
          desc_hl = 'StartMenuFiles',
          key = tostring(i-1),
          keymap = '',
          key_hl = 'StartMenuShortCut',
          key_format = ' %s', -- remove default surrounding `[]`
          action = 'e ' .. dashboard_bookmarks[i]
        })
      end

      --加载插件
      require('dashboard').setup {
        theme = 'doom',
        config = {
          header = {
          '',
          ' ██████╗  █████╗ ███████╗██╗  ██╗██████╗  ██████╗  █████╗ ██████╗ ██████╗  ',
          ' ██╔══██╗██╔══██╗██╔════╝██║  ██║██╔══██╗██╔═══██╗██╔══██╗██╔══██╗██╔══██╗ ',
          ' ██║  ██║███████║███████╗███████║██████╔╝██║   ██║███████║██████╔╝██║  ██║ ',
          ' ██║  ██║██╔══██║╚════██║██╔══██║██╔══██╗██║   ██║██╔══██║██╔══██╗██║  ██║ ',
          ' ██████╔╝██║  ██║███████║██║  ██║██████╔╝╚██████╔╝██║  ██║██║  ██║██████╔╝ ',
          ' ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝  ',
          '',
          },
          week_header = {
            enable = true,
          },
          center = custom_center,
          footer = {
          '',
          ' 🚀 Sharp tools make good work.',
          '',
          }
        }
      }

      --高亮设定
      vim.cmd([[
      hi clear DashboardHeader
      hi! link DashboardHeader StartMenuHeader
      hi clear DashboardFooter
      hi! link DashboardFooter StartMenuFooter
      hi clear DashboardProjectTitle
      hi! link DashboardProjectTitle StartMenuProjectTitle
      hi clear DashboardProjectTitleIcon
      hi! link DashboardProjectTitleIcon StartMenuProjectTitleIcon
      hi clear DashboardProjectIcon
      hi! link DashboardProjectIcon StartMenuProjectIcon
      hi clear DashboardMruTitle
      hi! link DashboardMruTitle StartMenuMruTitle
      hi clear DashboardMruIcon
      hi! link DashboardMruIcon StartMenuMruIcon
      hi clear DashboardFiles
      hi! link DashboardFiles StartMenuFiles
      hi clear DashboardShortCut
      hi! link DashboardShortCut StartMenuShortCut
      "hi clear DashboardShortCutIcon
      "hi! link DashboardShortCutIcon StartMenuShortCut
      ]])
      --vim.cmd.highlight('default link IndentLine Comment')

      vim.cmd([[Dashboard]])
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'}},
    keys = {
      --快捷键绑定
      { "<C-F1>", mode = { "n" }, "<cmd>Dashboard<cr>", noremap = true, silent = true, nowait = true, desc = "dashboard: Open Dashboard" },
      { "<Leader>me", mode = { "n" }, "<cmd>Dashboard<cr>", noremap = true, silent = true, nowait = true, desc = "dashboard: Open Dashboard" },
    },
  },
}
