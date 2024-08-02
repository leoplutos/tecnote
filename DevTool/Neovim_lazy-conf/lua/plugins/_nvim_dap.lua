return {
  -- https://github.com/mfussenegger/nvim-dap
  {
    "mfussenegger/nvim-dap",
    version = "*",
    event = "VeryLazy",
    priority = 60,
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()

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

      --高亮设定
      vim.cmd([[
        hi clear NvimDapVirtualText
        hi! link NvimDapVirtualText DapVirtualText
      ]])

    end,
    keys = {
      --快捷键绑定
      { "<Leader>dc", mode = { "n" }, function() dapui.close({}) dap.repl.close() vim.cmd('NvimTreeOpen') end, noremap = true, silent = true, nowait = true, desc = "DAP: Close Debug" },
      { "<F5>", mode = { "i", "n", "v" }, '<Cmd>lua require("dap").continue()<CR>', noremap = true, silent = true, nowait = true, desc = "DAP: Continue" },
      { "<F6>", mode = { "i", "n", "v" }, '<Cmd>lua require("dap").toggle_breakpoint()<CR>', noremap = true, silent = true, nowait = true, desc = "DAP: Toggle Breakpoint" },
      { "<F7>", mode = { "i", "n", "v" }, '<Cmd>lua require("dap").step_over()<CR>', noremap = true, silent = true, nowait = true, desc = "DAP: Step Over" },
      { "<F8>", mode = { "i", "n", "v" }, '<Cmd>lua require("dap").run_to_cursor()<CR>', noremap = true, silent = true, nowait = true, desc = "DAP: Run To Cursor" },
      { "<Leader>di", mode = { "n", "v" }, function() require('dap.ui.widgets').hover(nil,  { border = 'rounded' }) end, noremap = true, silent = true, nowait = true, desc = "DAP: Hover" },
      { "<Leader>dw", mode = { "n" }, function() require('dap.ui.widgets').centered_float(require('dap.ui.widgets').scopes, { border = 'rounded' }) end, noremap = true, silent = true, nowait = true, desc = "DAP: Centered Float Windows" },
      { "<Leader>c", mode = { "n" }, '<Cmd>close<CR>', noremap = true, silent = true, nowait = true, desc = "DAP: Close Float Windows" },
    },
  },
}
