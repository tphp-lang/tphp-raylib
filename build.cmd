@echo off
REM ============================================================
REM raylib build script (tcc compiler) - Windows version
REM
REM Usage:
REM   build.cmd                 # Build static library to lib\
REM   build.cmd clean           # Clean build artifacts
REM   build.cmd install-headers # Copy public headers to include\
REM
REM Platform: Windows -> PLATFORM_DESKTOP_WIN32 (Win32 native backend)
REM ============================================================

setlocal enabledelayedexpansion

REM -- Directories --
set "RAYLIB_SRC=raylib-6.0\src"
set "COMPAT_DIR=compat"
set "INCLUDE_DIR=include"
set "LIB_DIR=lib"
set "BUILD_DIR=build"
set "TARGET=%LIB_DIR%\libraylib.a"

REM -- Compile flags --
REM tcc_compat.h is force-included via -include into every translation unit
REM compat/ provides stub headers missing from tcc's winapi
set "CFLAGS=-DPLATFORM_DESKTOP_WIN32 -DGRAPHICS_API_OPENGL_33 -DUNICODE -I%COMPAT_DIR% -include %COMPAT_DIR%\tcc_compat.h -I%RAYLIB_SRC% -I%RAYLIB_SRC%\external -w"

REM -- raylib source modules --
set "SRCS=rcore rshapes rtextures rtext rmodels raudio"

REM -- Command dispatch --
set "ACTION=%~1"
if "%ACTION%"=="" set "ACTION=build"

if "%ACTION%"=="clean" goto :clean
if "%ACTION%"=="install-headers" goto :install_headers
if "%ACTION%"=="build" goto :build
goto :usage

:clean
echo Cleaning...
if exist "%BUILD_DIR%" rmdir /s /q "%BUILD_DIR%"
if exist "%TARGET%" del /q "%TARGET%"
echo Done.
goto :eof

:install_headers
if not exist "%INCLUDE_DIR%" mkdir "%INCLUDE_DIR%"
copy /y "%RAYLIB_SRC%\raylib.h"    "%INCLUDE_DIR%\" >nul
copy /y "%RAYLIB_SRC%\raymath.h"   "%INCLUDE_DIR%\" >nul
copy /y "%RAYLIB_SRC%\rlgl.h"      "%INCLUDE_DIR%\" >nul
copy /y "%RAYLIB_SRC%\rgestures.h" "%INCLUDE_DIR%\" >nul
copy /y "%RAYLIB_SRC%\rcamera.h"   "%INCLUDE_DIR%\" >nul
echo Headers installed to %INCLUDE_DIR%\
goto :eof

:build
if not exist "%BUILD_DIR%" mkdir "%BUILD_DIR%"
if not exist "%LIB_DIR%" mkdir "%LIB_DIR%"
echo "===== Building strat ====="
for %%M in (%SRCS%) do (
    echo tcc -c "%RAYLIB_SRC%\%%M.c" -o "%BUILD_DIR%\%%M.o" %CFLAGS%
    tcc -c "%RAYLIB_SRC%\%%M.c" -o "%BUILD_DIR%\%%M.o" %CFLAGS%
    if errorlevel 1 (
        echo Build failed: %%M.c
        exit /b 1
    )
)
echo "===== Building end ====="

echo "===== Archive ====="
echo tcc -ar rcs "%TARGET%" "%BUILD_DIR%\*.o"
tcc -ar rcs "%TARGET%" "%BUILD_DIR%\*.o"
if errorlevel 1 (
    echo Archive failed
    exit /b 1
)
echo Built %TARGET%
goto :eof

:usage
echo Usage: %0 [build^|clean^|install-headers]
exit /b 1
