--lsp.lua
--配置路径为 %LOCALAPPDATA%\nvim\lua
--nvim-lspconfig插件设置
--https://github.com/neovim/nvim-lspconfig
--https://github.com/hrsh7th/nvim-cmp
--https://github.com/hrsh7th/cmp-nvim-lsp
--设定参数参考 https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

-- 加载nvim-lspconfig插件
vim.cmd('packadd nvim-lspconfig')
-- 加载nvim-cmp插件（自动完成）
vim.cmd('packadd nvim-cmp')
-- 加载cmp-nvim-lsp插件（LSP自动完成）
vim.cmd('packadd cmp-nvim-lsp')

--给状态栏设置的调用函数（返回LSP状态显示到状态栏）
--做一个全局dict保存每个lsp的服务状态，存在即为启动中
--内容示例 let g:nvim_lsp_runflg = {'clangd': 1, 'pylsp': 2}
--内容在LspAttach回调函数内设置
vim.cmd(
[[
let g:nvim_lsp_runflg = {}
function! GetLspStatus() abort
  if !exists('g:nvim_lsp_runflg')
    let g:nvim_lsp_runflg = {}
  endif
  "根据文件类型取得lsp服务状态
  let lspServerName = ''
  if (&ft=='c') || (&ft=='cpp') || (&ft=='objc') || (&ft=='objcpp') || (&ft=='cuda') || (&ft=='proto')
    let lspServerName = 'clangd'
  elseif (&ft=='python')
    let lspServerName = 'pylsp'
  elseif (&ft=='java')
    let lspServerName = 'jdtls'
  elseif (&ft=='rust')
    let lspServerName = 'rust_analyzer'
  elseif (&ft=='go') || (&ft=='gomod') || (&ft=='gohtmltmpl') || (&ft=='gotexttmpl')
    let lspServerName = 'gopls'
  elseif (&ft=='vue')
    let lspServerName = 'volar'
  elseif (&ft=='cs') || (&ft=='solution')
    let lspServerName = 'omnisharp'
  elseif (&ft=='cobol')
    let lspServerName = 'cobol_ls'
  elseif (&ft=='javascript') || (&ft=='javascript.jsx') || (&ft=='javascriptreact') || (&ft=='typescript') || (&ft=='typescript.tsx') || (&ft=='typescriptreact')
    let lspServerName = 'tsserver'
  elseif (&ft=='kotlin')
    let lspServerName = 'kotlin_language_server'
  endif
  let lspStatus = ''
  if (has_key(g:nvim_lsp_runflg, lspServerName))
    let lspStatus = 'running'
  endif
  if lspStatus == ''
    let lspStatus = '❌'
  endif
  return lspStatus
endfunction
]]
)

