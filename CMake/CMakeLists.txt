cmake_minimum_required (VERSION 3.24)

#set(CMAKE_VERBOSE_MAKEFILE ON)

set(CMAKE_C_COMPILER "D:/Tools/WorkTool/C/codeblocks-20.03mingw-nosetup/MinGW/bin/gcc.exe")
set(CMAKE_C_COMPILER_WORKS TRUE)

add_compile_options(-Wall -g -fexec-charset=utf-8 -D UNICODE)

project (Win32Sample LANGUAGES C)

add_executable(messagebox WIN32 messagebox.c)
add_executable(hello WIN32 hello.c)
