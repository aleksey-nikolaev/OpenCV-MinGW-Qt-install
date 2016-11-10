@echo off
set __CD_=%CD%
set QTDIR_base=D:\Qt\5.7
set configerPath=d:\OpenCV-MinGW-Qt-install\configuration
set CMakePath=D:\Projects\cmake-3.5.1-win32-x86\bin
set path=%path%;%__CD_%\lib

choice /c 01234 /m "0- MSVC, 1- qtcreator, 2- cmake-gui, 3- qt5.7-mingw, 4- cmake-gui-mingw"
set choiseCode=%ERRORLEVEL%
if "%choiseCode%" geq "4" (
    call :starterMingw
) else (
    call :starter
)
set path=%path%;%PROOF_PATH%\lib
if "%choiseCode%" == "1" start /B /D "%VS140COMNTOOLS%..\IDE" devenv.exe /useenv
if "%choiseCode%" == "2" start /B /D "%QTDIR%\..\..\Tools\QtCreator\bin" qtcreator.exe
if "%choiseCode%" == "3" start /B /D "%CMakePath%" %CMakePath%\cmake-gui.exe
if "%choiseCode%" == "4" start /B /D "%QTDIR%\..\..\Tools\QtCreator\bin" qtcreator.exe
if "%choiseCode%" == "5" start /B /D "%CMakePath%" %CMakePath%\cmake-gui.exe
cd /d %__CD_%
exit /b 0

rem -------------------------------
:starter
    echo   MSVC evironment
    set ProjectPath=d:/Projects
    
    set PROOF_PATH=%ProjectPath%\proof-bin
    set QMAKEFEATURES=%PROOF_PATH%\features
    
    set QTDIR=%QTDIR_base%\msvc2015
    call %QTDIR%\bin\qtenv2.bat 
    call %configerPath%\msvc-env.bat
exit /b 0

rem -------------------------------
:starterMingw
    echo   MinGW evironment
    set ProjectPath=d:\ProjectsMINGW

    set PROOF_PATH=%ProjectPath%\proof-bin
    set QMAKEFEATURES=%PROOF_PATH%\features
    
    set QTDIR=%QTDIR_base%\mingw53_32
    call %QTDIR%\bin\qtenv2.bat 
    call %configerPath%\mingw-env.bat 
exit /b 0