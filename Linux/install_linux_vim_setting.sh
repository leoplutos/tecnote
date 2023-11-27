#---------------------------------------------------
#这个脚本将Git仓库的Vim/NeoVim设定复制到Linux环境
#---------------------------------------------------
#前提条件
#  git/curl/tar
#---------------------------------------------------
#Vim配置文件复制到
#  $HOME/work/lch/rc/vimrc/.vimrc
#  $HOME/work/lch/rc/vimrc/.gvimrc
#  $HOME/work/lch/rc/vimrc/vimconf
#---------------------------------------------------
#NeoVim配置文件复制到
#  $HOME/work/lch/rc/nvimrc
#---------------------------------------------------
#下载Vim插件到
#  $HOME/work/lch/rc/vimrc/vimconf/pack/vendor/opt
#  $HOME/work/lch/rc/vimrc/vimconf/pack/vendor/start
#---------------------------------------------------
#下载NeoVim插件到
#  $HOME/work/lch/rc/nvimrc/pack/vendor/opt
#  $HOME/work/lch/rc/nvimrc/pack/vendor/start
#---------------------------------------------------
#下载VSCode设定到
#  $HOME/.config/Code/User
#---------------------------------------------------
#下载WezTerm设定到
#  $HOME/.wezterm.lua
#---------------------------------------------------
#下载Alacritty设定到
#  $HOME/.config/alacritty/alacritty.yml
#---------------------------------------------------
#下载ConTour设定到
#  $HOME/.config/contour/contour.yml
#---------------------------------------------------

#设定镜像
export GITHUB_URL=https://hub.njuu.cf
export DOWNLOAD_URL=https://archive.njuu.cf
#设置是否需要Clone主仓库
export CLONE_MAIN_REPO_FLG=1
export DOWNLOAD_REPO_PATH=$HOME/work/lch/workspace/git/tecnote
export DOWNLOAD_VIM_PLUGIN_PATH=$HOME/work/lch/rc/vimrc/vimconf/pack/vendor/opt
export DOWNLOAD_NEOVIM_PLUGIN_PATH=$HOME/work/lch/rc/nvimrc/pack/vendor/opt
export VSCODE_SETTING_PATH=$HOME/.config/Code/User

#Clone 主仓库
if [[ "$CLONE_MAIN_REPO_FLG" -eq 1 ]]; then
  echo "======Clone Git Repo Start======"
  rm -rf $DOWNLOAD_REPO_PATH
  git clone --depth=1 -b master $GITHUB_URL/leoplutos/tecnote.git $DOWNLOAD_REPO_PATH
  rm -rf $DOWNLOAD_REPO_PATH/.git
  echo "======Clone Git Repo Complete======"
fi

#复制 Vim/NeoVim 配置文件
echo "======Copy Vim Setting Start======"
rm -f $HOME/work/lch/rc/vimrc/.vimrc
rm -f $HOME/work/lch/rc/vimrc/.gvimrc
rm -rf $HOME/work/lch/rc/vimrc/vimconf
cp -afp $DOWNLOAD_REPO_PATH/DevTool/Vim-conf/.vimrc $HOME/work/lch/rc/vimrc/.vimrc
cp -afp $DOWNLOAD_REPO_PATH/DevTool/Vim-conf/.gvimrc $HOME/work/lch/rc/vimrc/.gvimrc
cp -afp $DOWNLOAD_REPO_PATH/DevTool/Vim-conf/vimconf $HOME/work/lch/rc/vimrc/vimconf
mkdir -p $HOME/work/lch/rc/vimrc/vimconf/pack/vendor/opt
mkdir -p $HOME/work/lch/rc/vimrc/vimconf/pack/vendor/start
echo "======Copy Vim Setting Complete======"

echo "======Copy NeoVim Setting Start======"
rm -f $HOME/work/lch/rc/nvimrc/init.lua
rm -f $HOME/work/lch/rc/nvimrc/ginit.vim
rm -rf $HOME/work/lch/rc/nvimrc/lua
rm -rf $HOME/work/lch/rc/nvimrc/pack
cp -afp $DOWNLOAD_REPO_PATH/DevTool/Neovim-conf/init.lua $HOME/work/lch/rc/nvimrc/init.lua
cp -afp $DOWNLOAD_REPO_PATH/DevTool/Neovim-conf/ginit.vim $HOME/work/lch/rc/nvimrc/ginit.vim
cp -afp $DOWNLOAD_REPO_PATH/DevTool/Neovim-conf/lua $HOME/work/lch/rc/nvimrc/lua
mkdir -p $HOME/work/lch/rc/nvimrc/pack/vendor/opt
mkdir -p $HOME/work/lch/rc/nvimrc/pack/vendor/start
echo "======Copy NeoVim Setting Complete======"

