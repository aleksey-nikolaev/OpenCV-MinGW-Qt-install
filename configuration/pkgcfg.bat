@echo off
setlocal enabledelayedexpansion
if "%~1"=="" (
    echo Usage
    echo call pkgcfg.bat ArrayVariable [ProjectsPathArray [ProjectPathSuffix [wildcard]]]
    echo  ProjectsPathArray - separated by ; list of directories for search
    echo Also search will be made in all subdirs {first level} for each directory in ProjectsPathArray
    echo If ProjectsPathArray not set the ^%CD^% will be used
    echo  ProjectPathSuffix - separated by ; list of each directory suffixes
    echo Wildcard used for check existing of file in directory with suffixes. For pkg-config files use *.pc
)
echo [%0 %1 %2 %3 %4]
set ProjectsPath=%~2
if "%ProjectsPath%" == "" (
    set ProjectsPath=%CD%
)
set ProjectPathSuffix=%~3
set wildcard=%~4
rem if "%wildcard%" == "" (
rem     set wildcard=*.pc
rem )
set __path_List=
for %%a in ("%ProjectsPath:;=" "%") do (
    set __path__tmp=%%~a
    set __path__tmp=!__path__tmp:\=/!/
    set __path__tmp=!__path__tmp://=/!
    set __path__tmp=!__path__tmp:^(=!
    set __path__tmp=!__path__tmp:^)=!
    rem search in subdirs
    rem for /d make %%x very strange format, that is why used only "file name" i.e. dir name in this case %%~nxx
    for /d %%x in ("" "!__path__tmp!/*") do ( 
        set __path_with_suffix=!__path__tmp!%%~nxx/
        set __path_with_suffix=!__path_with_suffix://=/!
        call :appendPkgConfigPath __path_List "!__path_with_suffix!"
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
    for %%a in ("%ProjectPathSuffix:;=" "%") do (
        set __path_with_suffix=%~2%%~a/
        set __path_with_suffix=!__path_with_suffix://=/!
        if exist "!__path_with_suffix!%wildcard%" (
rem            echo found file in %~2 with %%~a
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