-- nvim-lspconfig插件设定
-- 语言服务器设定
local lspconfig = require('lspconfig')
-- C/C++(clangd)设置
lspconfig.clangd.setup {
  cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
--      '--compile-commands-dir=build',
    '-j=12',
    '--all-scopes-completion',
    '--completion-style=detailed',
    '--header-insertion=iwyu',
    '--pch-storage=memory',
    '--fallback-style=Google',
    '--function-arg-placeholders',
    '--enable-config',
    '--query-driver=gcc',
  },
  root_dir = lspconfig.util.root_pattern('.root', '.clangd', 'build.ninja', '.git');
}
-- Python(pylsp)设置
lspconfig.pylsp.setup {
  settings = {
    pylsp = {
      configurationSources = 'pycodestyle',
      plugins = {
        autopep8 = {
          enabled = false,
        },
        flake8 = {
          enabled = false,
        },
        pylint = {
          enabled = false,
        },
        pycodestyle = {
          enabled = true,
          ignore = {'E401', 'E402', 'E501'},
          -- maxLineLength = 100,
        },
        jedi = {
          auto_import_modules = 'gi',
          extra_paths = {'src', 'src/com', 'com'},
        },
        jedi_completion = {
          enabled = true,
          include_params = true,
          include_class_objects = false,
          include_function_objects = false,
          fuzzy = false,
          eager = false,
        },
        jedi_definition = {
          follow_imports = true,
          follow_builtin_imports = true,
        },
        jedi_hover = {
          enabled = true,
        },
        jedi_references = {
          enabled = true,
        },
        jedi_signature_help = {
          enabled = true,
        },
        jedi_symbolss = {
          enabled = true,
        },
      }
    }
  },
  root_dir = lspconfig.util.root_pattern('.root', '.env', 'setup.cfg', '.git');
}
-- Java(eclipse.jdt.ls)设置
lspconfig.jdtls.setup {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.level=ALL',
    '-Dfile.encoding=UTF-8',
    '-Xmx1G',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-jar',
    'D:/Tools/WorkTool/Java/lsp/jdt-language-server-1.26.0-202307271613/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar',
    '-configuration',
    'D:/Tools/WorkTool/Java/lsp/jdt-language-server-1.26.0-202307271613/config_win',
    '-data',
    --'D:/WorkSpace/Java',
    lspconfig.util.path.join(vim.loop.os_homedir(), '.cache/nvim-lsp-jdtls')
  },
  root_dir = lspconfig.util.root_pattern('.root', '.classpath', 'build.xml', 'pom.xml', 'settings.gradle', 'settings.gradle.kts', 'build.gradle', 'build.gradle.kts', '.git');
}
-- Rust(rust-analyzer)设置
lspconfig.rust_analyzer.setup {
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true,
      },
      lens = {
        enable = true,
      },
      check = {
        command = 'clippy',
        extraArgs = {'--', '-A', 'clippy::needless_return'},
      },
      diagnostics = {
        enable = true,
        experimental = {
          enable = true,
        },
      },
    },
  },
  root_dir = lspconfig.util.root_pattern('.root', 'Cargo.toml', '.git');
}
-- Go(gopls)设置
lspconfig.gopls.setup {
  cmd = {
    'gopls',
    '-remote=auto',
  },
  settings = {
    gopls = {
      -- gofumpt = true,
      analyses = {
        ST1000 = false,
        ST1003 = false,
        SA5001 = false,
        nilness = true,
        unusedwrite = true,
        unusedparams = true,
        fieldalignment = false,
        shadow = false,
        composites = false,
      },
      staticcheck = true,
      semanticTokens = true,
--[[
      ui = {
        codelenses = {
          generate = true,
          regenerate_cgo = true,
          test = true,
          vendor = true,
          tidy = true,
          upgrade_dependency = true,
          gc_details = true,
        },
        diagnostic = {
          annotations = {
            bounds = true,
            inline = true,
            escape = true,
            --nil = true,
          },
          staticcheck = true,
        },
        completion = {
          usePlaceholders = true,
          matcher = 'Fuzzy',
          completionBudget = '500ms',
        },
        navigation = {
          importShortcut = 'Definition',
          symbolMatcher = 'Fuzzy',
          symbolStyle = 'Dynamic',
        },
        semanticTokens = true,
      },
--]]
    },
  },
  root_dir = lspconfig.util.root_pattern('.root', 'go.mod', 'go.work', '.git');
}
-- Vue(volar-language-server)设置
lspconfig.volar.setup {
  init_options = {
    typescript = {
      tsdk = 'D:/Tools/WorkTool/NodeJs/node-v18.17.1-win-x64/node_global/node_modules/typescript/lib'
    }
  },
  root_dir = lspconfig.util.root_pattern('.root', 'package.json', '.git');
}
-- CSharp（OmniSharp）设置
lspconfig.omnisharp.setup {
  cmd = { 'OmniSharp', '-z', '--languageserver', '--encoding', 'utf-8', 'DotNet:enablePackageRestore=false' },
  filetypes = { 'cs'},
  enable_editorconfig_support = true,
  enable_ms_build_load_projects_on_demand = false,
  enable_roslyn_analyzers = false,
  organize_imports_on_format = false,
  enable_import_completion = false,
  sdk_include_prereleases = true,
  analyze_open_documents_only = false,
  root_dir = lspconfig.util.root_pattern('.root', '.sln', '.csproj', '.git');
}
-- Cobol（che-che4z-lsp-for-cobol）设置
lspconfig.cobol_ls.setup {
  cmd = {
    'java',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-Dline.speparator=\r\n',
    '-jar',
    'D:/Tools/WorkTool/Cobol/cobol-language-support-1.2.1/extension/server/jar/server.jar',
    'pipeEnabled',
  },
  filetypes = { 'cobol'},
  root_dir = lspconfig.util.root_pattern('.root', '.git');
}
-- JavaScript和TypeScript（typescript-language-server）设置
lspconfig.tsserver.setup {
  root_dir = lspconfig.util.root_pattern('.root', 'package.json', 'jsconfig.json', '.git');
}
-- Kotlin（kotlin-language-server）设置
lspconfig.kotlin_language_server.setup {
  root_dir = lspconfig.util.root_pattern('.root', 'settings.gradle', '.git');
}