#Clone Vim 插件
echo "======Clone Vim Plugin Repo Start======"
rm -rf $DOWNLOAD_VIM_PLUGIN_PATH
mkdir -p $DOWNLOAD_VIM_PLUGIN_PATH

echo "-----asyncomplete.vim"
git clone --depth=1 -b master $GITHUB_URL/prabirshrestha/asyncomplete.vim.git $DOWNLOAD_VIM_PLUGIN_PATH/asyncomplete.vim
rm -rf $DOWNLOAD_VIM_PLUGIN_PATH/asyncomplete.vim/.git
rm -rf $DOWNLOAD_VIM_PLUGIN_PATH/asyncomplete.vim/.github

echo "-----asyncomplete-buffer.vim"
git clone --depth=1 -b master $GITHUB_URL/prabirshrestha/asyncomplete-buffer.vim.git $DOWNLOAD_VIM_PLUGIN_PATH/asyncomplete-buffer.vim
rm -rf $DOWNLOAD_VIM_PLUGIN_PATH/asyncomplete-buffer.vim/.git

echo "-----asyncomplete-dictionary.vim"
git clone --depth=1 -b main $GITHUB_URL/koturn/asyncomplete-dictionary.vim.git $DOWNLOAD_VIM_PLUGIN_PATH/asyncomplete-dictionary.vim
rm -rf $DOWNLOAD_VIM_PLUGIN_PATH/asyncomplete-dictionary.vim/.git

echo "-----asyncomplete-lsp.vim"
git clone --depth=1 -b master $GITHUB_URL/prabirshrestha/asyncomplete-lsp.vim.git $DOWNLOAD_VIM_PLUGIN_PATH/asyncomplete-lsp.vim
rm -rf $DOWNLOAD_VIM_PLUGIN_PATH/asyncomplete-lsp.vim/.git

echo "-----coc.nvim"
git clone --depth=1 -b release $GITHUB_URL/neoclide/coc.nvim.git $DOWNLOAD_VIM_PLUGIN_PATH/coc.nvim
rm -rf $DOWNLOAD_VIM_PLUGIN_PATH/coc.nvim/.git

echo "-----ctrlp.vim"
git clone --depth=1 -b master $GITHUB_URL/ctrlpvim/ctrlp.vim.git $DOWNLOAD_VIM_PLUGIN_PATH/ctrlp
rm -rf $DOWNLOAD_VIM_PLUGIN_PATH/ctrlp/.git
rm -rf $DOWNLOAD_VIM_PLUGIN_PATH/ctrlp/.github

echo "-----ctrlp-funky"
git clone --depth=1 -b main $GITHUB_URL/tacahiroy/ctrlp-funky.git $DOWNLOAD_VIM_PLUGIN_PATH/ctrlp-funky
rm -rf $DOWNLOAD_VIM_PLUGIN_PATH/ctrlp-funky/.git

echo "-----indentLine"
git clone --depth=1 -b master $GITHUB_URL/Yggdroot/indentLine.git $DOWNLOAD_VIM_PLUGIN_PATH/indentLine
rm -rf $DOWNLOAD_VIM_PLUGIN_PATH/indentLine/.git
rm -rf $DOWNLOAD_VIM_PLUGIN_PATH/indentLine/.github

#LanguageClient-neovim废弃

echo "-----LeaderF(tag:v1.24)"
curl --create-dirs -o $DOWNLOAD_VIM_PLUGIN_PATH/LeaderF.tar.gz $DOWNLOAD_URL/Yggdroot/LeaderF/archive/refs/tags/v1.24.tar.gz
tar -zxvf $DOWNLOAD_VIM_PLUGIN_PATH/LeaderF.tar.gz -C $DOWNLOAD_VIM_PLUGIN_PATH
mv $DOWNLOAD_VIM_PLUGIN_PATH/LeaderF-1.24 $DOWNLOAD_VIM_PLUGIN_PATH/LeaderF
rm -rf $DOWNLOAD_VIM_PLUGIN_PATH/LeaderF/.github
rm -f $DOWNLOAD_VIM_PLUGIN_PATH/LeaderF.tar.gz

