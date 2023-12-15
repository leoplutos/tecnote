::---------------------------------------------------
::这个脚本将Git仓库的Vim/NeoVim设定复制到Windows环境
::---------------------------------------------------
::前提条件
::  git/curl/7zip
::---------------------------------------------------
::Vim配置文件复制到
::  %USERPROFILE%\.vimrc
::  %USERPROFILE%\.gvimrc
::  %USERPROFILE%\vimconf
::---------------------------------------------------
::NeoVim配置文件复制到
::  %LOCALAPPDATA%\nvim
::---------------------------------------------------
::下载Vim插件到
::  %USERPROFILE%\vimconf\pack\vendor\opt
::  %USERPROFILE%\vimconf\pack\vendor\start
::---------------------------------------------------
::下载NeoVim插件到
::  %LOCALAPPDATA%\nvim\pack\vendor\opt
::  %LOCALAPPDATA%\nvim\pack\vendor\start
::---------------------------------------------------
::下载VSCode设定到
::  %USERPROFILE%\AppData\Roaming\Code\User
::---------------------------------------------------
::下载WezTerm设定到
::  %USERPROFILE%\.wezterm.lua
::---------------------------------------------------
::下载Alacritty设定到
::  %APPDATA%\alacritty\alacritty.yml
::---------------------------------------------------
::下载ConTour设定到
::  %LocalAppData%\contour\contour.yml
::---------------------------------------------------

@echo off
::设定镜像
SET GITHUB_URL=https://hub.nuaa.cf
SET DOWNLOAD_URL=https://archive.nuaa.cf
::设置是否需要Clone主仓库
SET CLONE_MAIN_REPO_FLG=1
SET DOWNLOAD_REPO_PATH=D:\WorkSpace\Git\tecnote
SET DOWNLOAD_VIM_PLUGIN_PATH=%USERPROFILE%\vimconf\pack\vendor\opt
SET DOWNLOAD_NEOVIM_PLUGIN_PATH=%LOCALAPPDATA%\nvim\pack\vendor\opt
SET VSCODE_SETTING_PATH=%USERPROFILE%\AppData\Roaming\Code\User

::Clone 主仓库
if %CLONE_MAIN_REPO_FLG%==1 (
  echo ======Clone Git Repo Start======
  rmdir /S /Q %DOWNLOAD_REPO_PATH%
  git clone --depth=1 -b master %GITHUB_URL%/leoplutos/tecnote.git %DOWNLOAD_REPO_PATH%
  rmdir /S /Q %DOWNLOAD_REPO_PATH%\.git
  echo ======Clone Git Repo Complete======
)

::复制 Vim/NeoVim 配置文件
echo ======Copy Vim Setting Start======
del %USERPROFILE%\.vimrc
del %USERPROFILE%\.gvimrc
rmdir /S /Q %USERPROFILE%\vimconf
copy /y %DOWNLOAD_REPO_PATH%\DevTool\Vim-conf\.vimrc %USERPROFILE%\.vimrc
copy /y %DOWNLOAD_REPO_PATH%\DevTool\Vim-conf\.gvimrc %USERPROFILE%\.gvimrc
xcopy /e /s /i /r /h /y %DOWNLOAD_REPO_PATH%\DevTool\Vim-conf\vimconf %USERPROFILE%\vimconf
mkdir %USERPROFILE%\vimconf\pack\vendor\opt
mkdir %USERPROFILE%\vimconf\pack\vendor\start
echo ======Copy Vim Setting Complete======

echo ======Copy NeoVim Setting Start======
del %LOCALAPPDATA%\nvim\init.lua
del %LOCALAPPDATA%\nvim\ginit.vim
rmdir /S /Q %LOCALAPPDATA%\nvim\lua
rmdir /S /Q %LOCALAPPDATA%\nvim\pack
copy /y %DOWNLOAD_REPO_PATH%\DevTool\Neovim-conf\init.lua %LOCALAPPDATA%\nvim\init.lua
copy /y %DOWNLOAD_REPO_PATH%\DevTool\Neovim-conf\ginit.vim %LOCALAPPDATA%\nvim\ginit.vim
xcopy /e /s /i /r /h /y %DOWNLOAD_REPO_PATH%\DevTool\Neovim-conf\lua %LOCALAPPDATA%\nvim\lua
mkdir %LOCALAPPDATA%\nvim\pack\vendor\opt
mkdir %LOCALAPPDATA%\nvim\pack\vendor\start
echo ======Copy NeoVim Setting Complete======

