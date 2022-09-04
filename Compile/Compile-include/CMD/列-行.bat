@echo off
set m=0 
set n=0
setlocal enabledelayedexpansion
cd. >2.txt
for /f "delims=" %%i in (1.txt) do (
	set /p.= %%i <nul >>2.txt
)
	
REM for /f "delims=" %%i in (1.txt) do (
	REM set aa=!aa! %%i
REM )
REM echo.!aa!>%%a

::pause >nul 2>nul