@echo off
rem setlocal enabledelayedexpansion

set QTDIR=d:\Qt\Qt5.6.0-2015\5.6\msvc2015
set msysPath=d:\Projects\MinGW\msys\1.0
set MinGWPath=d:\Projects\MinGW
set PATH=%MinGWPath%;%msysPath%;%MinGWPath%\bin;%msysPath%\bin;%PROOF_PATH%;%QTDIR%\bin;%PATH%

set LIBRARY_PATH=%MinGWPath%\lib;%msysPath%\lib;%LIBRARY_PATH%
set CPLUS_INCLUDE_PATH=%MinGWPath%\include;%msysPath%\include;%CPLUS_INCLUDE_PATH% 

rem list of directories for search /including subdirs/
set ProjectsList=d:\Projects;%msysPath%;%MinGWPath%;%QTDIR%

rem Make list of folders that are present under each of ProjectsList directories itself and /install {sufixes}
set ProjectsPath=
call pkgcfg.bat ProjectsPath "%Projectslist%" ";install"

rem Make list of non-empty folders that are present under each of ProjectsList directories with sufixes
set ProjectsPathBin=
call pkgcfg.bat ProjectsPathBin "%Projectslist%" "bin;build/bin;install/bin" "*.*"

rem append those path to the PATH
set path=%ProjectsPath%;%ProjectsPathBin%;%path%

rem Check existing pkg-config.exe in PATH
for /F %%a in ("pkg-config.exe") do (
    if not exist %%~$PATH:a (
        echo "install %%a first"
        echo "http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/pkg-config_0.26-1_win32.zip"
        exit /b 1
    )
)

rem Collect all the folders that contain *.pc
set PKG_CONFIG_PATH_SUFFIX=;lib/pkgconfig;pkgconfig;lib;build/lib/pkgconfig;build/lib;build
call pkgcfg.bat PKG_CONFIG_PATH "%Projectslist%" "%PKG_CONFIG_PATH_SUFFIX%" "*.pc"

rem call any environment configuration or/and IDE or somethig else here.

rem endlocal
exit /b 0
