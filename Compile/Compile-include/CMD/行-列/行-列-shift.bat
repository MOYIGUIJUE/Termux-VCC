@echo off
for /f "delims=" %%a in ('dir /b *.txt') do (
	for /f "usebackq delims=" %%i in ("%%a") do (
		call :loop %%i
	)
)
exit /b
:loop
	set a=%1
	if not defined a goto :eof
	echo;%1
	shift
goto :loop