echo "-----lightline.vim"
git clone --depth=1 -b master $GITHUB_URL/itchyny/lightline.vim.git $DOWNLOAD_VIM_PLUGIN_PATH/lightline.vim
rm -rf $DOWNLOAD_VIM_PLUGIN_PATH/lightline.vim/.git
rm -rf $DOWNLOAD_VIM_PLUGIN_PATH/lightline.vim/.github

echo "-----lightline-bufferline"
git clone --depth=1 -b master $GITHUB_URL/mengelbrecht/lightline-bufferline.git $DOWNLOAD_VIM_PLUGIN_PATH/lightline-bufferline
rm -rf $DOWNLOAD_VIM_PLUGIN_PATH/lightline-bufferline/.git

echo "-----nerdtree(tag:v7.0)"
curl --create-dirs -o $DOWNLOAD_VIM_PLUGIN_PATH/nerdtree.tar.gz $DOWNLOAD_URL/preservim/nerdtree/archive/refs/tags/7.0.0.tar.gz
tar -zxvf $DOWNLOAD_VIM_PLUGIN_PATH/nerdtree.tar.gz -C $DOWNLOAD_VIM_PLUGIN_PATH
mv $DOWNLOAD_VIM_PLUGIN_PATH/nerdtree-7.0.0 $DOWNLOAD_VIM_PLUGIN_PATH/nerdtree
rm -rf $DOWNLOAD_VIM_PLUGIN_PATH/nerdtree/.github
rm -f $DOWNLOAD_VIM_PLUGIN_PATH/nerdtree.tar.gz

echo "-----vim-devicons"
git clone --depth=1 -b master $GITHUB_URL/ryanoasis/vim-devicons.git $DOWNLOAD_VIM_PLUGIN_PATH/vim-devicons
rm -rf $DOWNLOAD_VIM_PLUGIN_PATH/vim-devicons/.git
rm -rf $DOWNLOAD_VIM_PLUGIN_PATH/vim-devicons/.github

echo "-----vim-im-select"
git clone --depth=1 -b master $GITHUB_URL/brglng/vim-im-select.git $DOWNLOAD_VIM_PLUGIN_PATH/vim-im-select
rm -rf $DOWNLOAD_VIM_PLUGIN_PATH/vim-im-select/.git

echo "-----vim-lsp"
git clone --depth=1 -b master $GITHUB_URL/prabirshrestha/vim-lsp.git $DOWNLOAD_VIM_PLUGIN_PATH/vim-lsp
rm -rf $DOWNLOAD_VIM_PLUGIN_PATH/vim-lsp/.git
rm -rf $DOWNLOAD_VIM_PLUGIN_PATH/vim-lsp/.github

#vim-lsc废弃

echo "-----vimspector(tag:Build 6997902219)"
curl --create-dirs -o $DOWNLOAD_VIM_PLUGIN_PATH/vimspector.tar.gz $DOWNLOAD_URL/puremourning/vimspector/archive/refs/tags/6997902219.tar.gz
tar -zxvf $DOWNLOAD_VIM_PLUGIN_PATH/vimspector.tar.gz -C $DOWNLOAD_VIM_PLUGIN_PATH
mv $DOWNLOAD_VIM_PLUGIN_PATH/vimspector-6997902219 $DOWNLOAD_VIM_PLUGIN_PATH/vimspector
rm -rf $DOWNLOAD_VIM_PLUGIN_PATH/vimspector/.github
rm -f $DOWNLOAD_VIM_PLUGIN_PATH/vimspector.tar.gz

echo "-----vim-startify"
git clone --depth=1 -b master $GITHUB_URL/mhinz/vim-startify.git $DOWNLOAD_VIM_PLUGIN_PATH/vim-startify
rm -rf $DOWNLOAD_VIM_PLUGIN_PATH/vim-startify/.git

echo "-----vim-vsnip"
git clone --depth=1 -b master $GITHUB_URL/hrsh7th/vim-vsnip.git $DOWNLOAD_VIM_PLUGIN_PATH/vim-vsnip
rm -rf $DOWNLOAD_VIM_PLUGIN_PATH/vim-vsnip/.git
rm -rf $DOWNLOAD_VIM_PLUGIN_PATH/vim-vsnip/.github

