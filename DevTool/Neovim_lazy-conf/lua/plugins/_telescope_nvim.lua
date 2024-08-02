return {
  -- https://github.com/nvim-telescope/telescope.nvim
  {
    "nvim-telescope/telescope.nvim",
    tag = '0.1.8',
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    opts = {
    },
    config = function()

      --此函数从工程根路径查找内容
      function vim.find_files_from_project_root()
        --local function get_root_dir()
        --  local dot_root_path = vim.fn.finddir(".root", ".;")
        --  return vim.fn.fnamemodify(dot_root_path, ":h")
        --end
        local find_opts = {
          --cwd = get_root_dir(),
          cwd = vim.fn.GetProjectRoot(),
          hidden = true,
        }
        require("telescope.builtin").find_files(find_opts)
      end

      --此函数从工程根路径grep内容
      function vim.grep_files_from_project_root()
        --local function get_root_dir()
        --  local dot_root_path = vim.fn.finddir(".root", ".;")
        --  return vim.fn.fnamemodify(dot_root_path, ":h")
        --end
        local grep_opts = {
          --cwd = get_root_dir(),
          cwd = vim.fn.GetProjectRoot(),
        }
        require("telescope.builtin").live_grep(grep_opts)
      end

      --加载插件
      require('telescope').setup{
        defaults = {
          layout_config = {
          },
          mappings = {
            i = {
              ["<C-h>"] = "which_key"
            }
          },
          history = false,
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--trim",
            "--glob=!.git/* --glob=!.svn/* --glob=!node_modules/* --glob=!bin/* --glob=!build/* --glob=!lib/* --glob=!obj/* --glob=!target/ --glob=!.venv/* --glob=!dist/*",
            "--glob=!.git\\* --glob=!.svn\\* --glob=!node_modules\\* --glob=!bin\\* --glob=!build\\* --glob=!lib\\* --glob=!obj\\* --glob=!target\\* --glob=!.venv\\* --glob=!dist\\*",
          },
          file_ignore_patterns = {
            --忽略文件夹设定
            "^.git/",
            "^.svn/",
            "^.idea/",
            "^.cache/",
            ".*/bin/.*",
            ".*/obj/.*",
            ".*/lib/.*",
            "^build/",
            "^target/",
            "^packages/",
            "^node_modules/",
            "^__pycache__/",
            "^.venv/",
            "^.vs/",
            "^.settings/",
            "^.metadata/",
            "^dist/",
            "^.git\\",
            "^.svn\\",
            "^.idea\\",
            "^.cache\\",
            ".*\\bin\\.*",
            ".*\\obj\\.*",
            ".*\\lib\\.*",
            "^build\\",
            "^target\\",
            "^packages\\",
            "^node_modules\\",
            "^__pycache__\\",
            "^.venv\\",
            "^.vs\\",
            "^.settings\\",
            "^.metadata\\",
            "^dist\\",
            --忽略文件设定
            "%.o",
            "%.so",
            "%.pyc",
            "%.pyo",
            "%.a",
            "%.obj",
            "%.dll",
            "%.bin",
            "%.out",
            "%.jar",
            "%.pak",
            "%.class",
            "%.zip",
            "%.gz",
            "%.deb",
            "%.pdf",
            "%.png",
            "%.jpg",
            "%.gif",
            "%.bmp",
            "%.doc",
            "%.xls",
            "%.ppt",
            "%.suo",
            "%.user",
            "%.project",
            "%.classpath",
            "%.factorypath",
            "%.lock",
            "package%-lock.json",
            "go.sum",
            "%.tsbuildinfo",
          }
        },
        pickers = {
          --find_files = {
          --  find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          --},
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
              layout_strategy = "vertical",
              layout_config = {
                prompt_position = "bottom",
                vertical = {
                  width = 0.6,
                  height = 100,
                },
              },
            },
            specific_opts = {
              codeactions = false,
            }
          }
        }
      }

      --载入telescope-ui-select.nvim
      require('telescope').load_extension('ui-select')

      --高亮设定
      vim.cmd([[
      hi clear TelescopeNormal
      hi! link TelescopeNormal FinderNormal
      "hi clear TelescopePromptNormal
      "hi! link TelescopePromptNormal FinderInputText
      hi clear TelescopeTitle
      hi! link TelescopeTitle Title
      hi clear TelescopeBorder
      hi! link TelescopeBorder FinderBorder
      hi clear TelescopePromptCounter
      hi! link TelescopePromptCounter ThinTitle
      hi clear TelescopeMatching
      hi! link TelescopeMatching PmenuMatch
      "hi TelescopePromptPrefix   guifg=red
      ]])

    end,
    keys = {
      --快捷键绑定
      --{ "<leader>f", mode = { "n" }, '<Nop>', desc = "None" },
      --{ "<leader>ff", mode = { "n" }, function() require("telescope.builtin").find_files() end, noremap = true, silent = true, nowait = true, desc = "telescope: Find File" },
      { "<leader>ff", mode = { "n" }, function() vim.find_files_from_project_root() end, noremap = true, silent = true, nowait = true, desc = "telescope: Find File" },
      --{ "<leader>fg", mode = { "n" }, function() require("telescope.builtin").live_grep() end, noremap = true, silent = true, nowait = true, desc = "telescope: Grep File" },
      { "<leader>fg", mode = { "n" }, function() vim.grep_files_from_project_root() end, noremap = true, silent = true, nowait = true, desc = "telescope: Grep File" },
      { "<leader>fb", mode = { "n" }, function() require("telescope.builtin").buffers() end, noremap = true, silent = true, nowait = true, desc = "telescope: Find Buffers" },
      { "<leader>fh", mode = { "n" }, function() require("telescope.builtin").help_tags() end, noremap = true, silent = true, nowait = true, desc = "telescope: Find Help Tags" },
      { "<leader>fd", mode = { "n" }, function() require("telescope.builtin").diagnostics() end, noremap = true, silent = true, nowait = true, desc = "telescope: Find Diagnostics" },
      { "<leader>fr", mode = { "n" }, function() require("telescope.builtin").resume() end, noremap = true, silent = true, nowait = true, desc = "telescope: Open Previous Result" },
    },
  },
}
