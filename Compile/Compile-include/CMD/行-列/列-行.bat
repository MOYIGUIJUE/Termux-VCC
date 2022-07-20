@echo off
set m=0 
set n=0
setlocal enabledelayedexpansion
for /f "delims=" %%a in ('dir /b *.txt') do (
set /a m+=1
for /f "delims=" %%i in (%%a) do (
set /a n+=1
if !n! EQU 1 set aa=%%i
if !n! GTR 1 set aa=!aa! %%i
)
echo.!aa!>%%a
 if !m! equ 1 set "aa="&& set m=0
)
::pause >nul 2>nul