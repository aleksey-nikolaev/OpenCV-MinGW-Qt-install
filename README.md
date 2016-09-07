# OpenCV-MinGW-Qt-install
it for any how use gui instead console. How to build OpenCV libs for Qt+mingw

## Build OpenCV3.1.0 or OpenCV2.4.11

Start cmake-gui from console Qt environment. Useful batch file for build:

```batch
set QTDIR="for example d:\Qt\Qt5.7.0-mingw\5.7\mingw53_32"
set CMAKEDIR="for example d:\cmake5.4.1"
call "%QTDIR%\bin\qtenv2.bat"
start "gui" /B "%CMAKEDIR%\bin\cmake-gui.exe"
```
Do not close cmd when starting the batch file (Shift+Enter in the TotalComader)

Set options for project
  * `WITH_QT = 1`
  * `WITH_OPENGL = 1`    

Choose `CMAKE_BUILD_TYPE` or leave empty for default (Release)

Compile in same cmd whit the batch file. Change directory to where to build the binaries. Make sure that `CMAKE_INSTALL_PREFIX` is correct. Start `mingw32-make && mingw32-make install`. 

## Build OpenCV3.0.0

In the source of OpenCV find \cmake\OpenCVCompilerOptions.cmake and comment line with -Werror=non-virtual-dtor (it possible is 67). Mast be like this   

    #add_extra_compiler_option(-Werror=non-virtual-dtor)

Start cmake-gui from console Qt environment  

Set options  

  * `WITH_QT = 1`
  * `WITH_OPENGL = 1` 
  * `WITH_IPP = 0`
  * `WITH_DSHOW = 0`
  * `BUILD_TESTS = 0`.

Choose `CMAKE_BUILD_TYPE` or leave empty for default (Release) 

Compile.
