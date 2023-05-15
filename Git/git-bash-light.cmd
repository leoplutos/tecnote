set MSYSTEM=MINGW64
D:\Tools\WorkTool\Team\Git\usr\bin\mintty.exe ^
  -o AppID=GitForWindows.Bash ^
  -o RelaunchCommand="..\..\git-bash.exe" ^
  -o RelaunchDisplayName="Git Bash" ^
  -i /mingw64/share/git/git-for-windows.ico ^
  --loadconfig "%USERPROFILE%\minttyrc-light" ^
  --dir "%USERPROFILE%" ^
  /bin/bash --login -i

REM 下面是另一种用法
REM D:\Tool\Git\usr\bin\mintty.exe --loadconfig "%USERPROFILE%\minttyrc-light" --dir "%USERPROFILE%" --exec "/bin/bash" --login -i
