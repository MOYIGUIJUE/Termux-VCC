@echo off
set "local_path=%~dp0"
if "%local_path:~-1,1%"=="\" set local_path=%local_path:~0,-1%
%local_path%\Compile\Compile-bin\exec.bat %local_path%
echo;%local_path%\Compile\Compile-bin\exec.bat %local_path%
helpme.exe
echo;��������helps�س�����,���Դ���˽�˳��򼯺�
del %0
pause
cls
termux.bat