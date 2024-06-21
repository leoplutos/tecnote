
@echo off

set JAVA_HOME=D:\Tools\jdk-21
set BATCH_HOME=D:\GRPCBatch
set JAVACMD=%JAVA_HOME%\bin\java.exe

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