-- 快捷键绑定
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<Space>q', vim.diagnostic.setloclist)
vim.keymap.set('n', '<C-j>', ':lnext<CR>', { noremap = true })
vim.keymap.set('n', '<C-k>', ':lprevious<CR>', { noremap = true })
vim.keymap.set('n', '<Space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<Space>gn', vim.diagnostic.goto_next)
vim.keymap.set('n', '<Space>gp', vim.diagnostic.goto_prev)

-- 当前缓冲区的快捷键绑定
vim.api.nvim_create_augroup('UserLspConfig', { clear = true })
vim.api.nvim_clear_autocmds { group = 'UserLspConfig' }
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.bo[args.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    vim.bo[args.buf].tagfunc = 'v:lua.vim.lsp.tagfunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = args.buf }
    vim.keymap.set('n', '<Space>lo', vim.diagnostic.setloclist, opts)
    vim.keymap.set('n', '<Space>lc', ':lclose<CR>', { noremap = true })
    vim.keymap.set({ 'n', 'v' }, '<Space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<Space>gd', vim.lsp.buf.definition, opts)
    --vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<Space>gs', vim.lsp.buf.document_symbol, opts)
    vim.keymap.set('n', '<Space>gS', vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set('n', '<Space>p', vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set('n', '<Space>gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<Space>gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<Space>gt', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<Space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<Space>h', vim.lsp.buf.hover, opts)
    --vim.keymap.set('n', '<C-UP>', vim.lsp.buf.references, opts)
    --vim.keymap.set('n', '<C-Down>', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<Space>fm', function()
      vim.lsp.buf.format { async = true }
    end, opts)
    vim.keymap.set('n', '<Space>gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', '<Space>gh', vim.lsp.buf.signature_help, opts)
    --vim.keymap.set('n', '<Space>wa', vim.lsp.buf.add_workspace_folder, opts)
    --vim.keymap.set('n', '<Space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<Space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)

    --取得当前生效的LspClient对象
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    --在全局变量g:nvim_lsp_runflg中设定内容
    local localFlg = vim.g.nvim_lsp_runflg
    localFlg[client.name] = client.id
    vim.g.nvim_lsp_runflg = localFlg
    --当前选中符号的高亮设定(废弃)
    --if client.server_capabilities.documentHighlightProvider then
    --  vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
    --  vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
    --  vim.api.nvim_create_autocmd("CursorHold", {
    --      callback = vim.lsp.buf.document_highlight,
    --      buffer = bufnr,
    --      group = "lsp_document_highlight",
    --      desc = "Document Highlight",
    --  })
    --  vim.api.nvim_create_autocmd("CursorMoved", {
    --      callback = vim.lsp.buf.clear_references,
    --      buffer = bufnr,
    --      group = "lsp_document_highlight",
    --      desc = "Clear All the References",
    --  })
    --end
--当前选中符号的高亮设定
--需要设定updatetime为100毫秒
    vim.cmd(
[[
setlocal updatetime=100
augroup lsp_document_highlight
  autocmd! * <buffer>
  autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
  "autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
  autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
augroup END
]]
    )

  end,
  group = 'UserLspConfig',
})

--nvim-cmp插件设定
--cmp-nvim-lsp插件设定
local cmp = require'cmp'
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- 自动补全和补全说明窗口设定
    --completion = cmp.config.window.bordered(),
    completion = {
       border = 'rounded',
       --winhighlight = 'Normal:Pmenu,FloatBorder:None,CursorLine:PmenuSel,Search:None',
       winhighlight = 'Normal:None,FloatBorder:None,CursorLine:PmenuSel,Search:None',
       zindex = 1001,
       scrolloff = 0,
       col_offset = 0,
       side_padding = 1,
       scrollbar = true
    },
    --documentation = cmp.config.window.bordered(),
    documentation = {
       border = 'rounded',
       --winhighlight = 'Normal:Pmenu,FloatBorder:None,CursorLine:PmenuSel,Search:None',
       winhighlight = 'Normal:None,FloatBorder:None,CursorLine:PmenuSel,Search:None',
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
    ['<Esc>'] = cmp.mapping.abort(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, {'i'}),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, {'i'}),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    -- { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
    { name = 'path' },
  })
})

