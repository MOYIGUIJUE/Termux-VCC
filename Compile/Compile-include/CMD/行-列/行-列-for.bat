@echo off
setlocal enabledelayedexpansion
set n=0
for /f "delims=" %%i in (1.txt) do (
	for %%b in (%%i) do (
		REM set /a n+=1
		REM set Arr[!n!]=%%b
		echo;%%b
	)
)
REM for /l %%z in (1,1,!n!) do (
	REM echo;!Arr[%%z]!
REM )