echo "-----vim-vsnip-integ"
git clone --depth=1 -b master $GITHUB_URL/hrsh7th/vim-vsnip-integ.git $DOWNLOAD_VIM_PLUGIN_PATH/vim-vsnip-integ
rm -rf $DOWNLOAD_VIM_PLUGIN_PATH/vim-vsnip-integ/.git

echo "-----copy-vim-devicons-nerdtree_plugin"
cp -afp $DOWNLOAD_VIM_PLUGIN_PATH/vim-devicons/nerdtree_plugin $HOME/work/lch/rc/vimrc/vimconf/nerdtree_plugin

echo "======Clone Vim Plugin Repo Complete======"

#Clone NeoVim 插件
echo "======Clone NeoVim Plugin Repo Start======"
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH
mkdir -p $DOWNLOAD_NEOVIM_PLUGIN_PATH

echo "-----bufferline.nvim(tag:v4.4.0)"
curl --create-dirs -o $DOWNLOAD_NEOVIM_PLUGIN_PATH/bufferline.nvim.tar.gz $DOWNLOAD_URL/akinsho/bufferline.nvim/archive/refs/tags/v4.4.0.tar.gz
tar -zxvf $DOWNLOAD_NEOVIM_PLUGIN_PATH/bufferline.nvim.tar.gz -C $DOWNLOAD_NEOVIM_PLUGIN_PATH
mv $DOWNLOAD_NEOVIM_PLUGIN_PATH/bufferline.nvim-4.4.0 $DOWNLOAD_NEOVIM_PLUGIN_PATH/bufferline.nvim
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/bufferline.nvim/.github
rm -f $DOWNLOAD_NEOVIM_PLUGIN_PATH/bufferline.nvim.tar.gz

echo "-----cmp-buffer"
git clone --depth=1 -b main $GITHUB_URL/hrsh7th/cmp-buffer.git $DOWNLOAD_NEOVIM_PLUGIN_PATH/cmp-buffer
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/cmp-buffer/.git

echo "-----cmp-cmdline"
git clone --depth=1 -b main $GITHUB_URL/hrsh7th/cmp-cmdline.git $DOWNLOAD_NEOVIM_PLUGIN_PATH/cmp-cmdline
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/cmp-cmdline/.git

echo "-----cmp-dictionary(tag:2.1.0)"
curl --create-dirs -o $DOWNLOAD_NEOVIM_PLUGIN_PATH/cmp-dictionary.tar.gz $DOWNLOAD_URL/uga-rosa/cmp-dictionary/archive/refs/tags/v2.1.0.tar.gz
tar -zxvf $DOWNLOAD_NEOVIM_PLUGIN_PATH/cmp-dictionary.tar.gz -C $DOWNLOAD_NEOVIM_PLUGIN_PATH
mv $DOWNLOAD_NEOVIM_PLUGIN_PATH/cmp-dictionary-2.1.0 $DOWNLOAD_NEOVIM_PLUGIN_PATH/cmp-dictionary
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/cmp-dictionary/.github
rm -f $DOWNLOAD_NEOVIM_PLUGIN_PATH/cmp-dictionary.tar.gz

echo "-----cmp-nvim-lsp"
git clone --depth=1 -b main $GITHUB_URL/hrsh7th/cmp-nvim-lsp.git $DOWNLOAD_NEOVIM_PLUGIN_PATH/cmp-nvim-lsp
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/cmp-nvim-lsp/.git

echo "-----cmp-nvim-lsp-signature-help"
git clone --depth=1 -b main $GITHUB_URL/hrsh7th/cmp-nvim-lsp-signature-help.git $DOWNLOAD_NEOVIM_PLUGIN_PATH/cmp-nvim-lsp-signature-help
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/cmp-nvim-lsp-signature-help/.git

echo "-----cmp-path"
git clone --depth=1 -b main $GITHUB_URL/hrsh7th/cmp-path.git $DOWNLOAD_NEOVIM_PLUGIN_PATH/cmp-path
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/cmp-path/.git

echo "-----cmp-vsnip"
git clone --depth=1 -b main $GITHUB_URL/hrsh7th/cmp-vsnip.git $DOWNLOAD_NEOVIM_PLUGIN_PATH/cmp-vsnip
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/cmp-vsnip/.git

