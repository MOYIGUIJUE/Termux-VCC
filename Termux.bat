@echo off
if not "%~1" == "" (
	:loop
	if "%~1"=="" exit /b
	echo;%~a1|findstr /i "hs">nul && (
		attrib -s -h %1 
	) || attrib +s +h %1 
	shift
	goto loop
)
setlocal enabledelayedexpansion
for /f "tokens=2 delims=:" %%i in ('ipconfig ^|find "IPv4" ') do set IPv4=%%i
set IPv4=%IPv4: =%
set used=%USERNAME%
for %%i in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do ( 
	call set used=%%used:%%i=%%i%%
)
title 
path=%path%;%~dp0Compile\Compile-bin
path=%path%;%~dp0Compile\Compile-bin\Sourse Lib\NODE
path=%path%;D:\python\Scripts\;D:\python\
path=%path%;C:\Program Files\MySQL\MySQL Server 8.0\bin
modes 70 15
for /f "delims=:" %%a in ('findstr /n "splitline.*$" %~fs0') do set "splitline=%%a"
for /f "tokens=2,*" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Desktop"') do set "Desk=%%j"
set LANG=zh_CN
doskey cat=type $*
doskey clear=echo off $t cls $t modes 70 15 $t title $t colors 0x70 $t more +%splitline% %0 $t colors 0x07 $t set .= ^& set /p ".=%used%@%COMPUTERNAME%[%%cd%%]$ " ^& call %%.%% ^& set .=^& echo on
doskey cp=copy $*
doskey mv=move $*
doskey pwd=cd
doskey remove=move $1 E:\Desktop_copy\History^>nul
doskey ll=ls --color=auto $*
doskey note=D:\Notepad++\notepad++.exe $*
doskey tcc="%~dp0Compile\Compile-bin\Sourse Lib\TCC\tcc.exe" $*
doskey reboot=start cmd /c %0 $t exit
doskey ip=printf 0x07 "%IPv4%" ^| clip ^& echos 0x03 --IPv4��ַ�Ѹ��������а�-- 
call :random 
more +%splitline% %0
colors 0x07
prompt %used%@%COMPUTERNAME%[$P]$$$S
set h=& set s=
set splitline=
for /l %%i in (1,1,15) do set r%%i=
cmd /k 
:random
FOR %%i IN (0 1 2 3 4 5 6 8 9 a b c d e f) DO (SET /A h+=1 & SET r!h!=%%i)
����SET /A s=%RANDOM%%%%h%+1
rem ECHO %s%:!r%s%!
	colors 0x7!r%s%!
exit /b 
::::splitline:::::
                                                                       
                 ______                                                
                /_  __/__  _________ ___  __  ___  __                  
                 / / / _ \/ ___/ __ `__ \/ / / / |/_/                  
                / / /  __/ /  / / / / / / /_/ />  <                    
               /_/  \___/_/  /_/ /_/ /_/\__,_/_/|_|                    
                                                                       
                                                                       