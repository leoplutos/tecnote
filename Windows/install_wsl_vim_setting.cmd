::---------------------------------------------------
::这个脚本将Window系统下使用的Vim/NeoVim设定复制到WSL
::---------------------------------------------------
::Vim复制内容
::  %USERPROFILE%\.vimrc                   ->  %WSL_VIM_RC%\.vimrc
::  %USERPROFILE%\vimconf\after            ->  %WSL_VIM_RC%\vimconf\after
::  %USERPROFILE%\vimconf\colors           ->  %WSL_VIM_RC%\vimconf\colors
::  %USERPROFILE%\vimconf\dict             ->  %WSL_VIM_RC%\vimconf\dict
::  %USERPROFILE%\vimconf\ftdetect         ->  %WSL_VIM_RC%\vimconf\ftdetect
::  %USERPROFILE%\vimconf\init             ->  %WSL_VIM_RC%\vimconf\init
::  %USERPROFILE%\vimconf\nerdtree_plugin  ->  %WSL_VIM_RC%\vimconf\nerdtree_plugin
::  %USERPROFILE%\vimconf\syntax           ->  %WSL_VIM_RC%\vimconf\syntax
::需要打开复制插件Flg
::  %USERPROFILE%\vimconf\pack             ->  %WSL_VIM_RC%\vimconf\pack
::---------------------------------------------------
::NeoVim复制内容
::  %LOCALAPPDATA%\nvim\init.lua           ->  %WSL_NVIM_RC%\init.lua
::  %LOCALAPPDATA%\nvim\lua                ->  %WSL_NVIM_RC%\lua
::需要打开复制插件Flg
::  %LOCALAPPDATA%\nvim\pack               ->  %WSL_NVIM_RC%\pack
::---------------------------------------------------
::Snippet复制内容
::  %USERPROFILE%\AppData\Roaming\Code\User\snippets  ->  %WSL_SNIPPET_RC%
::---------------------------------------------------

@echo off

::设置是否复制插件文件夹
set COPY_PLUGIN_FOLDER=0
::设置WSL的设定文件路径
set WSL_VIM_RC=\\wsl.localhost\Ubuntu-22.04\home\lchuser\work\lch\rc\vimrc
set WSL_NVIM_RC=\\wsl.localhost\Ubuntu-22.04\home\lchuser\work\lch\rc\nvimrc
set WSL_SNIPPET_RC=\\wsl.localhost\Ubuntu-22.04\home\lchuser\work\lch\rc\snippets

echo ======Copy Vim/NeoVim Setting File to WSL======
echo ======Copy Vim Setting Start======

::复制Vim设定
copy /y %USERPROFILE%\.vimrc %WSL_VIM_RC%\.vimrc
xcopy /e /s /i /r /h /y %USERPROFILE%\vimconf\after %WSL_VIM_RC%\vimconf\after
xcopy /e /s /i /r /h /y %USERPROFILE%\vimconf\colors %WSL_VIM_RC%\vimconf\colors
xcopy /e /s /i /r /h /y %USERPROFILE%\vimconf\dict %WSL_VIM_RC%\vimconf\dict
xcopy /e /s /i /r /h /y %USERPROFILE%\vimconf\ftdetect %WSL_VIM_RC%\vimconf\ftdetect
xcopy /e /s /i /r /h /y %USERPROFILE%\vimconf\init %WSL_VIM_RC%\vimconf\init
xcopy /e /s /i /r /h /y %USERPROFILE%\vimconf\nerdtree_plugin %WSL_VIM_RC%\vimconf\nerdtree_plugin
xcopy /e /s /i /r /h /y %USERPROFILE%\vimconf\syntax %WSL_VIM_RC%\vimconf\syntax
if %COPY_PLUGIN_FOLDER%==1 (
  xcopy /e /s /i /r /h /y %USERPROFILE%\vimconf\pack %WSL_VIM_RC%\vimconf\pack
)
echo ======Copy Vim Setting End======
echo ======Copy NeoVim Setting End======

::复制NeoVim设定
copy /y %LOCALAPPDATA%\nvim\init.lua %WSL_NVIM_RC%\init.lua
xcopy /e /s /i /r /h /y %LOCALAPPDATA%\nvim\lua %WSL_NVIM_RC%\lua
if %COPY_PLUGIN_FOLDER%==1 (
  xcopy /e /s /i /r /h /y %LOCALAPPDATA%\nvim\pack %WSL_NVIM_RC%\pack
)

::复制Snippet
xcopy /e /s /i /r /h /y %USERPROFILE%\AppData\Roaming\Code\User\snippets %WSL_SNIPPET_RC%

echo ======Copy NeoVim Setting End======

@echo on
