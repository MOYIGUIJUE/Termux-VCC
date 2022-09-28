@echo off & title;
if not "%~1" == "" (
	if "%~1" == "/c" goto :termux
	if "%~1" == "/u" goto :update
	:loop
	if "%~1"=="" exit /b
	if not exist "%~1" shift&goto :loop
	echo;%~a1|findstr /i "hs">nul && (
		attrib -s -h %1 
	) || attrib +s +h %1 
	shift
	goto :loop
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
seta -a 180
REM nircmd.exe win trans title "TERMUX-VCC" 180
modes 70 15
for /f "tokens=2,*" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Desktop"') do set "Desk=%%j"
set LANG=zh_CN
doskey cat=type $*
doskey cp=copy $*
doskey clear=Title ^& cls ^& color 07 ^& modes 70 15 ^& echo; ^& install -v
doskey mv=move $*
doskey rv=recycle $*
doskey pwd=cd
doskey cds=cd /d $*
doskey ll=ls --color=auto $*
doskey note="%~dp0FILE\Notepad++\notepad++.exe" $*
doskey tcc="%~dp0Compile\Compile-include\tcc.exe" $*
doskey es="%~dp0Compile\Compile-include\es.exe" $*
doskey Everything="%~dp0Compile\Compile-include\Everything.exe" $*
doskey Gdown="%~dp0Compile\Compile-include\NeatDM.exe" $*
doskey ip=printf 0x07 "%IPv4%" ^| clip ^& echos 0x03 --[%IPv4%]“—∏¥÷∆÷¡ºÙ«–∞Â-- 
doskey ca=set /a ca_result=$*
doskey win=nircmd.exe win trans ititle $*
set dates=%date:~0,-3%
echo;
if exist "%Temp%\%dates:/=-%.install" ( call install -v ) else call install -c
echo;
prompt %used%@%COMPUTERNAME%[$P]$$$S
Set /P=[3 q< Nul
cmd /k %2
call :showcmd
exit /b 
:showcmd
printf 0x0a %used%@%COMPUTERNAME%
printf 0x09 [%cd%]
printf 0x07 "$ "
set /p.=
call %.%
set.=
goto :showcmd

:update
cd /d %~dp0
path=%~dp0Compile\Compile-bin;%path%
if not exist "%VCC_HOME%" (
	echo;  - Œ¥∞≤◊∞
	exit /b
)
call %VCC_HOME%\Compile\Compile-bin\vcc.bat -v >nul
set /p new_version=<%Temp%\%dates:/=-%.install
set new_version=%new_version:~11,-4%
:version_loop
if "%new_version:.=%" GTR "%version:.=%" (
	echo;call RUN-%version%.cmd
	call :vcc_version_add %version%
	goto :version_loop
) else echo;  - ÕÍ≥… -
exit /b


:vcc_version_add
for /f "tokens=1,2,3 delims=." %%i in ("%~1") do (
	set tal=%%i
	set mid=%%j
	set low=%%k
)
set /a low+=1
if %low% GTR 9 set /a mid+=1 & set low=0
if %mid% GTR 9 set /a tal+=1 & set mid=0
set version=%tal%.%mid%.%low%
goto :eof