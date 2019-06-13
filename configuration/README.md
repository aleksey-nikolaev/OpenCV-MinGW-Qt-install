# Configuration
Helpful tools for making environment for IDE and build.

#### switch code page
**`manual-code-page.bat`** helps to switch code page for console. Helpful when want to see what compiler or linker  write on output window (in QCreator with MSVC compiler)

#### Remove duplicates
**`uniqSet.bat`** helps to remove duplicates from the list (separated by `;` without `"`).

### Search for libs, headers, pc-files and etc.
**`querySearch.bat`** Make list of subdirectories for directories from the path list, with suffixes if set and check existing of file in the subdirectory by wildcard

`querySearch.bat ArrayVariable [ProjectsPathArray [ProjectPathSuffix [wildcard]]]`

  - ArrayVariable - Variable for resulting list store.
  - ProjectsPathArray - separated by ; list of directories for search. If ProjectsPathArray not set the %CD% will be used
  - ProjectPathSuffix - separated by ; list of each directory suffixes. If not set querySearch collect all first level subdirectories.
  - Wildcard used for check existence of file in a subdirectory. For pkg-config files use *.pc

### Macro for collecting path to libraries, includes, pc-files
**`projectConfig.bat`** used `querySearch` for collecting. Founded list sored in to the proper variable.

`projectConfig.bat "%ProjectPath%;%AnotherPathes%" [LIBPATH INCLUDE]`

First parameter is a directories list separated by `;`. Variables LIBPATH and INCLUDE are name for containers in which `*/lib` and `*/include` subdirectories from directories list will be added. The name used by default are `LIBRARY_PATH` and `CPLUS_INCLUDE_PATH` (mingw style).

#### Configuration for IDE:
Simple:
  * `mingw-env.bat "<extra project path list>"`
  * `msvc-env.bat "<extra project path list>"`

Both of these scripts call projectConfig.bat with `"<extra project path list>"` (for example, ` "%ProjectPath%;%ProjectPath%\opencv\install\x86\vc14"`) as the first parameter, so this list should contain a top directories for the search.

### CMake build helper `buildcmakeproject.bat`
**`buildcmakeproject.bat`** has three forms to make it easier to build an external project.
```batch
call buildcmakeproject <project name> <git address> <cmake additional> 
call buildcmakeproject /a  <project name> <source path> <cmake additional> 
call buildcmakeproject /b  <project name> <source path> <build path> <install path> <cmake additional> 
```
Before you call `buildcmakeproject.bat` set:
1. `DEPENDENCY_ROOT_PATH` - where this script can save some project (source, build) data,
1. `DEPENDENCY_INSTALL_PATH` - where to install after build,
2. `CONFIGURE_CMAKE_GENERATOR` - some text for cmake generator,
3. optionaly `BUILD_CONFIGURATION` - ;-separated list of build types.

Example:
```batch
if "%VS150COMNTOOLS%"=="" (
  echo Configure for MinGW
  set CONFIGURE_CMAKE_GENERATOR=-G"CodeBlocks - MinGW Makefiles"
) else (
  echo Configure for MSVC
  call "%VS150COMNTOOLS%..\..\VC\Auxiliary\Build\vcvars64.bat"
  rem set CXXFLAGS=/wd4127
  set CONFIGURE_CMAKE_GENERATOR=-G"Visual Studio 15 Win64" -Thost=x64 -DCMAKE_SHARED_LINKER_FLAGS_DEBUG="/DEBUG:FULL" -DCMAKE_DEBUG_POSTFIX="d"
)
rem set BUILD_CONFIGURATION=Debug

call buildcmakeproject zlib "https://github.com/madler/zlib.git"
call buildcmakeproject /a jpeg "c:/Projects/jpeg"
if "%VS150COMNTOOLS%"=="" (
  call buildcmakeproject OpenCV "https://github.com/opencv/opencv.git -b 4.0.1" "-DWITH_MSMF=NO -DBUILD_TESTS=OFF -DBUILD_PERF_TESTS=OFF -DBUILD_EXAMPLES=OFF -DBUILD_opencv_apps=ON -DBUILD_SHARED_LIBS=ON -DBUILD_opencv_java=OFF -DBUILD_opencv_python=OFF"
  set "PATH=%PATH%;%DEPENDENCY_INSTALL_PATH%/x64/mingw/bin"
) else (
  call buildcmakeproject OpenCV "https://github.com/opencv/opencv.git -b 4.1.0" "-DBUILD_TESTS=OFF -DBUILD_PERF_TESTS=OFF -DBUILD_EXAMPLES=OFF"
  set "PATH=%PATH%;%DEPENDENCY_INSTALL_PATH%/x64/vc15/bin"
)

call buildcmakeproject /b MyProj "c:/Projects/MyProj/source" "c:/Projects/MyProj/source-build" "c:/dependency/install" "-DMyProj_OPTION=1"

```

### Example for launch IDE
**`using-querySearch.bat`** make launch IDE easier. Just set correct `QTDIR_base`, `configerPath` and `ProjectPath`. Also check CMakePath - path to CMake GUI and other settings for your project.
