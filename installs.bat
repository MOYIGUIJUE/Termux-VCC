@echo off
title TERMUX-VCC
set "local_path=%~dp0"
if "%local_path:~-1,1%"=="\" set local_path=%local_path:~0,-1%
call %local_path%\Compile\Compile-bin\exec.bat %local_path%
echo;%local_path%\Compile\Compile-bin\exec.bat %local_path%
start cmd /c "termux /c helps"
start cmd /c "termux FILE"
del %0
exit /b
