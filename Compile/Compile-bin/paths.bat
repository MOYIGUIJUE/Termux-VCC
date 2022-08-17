@echo off
setlocal enabledelayedexpansion
set num=0
if "%~1"=="-" call :sourse
if "%~1"=="-c" goto :sourse_change

for /f "delims=" %%i in ('path') do (
	set "paths=%%i"
	set paths=!paths:;=" "!
	set paths="!paths:~5!"
	call :loop !paths!
)
exit /b
:loop
	set a=%1
	if not defined a goto :eof
	if "%~1"=="" ( 
		shift
		goto :loop
	)
	set /a num+=1
	echo;[%num%]	%~1
	shift
goto :loop

:sourse
for /f "tokens=3* delims= " %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v path') do (
	path=%%i%%j
)
exit /b

:sourse_change
for /f "tokens=3* delims= " %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v path') do (
	cmd /k path=%%i%%j
)