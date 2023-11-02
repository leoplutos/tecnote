--wezterm设定文件
--内容有参考 https://github.com/KevinSilvester/wezterm-config

local wezterm = require 'wezterm'
local act = wezterm.action
local config = {}
--是否使用NerdFont，0：不使用，1：使用
local l_use_nerdfont = 1

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- 基础设定
config.check_for_updates = false
--不自动加载配置文件
config.automatically_reload_config = false
--根据OS设定内容
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  --Windows
  config.default_prog = { 'cmd.exe', '/k', 'D:/Tools/WorkTool/Cmd/cmdautorun.cmd', '1' }
elseif wezterm.target_triple == 'x86_64-apple-darwin' then
  --MacOS
  config.default_prog = { '/bin/bash', '-l' }
else
  --Linux
  config.default_prog = { '/bin/bash', '-l' }
end
--config.default_gui_startup_args = { 'ssh', 'lchuser@172.20.115.248:8122' }
--config.default_cwd = "~"
config.launch_menu = {}
config.set_environment_variables = {}
--config.color_scheme = 'Sakura'
config.font = wezterm.font_with_fallback({
        --'等距更纱黑体 SC Nerd Font Light',
        '等距更纱黑体 SC Nerd Font',
        --'更紗等幅ゴシック J Nerd Font light',
        '更紗等幅ゴシック J Nerd Font',
    })
--config.font = wezterm.font('等距更纱黑体 SC Nerd Font', { weight = 'Bold', italic = false })
config.font_size = 12.0
--config.line_height = 0.9
--config.line_height = 1.0
--config.cell_width = 1.0
config.freetype_load_target = 'Normal' ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
config.freetype_render_target = 'Normal' ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
config.initial_cols = 145
config.initial_rows = 40
--config.window_decorations = "TITLE | RESIZE"
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.enable_scroll_bar = true
config.exit_behavior = "Close"
--config.animation_fps = 60
--config.max_fps = 60
--config.front_end = 'WebGpu'
--config.webgpu_power_preference = 'HighPerformance'
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = true
config.tab_max_width = 25
config.show_tab_index_in_tab_bar = false
config.switch_to_last_active_tab_when_closing_tab = true

--颜色设定
config.colors = {
  foreground = '#DADADA',
  background = '#1D1F21',
  cursor_bg = '#afffff',
  cursor_fg = '#1e1e1e',
  cursor_border = '#afffff',
  --selection_fg = '#DADADA',
  selection_bg = '#585b70',
  scrollbar_thumb = '#585b70',
  split = '#2997cc',
  ansi = {
    '#000000',
    '#CD3131',
    '#0DBC79',
    '#E5E510',
    '#2472C8',
    '#BC3FBC',
    '#11A8CD',
    '#E5E5E5',
  },
  brights = {
    '#666666',
    '#F14C4C',
    '#23D18B',
    '#F5F543',
    '#3B8EEA',
    '#D670D6',
    '#29B8DB',
    '#E5E5E5',
  },
  --indexed = { [136] = '#af8700' },
  compose_cursor = '#ffa500',
  copy_mode_active_highlight_bg = { Color = '#000000' },
  copy_mode_active_highlight_fg = { AnsiColor = 'Black' },
  copy_mode_inactive_highlight_bg = { Color = '#52ad70' },
  copy_mode_inactive_highlight_fg = { AnsiColor = 'White' },
  quick_select_label_bg = { Color = '#cd853f' },
  quick_select_label_fg = { Color = '#ffffff' },
  quick_select_match_bg = { Color = '#2472c8' },
  quick_select_match_fg = { Color = '#ffffff' },
  visual_bell = '#313244',

  tab_bar = {
    background = '#2e2e2e',
    inactive_tab_edge = '#2e2e2e',
    active_tab = {
      bg_color = '#1D1F21',
      fg_color = '#ffffff',
      intensity = 'Normal',
      underline = 'None',
      italic = false,
      strikethrough = false,
    },

    inactive_tab = {
      bg_color = '#2e2e2e',
      fg_color = '#808080',
    },

    inactive_tab_hover = {
      bg_color = '#3b3052',
      fg_color = '#909090',
      italic = true,
    },

    new_tab = {
      bg_color = '#2e2e2e',
      fg_color = '#e1e1e1',
    },

    new_tab_hover = {
      bg_color = '#3b3b3b',
      fg_color = '#e3e3e3',
      italic = true,
    },
  },
}

--Window设定
config.window_frame = {
  --font = wezterm.font { family = '等距更纱黑体 SC Nerd Font', weight = 'Bold' },
  --font_size = 12.0,
  active_titlebar_bg = '#2e2e2e',
  inactive_titlebar_bg = '#2e2e2e',
}
--config.window_padding = {
--   left = 5,
--   right = 10,
--   top = 12,
--   bottom = 7,
--}
config.window_close_confirmation = 'NeverPrompt'
config.inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 }

