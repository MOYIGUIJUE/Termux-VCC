@echo off
set "local_path=%~dp0"
if "%local_path:~-1,1%"=="\" set local_path=%local_path:~0,-1%
%local_path%\Compile\Compile-bin\exec.bat %local_path%
echo;%local_path%\Compile\Compile-bin\exec.bat %local_path%
echo;待会输入helps回车运行,可以大概了解此第三方程序集合,DIY你自己控制台
del %0
pause
cls
termux.bat