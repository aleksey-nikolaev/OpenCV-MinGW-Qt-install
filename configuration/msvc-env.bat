@echo off

set VS150COMNTOOLS=C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\Tools\

rem setlocal enabledelayedexpansion
set uniqSet=call %~dp0%uniqSet.bat
set projectConfig=call %~dp0%projectConfig.bat

rem this call might be dangerous because PATH appended - never clean
rem call "%VS150COMNTOOLS%..\..\VC\Auxiliary\Build\vcvarsall.bat" 
call "%VS150COMNTOOLS%..\..\VC\Auxiliary\Build\vcvars64.bat" 
%uniqSet% path_uniqSet "%path%"
set path=%path_uniqSet%
set path_uniqSet=

%projectConfig% %1 LIB INCLUDE
rem %uniqSet% LIBRARY_PATH "%LIB%"
rem %uniqSet% CPLUS_INCLUDE_PATH "%INCLUDE%"

rem endlocal
exit /b 0
