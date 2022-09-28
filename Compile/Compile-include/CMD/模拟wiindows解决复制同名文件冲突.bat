@echo off & title 
setlocal enabledelayedexpansion
for %%a in (q) do (
    for %%c in (t.bat) do (
		set num=0
		call :rename "%%a\%%~nxc"
        echo;"%%c" --^> "%%a\!name!%%~xc"
        copy "%%c" "%%a\!name!%%~xc"
    )
)
exit /b

:rename
set "name=%~n1"
set num=0
:loop
REM echo;  - "%~dp1\%name%%~x1"
if exist "%~dp1\%name%%~x1" (
	set /a num+=1
	set "name=%~n1£¨!num!£©"
	goto :loop
) else exit /b



rem mode 70,15
REM set num=0
REM setlocal enabledelayedexpansion
for /f "delims=" %%i in ('dir /b /ad') do (
	set /a num+=1
	set folder[!num!]="%%i"
	set "CmdMenuSel=!CmdMenuSel! "%%i""
)
CmdMenuSel 0708 %CmdMenuSel%
cd /d !folder[%errorlevel%]!
ls


edirected to "HKLM\SOFTWARE\Wow6432Node"

KEY TARGET	HKEY LOCAL MACHINE

KEY_NON_ADMIN_TARGET HKEY_CURRENT_USER
KEY STARTUP "SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run"
KEY_NON_ADMIN_STARTUP "Software\\Microsoft\\Windows\\CurrentVersion\\Run"
KEY_ROOT_STARTUP "SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon'
KEY_VALUE_NAME "WinUpdateSched"
KEY_SHELL_NAME "Shell"