echo "-----dashboard-nvim"
git clone --depth=1 -b master $GITHUB_URL/nvimdev/dashboard-nvim.git $DOWNLOAD_NEOVIM_PLUGIN_PATH/dashboard-nvim
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/dashboard-nvim/.git
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/dashboard-nvim/.github

echo "-----flash.nvim(tag:v1.18.2)"
curl --create-dirs -o $DOWNLOAD_NEOVIM_PLUGIN_PATH/flash.nvim.tar.gz $DOWNLOAD_URL/folke/flash.nvim/archive/refs/tags/v1.18.2.tar.gz
tar -zxvf $DOWNLOAD_NEOVIM_PLUGIN_PATH/flash.nvim.tar.gz -C $DOWNLOAD_NEOVIM_PLUGIN_PATH
mv $DOWNLOAD_NEOVIM_PLUGIN_PATH/flash.nvim-1.18.2 $DOWNLOAD_NEOVIM_PLUGIN_PATH/flash.nvim
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/flash.nvim/.github
rm -f $DOWNLOAD_NEOVIM_PLUGIN_PATH/flash.nvim.tar.gz

echo "-----im-select.nvim"
git clone --depth=1 -b master $GITHUB_URL/keaising/im-select.nvim.git $DOWNLOAD_NEOVIM_PLUGIN_PATH/im-select.nvim
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/im-select.nvim/.git

echo "-----indent-blankline.nvim(tag:Version 3.3.7)"
curl --create-dirs -o $DOWNLOAD_NEOVIM_PLUGIN_PATH/indent-blankline.nvim.tar.gz $DOWNLOAD_URL/lukas-reineke/indent-blankline.nvim/archive/refs/tags/v3.3.7.tar.gz
tar -zxvf $DOWNLOAD_NEOVIM_PLUGIN_PATH/indent-blankline.nvim.tar.gz -C $DOWNLOAD_NEOVIM_PLUGIN_PATH
mv $DOWNLOAD_NEOVIM_PLUGIN_PATH/indent-blankline.nvim-3.3.7 $DOWNLOAD_NEOVIM_PLUGIN_PATH/indent-blankline.nvim
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/indent-blankline.nvim/.github
rm -f $DOWNLOAD_NEOVIM_PLUGIN_PATH/indent-blankline.nvim.tar.gz

echo "-----lspkind.nvim"
git clone --depth=1 -b master $GITHUB_URL/onsails/lspkind.nvim.git $DOWNLOAD_NEOVIM_PLUGIN_PATH/lspkind.nvim
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/lspkind.nvim/.git

echo "-----lualine.nvim"
git clone --depth=1 -b master $GITHUB_URL/nvim-lualine/lualine.nvim.git $DOWNLOAD_NEOVIM_PLUGIN_PATH/lualine.nvim
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/lualine.nvim/.git
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/lualine.nvim/.github

echo "-----mason.nvim(tag:v1.8.3)"
curl --create-dirs -o $DOWNLOAD_NEOVIM_PLUGIN_PATH/mason.nvim.tar.gz $DOWNLOAD_URL/williamboman/mason.nvim/archive/refs/tags/v1.8.3.tar.gz
tar -zxvf $DOWNLOAD_NEOVIM_PLUGIN_PATH/mason.nvim.tar.gz -C $DOWNLOAD_NEOVIM_PLUGIN_PATH
mv $DOWNLOAD_NEOVIM_PLUGIN_PATH/mason.nvim-1.8.3 $DOWNLOAD_NEOVIM_PLUGIN_PATH/mason.nvim
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/mason.nvim/.github
rm -f $DOWNLOAD_NEOVIM_PLUGIN_PATH/mason.nvim.tar.gz

echo "-----nvim-autopairs"
git clone --depth=1 -b master $GITHUB_URL/windwp/nvim-autopairs.git $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-autopairs
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-autopairs/.git
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-autopairs/.github

echo "-----nvim-cmp"
git clone --depth=1 -b main $GITHUB_URL/hrsh7th/nvim-cmp.git $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-cmp
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-cmp/.git
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-cmp/.githooks
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-cmp/.github

echo "-----nvim-dap(tag:0.7.0)"
curl --create-dirs -o $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-dap.tar.gz $DOWNLOAD_URL/mfussenegger/nvim-dap/archive/refs/tags/0.7.0.tar.gz
tar -zxvf $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-dap.tar.gz -C $DOWNLOAD_NEOVIM_PLUGIN_PATH
mv $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-dap-0.7.0 $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-dap
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-dap/.github
rm -f $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-dap.tar.gz

