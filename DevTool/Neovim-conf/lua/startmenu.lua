--startmenu.lua
--配置路径为 %LOCALAPPDATA%\nvim\lua
--dashboard-nvim插件设置
--https://github.com/nvimdev/dashboard-nvim

-- 加载dashboard-nvim插件设置
vim.cmd('packadd dashboard-nvim')

--设置工程书签
local dashboard_bookmarks = {}
if (vim.g.g_i_osflg == 1 or vim.g.g_i_osflg == 2 or vim.g.g_i_osflg == 3) then
  -- 添加新元素到数组末尾
  dashboard_bookmarks[#dashboard_bookmarks + 1] = 'D:/WorkSpace/C/CSampleProject'
  dashboard_bookmarks[#dashboard_bookmarks + 1] = 'D:/WorkSpace/Java/JavaMavenBatProject'
  dashboard_bookmarks[#dashboard_bookmarks + 1] = 'D:/WorkSpace/Python/PythonSampleProject'
  dashboard_bookmarks[#dashboard_bookmarks + 1] = 'D:/WorkSpace/Rust/minigrep'
  dashboard_bookmarks[#dashboard_bookmarks + 1] = 'D:/WorkSpace/Go/GoSampleProject'
  dashboard_bookmarks[#dashboard_bookmarks + 1] = 'D:/WorkSpace/Dotnet/DotnetSampleProject'
  dashboard_bookmarks[#dashboard_bookmarks + 1] = 'D:/WorkSpace/Kotlin/KotlinSampleProject'
  dashboard_bookmarks[#dashboard_bookmarks + 1] = 'D:/WorkSpace/Vue/VueTS'
  dashboard_bookmarks[#dashboard_bookmarks + 1] = 'D:/WorkSpace/Angular/AngularTS'
  dashboard_bookmarks[#dashboard_bookmarks + 1] = 'D:/WorkSpace/React/ReactTS'
  dashboard_bookmarks[#dashboard_bookmarks + 1] = 'D:/WorkSpace/TypeScript/TSSampleProject'
  dashboard_bookmarks[#dashboard_bookmarks + 1] = 'D:/WorkSpace/Test/LanguagTest'

else
  -- 添加新元素到数组末尾
  dashboard_bookmarks[#dashboard_bookmarks + 1] = '~/work/lch/workspace/c/CSampleProject'
  dashboard_bookmarks[#dashboard_bookmarks + 1] = '~/work/lch/workspace/java/JavaMavenBatProject'
  dashboard_bookmarks[#dashboard_bookmarks + 1] = '~/work/lch/workspace/python/PythonSampleProject'
  dashboard_bookmarks[#dashboard_bookmarks + 1] = '~/work/lch/workspace/rust/minigrep'
  dashboard_bookmarks[#dashboard_bookmarks + 1] = '~/work/lch/workspace/go/GoSampleProject'
  dashboard_bookmarks[#dashboard_bookmarks + 1] = '~/work/lch/workspace/kotlin/KotlinSampleProject'
  dashboard_bookmarks[#dashboard_bookmarks + 1] = '~/work/lch/workspace/vue/VueTS'
  dashboard_bookmarks[#dashboard_bookmarks + 1] = '~/work/lch/workspace/angular/AngularTS'
  dashboard_bookmarks[#dashboard_bookmarks + 1] = '~/work/lch/workspace/react/ReactTS'
  dashboard_bookmarks[#dashboard_bookmarks + 1] = '~/work/lch/workspace/typescript/TSSampleProject'
  dashboard_bookmarks[#dashboard_bookmarks + 1] = '~/work/lch/workspace/test/LanguagTest'
end

--定义工程列表数据源
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

require('dashboard').setup({
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
})

--dashboard-nvim插件的高亮设定
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

--添加快捷键绑定
vim.keymap.set('n', '<C-F1>', ':Dashboard<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>me', ':Dashboard<CR>', { noremap = true })
