@echo off

chcp 65001

set IIS_HOME=C:\inetpub\wwwroot\eAdaptorOutbound

set BASE_HOME=%~dp0
set BASE_HOME=%BASE_HOME:~0,-1%
for %%d in (%BASE_HOME%) do set BASE_HOME=%%~dpd
set BASE_HOME=%BASE_HOME%eAdaptorSampleWebService

echo BASE_HOME: %BASE_HOME%
echo IIS_HOME: %IIS_HOME%

echo デプロイ先を削減
del /F /S /Q %IIS_HOME%

echo デプロイを実施
xcopy /e /s /i /r /h /y %BASE_HOME%\bin %IIS_HOME%\bin
copy /y %BASE_HOME%\eAdaptorSoapWebService.svc %IIS_HOME%\eAdaptorSoapWebService.svc
copy /y %BASE_HOME%\Web.config %IIS_HOME%\Web.config

exit /b %ERRORLEVEL%