::Clone Vim 插件
echo ======Clone Vim Plugin Repo Start======
rmdir /S /Q %DOWNLOAD_VIM_PLUGIN_PATH%
mkdir %DOWNLOAD_VIM_PLUGIN_PATH%

echo -----asyncomplete.vim
git clone --depth=1 -b master %GITHUB_URL%/prabirshrestha/asyncomplete.vim.git %DOWNLOAD_VIM_PLUGIN_PATH%\asyncomplete.vim
rmdir /S /Q %DOWNLOAD_VIM_PLUGIN_PATH%\asyncomplete.vim\.git
rmdir /S /Q %DOWNLOAD_VIM_PLUGIN_PATH%\asyncomplete.vim\.github

echo -----asyncomplete-buffer.vim
git clone --depth=1 -b master %GITHUB_URL%/prabirshrestha/asyncomplete-buffer.vim.git %DOWNLOAD_VIM_PLUGIN_PATH%\asyncomplete-buffer.vim
rmdir /S /Q %DOWNLOAD_VIM_PLUGIN_PATH%\asyncomplete-buffer.vim\.git

echo -----asyncomplete-dictionary.vim
git clone --depth=1 -b main %GITHUB_URL%/koturn/asyncomplete-dictionary.vim.git %DOWNLOAD_VIM_PLUGIN_PATH%\asyncomplete-dictionary.vim
rmdir /S /Q %DOWNLOAD_VIM_PLUGIN_PATH%\asyncomplete-dictionary.vim\.git

echo -----asyncomplete-lsp.vim
git clone --depth=1 -b master %GITHUB_URL%/prabirshrestha/asyncomplete-lsp.vim.git %DOWNLOAD_VIM_PLUGIN_PATH%\asyncomplete-lsp.vim
rmdir /S /Q %DOWNLOAD_VIM_PLUGIN_PATH%\asyncomplete-lsp.vim\.git

echo -----coc.nvim
git clone --depth=1 -b release %GITHUB_URL%/neoclide/coc.nvim.git %DOWNLOAD_VIM_PLUGIN_PATH%\coc.nvim
rmdir /S /Q %DOWNLOAD_VIM_PLUGIN_PATH%\coc.nvim\.git

echo -----ctrlp.vim
git clone --depth=1 -b master %GITHUB_URL%/ctrlpvim/ctrlp.vim.git %DOWNLOAD_VIM_PLUGIN_PATH%\ctrlp
rmdir /S /Q %DOWNLOAD_VIM_PLUGIN_PATH%\ctrlp\.git
rmdir /S /Q %DOWNLOAD_VIM_PLUGIN_PATH%\ctrlp\.github

echo -----ctrlp-funky
git clone --depth=1 -b main %GITHUB_URL%/tacahiroy/ctrlp-funky.git %DOWNLOAD_VIM_PLUGIN_PATH%\ctrlp-funky
rmdir /S /Q %DOWNLOAD_VIM_PLUGIN_PATH%\ctrlp-funky\.git

echo -----indentLine
git clone --depth=1 -b master %GITHUB_URL%/Yggdroot/indentLine.git %DOWNLOAD_VIM_PLUGIN_PATH%\indentLine
rmdir /S /Q %DOWNLOAD_VIM_PLUGIN_PATH%\indentLine\.git
rmdir /S /Q %DOWNLOAD_VIM_PLUGIN_PATH%\indentLine\.github

::LanguageClient-neovim废弃

echo -----LeaderF(tag:v1.24)
curl --create-dirs -o %DOWNLOAD_VIM_PLUGIN_PATH%\LeaderF.zip %DOWNLOAD_URL%/Yggdroot/LeaderF/archive/refs/tags/v1.24.zip
7z x %DOWNLOAD_VIM_PLUGIN_PATH%\LeaderF.zip -o%DOWNLOAD_VIM_PLUGIN_PATH%
ren %DOWNLOAD_VIM_PLUGIN_PATH%\LeaderF-1.24 LeaderF
rmdir /S /Q %DOWNLOAD_VIM_PLUGIN_PATH%\LeaderF\.github
del %DOWNLOAD_VIM_PLUGIN_PATH%\LeaderF.zip

