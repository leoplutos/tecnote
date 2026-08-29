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
  --config.default_prog = { 'cmd.exe', '/k', 'C:/qiao/00_Tools/Cmd/cmdautorun_liang.cmd', '1' }
  config.default_prog = { 'C:/qiao/00_Tools/Shell/NuShell/nu.exe' }
elseif wezterm.target_triple == 'x86_64-apple-darwin' then
  --MacOS
  config.default_prog = { os.getenv("SHELL") }
else
  --Linux
  config.default_prog = { '/bin/bash', '-l' }
end
--config.default_gui_startup_args = { 'ssh', 'lchuser@172.20.115.248:8122' }
--config.default_cwd = "~"
config.launch_menu = {}
config.set_environment_variables = {}
--config.color_scheme = 'Sakura'
--config.line_height = 1.0
--config.cell_width = 1.0
config.freetype_load_target = 'Normal' ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
config.freetype_render_target = 'Normal' ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
--禁用死键
config.use_dead_keys = false
-- 初始大小
config.initial_cols = 145
config.initial_rows = 35
-- 关闭时不进行确认
config.window_close_confirmation = 'NeverPrompt'
--取消 Windows 原生标题栏
--config.window_decorations = "TITLE | RESIZE"
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
-- 启用滚动条
config.enable_scroll_bar = true
-- 滚动条尺寸为 10
config.window_padding = {
   left = 10,
   right = 10,
   top = 10,
   bottom = 10,
}
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

--取得home_dir下指定文件的内容
local function get_local_bashrc(filename)
  local bashrc_path = wezterm.home_dir .. filename
  local bashrc_file = io.open(bashrc_path, "r")
  if not bashrc_file then
    wezterm.log_error('rc file not found: ' .. bashrc_path)
    return nil
  end

  -- "*a" 表示读取全部内容
  local file_content = bashrc_file:read("*a")
  bashrc_file:close()

  if file_content == '' then
    wezterm.log_error('rc file is empty: ' .. bashrc_path)
    return nil
  end

  return file_content
end

--将本地rc文件内容注入到当前pane，并在bash中source
local function source_local_file(window, pane, filename)
  local content = get_local_bashrc(filename)
  if not content then
    return
  end

  local marker = '__WEZTERM_RC_' .. tostring(os.time()) .. '__'
  local cmd = table.concat({
    'set +o history',
    "source /dev/stdin <<'" .. marker .. "'",
    content,
    marker,
    'set -o history',
    'history -r',
    'clear',
  }, '\n') .. '\n'

  window:perform_action(wezterm.action.SendString(cmd), pane)
end


-- SSH服务器菜单设定
--
-- 当前版本：自动解析 ~/.ssh/config 生成菜单
--   - Windows / macOS / Linux 通用
--   - 新增服务器时，只需要维护 ~/.ssh/config
--   - 菜单显示 Host、User、HostName、Port
--   - 实际执行命令始终是：ssh <Host别名>
--
-- ~/.ssh/config 示例：
--Host local_wsl
--    HostName 127.0.0.1
--    Port 8122
--    User lch
--    StrictHostKeyChecking no
--    UserKnownHostsFile /dev/null
--    # MenuName: 🎉 Local WSL Docker

--       一些其他的例子
--       🐳 Local WSL Docker
--       💡️ AWS Production
--       🏢 Office
--       🖥️ NAS
--
-- 可选：在 Host 区块内添加 `# MenuName:`，可以自定义菜单显示名。
-- 不写 MenuName 时，默认显示 Host 别名。

--[[
-- 固定列表方式：暂时停用
-- 如果以后想恢复手动维护服务器列表，可以取消这段注释，
-- 然后把 open_ssh_menu() 中的 get_ssh_choices_from_config()
-- 改回 get_ssh_choices_from_static_list()。
local ssh_servers = {
  { label = '🎉 local docker 127.0.0.1:8122', command = 'ssh lch@127.0.0.1 -p 8122' },
  { label = '💡 local docker 127.0.0.2:22', command = 'ssh lch@127.0.0.2 -p 22' },
  -- 示例：按需解除注释/修改
  -- { label = 'AWS Dev', command = 'ssh aws-dev' },
  -- { label = 'GCP Dev', command = 'ssh gcp-dev' },
  -- { label = 'Office Server', command = 'ssh office' },
}

local function get_ssh_choices_from_static_list()
  local choices = {}
  for _, server in ipairs(ssh_servers) do
    table.insert(choices, {
      id = server.command,
      label = server.label,
    })
  end
  return choices
end
]]

-- 去掉字符串前后的空白字符
local function trim(s)
  return (s:gsub('^%s+', ''):gsub('%s+$', ''))
end

-- 判断文件是否存在
local function file_exists(path)
  local f = io.open(path, 'r')
  if f then
    f:close()
    return true
  end
  return false
end

