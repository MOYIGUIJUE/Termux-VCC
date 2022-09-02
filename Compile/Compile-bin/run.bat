@echo off
setlocal enabledelayedexpansion
title %1
cd /d %~dp1
set a=!time!
call %1 %2
set b=!time!
set /a h1=%a:~0,2%
set /a m1=1%a:~3,2%-100
set /a s1=1%a:~6,2%-100
set /a h2=%b:~0,2%
set /a m2=1%b:~3,2%-100
set /a s2=1%b:~6,2%-100
if %h2% LSS %h1% set /a h2=%h2%+24

if %h1% NEQ %h2% (
	set /a ts1=%h1%*3600+%m1%*60+%s1%
	set /a ts2=%h2%*3600+%m2%*60+%s2%
) else (
	if %m1% NEQ %m2% (
		set /a ts1=%m1%*60+%s1%
		set /a ts2=%m2%*60+%s2%
	) else (
		set /a ts1=%s1%
		set /a ts2=%s2%
	)
)

set /a ts=%ts2%-%ts1%
set ms_b=%a:~-2%
set ms_e=%b:~-2%
if %ms_e% lss %ms_b% set /a ms_e=%ms_e%+100
set /a ms_=%ms_e%-%ms_b%
set /a h=%ts%/3600
set /a m=(%ts%-%h%*3600)/60
set /a s=%ts%%%60
echo.
echo;-------------------------------
echo;Process exited after %ts%.%ms_% seconds with return value %errorlevel%
set /a ms=%ts%*100+%ms_%
echo;ms:%ms%0ms                  耗时 %h% 小时 %m% 分 %s% 秒 %ms_%0 ms

