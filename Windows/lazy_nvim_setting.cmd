::---------------------------------------------------
::将Git仓库的NeoVim设定复制到Windows环境(Lazy.nvim)
::---------------------------------------------------
::前提条件
::  git
::---------------------------------------------------
::NeoVim配置文件复制到
::  %LOCALAPPDATA%\nvim
::---------------------------------------------------

@echo off

::变量设定
SET GITHUB_URL=https://bgithub.xyz
SET WORK_DIR=%USERPROFILE%\.cache\lazy_nvim_setting
SET NVIM_CONF_DIR=%LOCALAPPDATA%\nvim
set PREV_DIR=%CD%

::git设定
git config --global gui.encoding utf-8
git config --global color.ui true
git config --global core.autoCRLF false
git config --global core.sparseCheckout true

::判断文件夹是否存在，不存在就新建
if not exist "%WORK_DIR%" (
    mkdir "%WORK_DIR%"
    echo Folder created: %WORK_DIR%
    ::从Github获取设定文件（稀疏检出）
    git clone -b master --depth 1 --filter=blob:none --no-checkout --sparse %GITHUB_URL%/leoplutos/tecnote.git %WORK_DIR%
    cd /d %WORK_DIR%
    git sparse-checkout set --no-cone "DevTool/Neovim_lazy-conf" "DevTool/Vim-conf"
    git checkout
) else (
    echo Folder already exists: %WORK_DIR%
    ::从Github获取最新
    cd /d %WORK_DIR%
    git pull
)
if not exist "%NVIM_CONF_DIR%" (
    mkdir "%NVIM_CONF_DIR%"
    echo Folder created: %NVIM_CONF_DIR%
) else (
    echo Folder already exists: %NVIM_CONF_DIR%
)

::复制到nvim设定目录
xcopy /e /s /i /r /h /y %WORK_DIR%\DevTool\Neovim_lazy-conf\* %NVIM_CONF_DIR%
xcopy /e /s /i /r /h /y %WORK_DIR%\DevTool\Vim-conf\vimconf\colors %NVIM_CONF_DIR%\colors

echo Setting Complited
cd /d %PREV_DIR%

@echo on
