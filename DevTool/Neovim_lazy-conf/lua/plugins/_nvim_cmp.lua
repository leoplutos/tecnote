return {
  --https://github.com/hrsh7th/nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    version = "*",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      {"hrsh7th/cmp-nvim-lsp"},
      {"hrsh7th/cmp-buffer"},
      {"onsails/lspkind.nvim"},
      --使用原生snip适配
      --{"hrsh7th/cmp-vsnip"},
      --{"hrsh7th/vim-vsnip"},
      {"garymjr/nvim-snippets", opts = { search_paths = { vim.fn.stdpath('config') .. '/snippets', vim.g.vscode_snippets } } },
    },
    config = function()

      --加载插件
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
      end

      local cmp = require('cmp')
      local lspkind = require('lspkind')
      cmp.setup({
        completion = {
          keyword_length = 2,
        },
        -- 设置代码片段引擎，用于根据代码片段补全
        snippet = {
          expand = function(args)
            --vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
          end,
        },
        experimental = {
          ghost_text = true,
        },
        -- 自动补全和补全说明窗口设定
        window = {
          --completion = cmp.config.window.bordered(),
          completion = {
             border = 'rounded',
             winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:FloatSelBg,Search:None',
             --winhighlight = 'Normal:None,FloatBorder:None,CursorLine:PmenuSelBg,Search:None',
             zindex = 1001,
             scrolloff = 0,
             col_offset = 0,
             side_padding = 1,
             scrollbar = true
          },
          --documentation = cmp.config.window.bordered(),
          documentation = {
             border = 'rounded',
             winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSelBg,Search:None',
             --winhighlight = 'Normal:None,FloatBorder:None,CursorLine:PmenuSelBg,Search:None',
             zindex = 1002,
             scrolloff = 0,
             col_offset = 0,
             side_padding = 1,
             scrollbar = true
          },
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-i>'] = cmp.mapping.complete(),
          ['<C-s>'] = cmp.mapping.complete({
              config = {
                sources = {
                  --{ name = 'vsnip' }
                  { name = 'snippets' }
                }
              }
            }),
          ['<Esc>'] = cmp.mapping.abort(),
          --['<Esc>'] = cmp.mapping(function(fallback)
          --  cmp.abort()
          --  fallback()
          --end, { "i", "s" }),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          --['<CR>'] = cmp.mapping.confirm(),
          --['<CR>'] = cmp.mapping(function(fallback)
          --    --require("util").create_undo()
          --    if cmp.confirm({ select = true }) then
          --      return
          --    end
          --  end
          --  return fallback()
          --end, { "i", "s" }),
          ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          --['<Tab>'] = cmp.mapping(function(fallback)
          --  if cmp.visible() then
          --    cmp.select_next_item()
          --  elseif vim.fn["vsnip#available"](1) == 1 then
          --    feedkey("<Plug>(vsnip-expand-or-jump)", "")
          --  elseif has_words_before() then
          --    cmp.complete()
          --  else
          --    fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
          --  end
          --end, { "i", "s" }),
          --['<S-Tab>'] = cmp.mapping(function()
          --  if cmp.visible() then
          --    cmp.select_prev_item()
          --  elseif vim.fn["vsnip#jumpable"](-1) == 1 then
          --    feedkey("<Plug>(vsnip-jump-prev)", "")
          --  end
          --end, { "i", "s" })
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif vim.snippet.active({ direction = 1 }) then
              feedkey("<cmd>lua vim.snippet.jump(1)<CR>", "")
            elseif has_words_before() then
              cmp.complete()
            else
              fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_prev_item()
            elseif vim.snippet.active({ direction = -1 }) then
              feedkey("<cmd>lua vim.snippet.jump(-1)<CR>", "")
            end
          end, { "i", "s" }),
        }),
        -- 补全来源
        sources = cmp.config.sources({
          { name = 'nvim_lsp', keyword_length=2, group_index = 1, priority=1 },
          { name = 'nvim_lsp_signature_help', keyword_length=2, group_index = 1, priority=2 },
          --{ name = 'vsnip', keyword_length=2, group_index = 1, priority=3 },
          { name = 'snippets', keyword_length=2, max_item_count = 5, group_index = 1, priority=3 },
          { name = 'buffer', keyword_length=2, max_item_count = 5, group_index = 2, priority=4 },
          { name = 'path', keyword_length=2, group_index = 2, priority=5 },
          { name = 'dictionary', keyword_length=2, group_index = 2, priority=6 },
        }),
        -- 设置补全显示的格式（lspkind.nvim插件）
        formatting = {
          format = lspkind.cmp_format({
            with_text = true,
            maxwidth = 50,
            before = function(entry, vim_item)
              vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
              return vim_item
            end,
            menu = {
              buffer = "[Buffer]",
              nvim_lsp = "[Lsp]",
              nvim_lua = "[Lua]",
              path = "[Path]",
              luasnip = "[Luasnip]",
              vsnip = "[Vsnip]",
              snippets = "[Snippets]",
            },
          }),
        },
      })

      --根据文件类型来选择补全来源
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'git' },
        }, {
          { name = 'buffer' },
        })
      })

      -- 命令模式下输入 `/` 启用补全
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- 命令模式下输入 `:` 启用补全
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })

      --nvim-cmp插件的高亮设定
      vim.cmd([[
      "CmpItemAbbr - 不匹配的字符
      "CmpItemAbbrDeprecated - 已弃用的不匹配的字符
      "CmpItemAbbrMatch - 匹配的字符
      "CmpItemAbbrMatchFuzzy - 模糊匹配的字符
      "CmpItemKind - 类型（即符号种类）
      "CmpItemKind%KIND_NAME%* - 特定的种类
      "CmpItemMenu - 菜单字段
      hi clear CmpItemAbbr
      hi! link CmpItemAbbr PmenuFg
      hi clear CmpItemAbbrDefault
      hi! link CmpItemAbbrDefault PmenuFg
      hi clear CmpItemAbbrDeprecated
      hi! link CmpItemAbbrDeprecated PmenuDeprecated
      hi clear CmpItemAbbrMatch
      hi! link CmpItemAbbrMatch PmenuMatch
      hi clear CmpItemAbbrMatchFuzzy
      hi! link CmpItemAbbrMatchFuzzy PmenuMatchFuzzy
      hi clear CmpItemKindDefault
      hi! link CmpItemKindDefault PmenuFg
      hi clear CmpItemKindKeyword
      hi! link CmpItemKindKeyword Keyword
      hi clear CmpItemKindVariable
      hi! link CmpItemKindVariable Variables
      hi clear CmpItemKindConstant
      hi! link CmpItemKindConstant Constant
      hi clear CmpItemKindReference
      hi! link CmpItemKindReference Lifetime
      hi clear CmpItemKindValue
      hi! link CmpItemKindValue String
      hi clear CmpItemKindCopilot
      hi! link CmpItemKindCopilot Number
      hi clear CmpItemKindFunction
      hi! link CmpItemKindFunction Function
      hi clear CmpItemKindMethod
      hi! link CmpItemKindMethod Function
      hi clear CmpItemKindConstructor
      hi! link CmpItemKindConstructor Special
      hi clear CmpItemKindClass
      hi! link CmpItemKindClass Struct
      hi clear CmpItemKindInterface
      hi! link CmpItemKindInterface Interface
      hi clear CmpItemKindStruct
      hi! link CmpItemKindStruct Struct
      hi clear CmpItemKindEvent
      hi! link CmpItemKindEvent Struct
      hi clear CmpItemKindEnum
      hi! link CmpItemKindEnum Struct
      hi clear CmpItemKindUnit
      hi! link CmpItemKindUnit Macro
      hi clear CmpItemKindModule
      hi! link CmpItemKindModule ThinTitle
      hi clear CmpItemKindProperty
      hi! link CmpItemKindProperty Property
      hi clear CmpItemKindField
      hi! link CmpItemKindField Identifier
      hi clear CmpItemKindTypeParameter
      hi! link CmpItemKindTypeParameter Parameter
      hi clear CmpItemKindEnumMember
      hi! link CmpItemKindEnumMember EnumMember
      hi clear CmpItemKindOperator
      hi! link CmpItemKindOperator Operator
      hi clear CmpItemKindSnippet
      hi! link CmpItemKindSnippet Regexp
      hi clear CmpItemKindText
      hi! link CmpItemKindText Debug
      hi clear CmpItemKindFile
      hi! link CmpItemKindFile Variables
      hi clear CmpItemKindFolder
      hi! link CmpItemKindFolder Directory
      hi clear CmpItemKindColor
      hi! link CmpItemKindColor Lifetime
      hi clear CmpItemMenu
      hi! link CmpItemMenu Comment
      ]])

    end,
  }
}
