@echo off 
%2mshta vbscript:createobject("shell.application").shellexecute("""%~dpnx0""","%~1 ::",,"runas",1)(window.close)&exit /b
REM setlocal enabledelayedexpansion
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v VCC_HOME /f
reg delete HKCR\gccbinpath /f >nul
reg delete HKCR\Directory\Background\shell\Termux /f >nul
( reg delete HKLM\Software\Classes\*\Shell\Notepad++ /f >nul ) && rd /s /q compile
pause
