@echo off & title ж��VCC
%2mshta vbscript:createobject("shell.application").shellexecute("""%~dpnx0""","%~1 ::",,"runas",1)(window.close)&exit /b
REM setlocal enabledelayedexpansion
echo;---�Ƿ�ȷ��ж��VCC---
pause >nul
( reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v VCC_HOME /f ) || echo;��Ҫ����ԱȨ��
reg delete HKCR\gccbinpath /f >nul
reg delete HKCR\Directory\Background\shell\Termux /f >nul
( reg delete HKLM\Software\Classes\*\Shell\Notepad++ /f >nul ) && rd /s /q compile
pause >nul
