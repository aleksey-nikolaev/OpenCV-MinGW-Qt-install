@echo off
rem setlocal enabledelayedexpansion
set uniqSet=call %~dp0%uniqSet.bat
set projectConfig=call %~dp0%projectConfig.bat

rem this call might be dangerous because PATH appended - never clean
call "%VS140COMNTOOLS%..\..\VC\vcvarsall.bat" 
%uniqSet% path_uniqSet "%path%"
set path=%path_uniqSet%
set path_uniqSet=

%projectConfig% "%ProjectPath%;%ProjectPath%\opencv\x86\vc14" LIB INCLUDE
rem %uniqSet% LIBRARY_PATH "%LIB%"
rem %uniqSet% CPLUS_INCLUDE_PATH "%INCLUDE%"

rem endlocal
exit /b 0
