--debugger.lua
--配置路径为 %LOCALAPPDATA%\nvim\lua
--nvim-dap插件设置
--https://github.com/williamboman/mason.nvim
--https://github.com/mfussenegger/nvim-dap
--https://github.com/rcarriga/nvim-dap-ui
--https://github.com/theHamsta/nvim-dap-virtual-text
--NOTE:nvim-dap-virtual-text需要nvim-treesitter

--加载nvim-dap插件设置
vim.cmd('packadd mason.nvim')
vim.cmd('packadd nvim-dap')
vim.cmd('packadd nvim-dap-ui')
vim.cmd('packadd nvim-dap-virtual-text')

--设置调式器路径
local dap_cmd_path = {}
if (vim.g.g_i_osflg == 1 or vim.g.g_i_osflg == 2 or vim.g.g_i_osflg == 3) then
  dap_cmd_path.lldb_cmd_path = vim.fn.expand('~/.vscode/extensions/vadimcn.vscode-lldb-1.9.2/adapter/codelldb.exe')
  dap_cmd_path.python_cmd_path = 'D:/Tools/WorkTool/Python/Python38-32/python.exe'
  dap_cmd_path.go_dlv_cmd_path = 'D:/Tools/WorkTool/Go/go_global/bin/dlv.exe'
else
  dap_cmd_path.lldb_cmd_path = vim.fn.expand('~/.vscode/extensions/vadimcn.vscode-lldb-1.9.2/adapter/codelldb')
  dap_cmd_path.python_cmd_path = '/usr/bin/python3'
  dap_cmd_path.go_dlv_cmd_path = '/home/lchuser/work/lch/tool/go_global/bin/dlv'
end

--设定mason
require('mason').setup({
    ui = {
        border = 'rounded',
        icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗'
        }
    }
})

--设定nvim-dap-ui
local dapui = require('dapui')
dapui.setup({
  floating = {
    border = "rounded",
    mappings = {
      close = { "q", "<Esc>" }
    }
  },
})

--设定nvim-dap
local dap = require('dap')
--dap.defaults.fallback.force_external_terminal = false
--dap.defaults.fallback.terminal_win_cmd = '50vsplit new'
--dap.defaults.fallback.focus_terminal = false
dap.set_log_level('WARN')
local widgets = require('dap.ui.widgets')
dap.listeners.after.event_initialized['dapui_config'] = function()
  vim.cmd('NvimTreeClose')
  --vim.cmd('NvimTreeToggle')
  dapui.open({})
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  --dapui.close({})
end
dap.listeners.before.event_exited['dapui_config'] = function()
  --dapui.close({})
end

--设定nvim-dap-virtual-text
require('nvim-dap-virtual-text').setup({
  enabled = true,
  virt_text_pos = 'eol',
})

--C/C++/Rust设定
--可以在VSCode中安装CodeLLDB  https://marketplace.visualstudio.com/items?itemName=vadimcn.vscode-lldb
--也可以使用vimspector下载的CodeLLDB /vimspector/gadgets/windows/CodeLLDB
--也可以使用mason安装CodeLLDB https://github.com/vadimcn/vscode-lldb
--安装后配置上路径即可
dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    command = dap_cmd_path.lldb_cmd_path,
    args = {"--port", "${port}"},
    -- On windows you may have to uncomment this:
    detached = false,
  }
}
dap.configurations.c = {
  {
    name = 'Launch file',
    type = 'codelldb',
    request = 'launch',
    program = function()
      if vim.o.filetype == 'c' or vim.o.filetype == 'cpp' then
        return vim.g.g_s_projectrootpath .. '/bin/Debug/${fileBasenameNoExtension}.exe'
      else
        return vim.g.g_s_projectrootpath .. '/target/debug/minigrep.exe'
      end
    end,
    cwd = function()
      return vim.g.g_s_projectrootpath .. '/testdir'
    end,
    stopOnEntry = false,
  },
}
dap.configurations.cpp = dap.configurations.c
--dap.configurations.rust = dap.configurations.c
dap.configurations.rust = {
  {
    name = 'Launch file',
    type = 'codelldb',
    request = 'launch',
    program = function()
      if vim.o.filetype == 'c' or vim.o.filetype == 'cpp' then
        return vim.g.g_s_projectrootpath .. '/bin/Debug/${fileBasenameNoExtension}.exe'
      else
        return vim.g.g_s_projectrootpath .. '/target/debug/minigrep.exe'
      end
    end,
    args = { 'body', 'poem.txt' },
    cwd = function()
      return vim.g.g_s_projectrootpath
    end,
    stopOnEntry = false,
  },
}