echo -----lightline.vim
git clone --depth=1 -b master %GITHUB_URL%/itchyny/lightline.vim.git %DOWNLOAD_VIM_PLUGIN_PATH%\lightline.vim
rmdir /S /Q %DOWNLOAD_VIM_PLUGIN_PATH%\lightline.vim\.git
rmdir /S /Q %DOWNLOAD_VIM_PLUGIN_PATH%\lightline.vim\.github

echo -----lightline-bufferline
git clone --depth=1 -b master %GITHUB_URL%/mengelbrecht/lightline-bufferline.git %DOWNLOAD_VIM_PLUGIN_PATH%\lightline-bufferline
rmdir /S /Q %DOWNLOAD_VIM_PLUGIN_PATH%\lightline-bufferline\.git

echo -----nerdtree(tag:v7.0)
curl --create-dirs -o %DOWNLOAD_VIM_PLUGIN_PATH%\nerdtree.zip %DOWNLOAD_URL%/preservim/nerdtree/archive/refs/tags/7.0.0.zip
7z x %DOWNLOAD_VIM_PLUGIN_PATH%\nerdtree.zip -o%DOWNLOAD_VIM_PLUGIN_PATH%
ren %DOWNLOAD_VIM_PLUGIN_PATH%\nerdtree-7.0.0 nerdtree
rmdir /S /Q %DOWNLOAD_VIM_PLUGIN_PATH%\nerdtree\.github
del %DOWNLOAD_VIM_PLUGIN_PATH%\nerdtree.zip

echo -----vim-devicons
git clone --depth=1 -b master %GITHUB_URL%/ryanoasis/vim-devicons.git %DOWNLOAD_VIM_PLUGIN_PATH%\vim-devicons
rmdir /S /Q %DOWNLOAD_VIM_PLUGIN_PATH%\vim-devicons\.git
rmdir /S /Q %DOWNLOAD_VIM_PLUGIN_PATH%\vim-devicons\.github

echo -----vim-im-select
git clone --depth=1 -b master %GITHUB_URL%/brglng/vim-im-select.git %DOWNLOAD_VIM_PLUGIN_PATH%\vim-im-select
rmdir /S /Q %DOWNLOAD_VIM_PLUGIN_PATH%\vim-im-select\.git

echo -----vim-lsp
git clone --depth=1 -b master %GITHUB_URL%/prabirshrestha/vim-lsp.git %DOWNLOAD_VIM_PLUGIN_PATH%\vim-lsp
rmdir /S /Q %DOWNLOAD_VIM_PLUGIN_PATH%\vim-lsp\.git
rmdir /S /Q %DOWNLOAD_VIM_PLUGIN_PATH%\vim-lsp\.github

::vim-lsc废弃

echo -----vimspector(tag:Build 6997902219)
curl --create-dirs -o %DOWNLOAD_VIM_PLUGIN_PATH%\vimspector.zip %DOWNLOAD_URL%/puremourning/vimspector/archive/refs/tags/6997902219.zip
7z x %DOWNLOAD_VIM_PLUGIN_PATH%\vimspector.zip -o%DOWNLOAD_VIM_PLUGIN_PATH%
ren %DOWNLOAD_VIM_PLUGIN_PATH%\vimspector-6997902219 vimspector
rmdir /S /Q %DOWNLOAD_VIM_PLUGIN_PATH%\vimspector\.github
del %DOWNLOAD_VIM_PLUGIN_PATH%\vimspector.zip

echo -----vim-startify
git clone --depth=1 -b master %GITHUB_URL%/mhinz/vim-startify.git %DOWNLOAD_VIM_PLUGIN_PATH%\vim-startify
rmdir /S /Q %DOWNLOAD_VIM_PLUGIN_PATH%\vim-startify\.git

echo -----vim-vsnip
git clone --depth=1 -b master %GITHUB_URL%/hrsh7th/vim-vsnip.git %DOWNLOAD_VIM_PLUGIN_PATH%\vim-vsnip
rmdir /S /Q %DOWNLOAD_VIM_PLUGIN_PATH%\vim-vsnip\.git
rmdir /S /Q %DOWNLOAD_VIM_PLUGIN_PATH%\vim-vsnip\.github

