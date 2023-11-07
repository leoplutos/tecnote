--imselect.lua
--配置路径为 %LOCALAPPDATA%\nvim\lua
--im-select.nvim插件设置
--https://github.com/keaising/im-select.nvim

-- 加载im-select.nvim插件设置
vim.cmd('packadd im-select.nvim')

local imselect_config = {}
--根据OS设定命令
if (vim.g.g_i_osflg == 1 or vim.g.g_i_osflg == 2 or vim.g.g_i_osflg == 3) then
  imselect_config.command = 'D:/Tools/WorkTool/Text/im-select/x64/im-select.exe'
  imselect_config.default = '1033'
elseif (vim.g.g_i_osflg == 4) then
  imselect_config.command = '/usr/local/bin/im-select'
  imselect_config.default = 'com.apple.keylayout.ABC'
else
  imselect_config.command = 'fcitx5-remote'
  imselect_config.default = 'keyboard-us'
end

require('im_select').setup({
  default_im_select  = imselect_config.default,
  default_command = imselect_config.command,
  --set_default_events = { "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" },
  --set_previous_events = { "InsertEnter" },
  set_previous_events = {},
  keep_quiet_on_no_binary = false,
  async_switch_im = false
})