--快捷键绑定
config.keys = {
    { key = 'l', mods = 'ALT', action = act.ShowLauncher },
    { key = 'q', mods = 'ALT', action = 'QuickSelect' },
    { key = 'c', mods = 'ALT', action = act.ActivateCopyMode },
    { key = 'f', mods = 'ALT', action = act.Search { CaseInSensitiveString = '' }},
    { key = 'k', mods = 'ALT', action = act.SendString 'clear\r\n' },
    --ALT+W:进入WSL
    { key = 'w', mods = 'ALT', action = act.Multiple {
        act.SendString 'wsl -d Ubuntu-22.04\r\n',
        act.SendString 'cd ~\n',
        act.SendString 'source ~/work/lch/rc/bashrc/.bashrc-personal\n',
      },
    },
    --ALT+1:SSH连接远程服务器
    { key = '1', mods = 'ALT', action = act.Multiple {
        act.SendString 'wezterm ssh -- lchuser@172.20.115.248:8122\r\n',
      },
    },
    --ALT+s:source个人rc
    { key = 's', mods = 'ALT', action = act.Multiple {
        act.SendString 'source ~/work/lch/rc/bashrc/.bashrc-personal\n',
      },
    },
}

--绑定鼠标右键粘贴
config.mouse_bindings = {
  {
    event = { Down = { streak = 1, button = "Right" } },
    mods = "NONE",
    action = act({ PasteFrom = "Clipboard" }),
  },
}

--function Basename(s)
--    return string.gsub(s, "(.*[/\\])(.*)", "%2")
--end
--wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
--    local pane = tab.active_pane
--    local title = Basename(pane.foreground_process_name)
--    return {
--        { Text = " " .. title .. " " },
--    }
--end)
-- 根据os.date返回周
local function day_of_week_cn (w_num)
  if w_num == 1 then
    return '周日'
  elseif w_num == 2 then
    return '周一'
  elseif w_num == 3 then
    return '周二'
  elseif w_num == 4 then
    return '周三'
  elseif w_num == 5 then
    return '周四'
  elseif w_num == 6 then
    return '周五'
  elseif w_num == 7 then
    return '周六'
  end
end

-- 在右上角表示年月日，时间和电池状态
wezterm.on('update-status', function(window, pane)
  local wday = os.date('*t').wday
  local wday_cn = string.format('(%s )', day_of_week_cn(wday))
  local calendar_icon = ''
  local clock_icon = ''
  if l_use_nerdfont == 0 then
    calendar_icon = '📆'
    clock_icon = '⏰'
  else
    -- \uf073
    calendar_icon = ''
    -- \uf43a
    clock_icon = ''
  end
  local date = wezterm.strftime(calendar_icon .. '   %Y-%m-%d ' .. wday_cn .. '   ' .. clock_icon .. '   %H:%M:%S');
  local battery = ''
  local discharging_icons = {}
  local charging_icons = {}
  local thunder_icon = ''
  if l_use_nerdfont == 0 then
    discharging_icons = { '🌑', '🌑', '🌒', '🌒', '🌗', '🌓', '🌔', '🌔', '🌕', '🌕' }
    charging_icons = { '🌑', '🌑', '🌒', '🌒', '🌗', '🌓', '🌔', '🌔', '🌕', '🌕' }
    --thunder_icon = '⚡'
  else
    discharging_icons = { '󰂃', '󰁺', '󰁻', '󰁼', '󰁽', '󰁿', '󰂀', '󰂁', '󰂂', '󰁹' }
    charging_icons = { '󰂃', '󰢜', '󰂆', '󰂇', '󰂈', '󰂉', '󰢞', '󰂊', '󰂋', '󰂅' }
    --thunder_icon = '󱐋'
  end

  local charge = ''
  local icon = ''
  for _, b in ipairs(wezterm.battery_info()) do
     local battery_state_of_charge = math.floor(b.state_of_charge * 100)
     local battery_icon_idx = math.floor(b.state_of_charge * 10)
     if b.state == 'Charging' then
        --icon = thunder_icon .. ' ' .. charging_icons[battery_icon_idx]
        icon = charging_icons[battery_icon_idx]
     else
        icon = discharging_icons[battery_icon_idx]
     end
     charge = battery_state_of_charge .. '%'
  end
  battery = charge .. icon
  window:set_right_status(wezterm.format {
    { Foreground = { Color = '#e1e1ff' } },
    { Text = date .. '   ' .. battery, },
  })
end)
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local tab_index = tab.tab_index + 1
  if tab.is_active and string.match(tab.active_pane.title, 'Copy mode:') ~= nil then
    return string.format(' %d %s ', tab_index, 'Copy mode...')
  end
  return string.format(' %d ', tab_index)
end)

return config
