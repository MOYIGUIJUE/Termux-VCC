@echo off
setlocal enabledelayedexpansion
set n=0
set m=0
for /f "usebackq delims=" %%A in (`dir /b`) do (
	set /a m+=1
	set Arr[!n!][!m!]=%%A
	if !m! equ 3 (
		set /a m=0
		set /a n+=1
	)
)
for /l %%a in (0,1,!n!) do (
	for /l %%b in (0,1,3) do (
		printf 0x07 "!Arr[%%a][%%b]!	"
	)
	echo;
)
echo on