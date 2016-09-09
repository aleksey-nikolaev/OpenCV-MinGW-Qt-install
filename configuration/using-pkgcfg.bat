@echo off
rem setlocal enabledelayedexpansion
set ProjectPath=d:\Projects
set uniqSet=call %~dp0%uniqSet.bat
set projectConfig=call %~dp0%projectConfig.bat

set QTDIR=d:\Qt\Qt5.6.0-2015\5.6\msvc2015
set msysPath=d:\Projects\MinGW\msys\1.0
set MinGWPath=d:\Projects\MinGW
set PATH=%MinGWPath%;%msysPath%;%MinGWPath%\bin;%msysPath%\bin;%PROOF_PATH%;%QTDIR%\bin;%PATH%

rem Clear duplicates from path
%uniqSet% path_uniqSet "%path%"
set path=%path_uniqSet%
set path_uniqSet=

%projectConfig% "%ProjectPath%;%ProjectPath%\opencv\x86\vc14"
rem or %projectConfig% "%ProjectPath%" LIBPATH INCLUDE
rem where variadles LIBPATH and INCLUDE are name for containers
rem in which */lib and */include pathes from ProjectPath will be added
rem The name used by default are LIBRARY_PATH and CPLUS_INCLUDE_PATH

rem endlocal
exit /b 0
