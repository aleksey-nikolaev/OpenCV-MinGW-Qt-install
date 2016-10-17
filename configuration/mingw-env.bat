@echo off
rem setlocal enabledelayedexpansion
set uniqSet=call %~dp0%uniqSet.bat
set projectConfig=call %~dp0%projectConfig.bat

rem this call might be dangerous because PATH appended - never clean
%uniqSet% path_uniqSet "%path%"
set path=%path_uniqSet%
set path_uniqSet=

%projectConfig% "%ProjectPath%;%ProjectPath%\opencv\install\x86\mingw"

rem endlocal
exit /b 0
