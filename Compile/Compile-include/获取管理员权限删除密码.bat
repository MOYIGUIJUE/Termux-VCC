%1 %2
ver|find "5.">nul&&goto :Admin
mshta vbscript:createobject("shell.application").shellexecute("%~s0","goto :Admin","","runas",1)(window.close)&goto :eof
:Admin
echo * |net user %username% *

REM @echo off
REM if exist "%SystemRoot%\SysWOW64" path %path%;%windir%\SysNative;%SystemRoot%\SysWOW64;%~dp0
REM bcdedit >nul
REM if '%errorlevel%' NEQ '0' (goto UACPrompt) else (goto UACAdmin)
REM :UACPrompt
REM %1 start "" mshta vbscript:createobject("shell.application").shellexecute("""%~0""","::",,"runas",1)(window.close)&exit
REM exit /B
REM :UACAdmin
REM cd /d "%~dp0"
REM echo 当前运行路径是：%CD%
REM echo 已获取管理员权限
REM pause