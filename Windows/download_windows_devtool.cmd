::---------------------------------------------------
::这个脚本将下载Windows平台开发工具
::---------------------------------------------------
::前提条件
::  curl/git
::---------------------------------------------------
::  1.7-zip(https://www.7-zip.org/download.html)
::  2.sakura-editor(https://github.com/sakura-editor/sakura/releases)
::  3.VS Code(https://code.visualstudio.com/Download)
::  4.Gvim(https://github.com/vim/vim-win32-installer/releases)
::  5.NeoVim(https://github.com/neovim/neovim/releases)
::  6.NeoVide(https://github.com/neovide/neovide/releases)
::  7.WindowsTerminal(https://github.com/microsoft/terminal/releases)
::  8.WezTerm(https://github.com/wez/wezterm/releases/)
::  9.Alacritty(https://github.com/alacritty/alacritty/releases)
::  10.ConTour(https://github.com/contour-terminal/contour/releases)
::  11.im-select(https://github.com/daipeihust/im-select)
::  12.Chrome(https://www.google.cn/intl/zh-CN/chrome/)
::  13.WinMerge(https://winmerge.org/downloads/?lang=en)
::  14.fzf(https://github.com/junegunn/fzf/releases)
::  15.ripgrep(https://github.com/BurntSushi/ripgrep/releases)
::  16.bat(https://github.com/sharkdp/bat/releases)
::---------------------------------------------------

@echo off
::设定镜像
SET GITHUB_URL=https://hub.njuu.cf
SET DOWNLOAD_URL=https://download.njuu.cf
SET DOWNLOAD_PATH=D:\Download

echo ======DevelopTool DownLoad Start======

::echo -----7-zip(tag:23.01)
::curl --create-dirs -o %DOWNLOAD_PATH%\7z2301-x64.exe https://www.7-zip.org/a/7z2301-x64.exe
::move %DOWNLOAD_PATH%\7z2301-x64.exe D:\ToolInstall
::echo -----7-zip download complete - D:\ToolInstall\7z2301-x64.exe

echo -----sakura-editor(tag:v2.4.2)
curl --create-dirs -o %DOWNLOAD_PATH%\sakura-tag-v2.4.2-build4203-a3e63915b-Win32-Release-Installer.zip %DOWNLOAD_URL%/sakura-editor/sakura/releases/download/v2.4.2/sakura-tag-v2.4.2-build4203-a3e63915b-Win32-Release-Installer.zip
mkdir D:\ToolInstall\Text\SakuraEditor\2.4.2
move %DOWNLOAD_PATH%\sakura-tag-v2.4.2-build4203-a3e63915b-Win32-Release-Installer.zip D:\ToolInstall\Text\SakuraEditor\2.4.2
echo -----sakura-editor download complete - D:\ToolInstall\Text\SakuraEditor\2.4.2\sakura-tag-v2.4.2-build4203-a3e63915b-Win32-Release-Installer.zip

echo -----VS Code(tag:1.84.2)
curl --create-dirs -o %DOWNLOAD_PATH%\VSCode-win32-x64-1.84.2.zip https://vscode.cdn.azure.cn/stable/1a5daa3a0231a0fbba4f14db7ec463cf99d7768e/VSCode-win32-x64-1.84.2.zip
mkdir D:\ToolInstall\Text\VSCode
move %DOWNLOAD_PATH%\VSCode-win32-x64-1.84.2.zip D:\ToolInstall\Text\VSCode
echo -----VS Code download complete - D:\ToolInstall\Text\VSCode\VSCode-win32-x64-1.84.2.zip

echo -----Gvim(tag:v9.0.2130)
curl --create-dirs -o %DOWNLOAD_PATH%\gvim_9.0.2130_x86.zip %DOWNLOAD_URL%/vim/vim-win32-installer/releases/download/v9.0.2130/gvim_9.0.2130_x86.zip
mkdir D:\ToolInstall\Text\gvim\gvim9.0.2130
move %DOWNLOAD_PATH%\gvim_9.0.2130_x86.zip D:\ToolInstall\Text\gvim\gvim9.0.2130
curl --create-dirs -o %DOWNLOAD_PATH%\gvim_9.0.2130_x86_pdb.zip %DOWNLOAD_URL%/vim/vim-win32-installer/releases/download/v9.0.2130/gvim_9.0.2130_x86_pdb.zip
move %DOWNLOAD_PATH%\gvim_9.0.2130_x86_pdb.zip D:\ToolInstall\Text\gvim\gvim9.0.2130
echo -----Gvim download complete - D:\ToolInstall\Text\gvim\gvim9.0.2130\gvim_9.0.2130_x86.zip
echo -----Gvim download complete - D:\ToolInstall\Text\gvim\gvim9.0.2130\gvim_9.0.2130_x86_pdb.zip

echo -----NeoVim(tag:nightly)
curl --create-dirs -o %DOWNLOAD_PATH%\nvim-nightly-win64.zip %DOWNLOAD_URL%/neovim/neovim/releases/download/nightly/nvim-win64.zip
mkdir D:\ToolInstall\Text\neovim\nightly
move %DOWNLOAD_PATH%\nvim-nightly-win64.zip D:\ToolInstall\Text\neovim\nightly
echo -----NeoVim download complete - D:\ToolInstall\Text\neovim\nightly\nvim-nightly-win64.zip

echo -----NeoVide(tag:0.11.2)
curl --create-dirs -o %DOWNLOAD_PATH%\neovide-0.11.2.exe.zip %DOWNLOAD_URL%/neovide/neovide/releases/download/0.11.2/neovide.exe.zip
mkdir D:\ToolInstall\Text\neovim\neovide
move %DOWNLOAD_PATH%\neovide-0.11.2.exe.zip D:\ToolInstall\Text\neovim\neovide
echo -----NeoVide download complete - D:\ToolInstall\Text\neovim\neovide\neovide-0.11.2.exe.zip

echo -----WindowsTerminal(tag:v1.18.3181.0)
curl --create-dirs -o %DOWNLOAD_PATH%\Microsoft.WindowsTerminal_1.18.3181.0_8wekyb3d8bbwe.msixbundle %DOWNLOAD_URL%/microsoft/terminal/releases/download/v1.18.3181.0/Microsoft.WindowsTerminal_1.18.3181.0_8wekyb3d8bbwe.msixbundle
mkdir D:\ToolInstall\Linux\WindowsTerminal
move %DOWNLOAD_PATH%\Microsoft.WindowsTerminal_1.18.3181.0_8wekyb3d8bbwe.msixbundle D:\ToolInstall\Linux\WindowsTerminal
echo -----WindowsTerminal download complete - D:\ToolInstall\Linux\WindowsTerminal\Microsoft.WindowsTerminal_1.18.3181.0_8wekyb3d8bbwe.msixbundle

echo -----WezTerm(tag:0.11.2)
curl --create-dirs -o %DOWNLOAD_PATH%\WezTerm-windows-20230712-072601-f4abf8fd.zip %DOWNLOAD_URL%/wez/wezterm/releases/download/20230712-072601-f4abf8fd/WezTerm-windows-20230712-072601-f4abf8fd.zip
mkdir D:\ToolInstall\Linux\WezTerm
move %DOWNLOAD_PATH%\WezTerm-windows-20230712-072601-f4abf8fd.zip D:\ToolInstall\Linux\WezTerm
echo -----WezTerm download complete - D:\ToolInstall\Linux\WezTerm\WezTerm-windows-20230712-072601-f4abf8fd.zip

echo -----Alacritty(tag:0.12.3)
curl --create-dirs -o %DOWNLOAD_PATH%\Alacritty-v0.12.3-portable.exe %DOWNLOAD_URL%/alacritty/alacritty/releases/download/v0.12.3/Alacritty-v0.12.3-portable.exe
mkdir D:\ToolInstall\Linux\Alacritty
move %DOWNLOAD_PATH%\Alacritty-v0.12.3-portable.exe D:\ToolInstall\Linux\Alacritty
echo -----Alacritty download complete - D:\ToolInstall\Linux\Alacritty\Alacritty-v0.12.3-portable.exe

echo -----ConTour(tag:0.3.12.262)
curl --create-dirs -o %DOWNLOAD_PATH%\contour-0.3.12.262-win64.zip %DOWNLOAD_URL%/contour-terminal/contour/releases/download/v0.3.12.262/contour-0.3.12.262-win64.zip
mkdir D:\ToolInstall\Linux\ConTour
move %DOWNLOAD_PATH%\contour-0.3.12.262-win64.zip D:\ToolInstall\Linux\ConTour
echo -----ConTour download complete - D:\ToolInstall\Linux\ConTour\contour-0.3.12.262-win64.zip

echo -----im-select
git clone --depth=1 -b master %GITHUB_URL%/daipeihust/im-select.git %DOWNLOAD_PATH%\im-select
mkdir D:\Tools\WorkTool\Text\im-select
move %DOWNLOAD_PATH%\im-select\win\out\x64 D:\Tools\WorkTool\Text\im-select
move %DOWNLOAD_PATH%\im-select\win\out\x86 D:\Tools\WorkTool\Text\im-select
rmdir /S /Q %DOWNLOAD_PATH%\im-select
echo -----im-select download complete - D:\Tools\WorkTool\Text\im-select

echo -----fzf(tag:0.44.1)
curl --create-dirs -o %DOWNLOAD_PATH%\fzf-0.44.1-windows_amd64.zip %DOWNLOAD_URL%/junegunn/fzf/releases/download/0.44.1/fzf-0.44.1-windows_amd64.zip
mkdir D:\ToolInstall\Search\fzf
move %DOWNLOAD_PATH%\fzf-0.44.1-windows_amd64.zip D:\ToolInstall\Search\fzf
echo -----fzf download complete - D:\ToolInstall\Search\fzf\fzf-0.44.1-windows_amd64.zip

echo -----ripgrep(tag:14.0.3)
curl --create-dirs -o %DOWNLOAD_PATH%\ripgrep-14.0.3-x86_64-pc-windows-msvc.zip %DOWNLOAD_URL%/BurntSushi/ripgrep/releases/download/14.0.3/ripgrep-14.0.3-x86_64-pc-windows-msvc.zip
mkdir D:\ToolInstall\Search\ripgrep
move %DOWNLOAD_PATH%\ripgrep-14.0.3-x86_64-pc-windows-msvc.zip D:\ToolInstall\Search\ripgrep
echo -----ripgrep download complete - D:\ToolInstall\Search\ripgrep\ripgrep-14.0.3-x86_64-pc-windows-msvc.zip

echo -----bat(tag:v0.24.0)
curl --create-dirs -o %DOWNLOAD_PATH%\bat-v0.24.0-x86_64-pc-windows-msvc.zip %DOWNLOAD_URL%/sharkdp/bat/releases/download/v0.24.0/bat-v0.24.0-x86_64-pc-windows-msvc.zip
mkdir D:\ToolInstall\Search\bat
move %DOWNLOAD_PATH%\bat-v0.24.0-x86_64-pc-windows-msvc.zip D:\ToolInstall\Search\bat
echo -----bat download complete - D:\ToolInstall\Search\bat\bat-v0.24.0-x86_64-pc-windows-msvc.zip

echo ======DevelopTool DownLoad Complete======

pause

@echo on
