@echo off & title 卸载VCC
%2mshta vbscript:createobject("shell.application").shellexecute("""%~dpnx0""","%~1 ::",,"runas",1)(window.close)&exit /b
REM setlocal enabledelayedexpansion
cd /d %~dp0
echo;  -- 是否确认卸载VCC --
pause >nul
rd /s /q Compile
rd /s /q FILE
del termux.bat
( reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v VCC_HOME /f ) || echo;需要管理员权限
reg delete HKCR\gccbinpath /f >nul
reg delete HKCR\Directory\Background\shell\Termux /f >nul 
reg delete HKLM\Software\Classes\*\Shell\Notepad++ /f >nul
echo;  -- 卸载VCC成功 --
pause >nul
del %0 & pause >nul

