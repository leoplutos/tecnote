--debugger.lua
--配置路径为 %LOCALAPPDATA%\nvim\lua
--nvim-dap插件设置
--https://github.com/williamboman/mason.nvim
--https://github.com/mfussenegger/nvim-dap
--https://github.com/rcarriga/nvim-dap-ui
--https://github.com/theHamsta/nvim-dap-virtual-text

--加载nvim-dap插件设置
vim.cmd('packadd mason.nvim')
vim.cmd('packadd nvim-dap')
vim.cmd('packadd nvim-dap-ui')
vim.cmd('packadd nvim-dap-virtual-text')

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
dapui.setup({})

--设定nvim-dap
local dap = require('dap')
dap.listeners.after.event_initialized['dapui_config'] = function()
  vim.cmd('NvimTreeClose')
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
    enable_commands = true,
    highlight_changed_variables = true,
    highlight_new_as_changed = false,
    show_stop_reason = true,
    commented = false,
    only_first_definition = true,
    all_references = false,
    clear_on_continue = false,
    display_callback = function(variable, buf, stackframe, node, options)
      if options.virt_text_pos == 'inline' then
        return ' = ' .. variable.value
      else
        return variable.name .. ' = ' .. variable.value
      end
    end,
    virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',
    all_frames = false,
    virt_lines = false,
    virt_text_win_col = nil
})

--Python设定
--需要 pip install -i https://pypi.tuna.tsinghua.edu.cn/simple debugpy
dap.adapters.python = {
  type = 'executable';
  command = 'D:/Tools/WorkTool/Python/Python38-32/python.exe';
  args = { '-m', 'debugpy.adapter' };
}
dap.configurations.python = {
  {
    type = 'python';
    request = 'launch';
    name = 'launch file';
    program = '${file}';
    pythonPath = function ()
        return 'D:/Tools/WorkTool/Python/Python38-32/python.exe'
    end
  },
}

--设定调试颜色和图标
local dap_breakpoint = {
    error = {
        text = vim.g.debugBreakPointIcon,
        texthl = 'BreakPoint',
        linehl = 'BreakPoint',
        numhl = 'BreakPoint',
    },
    condition = {
        text = vim.g.debugBreakPointCondIcon,
        texthl = 'BreakPoint',
        linehl = 'BreakPoint',
        numhl = 'BreakPoint',
    },
    rejected = {
        text = vim.g.debugRejectedIcon,
        texthl = 'BreakPoint',
        linehl = 'BreakPoint',
        numhl = 'BreakPoint',
    },
    logpoint = {
        text = vim.g.debugBreakPointLogIcon,
        texthl = 'BreakLogPoint',
        linehl = 'BreakLogPoint',
        numhl = 'BreakLogPoint',
    },
    stopped = {
        text = vim.g.debugProgramCounterIcon,
        texthl = 'DebugLine',
        linehl = 'DebugLine',
        numhl = 'DebugLine',
    },
}
vim.fn.sign_define('DapBreakpoint', dap_breakpoint.error)
vim.fn.sign_define('DapBreakpointCondition', dap_breakpoint.condition)
vim.fn.sign_define('DapBreakpointRejected', dap_breakpoint.rejected)
vim.fn.sign_define('DapLogPoint', dap_breakpoint.logpoint)
vim.fn.sign_define('DapStopped', dap_breakpoint.stopped)

-- 快捷键绑定
--<Leader>ms：打开mason
vim.keymap.set({'n'}, '<Leader>ms', '<Cmd>Mason<CR>', {noremap = true})
--<Leader>ms：打开关闭Debug界面
vim.keymap.set({'n'}, '<Leader>du', dapui.toggle, {noremap = true})
--F5：开始调试
vim.keymap.set({'i', 'n', 'v'}, '<F5>', '<Cmd>lua require("dap").continue()<CR>', {noremap = true})
--F6：添加断点
vim.keymap.set({'i', 'n', 'v'}, '<F6>', '<Cmd>lua require("dap").toggle_breakpoint()<CR>', {noremap = true})
--F7：下一步
vim.keymap.set({'i', 'n', 'v'}, '<F7>', '<Cmd>lua require("dap").step_over()<CR>', {noremap = true})
--F8：运行到光标处
--vim.keymap.set({'i', 'n', 'v'}, '<F8>', '<Cmd>lua require("dap").goto_()<CR>', {noremap = true})
vim.keymap.set({'i', 'n', 'v'}, '<F8>', '<Cmd>lua require("dap").run_to_cursor()<CR>', {noremap = true})

