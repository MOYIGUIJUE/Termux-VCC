@echo off &title TERMUX-VCC
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
for /f "tokens=2,*" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Desktop"') do set "Desk=%%j"
set LANG=zh_CN
doskey cat=type $*
doskey cp=copy $*
doskey clear=Title ^& cls
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
call install -c
echo;
echo;  Open sourse at:
printf 0x07 "  - Gitee: "
printf 0x03 https://gitee.com/cctv3058084277/main
echo;
printf 0x07 "  - Github: "
printf 0x03 https://github.com/MOYIGUIJUE/cctv
echo;
echo;
modes 70 15
prompt %used%@%COMPUTERNAME%[$P]$$$S
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
