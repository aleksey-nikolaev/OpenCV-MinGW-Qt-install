rem --- call buildcmakeproject <project name> <git address> <cmake additional> --------------
rem --- call buildcmakeproject /a  <project name> <source path> <cmake additional> ------
rem --- call buildcmakeproject /b  <project name> <source path> <build path> <install path> <cmake additional> ------
rem set DEPENDENCY_ROOT_PATH, DEPENDENCY_INSTALL_PATH, CONFIGURE_CMAKE_GENERATOR, [BUILD_CONFIGURATION]
setlocal enabledelayedexpansion
set __install_path=%DEPENDENCY_INSTALL_PATH%
set __source_path=
set __build_path=
set __tmp=%~1
if not "%__tmp:~0,1%"=="/" (
  set __project=%~1
  set __git_param=%~2
  set __cmake_param=%~3
  echo Project: !__project! git: !__git_param! params: !__cmake_param!
) else (
  set __project=%~2
  set __source_path=%~3
  if "%__tmp%"=="/a" (
    set __cmake_param=%~4
  ) else (
    set __build_path=%~4
    set __install_path=%~5
    set __cmake_param=%~6
  )
  echo Project: !__project! params: !__cmake_param!
)
set __project_path=%DEPENDENCY_ROOT_PATH%/%__project%
if not exist "%__project_path%" md "%__project_path%"

if "%__source_path%" == "" set __source_path=%__project_path%/source
if not exist "%__source_path%" git clone --progress -v %__git_param% --depth 1 "%__source_path%"

if "%__build_path%"=="" set __build_path=%__project_path%/source-build
if not exist "%__build_path%" md "%__build_path%"

set __max_proc=-j4
if not "%VS150COMNTOOLS%"=="" set __max_proc=/m

set __multiconfig=0
set __tmp=%CONFIGURE_CMAKE_GENERATOR:"=%
if "%__tmp:Makefile=%" == "%__tmp:Ninja=%" set __multiconfig=1

if "%BUILD_CONFIGURATION:"=%" == "" set BUILD_CONFIGURATION=Debug;Release
for %%b in (%BUILD_CONFIGURATION%) do (
  call :makeBuildConfiguration %%b || exit /b 1
)
endlocal
exit /b 0

rem configure make and install for each BUILD_CONFIGURATION: makeBuildConfiguration <BUILD_CONFIG>
:makeBuildConfiguration
  set __install_tag=%__project_path%/installed%~1
  if exist "%__install_tag%" (
      echo  Project: %__project% Installed %~1
      exit /b 0
  )
  cd /d "%__build_path%"
  if !__multiconfig! == 0 set __cmake_config=-DCMAKE_BUILD_TYPE=%1
  if !__multiconfig! LEQ 1 ((
    set /a "__multiconfig=__multiconfig*2"
    cmake "%__source_path%" %CONFIGURE_CMAKE_GENERATOR% !__cmake_config! -DCMAKE_INSTALL_PREFIX=%__install_path% %__cmake_param%
  ) || exit /b 1)
  (cmake --build . --target install --config %1 -- %__max_proc%
  ) || exit /b 1
  md "%__install_tag%"
exit /b 0
