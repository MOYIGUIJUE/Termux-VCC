@echo off &title TERMUX-VCC&cls
if not "%~1" == "" (
	if "%~1" == "/c" goto :termux
	:loop
	if "%~1"=="" exit /b
	echo;%~a1|findstr /i "hs">nul && (
		attrib -s -h %1 
	) || attrib +s +h %1 
	shift
	goto loop
)
:termux
setlocal enabledelayedexpansion
for /f "tokens=2 delims=:" %%i in ('ipconfig ^|find "IPv4" ') do set IPv4=%%i
set IPv4=%IPv4: =%
set used=%USERNAME%
for %%i in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do ( 
	call set used=%%used:%%i=%%i%%
)
path=%~dp0Compile\Compile-bin;%path%
nircmd.exe win trans title "TERMUX-VCC" 180
modes 68 15
for /f "delims=:" %%a in ('findstr /n "splitline.*$" %~fs0') do set "splitline=%%a"
for /f "tokens=2,*" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Desktop"') do set "Desk=%%j"
set LANG=zh_CN
doskey cat=type $*
doskey cp=copy $*
doskey mv=move $*
doskey rv=recycle $*
doskey pwd=cd
doskey cds=cd /d $*
doskey ll=ls --color=auto $*
doskey note="%~dp0FILE\Notepad++\notepad++.exe" $*
doskey tcc="%~dp0FILE\TCC\tcc.exe" $*
doskey ip=printf 0x07 "%IPv4%" ^| clip ^& echos 0x03 --[%IPv4%]�Ѹ��������а�-- 
doskey ca=set /a ca_result=$*
call :random 
more +%splitline% %~dpnx0
colors 0x07
modes 70 15
prompt %used%@%COMPUTERNAME%[$P]$$$S
set h=& set s=
set splitline=
for /l %%i in (1,1,15) do set r%%i=
cmd /k %2
call :showcmd
exit /b
:random
FOR %%i IN (0 1 2 3 4 5 6 8 9 a b c d e f) DO (SET /A h+=1 & SET r!h!=%%i)
����SET /A s=%RANDOM%%%%h%+1
	colors 0x7!r%s%!
exit /b 
:showcmd
printf 0x0a %used%@%COMPUTERNAME%
printf 0x09 [%cd%]
printf 0x07 "$ "
set /p.=
call %.%
set.=
goto :showcmd
::::splitline:::::
.
                 ______                                               
                /_  __/__  _________ ___  __  ___  __                 
                 / / / _ \/ ___/ __ `__ \/ / / / |/_/                 
                / / /  __/ /  / / / / / / /_/ />  <                   
               /_/  \___/_/  /_/ /_/ /_/\__,_/_/|_|                   
.                                                                     
.                                                                     