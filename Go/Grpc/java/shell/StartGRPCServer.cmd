@echo off

chcp 65001

::取得参数1
set "USE_PORT=%~1"
if defined USE_PORT (
  ::如果参数1存在
  echo 端口：%USE_PORT%
) else (
  ::如果参数1不存在
  set USE_PORT=50051
)

set JAVA_HOME=D:\Tools\WorkTool\Java\jdk-21.0.3+9
set BATCH_HOME=D:\GRPCBatch
set JAVACMD=%JAVA_HOME%\bin\java.exe

set JAVA_TOOL_OPTIONS=-Duser.language=en -Dfile.encoding=UTF-8 -Dgrpc.port=%USE_PORT%

:: 启用变量延迟
SetLocal EnableDelayedExpansion
set CLASSPATH=.
:: 遍历lib目录下的所有jar文件并构建CLASSPATH
for %%i in (%BATCH_HOME%\lib\*.jar) do (
    set CLASSPATH=!CLASSPATH!;%%i
)
set CLASSPATH=!CLASSPATH!;%BATCH_HOME%\conf
:: 输出CLASSPATH
:: echo CLASSPATH=%CLASSPATH%
:: 还原系统环境设置 将CLASSPATH变量导出到环境变量
endlocal & set CLASSPATH=%CLASSPATH%

%JAVACMD% -classpath %CLASSPATH% javagrpc.main.ServerMain

exit /b %ERRORLEVEL%