--Python设定
--需要 pip install -i https://pypi.tuna.tsinghua.edu.cn/simple debugpy
dap.adapters.python = {
  type = 'executable',
  command = dap_cmd_path.python_cmd_path,
  args = { '-m', 'debugpy.adapter' },
}
dap.configurations.python = {
  {
    name = 'Launch file',
    type = 'python',
    request = 'launch',
    program = '${file}',
    cwd = function()
      return vim.g.g_s_projectrootpath .. '/testdir'
    end,
    pythonPath = function ()
      return dap_cmd_path.python_cmd_path
    end
  },
}

--Golang设定
--可以使用vimspector下载的delve /vimspector/gadgets/windows/delve
--也可以使用go来安装 go install github.com/go-delve/delve/cmd/dlv@latest
--也可以使用mason安装delve  vim.fn.stdpath('data')..'/mason/bin/dlv.cmd'
--也可以使用apt来安装(版本有些低) sudo apt install delve
dap.adapters.delve = {
  type = 'server',
  port = '${port}',
  executable = {
    command = dap_cmd_path.go_dlv_cmd_path,
    args = {'dap', '-l', '127.0.0.1:${port}'},
  }
}
dap.configurations.go = {
  {
    type = "delve",
    name = "Debug",
    request = "launch",
    program = "${file}"
  },
  {
    type = "delve",
    name = "Debug test", -- configuration for debugging test files
    request = "launch",
    mode = "test",
    program = "${file}"
  },
  -- works with go.mod packages and sub packages
  {
    type = "delve",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}"
  }
}

--设定调试颜色和图标
local dap_breakpoint = {
    breakpoint = {
        text = vim.g.debugBreakPointIcon,
        texthl = 'BreakPoint',
        --linehl = 'BreakPoint',
        --numhl = 'BreakPoint',
    },
    breakpointCond = {
        text = vim.g.debugBreakPointCondIcon,
        texthl = 'BreakPoint',
        --linehl = 'BreakPoint',
        --numhl = 'BreakPoint',
    },
    rejected = {
        text = vim.g.debugRejectedIcon,
        texthl = 'BreakPoint',
        --linehl = 'BreakPoint',
        --numhl = 'BreakPoint',
    },
    logpoint = {
        text = vim.g.debugBreakPointLogIcon,
        texthl = 'BreakLogPoint',
        --linehl = 'BreakLogPoint',
        --numhl = 'BreakLogPoint',
    },
    stopped = {
        text = vim.g.debugProgramCounterIcon,
        texthl = 'DebugLine',
        linehl = 'DebugLine',
        numhl = 'DebugLine',
    },
}
vim.fn.sign_define('DapBreakpoint', dap_breakpoint.breakpoint)
vim.fn.sign_define('DapBreakpointCondition', dap_breakpoint.breakpointCond)
vim.fn.sign_define('DapBreakpointRejected', dap_breakpoint.rejected)
vim.fn.sign_define('DapLogPoint', dap_breakpoint.logpoint)
vim.fn.sign_define('DapStopped', dap_breakpoint.stopped)

-- 快捷键绑定
--<Leader>ms：打开mason
vim.keymap.set({'n'}, '<Leader>ms', '<Cmd>Mason<CR>', {noremap = true})
--<Leader>ms：关闭Debug界面
vim.keymap.set({'n'}, '<Leader>dc', function()
  dapui.close({})
  dap.repl.close()
  vim.cmd('NvimTreeOpen')
  --vim.cmd('NvimTreeToggle')
end, {noremap = true})
--F5：开始调试
vim.keymap.set({'i', 'n', 'v'}, '<F5>', '<Cmd>lua require("dap").continue()<CR>', {noremap = true})
--F6：添加断点
vim.keymap.set({'i', 'n', 'v'}, '<F6>', '<Cmd>lua require("dap").toggle_breakpoint()<CR>', {noremap = true})
--F7：下一步
vim.keymap.set({'i', 'n', 'v'}, '<F7>', '<Cmd>lua require("dap").step_over()<CR>', {noremap = true})
--F8：运行到光标处
vim.keymap.set({'i', 'n', 'v'}, '<F8>', '<Cmd>lua require("dap").run_to_cursor()<CR>', {noremap = true})
--<Leader>di：查看光标下的变量
vim.keymap.set({'n', 'v'}, '<Leader>di', function()
  widgets.hover(nil,  { border = 'rounded' })
end)
--<Leader>dw：打开浮动窗口查看所有变量
vim.keymap.set('n', '<Leader>dw', function()
  widgets.centered_float(widgets.scopes, { border = 'rounded' })
end, {noremap = true})
--<Leader>fc：关闭浮动窗口
vim.keymap.set('n', '<Leader>fc', '<Cmd>close<CR>', {noremap = true})


--高亮设定
vim.cmd([[
hi clear NvimDapVirtualText
hi! link NvimDapVirtualText DapVirtualText
]])
