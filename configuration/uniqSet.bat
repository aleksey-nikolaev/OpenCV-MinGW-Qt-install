@echo off
setlocal enabledelayedexpansion
rem echo [%0  %1  %2] echo [%3  %4  %5]

set ProjectsPath=%~2
if "%ProjectsPath%" == "" (
    exit /b 1
)

set __path_List=!%1!
if not "!__path_List!" == "" set __path_List="!__path_List:;=";"!"

for %%a in ("!ProjectsPath:;=";"!") do (
    call :uniqTest %%a
    if !ERRORLEVEL! == 0 call :set_append __path_List %%a
)
endlocal & set %1=%__path_List:"=%&
exit /b 0

rem -----------------------------------------------------
:uniqTest
    if !__path_List! == "" exit /b 0
    set __path_=%1
    set __path_=!__path_:/=!
    set __path_=!__path_:\=!
    for %%b in (!__path_List!) do (
        set __element_=%%b
        set __element_=!__element_:/=!
        set __element_=!__element_:\=!
        if !__element_! == !__path_! (
            echo !__element_! == !__path_!
            exit /b 1
        )
    )
exit /b 0

rem -----------------------------------------------------
:set_append
    if "!%1!" == "" (
        set %1=%2
    ) else (
        set %1=!%1!;%2
    )
exit /b 0