-- 特殊文件类型设置
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  }, {
    { name = 'buffer' },
  })
})

-- /和?的搜索设置
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- 命令模式的设置
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

--nvim-cmp插件的高亮设定
vim.cmd(
[[
"CmpItemAbbr - 不匹配的字符
"CmpItemAbbrDeprecated - 已弃用的不匹配的字符
"CmpItemAbbrMatch - 匹配的字符
"CmpItemAbbrMatchFuzzy - 模糊匹配的字符
"CmpItemKind - 类型（即符号种类）
"CmpItemKind%KIND_NAME%* - 特定的种类
"CmpItemMenu - 菜单字段
hi clear CmpItemAbbr
hi! link CmpItemAbbr Normal
hi clear CmpItemAbbrDeprecated
hi! link CmpItemAbbrDeprecated PmenuDeprecated
hi clear CmpItemAbbrMatch
hi! link CmpItemAbbrMatch PmenuMatch
hi clear CmpItemAbbrMatchFuzzy
hi! link CmpItemAbbrMatchFuzzy PmenuMatchFuzzy
"hi clear CmpItemKindDefault
"hi! link CmpItemKindDefault Normal
hi clear CmpItemKindKeyword
hi! link CmpItemKindKeyword Keyword
hi clear CmpItemKindVariable
hi! link CmpItemKindVariable Variables
hi clear CmpItemKindConstant
hi! link CmpItemKindConstant Constant
hi clear CmpItemKindReference
hi! link CmpItemKindReference Normal
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
hi clear CmpItemMenu
hi! link CmpItemMenu Comment
]]
)

-- Snippets设定
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
--     capabilities = capabilities,
--   }
-- end

--Ctrl+F2显示LSP服务器状态
vim.keymap.set({'n'}, '<C-F2>', ':LspInfo<CR>', { noremap = true })

--Lsp相关的高亮设定
--:sign list 查看所有定义
vim.cmd([[
sign define DiagnosticSignError text=❌ texthl=DiagnosticSignError linehl= numhl=
sign define DiagnosticSignWarn text=🆖 texthl=DiagnosticSignWarn linehl= numhl=
sign define DiagnosticSignInfo text=❗ texthl=DiagnosticSignInfo linehl= numhl=
sign define DiagnosticSignHint text=🗝 texthl=DiagnosticSignHint linehl= numhl=
]])