echo "-----nvim-dap-ui(tag:v3.9.1)"
curl --create-dirs -o $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-dap-ui.tar.gz $DOWNLOAD_URL/rcarriga/nvim-dap-ui/archive/refs/tags/v3.9.1.tar.gz
tar -zxvf $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-dap-ui.tar.gz -C $DOWNLOAD_NEOVIM_PLUGIN_PATH
mv $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-dap-ui-3.9.1 $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-dap-ui
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-dap-ui/.github
rm -f $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-dap-ui.tar.gz

echo "-----nvim-dap-virtual-text"
git clone --depth=1 -b master $GITHUB_URL/theHamsta/nvim-dap-virtual-text.git $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-dap-virtual-text
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-dap-virtual-text/.git
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-dap-virtual-text/.github

echo "-----nvim-lspconfig"
git clone --depth=1 -b master $GITHUB_URL/neovim/nvim-lspconfig.git $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-lspconfig
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-lspconfig/.git
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-lspconfig/.github

echo "-----nvim-tree.lua"
git clone --depth=1 -b master $GITHUB_URL/nvim-tree/nvim-tree.lua.git $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-tree.lua
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-tree.lua/.git
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-tree.lua/.github

echo "-----nvim-treesitter(tag:v0.9.1)"
curl --create-dirs -o $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-treesitter.tar.gz $DOWNLOAD_URL/nvim-treesitter/nvim-treesitter/archive/refs/tags/v0.9.1.tar.gz
tar -zxvf $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-treesitter.tar.gz -C $DOWNLOAD_NEOVIM_PLUGIN_PATH
mv $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-treesitter-0.9.1 $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-treesitter
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-treesitter/.github
rm -f $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-treesitter.tar.gz

echo "-----nvim-web-devicons"
git clone --depth=1 -b master $GITHUB_URL/nvim-tree/nvim-web-devicons.git $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-web-devicons
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-web-devicons/.git
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/nvim-web-devicons/.github

echo "-----plenary.nvim(tag:v0.1.4)"
curl --create-dirs -o $DOWNLOAD_NEOVIM_PLUGIN_PATH/plenary.nvim.tar.gz $DOWNLOAD_URL/nvim-lua/plenary.nvim/archive/refs/tags/v0.1.4.tar.gz
tar -zxvf $DOWNLOAD_NEOVIM_PLUGIN_PATH/plenary.nvim.tar.gz -C $DOWNLOAD_NEOVIM_PLUGIN_PATH
mv $DOWNLOAD_NEOVIM_PLUGIN_PATH/plenary.nvim-0.1.4 $DOWNLOAD_NEOVIM_PLUGIN_PATH/plenary.nvim
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/plenary.nvim/.github
rm -f $DOWNLOAD_NEOVIM_PLUGIN_PATH/plenary.nvim.tar.gz

echo "-----symbols-outline.nvim"
git clone --depth=1 -b master $GITHUB_URL/simrat39/symbols-outline.nvim.git $DOWNLOAD_NEOVIM_PLUGIN_PATH/symbols-outline.nvim
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/symbols-outline.nvim/.git
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/symbols-outline.nvim/.github

echo "-----telescope.nvim(tag:telescope v0.1.4)"
curl --create-dirs -o $DOWNLOAD_NEOVIM_PLUGIN_PATH/telescope.nvim.tar.gz $DOWNLOAD_URL/nvim-telescope/telescope.nvim/archive/refs/tags/0.1.4.tar.gz
tar -zxvf $DOWNLOAD_NEOVIM_PLUGIN_PATH/telescope.nvim.tar.gz -C $DOWNLOAD_NEOVIM_PLUGIN_PATH
mv $DOWNLOAD_NEOVIM_PLUGIN_PATH/telescope.nvim-0.1.4 $DOWNLOAD_NEOVIM_PLUGIN_PATH/telescope.nvim
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/telescope.nvim/.github
rm -f $DOWNLOAD_NEOVIM_PLUGIN_PATH/telescope.nvim.tar.gz

echo "-----telescope-ui-select.nvim"
git clone --depth=1 -b master $GITHUB_URL/nvim-telescope/telescope-ui-select.nvim.git $DOWNLOAD_NEOVIM_PLUGIN_PATH/telescope-ui-select.nvim
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/telescope-ui-select.nvim/.git
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/telescope-ui-select.nvim/.github

