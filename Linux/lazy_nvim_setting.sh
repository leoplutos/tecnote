#!/bin/bash

#---------------------------------------------------
#将Git仓库的NeoVim设定复制到Linux环境(Lazy.nvim)
#---------------------------------------------------
#前提条件
#  git
#---------------------------------------------------
#NeoVim配置文件复制到
#  ${HOME}/.config/nvim
#---------------------------------------------------

#变量设定
export GITHUB_URL=https://bgithub.xyz
export WORK_DIR=${HOME}/.cache/lazy_nvim_setting
export NVIM_CONF_DIR=${HOME}/.config/nvim

#git设定
git config --global gui.encoding utf-8
git config --global color.ui true
git config --global core.autoCRLF false
git config --global core.sparseCheckout true

#判断文件夹是否存在，不存在就新建
if [ -d "$WORK_DIR" ]; then
    echo "Folder already exists: $WORK_DIR"
    #从Github获取最新
    cd ${WORK_DIR}
    git pull
else
    mkdir -p "$WORK_DIR"
    echo "Folder created: $WORK_DIR"
    #从Github获取设定文件（稀疏检出）
    git clone -b master --depth 1 --filter=blob:none --no-checkout --sparse ${GITHUB_URL}/leoplutos/tecnote.git ${WORK_DIR}
    cd ${WORK_DIR}
    git sparse-checkout set --no-cone "DevTool/Neovim_lazy-conf" "DevTool/Vim-conf"
    git checkout
fi
if [ -d "$NVIM_CONF_DIR" ]; then
    echo "Folder already exists: $NVIM_CONF_DIR"
else
    mkdir -p "$NVIM_CONF_DIR"
    echo "Folder created: $NVIM_CONF_DIR"
fi

#复制到nvim设定目录
cp -afp ${WORK_DIR}/DevTool/Neovim_lazy-conf/* ${NVIM_CONF_DIR}
cp -afp ${WORK_DIR}/DevTool/Vim-conf/vimconf/colors/ ${NVIM_CONF_DIR}

echo "Setting Complited"
