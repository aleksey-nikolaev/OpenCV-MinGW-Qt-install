@echo off

rem Usage call projectConfig.bat "%ProjectPath%" [LIBPATH INCLUDE]
rem where variadles LIBPATH and INCLUDE are name for containers
rem in which */lib and */include pathes from ProjectPath will be added
rem  The name used by default are LIBRARY_PATH and CPLUS_INCLUDE_PATH

setlocal
set querySearch=call %~dp0%pkgcfg.bat
set uniqSet=call %~dp0%uniqSet.bat

set ProjectPath=%~1
set LIBRARY_PATH_var=%2
set CPLUS_INCLUDE_PATH_var=%3
if "%ProjectPath%" == "" set ProjectPath=%CD%
if "%LIBRARY_PATH_var%" == "" set LIBRARY_PATH_var=LIBRARY_PATH
if "%CPLUS_INCLUDE_PATH_var%" == "" set CPLUS_INCLUDE_PATH_var=CPLUS_INCLUDE_PATH

echo [1] Configurating project for path %ProjectPath%

echo [2] Make ProjectsList of directories from ProjectPath and ProjectPath/install
rem Make list of directories from ProjectPath and it`s subdirs 
rem {an empty tag for search - i.e. folder irrelevant to files containing} 
rem and directories like this ProjectPath/install {the second tag for search} 
%querySearch% ProjectsList "%ProjectPath%" ";install"

echo [3] Make ProjectsPathBin list of directories from non empty ProjectsList/bin
%querySearch% ProjectsPathBin "%ProjectsList%" "bin" "*.*"

echo [4] Make ProjectsPathLib list of directories from non empty ProjectsList/lib
%querySearch% ProjectsPathLib "%ProjectsList%" "lib" "*.*"

echo [5] Make ProjectsPathInclude list of directories from non empty ProjectsList/include
%querySearch% ProjectsPathInclude "%ProjectsList%" "include" "*.*"

echo [6] Append PATH with ProjectsPathBin
%uniqSet% path "%ProjectsPathBin%"
rem Check existing pkg-config.exe in PATH
for /F %%a in ("pkg-config.exe") do (
    if not exist %%~$PATH:a (
        echo "install %%a first"
        echo "http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/pkg-config_0.26-1_win32.zip"
        exit /b 1
    )
)

echo [7] Make PKG_CONFIG_PATH list of directories. Search ProjectsList and ProjectsPathLib dirs and its pkgconfig subdirectories where *.pc files are present
%querySearch% PKG_CONFIG_PATH "%ProjectsList%;%ProjectsPathLib%" ";pkgconfig" "*.pc"

endlocal & (
    set "path=%path%"
    %uniqSet% %LIBRARY_PATH_var% "%ProjectsPathLib%"
    %uniqSet% %CPLUS_INCLUDE_PATH_var% "%ProjectsPathInclude%"
    set "PKG_CONFIG_PATH=%PKG_CONFIG_PATH%"
)
exit /b 0

