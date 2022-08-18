@echo off
setlocal enabledelayedexpansion
set num=0
if "%~1"=="-" call :sourse

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
for /f "tokens=3* delims= " %%i in ('reg query HKCU\Environment /v path') do (
	for /f "tokens=3* delims= " %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v path') do (
		path=%%a%%b%%i%%j
		exit /b
	)
)