echo "-----toggleterm.nvim(tag:v2.8.0)"
curl --create-dirs -o $DOWNLOAD_NEOVIM_PLUGIN_PATH/toggleterm.nvim.tar.gz $DOWNLOAD_URL/akinsho/toggleterm.nvim/archive/refs/tags/v2.8.0.tar.gz
tar -zxvf $DOWNLOAD_NEOVIM_PLUGIN_PATH/toggleterm.nvim.tar.gz -C $DOWNLOAD_NEOVIM_PLUGIN_PATH
mv $DOWNLOAD_NEOVIM_PLUGIN_PATH/toggleterm.nvim-2.8.0 $DOWNLOAD_NEOVIM_PLUGIN_PATH/toggleterm.nvim
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/toggleterm.nvim/.github
rm -f $DOWNLOAD_NEOVIM_PLUGIN_PATH/toggleterm.nvim.tar.gz

echo "-----tokyonight.nvim(tag:v2.9.0)"
curl --create-dirs -o $DOWNLOAD_NEOVIM_PLUGIN_PATH/tokyonight.nvim.tar.gz $DOWNLOAD_URL/folke/tokyonight.nvim/archive/refs/tags/v2.9.0.tar.gz
tar -zxvf $DOWNLOAD_NEOVIM_PLUGIN_PATH/tokyonight.nvim.tar.gz -C $DOWNLOAD_NEOVIM_PLUGIN_PATH
mv $DOWNLOAD_NEOVIM_PLUGIN_PATH/tokyonight.nvim-2.9.0 $DOWNLOAD_NEOVIM_PLUGIN_PATH/tokyonight.nvim
rm -rf $DOWNLOAD_NEOVIM_PLUGIN_PATH/tokyonight.nvim/.github
rm -f $DOWNLOAD_NEOVIM_PLUGIN_PATH/tokyonight.nvim.tar.gz

echo "-----copy-lualine.nvim-themes"
cp -rT $DOWNLOAD_REPO_PATH/DevTool/Neovim-conf/pack/vendor/opt $HOME/work/lch/rc/nvimrc/pack/vendor/opt

echo "======Clone NeoVim Plugin Repo Complete======"

#复制 VSCode 配置文件
echo "======Copy VSCode Setting Start======"
rm -rf $VSCODE_SETTING_PATH
mkdir -p $VSCODE_SETTING_PATH
cp -afp $DOWNLOAD_REPO_PATH/DevTool/VSCode-conf/user/settings.json $VSCODE_SETTING_PATH/settings.json
cp -afp $DOWNLOAD_REPO_PATH/DevTool/VSCode-conf/user/keybindings.json $VSCODE_SETTING_PATH/keybindings.json
cp -afp $DOWNLOAD_REPO_PATH/DevTool/VSCode-conf/user/tasks.json $VSCODE_SETTING_PATH/tasks.json
cp -afp $DOWNLOAD_REPO_PATH/DevTool/VSCode-conf/snippets $VSCODE_SETTING_PATH/snippets
cp -afp $DOWNLOAD_REPO_PATH/DevTool/VSCode-conf/vbs $VSCODE_SETTING_PATH/vbs
echo "======Copy VSCode Setting Complete======"

#复制 WezTerm 配置文件
echo "======Copy WezTerm Setting Start======"
rm -f $HOME/.wezterm.lua
cp -afp $DOWNLOAD_REPO_PATH/DevTool/WezTerm_conf/wezterm.lua $HOME/.wezterm.lua
echo "======Copy WezTerm Setting Complete======"

#复制 Alacritty 配置文件
echo "======Copy Alacritty Setting Start======"
rm -rf $HOME/.config/alacritty
mkdir -p $HOME/.config/alacritty
cp -afp $DOWNLOAD_REPO_PATH/DevTool/alacritty_conf/alacritty.yml $HOME/.config/alacritty/alacritty.yml
echo "======Copy Alacritty Setting Complete======"

#复制 ConTour 配置文件
echo "======Copy ConTour Setting Start======"
rm -rf $HOME/.config/contour
mkdir -p $HOME/.config/contour
cp -afp $DOWNLOAD_REPO_PATH/DevTool/contour_conf/contour.yml $HOME/.config/contour/contour.yml
echo "======Copy ConTour Setting Complete======"

read -p "Press enter to continue"

