@echo off
set __CD_=%CD%
set QTDIR_base=D:\Qt\Qt5\5.10.0
set CMakePath=D:\Tools\cmake-3.8.1-win64-x64\bin
set configerPath=d:\Tools\OpenCV-MinGW-Qt-install\configuration

choice /c 1234567 /m "MSVC: 1- VS, 2- qtcreator, 3- cmake-gui, 4- run additional script. MINGW: 5- qtcreator, 6- cmake-gui, 7- run additional script"
set choiseCode=%ERRORLEVEL%
if "%choiseCode%" geq "5" (
    call :starterMingw
) else (
    call :starter
)
set path=%path%;%ADDITIONAL_PATH%\lib
if "%choiseCode%" == "1" start /B /D "%VS150COMNTOOLS%..\IDE" devenv.exe /useenv
if "%choiseCode%" == "2" start /B /D "%QTDIR%\..\..\Tools\QtCreator\bin" qtcreator.exe
if "%choiseCode%" == "3" start /B /D "%CMakePath%" %CMakePath%\cmake-gui.exe
if "%choiseCode%" == "4" cd %__CD_%\additional && additional.py --src ./ --dest %ADDITIONAL_PATH%

if "%choiseCode%" == "5" start /B /D "%QTDIR%\..\..\Tools\QtCreator\bin" qtcreator.exe
if "%choiseCode%" == "6" start /B /D "%CMakePath%" %CMakePath%\cmake-gui.exe
if "%choiseCode%" == "7" cd %__CD_%\additional && additional.py --src ./ --dest %ADDITIONAL_PATH%
cd /d %__CD_%
exit /b 0

rem -------------------------------
:starter
    echo   MSVC evironment
    set ProjectPath=d:/ProjectsMSVC
    
    set ADDITIONAL_PATH=%ProjectPath%\additional-bin
    set QMAKEFEATURES=%ADDITIONAL_PATH%\features
    
    set QTDIR=%QTDIR_base%\msvc2017_64
    call %QTDIR%\bin\qtenv2.bat 
    call %configerPath%\msvc-env.bat "%ProjectPath%;%ProjectPath%\opencv\install\x64\vc15"
exit /b 0

rem -------------------------------
:starterMingw
    echo   MinGW evironment
    set ProjectPath=d:\ProjectsMINGW

    set ADDITIONAL_PATH=%ProjectPath%\additional-bin
    set QMAKEFEATURES=%ADDITIONAL_PATH%\features
    
    set QTDIR=%QTDIR_base%\mingw53_32
    call %QTDIR%\bin\qtenv2.bat 
    call %configerPath%\mingw-env.bat "%ProjectPath%;%ProjectPath%\opencv\install\x86\mingw"
exit /b 0