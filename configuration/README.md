# Configuration
Helpful tools for making environment for IDE and build.

#### switch code page
`manual code page.bat` helps to switch code page for console. Helpful when want to see what compiler or linker  write on output window (in QCreator with MSVC compiler)

#### Remove duplicates
`uniqSet.bat` helps to remove duplicates from the list (separated by `;` without `"`).

### Search for libs, headers, pc-files and etc.
`querySearch.bat` Make list of subdirectories for directories from the path list, with suffixes if set and check existing of file in the subdirectory by wildcard

`querySearch.bat ArrayVariable [ProjectsPathArray [ProjectPathSuffix [wildcard]]]`

  - ArrayVariable - Variable for resulting list store.
  - ProjectsPathArray - separated by ; list of directories for search. If ProjectsPathArray not set the %CD% will be used
  - ProjectPathSuffix - separated by ; list of each directory suffixes. If not set querySearch collect all first level subdirectories.
  - Wildcard used for check existence of file in a subdirectory. For pkg-config files use *.pc

### Macro for collecting path to libraries, includes, pc-files
`projectConfig.bat` used `querySearch` for collecting. Founded list sored in to the proper variable.

`projectConfig.bat "%ProjectPath%;%AnotherPathes%" [LIBPATH INCLUDE]`

First parameter is a directories list separated by `;`. Variables LIBPATH and INCLUDE are name for containers in which `*/lib` and `*/include` subdirectories from directories list will be added. The name used by default are `LIBRARY_PATH` and `CPLUS_INCLUDE_PATH` (mingw style).


#### Configuration for IDE:
Simple:
  * `mingw-env.bat`
  * `msvc-env.bat`

### Example for launch IDE
`using-querySearch.bat` make launch IDE easier. Just set correct `QTDIR_base`, `configerPath` and `ProjectPath`. Also check CMakePath - path to CMake GUI and other settings for your project.
