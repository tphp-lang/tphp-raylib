@echo off
REM ============================================================
REM raylib test build script (tcc compiler) - Windows version
REM
REM Usage:
REM   build.cmd        # Build test program
REM   build.cmd run    # Build and run
REM   build.cmd clean  # Clean
REM
REM Depends: root directory has lib\libraylib.a and include\raylib.h
REM ============================================================

setlocal

set "ROOT_DIR=.."
set "INCLUDE_DIR=%ROOT_DIR%\include"
set "LIB_DIR=%ROOT_DIR%\lib"
set "COMPAT_DIR=%ROOT_DIR%\compat"
set "TARGET=test_raylib.exe"

REM -- Link flags --
set "LDFLAGS=-I%INCLUDE_DIR% -w -L%LIB_DIR% -lraylib -lopengl32 -lgdi32 -lwinmm -luser32 -ladvapi32 -lole32 -lshlwapi"

set "ACTION=%~1"
if "%ACTION%"=="" set "ACTION=build"

if "%ACTION%"=="clean" goto :clean
if "%ACTION%"=="build" goto :build
if "%ACTION%"=="run" goto :run
goto :usage

:clean
echo Cleaning...
if exist "%TARGET%" del /q "%TARGET%"
echo Done.
goto :eof

:build
echo CC  main.c
tcc main.c "%COMPAT_DIR%\user32_ext.def" -o "%TARGET%" %LDFLAGS%
if errorlevel 1 (
    echo Build failed
    exit /b 1
)
echo Built %TARGET%
goto :eof

:run
call :build
if errorlevel 1 exit /b 1
echo Running %TARGET%...
"%TARGET%"
goto :eof

:usage
echo Usage: %0 [build^|run^|clean]
exit /b 1