echo -----vim-vsnip-integ
git clone --depth=1 -b master %GITHUB_URL%/hrsh7th/vim-vsnip-integ.git %DOWNLOAD_VIM_PLUGIN_PATH%\vim-vsnip-integ
rmdir /S /Q %DOWNLOAD_VIM_PLUGIN_PATH%\vim-vsnip-integ\.git

echo -----vim-which-key
git clone --depth=1 -b master %GITHUB_URL%/liuchengxu/vim-which-key.git %DOWNLOAD_VIM_PLUGIN_PATH%\vim-which-key
rmdir /S /Q %DOWNLOAD_VIM_PLUGIN_PATH%\vim-which-key\.git
rmdir /S /Q %DOWNLOAD_VIM_PLUGIN_PATH%\vim-which-key\.github

echo -----copy-vim-devicons-nerdtree_plugin
xcopy /e /s /i /r /h /y %DOWNLOAD_VIM_PLUGIN_PATH%\vim-devicons\nerdtree_plugin %USERPROFILE%\vimconf\nerdtree_plugin

echo ======Clone Vim Plugin Repo Complete======

::Clone NeoVim 插件
echo ======Clone NeoVim Plugin Repo Start======
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%
mkdir %DOWNLOAD_NEOVIM_PLUGIN_PATH%

echo -----bufferline.nvim(tag:v4.4.0)
curl --create-dirs -o %DOWNLOAD_NEOVIM_PLUGIN_PATH%\bufferline.nvim.zip %DOWNLOAD_URL%/akinsho/bufferline.nvim/archive/refs/tags/v4.4.0.zip
7z x %DOWNLOAD_NEOVIM_PLUGIN_PATH%\bufferline.nvim.zip -o%DOWNLOAD_NEOVIM_PLUGIN_PATH%
ren %DOWNLOAD_NEOVIM_PLUGIN_PATH%\bufferline.nvim-4.4.0 bufferline.nvim
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\bufferline.nvim\.github
del %DOWNLOAD_NEOVIM_PLUGIN_PATH%\bufferline.nvim.zip

echo -----cmp-buffer
git clone --depth=1 -b main %GITHUB_URL%/hrsh7th/cmp-buffer.git %DOWNLOAD_NEOVIM_PLUGIN_PATH%\cmp-buffer
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\cmp-buffer\.git

echo -----cmp-cmdline
git clone --depth=1 -b main %GITHUB_URL%/hrsh7th/cmp-cmdline.git %DOWNLOAD_NEOVIM_PLUGIN_PATH%\cmp-cmdline
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\cmp-cmdline\.git

echo -----cmp-dictionary(tag:2.1.0)
curl --create-dirs -o %DOWNLOAD_NEOVIM_PLUGIN_PATH%\cmp-dictionary.zip %DOWNLOAD_URL%/uga-rosa/cmp-dictionary/archive/refs/tags/v2.1.0.zip
7z x %DOWNLOAD_NEOVIM_PLUGIN_PATH%\cmp-dictionary.zip -o%DOWNLOAD_NEOVIM_PLUGIN_PATH%
ren %DOWNLOAD_NEOVIM_PLUGIN_PATH%\cmp-dictionary-2.1.0 cmp-dictionary
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\cmp-dictionary\.github
del %DOWNLOAD_NEOVIM_PLUGIN_PATH%\cmp-dictionary.zip

echo -----cmp-nvim-lsp
git clone --depth=1 -b main %GITHUB_URL%/hrsh7th/cmp-nvim-lsp.git %DOWNLOAD_NEOVIM_PLUGIN_PATH%\cmp-nvim-lsp
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\cmp-nvim-lsp\.git

echo -----cmp-nvim-lsp-signature-help
git clone --depth=1 -b main %GITHUB_URL%/hrsh7th/cmp-nvim-lsp-signature-help.git %DOWNLOAD_NEOVIM_PLUGIN_PATH%\cmp-nvim-lsp-signature-help
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\cmp-nvim-lsp-signature-help\.git

echo -----cmp-path
git clone --depth=1 -b main %GITHUB_URL%/hrsh7th/cmp-path.git %DOWNLOAD_NEOVIM_PLUGIN_PATH%\cmp-path
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\cmp-path\.git

