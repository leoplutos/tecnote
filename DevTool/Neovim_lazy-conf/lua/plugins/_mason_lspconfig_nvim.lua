return {
  -- https://github.com/williamboman/mason-lspconfig.nvim
  {
    "williamboman/mason-lspconfig.nvim",
    version = "*",
    event = "VeryLazy",
    priority = 52,
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = {
    },
    config = function()
      -- mason-lspconfig v2：setup_handlers は廃止された。
      -- ここでは ensure_installed のみ使い、自動有効化は無効にする。
      -- （各 server は下の vim.lsp.config / vim.lsp.enable で明示的に制御する）
      require("mason-lspconfig").setup{
        ensure_installed = {},
        automatic_enable = false,
      }

      -- 補完機能の全機能（これを設定しないと関数選択時に後ろの括弧が付かない）
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local java_debug_jar_path = vim.g.mason_nvim_root ..  '/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar'

      -- 全 server 共通のデフォルト設定（補完 capabilities）
      vim.lsp.config('*', {
        capabilities = capabilities,
      })

      -- Lua
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }
            }
          }
        }
      })

      -- Java
      vim.lsp.config('jdtls', {
        init_options = {
          bundles = {
            -- jdtls に java-debug プラグインを読み込ませる
            java_debug_jar_path,
          },
          workspaceFolders = vim.fs.joinpath(vim.uv.os_homedir(), '.cache/jdtls/workspace'),
          extendedClientCapabilities = {
            classFileContentsSupport = true,
            generateToStringPromptSupport = true,
            hashCodeEqualsPromptSupport = true,
            advancedExtractRefactoringSupport = true,
            advancedOrganizeImportsSupport = true,
            generateConstructorsPromptSupport = true,
            generateDelegateMethodsPromptSupport = true,
            moveRefactoringSupport = true,
            overrideMethodsPromptSupport = true,
            executeClientCommandSupport = true,
            resolveAdditionalTextEditsSupport = true,
            inferSelectionSupport = {
              "extractMethod",
              "extractVariable",
              "extractConstant",
              "extractVariableAllOccurrence"
            },
          },
          settings = {
            java = {
              configuration = {
                updateBuildConfiguration = "interactive",
                maven = {
                  userSettings = vim.g.user_home .. '/.m2/settings.xml',
                  globalSettings = vim.g.java_maven_conf_path,
                },
              },
              eclipse = {
                downloadSources = true,
              },
              maven = {
                downloadSources = true,
                updateSnapshots = true,
              },
              implementationsCodeLens = {
                enabled = false,
              },
              referencesCodeLens = {
                enabled = false,
              },
              references = {
                includeAccessors = true,
                includeDecompiledSources = true,
              },
              contentProvider = {
                preferred = 'fernflower',
              },
              import = {
                maven = {
                  enabled = true,
                },
                gradle = {
                  enabled = true,
                },
              },
              inlayhints = {
                parameterNames = {
                  enabled = true,
                },
              },
              sources = {
                organizeImports = {
                  starThreshold = 9999,
                  staticStarThreshold = 9999,
                },
              },
              showBuildStatusOnStart = {
                enabled = true,
              },
              signatureHelp = {
                enabled = true,
              },
              codeGeneration = {
                toString = {
                  template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
                },
                useBlocks = true,
              },
            },
          },
        },
        root_markers = { 'pom.xml', 'gradlew', 'mvnw', '.git', '.vscode' },
      })

      -- Python
      vim.lsp.config('pyright', {
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = 'openFilesOnly',
              typeCheckingMode = 'basic',
              --stubPath = 'src/com',
            },
          },
        },
        root_markers = { '.venv', 'pyproject.toml', '.git', '.vscode' },
      })

      -- Golang
      vim.lsp.config('gopls', {
        init_options = {
          usePlaceholders = true,
        },
        settings = {
          gopls = {
            allExperiments = true,
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
            codelenses = {
              generate = true,
              regenerate_cgo = true,
              test = true,
              vendor = true,
              tidy = true,
              upgrade_dependency = true,
              gc_details = true,
            },
            annotations = {
              bounds = true,
              inline = true,
              escape = true,
              --nil = true,
            },
            usePlaceholders = true,
            matcher = 'Fuzzy',
            completionBudget = '500ms',
            importShortcut = 'Definition',
            symbolMatcher = 'Fuzzy',
            symbolStyle = 'Dynamic',
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            directoryFilters = { '-node_modules', '-data' },
          },
        },
        root_markers = { 'go.mod', 'go.work', '.git', '.vscode' },
      })

      -- Rust
      vim.lsp.config('rust_analyzer', {
        settings = {
          ['rust-analyzer'] = {
            cargo = {
              buildScripts = {
                enable = true,
              },
            },
            checkOnSave = false,
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
        root_markers = { 'Cargo.toml', '.git', '.vscode' },
      })

      -- CSharp（root 検出は lspconfig の既定（*.sln / *.csproj）に任せる）
      -- 追加設定が無いため vim.lsp.config は不要。capabilities は '*' から継承。

      -- Vue（volar は非推奨。vue_ls に変更。lspconfig 3.0.0 で volar は削除予定）
      vim.lsp.config('vue_ls', {
        init_options = {
          vue = {
            hybridMode = false,
          },
        },
        --filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
        filetypes = { 'vue' },
        root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git', '.vscode' },
      })

      -- Javascript/Typescript
      vim.lsp.config('ts_ls', {
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact'},
        root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git', '.vscode' },
      })

      -- 各 server を明示的に有効化（FileType に応じて自動起動する）
      vim.lsp.enable({
        'lua_ls',
        'jdtls',
        'pyright',
        'gopls',
        'rust_analyzer',
        'csharp_ls',
        'vue_ls',
        'ts_ls',
      })
    end,
    keys = {
    },
  }
}
