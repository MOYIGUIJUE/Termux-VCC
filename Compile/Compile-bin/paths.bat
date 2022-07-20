@echo off
setlocal enabledelayedexpansion
set num=0
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