echo -----cmp-vsnip
git clone --depth=1 -b main %GITHUB_URL%/hrsh7th/cmp-vsnip.git %DOWNLOAD_NEOVIM_PLUGIN_PATH%\cmp-vsnip
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\cmp-vsnip\.git

echo -----dashboard-nvim
git clone --depth=1 -b master %GITHUB_URL%/nvimdev/dashboard-nvim.git %DOWNLOAD_NEOVIM_PLUGIN_PATH%\dashboard-nvim
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\dashboard-nvim\.git
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\dashboard-nvim\.github

echo -----flash.nvim(tag:v1.18.2)
curl --create-dirs -o %DOWNLOAD_NEOVIM_PLUGIN_PATH%\flash.nvim.zip %DOWNLOAD_URL%/folke/flash.nvim/archive/refs/tags/v1.18.2.zip
7z x %DOWNLOAD_NEOVIM_PLUGIN_PATH%\flash.nvim.zip -o%DOWNLOAD_NEOVIM_PLUGIN_PATH%
ren %DOWNLOAD_NEOVIM_PLUGIN_PATH%\flash.nvim-1.18.2 flash.nvim
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\flash.nvim\.github
del %DOWNLOAD_NEOVIM_PLUGIN_PATH%\flash.nvim.zip

echo -----im-select.nvim
git clone --depth=1 -b master %GITHUB_URL%/keaising/im-select.nvim.git %DOWNLOAD_NEOVIM_PLUGIN_PATH%\im-select.nvim
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\im-select.nvim\.git

echo -----indent-blankline.nvim(tag:Version 3.3.7)
curl --create-dirs -o %DOWNLOAD_NEOVIM_PLUGIN_PATH%\indent-blankline.nvim.zip %DOWNLOAD_URL%/lukas-reineke/indent-blankline.nvim/archive/refs/tags/v3.3.7.zip
7z x %DOWNLOAD_NEOVIM_PLUGIN_PATH%\indent-blankline.nvim.zip -o%DOWNLOAD_NEOVIM_PLUGIN_PATH%
ren %DOWNLOAD_NEOVIM_PLUGIN_PATH%\indent-blankline.nvim-3.3.7 indent-blankline.nvim
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\indent-blankline.nvim\.github
del %DOWNLOAD_NEOVIM_PLUGIN_PATH%\indent-blankline.nvim.zip

echo -----lspkind.nvim
git clone --depth=1 -b master %GITHUB_URL%/onsails/lspkind.nvim.git %DOWNLOAD_NEOVIM_PLUGIN_PATH%\lspkind.nvim
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\lspkind.nvim\.git

echo -----lualine.nvim
git clone --depth=1 -b master %GITHUB_URL%/nvim-lualine/lualine.nvim.git %DOWNLOAD_NEOVIM_PLUGIN_PATH%\lualine.nvim
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\lualine.nvim\.git
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\lualine.nvim\.github

echo -----mason.nvim(tag:v1.8.3)
curl --create-dirs -o %DOWNLOAD_NEOVIM_PLUGIN_PATH%\mason.nvim.zip %DOWNLOAD_URL%/williamboman/mason.nvim/archive/refs/tags/v1.8.3.zip
7z x %DOWNLOAD_NEOVIM_PLUGIN_PATH%\mason.nvim.zip -o%DOWNLOAD_NEOVIM_PLUGIN_PATH%
ren %DOWNLOAD_NEOVIM_PLUGIN_PATH%\mason.nvim-1.8.3 mason.nvim
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\mason.nvim\.github
del %DOWNLOAD_NEOVIM_PLUGIN_PATH%\mason.nvim.zip

echo -----nvim-autopairs
git clone --depth=1 -b master %GITHUB_URL%/windwp/nvim-autopairs.git %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-autopairs
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-autopairs\.git
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-autopairs\.github

echo -----nvim-cmp
git clone --depth=1 -b main %GITHUB_URL%/hrsh7th/nvim-cmp.git %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-cmp
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-cmp\.git
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-cmp\.githooks
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-cmp\.github

echo -----nvim-dap(tag:0.7.0)
curl --create-dirs -o %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-dap.zip %DOWNLOAD_URL%/mfussenegger/nvim-dap/archive/refs/tags/0.7.0.zip
7z x %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-dap.zip -o%DOWNLOAD_NEOVIM_PLUGIN_PATH%
ren %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-dap-0.7.0 nvim-dap
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-dap\.github
del %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-dap.zip

