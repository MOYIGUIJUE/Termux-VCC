@echo off
setlocal enabledelayedexpansion
set n=0
for /f "delims=" %%a in ('dir /b *.txt') do (
	for /f "usebackq delims=" %%i in ("%%a") do (
		for %%b in (%%i) do (
			set /a n+=1
			set Arr[!n!]=%%b
		)
	)
	cd.>%%a
	for /l %%z in (1,1,!n!) do (
		echo;!Arr[%%z]!>>%%a
	)
)
