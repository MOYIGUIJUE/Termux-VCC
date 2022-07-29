@echo off
set "local_path=%~dp0"
if "%local_path:~-1,1%"=="\" set local_path=%local_path:~0,-1%
%local_path%\Compile\Compile-bin\exec.bat %local_path%
echo;%local_path%\Compile\Compile-bin\exec.bat %local_path%
helpme.exe
echo;待会输入helps回车运行,可以大概了解此程序集合
del %0
pause
cls
termux.bat