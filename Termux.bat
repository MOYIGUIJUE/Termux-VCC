@echo off &title &cls
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
for /f "tokens=3* delims= " %%i in ('reg query HKCU\Environment /v path') do (
	for /f "tokens=3* delims= " %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v path') do (
		path=%%a%%b%%i%%j
	)
)
path=%~dp0Compile\Compile-bin;%path%
modes 68 15
for /f "delims=:" %%a in ('findstr /n "splitline.*$" %~fs0') do set "splitline=%%a"
for /f "tokens=2,*" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Desktop"') do set "Desk=%%j"
set LANG=zh_CN
doskey cat=type $*
REM doskey clear=echo off $t cls $t title $t modes 68 15 $t colors 0x70 $t more +%splitline% %0 $t colors 0x07 $t modes 70 15 $t set .= ^& set /p ".=%used%@%COMPUTERNAME%[%%cd%%]$ " ^& call %%.%% ^& set .=^& echo on
doskey cp=copy $*
doskey mv=move $*
doskey pwd=cd
doskey ll=ls --color=auto $*
doskey note="%~dp0Compile\Compile-bin\Sourse Lib\Notepad++\notepad++.exe" $*
doskey tcc="%~dp0Compile\Compile-bin\Sourse Lib\TCC\tcc.exe" $*
doskey ip=printf 0x07 "%IPv4%" ^| clip ^& echos 0x03 --[%IPv4%]ÒÑ¸´ÖÆÖÁ¼ôÇÐ°å-- 
doskey ca=set /a ca_result=$*
call :random 
more +%splitline% %~dpnx0
colors 0x07
modes 70 15
prompt %used%@%COMPUTERNAME%[$P]$$$S
set h=& set s=
set splitline=
for /l %%i in (1,1,15) do set r%%i=
cmd /k 
exit /b
:random
FOR %%i IN (0 1 2 3 4 5 6 8 9 a b c d e f) DO (SET /A h+=1 & SET r!h!=%%i)
¡¡¡¡SET /A s=%RANDOM%%%%h%+1
rem ECHO %s%:!r%s%!
	colors 0x7!r%s%!
exit /b 
::::splitline:::::
.
                 ______                                               
                /_  __/__  _________ ___  __  ___  __                 
                 / / / _ \/ ___/ __ `__ \/ / / / |/_/                 
                / / /  __/ /  / / / / / / /_/ />  <                   
               /_/  \___/_/  /_/ /_/ /_/\__,_/_/|_|                   
.                                                                     
.                                                                     