-- 从多个候选路径中找到可用的 ssh config
-- 说明：
--   wezterm.home_dir 在 Windows 通常是 C:\Users\用户名
--   在 macOS / Linux 通常是 /Users/用户名 或 /home/用户名
local function get_ssh_config_path()
  local candidates = {
    wezterm.home_dir .. '/.ssh/config',
  }

  for _, path in ipairs(candidates) do
    if file_exists(path) then
      return path
    end
  end

  return nil
end

-- 将一个 Host 区块转换为 InputSelector 的一项
-- host.alias    : Host 别名，例如 local_wsl
-- host.hostname : HostName，例如 127.0.0.1
-- host.user     : User，例如 lch
-- host.port     : Port，例如 8122
-- host.menu_name: 可选，自定义显示名称，例如 🐳 Local WSL Docker
local function build_ssh_choice(host)
  local alias = host.alias or ''
  local hostname = host.hostname or '?'
  local user = host.user or '?'
  local port = host.port or '22'
  local menu_name = host.menu_name or alias

  -- label 是菜单中显示的内容。
  -- 使用两行显示：第一行是菜单名，第二行是 user@hostname:port。
  local label = string.format('%s\n   %s@%s:%s', menu_name, user, hostname, port)

  return {
    -- id 是实际执行的命令。
    -- 这里不拼接 user/hostname/port，而是交给 OpenSSH 读取 ~/.ssh/config。
    id = 'ssh ' .. alias,
    label = label,
  }
end

-- 解析 ~/.ssh/config
-- 支持字段：
--   Host
--   HostName
--   User
--   Port
--   # MenuName:
--
-- 自动忽略：
--   Host *
--   包含通配符的 Host，例如 *.example.com、dev-*
--
-- 注意：
--   一个 Host 行如果写了多个别名，例如 `Host dev dev2`，
--   会分别生成 dev 和 dev2 两个菜单项。
local function get_ssh_choices_from_config()
  local ssh_config_path = get_ssh_config_path()
  if not ssh_config_path then
    wezterm.log_error('ssh config not found: ' .. wezterm.home_dir .. '/.ssh/config')
    return {}
  end

  local file = io.open(ssh_config_path, 'r')
  if not file then
    wezterm.log_error('failed to open ssh config: ' .. ssh_config_path)
    return {}
  end

  local choices = {}
  local current_hosts = {}
  local current = nil

  local function flush_current()
    if not current then
      return
    end

    for _, alias in ipairs(current_hosts) do
      if alias ~= '*' and not alias:find('%*') and not alias:find('%?') then
        local host = {
          alias = alias,
          hostname = current.hostname,
          user = current.user,
          port = current.port,
          menu_name = current.menu_name,
        }
        table.insert(choices, build_ssh_choice(host))
      end
    end
  end

  for line in file:lines() do
    local raw = line
    line = trim(line)

    -- 读取自定义菜单名：# MenuName: xxxx
    -- 这个注释需要写在对应 Host 区块里面。
    local menu_name = raw:match('^%s*#%s*MenuName:%s*(.+)%s*$')
    if menu_name and current then
      current.menu_name = trim(menu_name)
    end

    -- 跳过空行和普通注释
    if line ~= '' and not line:match('^#') then
      local key, value = line:match('^(%S+)%s+(.+)$')
      if key and value then
        key = string.lower(key)
        value = trim(value)

        if key == 'host' then
          flush_current()

          current_hosts = {}
          for alias in value:gmatch('%S+') do
            table.insert(current_hosts, alias)
          end

          current = {
            hostname = nil,
            user = nil,
            port = nil,
            menu_name = nil,
          }
        elseif current then
          if key == 'hostname' then
            current.hostname = value
          elseif key == 'user' then
            current.user = value
          elseif key == 'port' then
            current.port = value
          end
        end
      end
    end
  end

  file:close()
  flush_current()

  table.sort(choices, function(a, b)
    return a.label < b.label
  end)

  return choices
end

-- 打开 SSH 服务器选择菜单
-- 作用：
--   1. 自动读取 ~/.ssh/config
--   2. 将 Host 信息转换成 InputSelector 的 choices
--   3. 弹出一个可模糊搜索的 SSH 菜单
--   4. 用户选择某台服务器后，将 `ssh <Host别名>` 发送到当前 pane 执行
--
-- 操作：
--   - 输入文字：搜索服务器
--   - Enter：连接选中的服务器
--   - Esc：取消
local function open_ssh_menu(window, pane)
  local choices = get_ssh_choices_from_config()

  if #choices == 0 then
    window:toast_notification(
      'WezTerm SSH Menu',
      '没有找到可用的 SSH Host。请确认 ~/.ssh/config 是否存在，并包含 Host 配置。',
      nil,
      5000
    )
    return
  end

  window:perform_action(act.InputSelector {
    title = ' 🚀 SSH Servers ',
    description = '选择服务器后按 Enter 连接 / 输入文字可搜索 / Esc 取消',
    fuzzy = true,
    choices = choices,
    action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
      -- id 为 nil 表示用户按 Esc 取消了菜单
      if not id then
        return
      end

      -- 将选中的 ssh 命令发送到当前 pane，并自动回车执行
      inner_window:perform_action(act.SendString(id .. '\r\n'), inner_pane)
    end),
  }, pane)