echo -----nvim-dap-ui(tag:v3.9.1)
curl --create-dirs -o %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-dap-ui.zip %DOWNLOAD_URL%/rcarriga/nvim-dap-ui/archive/refs/tags/v3.9.1.zip
7z x %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-dap-ui.zip -o%DOWNLOAD_NEOVIM_PLUGIN_PATH%
ren %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-dap-ui-3.9.1 nvim-dap-ui
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-dap-ui\.github
del %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-dap-ui.zip

echo -----nvim-dap-virtual-text
git clone --depth=1 -b master %GITHUB_URL%/theHamsta/nvim-dap-virtual-text.git %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-dap-virtual-text
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-dap-virtual-text\.git
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-dap-virtual-text\.github

echo -----nvim-lspconfig
git clone --depth=1 -b master %GITHUB_URL%/neovim/nvim-lspconfig.git %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-lspconfig
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-lspconfig\.git
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-lspconfig\.github

echo -----nvim-tree.lua
git clone --depth=1 -b master %GITHUB_URL%/nvim-tree/nvim-tree.lua.git %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-tree.lua
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-tree.lua\.git
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-tree.lua\.github

echo -----nvim-treesitter(tag:v0.9.1)
curl --create-dirs -o %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-treesitter.zip %DOWNLOAD_URL%/nvim-treesitter/nvim-treesitter/archive/refs/tags/v0.9.1.zip
7z x %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-treesitter.zip -o%DOWNLOAD_NEOVIM_PLUGIN_PATH%
ren %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-treesitter-0.9.1 nvim-treesitter
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-treesitter\.github
del %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-treesitter.zip

echo -----nvim-web-devicons
git clone --depth=1 -b master %GITHUB_URL%/nvim-tree/nvim-web-devicons.git %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-web-devicons
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-web-devicons\.git
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\nvim-web-devicons\.github

echo -----plenary.nvim(tag:v0.1.4)
curl --create-dirs -o %DOWNLOAD_NEOVIM_PLUGIN_PATH%\plenary.nvim.zip %DOWNLOAD_URL%/nvim-lua/plenary.nvim/archive/refs/tags/v0.1.4.zip
7z x %DOWNLOAD_NEOVIM_PLUGIN_PATH%\plenary.nvim.zip -o%DOWNLOAD_NEOVIM_PLUGIN_PATH%
ren %DOWNLOAD_NEOVIM_PLUGIN_PATH%\plenary.nvim-0.1.4 plenary.nvim
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\plenary.nvim\.github
del %DOWNLOAD_NEOVIM_PLUGIN_PATH%\plenary.nvim.zip

echo -----symbols-outline.nvim
git clone --depth=1 -b master %GITHUB_URL%/simrat39/symbols-outline.nvim.git %DOWNLOAD_NEOVIM_PLUGIN_PATH%\symbols-outline.nvim
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\symbols-outline.nvim\.git
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\symbols-outline.nvim\.github

echo -----telescope.nvim(tag:telescope v0.1.4)
curl --create-dirs -o %DOWNLOAD_NEOVIM_PLUGIN_PATH%\telescope.nvim.zip %DOWNLOAD_URL%/nvim-telescope/telescope.nvim/archive/refs/tags/0.1.4.zip
7z x %DOWNLOAD_NEOVIM_PLUGIN_PATH%\telescope.nvim.zip -o%DOWNLOAD_NEOVIM_PLUGIN_PATH%
ren %DOWNLOAD_NEOVIM_PLUGIN_PATH%\telescope.nvim-0.1.4 telescope.nvim
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\telescope.nvim\.github
del %DOWNLOAD_NEOVIM_PLUGIN_PATH%\telescope.nvim.zip

echo -----telescope-ui-select.nvim
git clone --depth=1 -b master %GITHUB_URL%/nvim-telescope/telescope-ui-select.nvim.git %DOWNLOAD_NEOVIM_PLUGIN_PATH%\telescope-ui-select.nvim
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\telescope-ui-select.nvim\.git
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\telescope-ui-select.nvim\.github

