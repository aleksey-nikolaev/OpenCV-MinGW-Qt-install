@echo off
setlocal enabledelayedexpansion
if "%~1"=="" (
    echo Usage
    echo call querySearch.bat ArrayVariable [ProjectsPathArray [ProjectPathSuffix [wildcard]]]
    echo  ProjectsPathArray - separated by ; list of directories for search
    echo Also search will be made in all subdirs {first level} for each directory in ProjectsPathArray
    echo If ProjectsPathArray not set the ^%CD^% will be used
    echo  ProjectPathSuffix - separated by ; list of each directory suffixes
    echo Wildcard used for check existing of file in directory with suffixes. For pkg-config files use *.pc
)
rem echo [%0 %1 %2 %3 %4]
set ProjectsPath=%~2
set ProjectsPath=!ProjectsPath:^"=!
if "%ProjectsPath%" == "" (
    set ProjectsPath=%CD%
)
set ProjectPathSuffix=%~3
set ProjectPathSuffix=!ProjectPathSuffix:^"=!
set wildcard=%~4

set __path_List=
for %%a in ("%ProjectsPath:;=";"%") do (
    set __element__tmp=%%~a
    set __element__tmp=!__element__tmp:\=/!

    if "!__element__tmp:~-1!" == "/" set __element__tmp=!__element__tmp:~0,-1!

    call :appendPkgConfigPath __path_List "!__element__tmp!"
    if "%wildcard%" == "" (
        rem search in subdirs
        rem for /d make %%x very strange format {like d:opencv instead d:/ProjectsMINGW/opencv},
        rem  that is why used only "file name" i.e. dir name in this case %%~nxx
        for /d %%x in ("!__element__tmp!/*") do ( 
            call :appendPkgConfigPath __path_List "!__element__tmp!/%%~nxx"
        )
    )
)
rem send __path_List over local
endlocal & set %1=%__path_List%&
exit /b 0

rem -----------------------------------------------------
:appendPkgConfigPath
    set getPkgConfigPathes_return=
    call :getPkgConfigPathes getPkgConfigPathes_return %2
    if "!getPkgConfigPathes_return!" == "" (exit /b 0)
    call :set_append %1 "!getPkgConfigPathes_return!"
exit /b 0

rem -----------------------------------------------------
:getPkgConfigPathes
    for %%a in ("%ProjectPathSuffix:;=";"%") do (
        set __path_with_suffix=%~2/%%~a
        if "!__path_with_suffix:~-1!" == "/" set __path_with_suffix=!__path_with_suffix:~0,-1!
        if "!__path_with_suffix:~-1!" == "/" set __path_with_suffix=!__path_with_suffix:~0,-1!
        if exist "!__path_with_suffix!/%wildcard%" (
            echo      found in !__path_with_suffix!
            call :set_append %1 "!__path_with_suffix!"
        )
    )
exit /b 0

rem -----------------------------------------------------
:set_append
    if "!%1!" == "" (
        set %1=%~2
    ) else (
        set %1=!%1!;%~2
    )
exit /b 0
