# OpenCV-MinGW-Qt-install
it for any how use gui instead console. How to build OpenCV libs for Qt+mingw

Зайдите на вики или посмотрите README.ru.md, там всё подробно расписано.

## Build OpenCV3.0.0

In the source of OpenCV find \cmake\OpenCVCompilerOptions.cmake and comment line with -Werror=non-virtual-dtor (it posible is 67). Mast be like this   

    #add_extra_compiler_option(-Werror=non-virtual-dtor)

Start cmake-gui from console Qt environment  

Set options  

  * `WITH_QT = 1`
  * `WITH_OPENGL = 1` 
  * `WITH_IPP = 0`
  * `WITH_DSHOW = 0`
  * `BUILD_TESTS = 0`.

Choose `CMAKE_BUILD_TYPE` 

Compile.

## Build OpenCV2.4.11

Start cmake-gui from console Qt environment  

Set options  

  * `WITH_QT = 1`
  * `WITH_OPENGL = 1`    
  
Choose `CMAKE_BUILD_TYPE` 

Compile.