echo -----toggleterm.nvim(tag:v2.8.0)
curl --create-dirs -o %DOWNLOAD_NEOVIM_PLUGIN_PATH%\toggleterm.nvim.zip %DOWNLOAD_URL%/akinsho/toggleterm.nvim/archive/refs/tags/v2.8.0.zip
7z x %DOWNLOAD_NEOVIM_PLUGIN_PATH%\toggleterm.nvim.zip -o%DOWNLOAD_NEOVIM_PLUGIN_PATH%
ren %DOWNLOAD_NEOVIM_PLUGIN_PATH%\toggleterm.nvim-2.8.0 toggleterm.nvim
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\toggleterm.nvim\.github
del %DOWNLOAD_NEOVIM_PLUGIN_PATH%\toggleterm.nvim.zip

echo -----tokyonight.nvim(tag:v2.9.0)
curl --create-dirs -o %DOWNLOAD_NEOVIM_PLUGIN_PATH%\tokyonight.nvim.zip %DOWNLOAD_URL%/folke/tokyonight.nvim/archive/refs/tags/v2.9.0.zip
7z x %DOWNLOAD_NEOVIM_PLUGIN_PATH%\tokyonight.nvim.zip -o%DOWNLOAD_NEOVIM_PLUGIN_PATH%
ren %DOWNLOAD_NEOVIM_PLUGIN_PATH%\tokyonight.nvim-2.9.0 tokyonight.nvim
rmdir /S /Q %DOWNLOAD_NEOVIM_PLUGIN_PATH%\tokyonight.nvim\.github
del %DOWNLOAD_NEOVIM_PLUGIN_PATH%\tokyonight.nvim.zip

echo -----copy-lualine.nvim-themes
xcopy /e /s /i /r /h /y %DOWNLOAD_REPO_PATH%\DevTool\Neovim-conf\pack\vendor\opt %LOCALAPPDATA%\nvim\pack\vendor\opt

echo ======Clone NeoVim Plugin Repo Complete======

::复制 VSCode 配置文件
echo ======Copy VSCode Setting Start======
del %VSCODE_SETTING_PATH%\settings.json
del %VSCODE_SETTING_PATH%\keybindings.json
del %VSCODE_SETTING_PATH%\tasks.json
rmdir /S /Q %VSCODE_SETTING_PATH%\snippets
rmdir /S /Q %VSCODE_SETTING_PATH%\vbs
copy /y %DOWNLOAD_REPO_PATH%\DevTool\VSCode-conf\user\settings.json %VSCODE_SETTING_PATH%\settings.json
copy /y %DOWNLOAD_REPO_PATH%\DevTool\VSCode-conf\user\keybindings.json %VSCODE_SETTING_PATH%\keybindings.json
copy /y %DOWNLOAD_REPO_PATH%\DevTool\VSCode-conf\user\tasks.json %VSCODE_SETTING_PATH%\tasks.json
xcopy /e /s /i /r /h /y %DOWNLOAD_REPO_PATH%\DevTool\VSCode-conf\snippets %VSCODE_SETTING_PATH%\snippets
xcopy /e /s /i /r /h /y %DOWNLOAD_REPO_PATH%\DevTool\VSCode-conf\vbs %VSCODE_SETTING_PATH%\vbs
echo ======Copy VSCode Setting Complete======

::复制 WezTerm 配置文件
echo ======Copy WezTerm Setting Start======
del %USERPROFILE%\.wezterm.lua
copy /y %DOWNLOAD_REPO_PATH%\DevTool\WezTerm_conf\wezterm.lua %USERPROFILE%\.wezterm.lua
echo ======Copy WezTerm Setting Complete======

::复制 Alacritty 配置文件
echo ======Copy Alacritty Setting Start======
del %APPDATA%\alacritty\alacritty.yml
copy /y %DOWNLOAD_REPO_PATH%\DevTool\alacritty_conf\alacritty.yml %APPDATA%\alacritty\alacritty.yml
echo ======Copy Alacritty Setting Complete======

::复制 ConTour 配置文件
echo ======Copy ConTour Setting Start======
del %LocalAppData%\contour\contour.yml
copy /y %DOWNLOAD_REPO_PATH%\DevTool\contour_conf\contour.yml %LocalAppData%\contour\contour.yml
echo ======Copy ConTour Setting Complete======

pause

@echo on