end

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
        act.SendString 'wezterm ssh -- lch@127.0.0.1:8122\r\n',
      },
    },
    --ALT+m:SSH服务器菜单
    {
      key = 'm',
      mods = 'ALT',
      action = wezterm.action_callback(function(window, pane)
        open_ssh_menu(window, pane)
      end),
    },
    --ALT+s:source个人rc
    {
      key = 's',
      mods = 'ALT',
      action = wezterm.action_callback(function(window, pane)
        source_local_file(window, pane, '/.bashrc-personal')
      end),
    },
    --ALT+d:source容易用rc
    {
      key = 'd',
      mods = 'ALT',
      action = wezterm.action_callback(function(window, pane)
        source_local_file(window, pane, '/.bashrc-docker')
      end),
    },
    --ALT+V:左右分隔
    { key = 'v', mods = 'ALT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }},
    --ALT+H:上下分隔
    { key = 'h', mods = 'ALT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }},
    --ALT+LeftArrow:移动到左边窗口
    { key = 'LeftArrow', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Left' },
    --ALT+RightArrow:移动到右边窗口
    { key = 'RightArrow', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Right' },
    --ALT+UpArrow:移动到上边窗口
    { key = 'UpArrow', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Up' },
    --ALT+DownArrow:移动到下边窗口
    { key = 'DownArrow', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Down' },
    --Ctrl+数字:移动到对应窗口
    { key = '1', mods = 'CTRL', action = wezterm.action.ActivateTab(0) },
    { key = '2', mods = 'CTRL', action = wezterm.action.ActivateTab(1) },
    { key = '3', mods = 'CTRL', action = wezterm.action.ActivateTab(2) },
    { key = '4', mods = 'CTRL', action = wezterm.action.ActivateTab(3) },
    { key = '5', mods = 'CTRL', action = wezterm.action.ActivateTab(4) },
    { key = '6', mods = 'CTRL', action = wezterm.action.ActivateTab(5) },
    { key = '7', mods = 'CTRL', action = wezterm.action.ActivateTab(6) },
    { key = '8', mods = 'CTRL', action = wezterm.action.ActivateTab(7) },
    { key = '9', mods = 'CTRL', action = wezterm.action.ActivateTab(8) },
    --Ctrl+w:关闭窗口
    { key = 'w', mods = 'CTRL', action = wezterm.action.CloseCurrentTab { confirm = true } },
    --ALT+e:重命名tab
    { key = 'e', mods = 'ALT', action = act.PromptInputLine {
        description = 'Enter new name for tab',
        action = wezterm.action_callback(function(window, pane, line)
          -- line will be `nil` if they hit escape without entering anything
          -- An empty string if they just hit enter
          -- Or the actual line of text they wrote
          if line then
            window:active_tab():set_title(line)
          end
        end),
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

  local shortcut = '⌥V↔ ⌥H↕ ⌥M SSH'

  window:set_right_status(wezterm.format {
    { Foreground = { Color = '#8fb7ff' } },
    { Text = shortcut },
    { Text = '      ' },
    { Foreground = { Color = '#c8d3f5' } },
    { Text = date },
    { Text = '   ' },
    { Foreground = { Color = '#98c379' } },
    { Text = battery },
  })
end)
--wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
--  local tab_index = tab.tab_index + 1
--  if tab.is_active and string.match(tab.active_pane.title, 'Copy mode:') ~= nil then
--    return string.format(' %d %s ', tab_index, 'Copy mode...')
--  end
--  return string.format(' %d ', tab_index)
--end)

-- 字体
--config.font = wezterm.font('等距更纱黑体 SC Nerd Font', { weight = 'Bold', italic = false })
config.font = wezterm.font_with_fallback({
        --'等距更纱黑体 SC Nerd Font Light',
        --'等距更纱黑体 SC Nerd Font',
        --'更紗等幅ゴシック J Nerd Font light',
        '更紗等幅ゴシック J Nerd Font',
        'Cascadia Code NF',
        'Consolas 7NF',
        'Consolas ligaturized v3',
        'JetBrains Mono',
    })
--config.font_size = 12.0
config.font_size = 10.0

--颜色设定
config.colors = {
  foreground = '#DADADA',
  background = '#1D1F21',
  cursor_bg = '#00FFFF',
  cursor_fg = '#1e1e1e',
  cursor_border = '#afffff',
  --selection_fg = '#DADADA',
  --selection_bg = '#585b70',
  selection_bg = '#20374c',
  scrollbar_thumb = '#585b70',
  split = '#235b76',
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
    '#243C4F',
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
  quick_select_label_bg = { Color = '#ff007c' },
  quick_select_label_fg = { Color = '#ffffff' },
  quick_select_match_bg = { Color = '#114957' },
  quick_select_match_fg = { Color = '#c5d0f3' },
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
-- 非当前焦点的 pane 降低亮度和饱和度
config.inactive_pane_hsb = {
    saturation = 0.9, brightness = 0.2
}

return config
