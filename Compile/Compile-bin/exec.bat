@echo off
if "%~1"=="" (
	echo;Usage: exec {[-r][path]}
	echo;       �������ӵ�2������
	echo;       ���������пո�
	echo;       -rֱ�ӽ������̨
	exit /b
)
%2start mshta vbscript:createobject("shell.application").shellexecute("""%~dpnx0""","%~1 ::",,"runas",1)(window.close)&exit /b
if exist %1 (
	for /l %%i in (1 1 3) do call :number%%i %1
	setx /M VCC_HOME %1
	pause >nul
)
title HKCR_REG
cd /d %~dp0..\..
path=%~dp0;%path%
modes 70 15
set LANG=zh_CN
doskey cat=type $*
doskey clear=echo off $t cls $t modes 70 15 $t title $t set .= ^& set /p ".=root@%COMPUTERNAME%[%%cd%%]# " ^& call %%.%% ^& set .=^& echo on
doskey cp=copy $*
doskey mv=move $*
doskey pwd=cd
doskey ll=ls --color=auto $*
doskey note="%~dp0..\Compile-bin\Sourse Lib\Notepad++\notepad++.exe" $*
doskey tcc="%~dp0Compile\Compile-bin\Sourse Lib\TCC\tcc.exe" $*
doskey ip=printf 0x07 "%IPv4: =%" ^| clip ^& echos 0x03 --IPv4��ַ�Ѹ��������а�-- 
set cds=%cd%
cd..
if "%cd%"=="%cds%" set cds=%cds:\=%
cd %~dp0..\..
if "%1"=="-r" goto :root
:reg_choose
set reg_choose=
reg query "HKCR\gccbinpath" 1>nul 2>nul && echo;[1][HKCR\gccbinpath] || echo;[1][NO][HKCR\gccbinpath]
reg query "HKCR\Directory\Background\shell\Termux" 1>nul 2>nul && echo;[2][HKCR\Directory\Background\shell\Termux] || echo;[2][NO][HKCR\Directory\Background\shell\Termux]
reg query "HKLM\Software\Classes\*\Shell\Notepad++" 1>nul 2>nul && echo;[3][HKLM\Software\Classes\*\Shell\Notepad++] || echo;[3][NO][HKLM\Software\Classes\*\Shell\Notepad++]
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v VCC_HOME 1>nul 2>nul && echo;[4][VCC_HOME] || echo;[4][NO][VCC_HOME]
echo;
set /p "reg_choose=[%1][Choose del\add number(all\list\add\home)]$ "
if /i "%reg_choose%"=="all" (
	for /l %%i in (1 1 3) do call :number%%i %cds%
) else if /i "%reg_choose%"=="list" (
	for /f "delims=" %%i in ('reg query "HKCR\gccbinpath"') do echo;%%i
	for /f "delims=" %%i in ('reg query "HKCR\Directory\Background\shell\Termux\Command" 2^>nul') do echo;%%i
	for /f "delims=" %%i in ('reg query "HKLM\Software\Classes\*\Shell\Notepad++\Command" 2^>nul') do echo;%%i
	for /f "delims=" %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v VCC_HOME 2^>nul') do echo;%%i
	pause >nul
	cls
	goto :reg_choose
) else if /i "%reg_choose%"=="add" (
	call :ADD_REG
	goto :reg_choose
) else if /i "%reg_choose%"=="home" (
	reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v VCC_HOME 1>nul 2>nul && reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v VCC_HOME /f || setx /M VCC_HOME %cds% 
	pause >nul
	cls
	goto :reg_choose
) else if "%reg_choose%"=="" (
	goto :root
) else (
	call :number%reg_choose% %cds%
	cls
	goto :reg_choose
)
echo;
:root
prompt root@%COMPUTERNAME%[$P]#$S
cmd /k
cls
goto :reg_choose

:number1
echo;[HKCR\gccbinpath]
reg query "HKCR\gccbinpath" 1>nul 2>nul
if errorlevel 1 (
	echo;����gccbinpath��... [%~1\Compile\Compile-include\bin]
	REG ADD HKCR\gccbinpath /t REG_SZ /d "%~1\Compile\Compile-include\bin" /f > nul
) else if errorlevel 0 (
	echo;ɾ��gccbinpath��...
	reg delete HKCR\gccbinpath /f >nul
)
goto :eof

rem --------------
:number2
echo;&echo;[HKCR\Directory\Background\shell\Termux]
reg query "HKCR\Directory\Background\shell\Termux" 1>nul 2>nul
if errorlevel 1 (
	echo;����Termux��... [\Command][%~1\Termux.bat]
	REG ADD HKCR\Directory\Background\shell\Termux /t REG_SZ /d "Termux" /f > nul
	REG ADD HKCR\Directory\Background\shell\Termux\Command /t REG_SZ /d "%~1\Termux.bat" /f > nul
) else (
	echo;ɾ��Termux��...
	reg delete HKCR\Directory\Background\shell\Termux /f >nul
)
goto :eof

rem --------------
:number3
echo;&echo;[HKLM\Software\Classes\*\Shell\Notepad++]
reg query "HKLM\Software\Classes\*\Shell\Notepad++" 1>nul 2>nul
if errorlevel 1 (
	echo;����Notepad++��... [\Command][%~1\Compile\Compile-bin\Sourse Lib\Notepad++\notepad++.exe "%%1"]
	REG ADD HKLM\Software\Classes\*\Shell\Notepad++ /t REG_SZ /d "Notepad++" /f > nul
	REG ADD HKLM\Software\Classes\*\Shell\Notepad++\Command /t REG_SZ /d "%~1\Compile\Compile-bin\Sourse Lib\Notepad++\notepad++.exe \"%%1\"" /f > nul
	REM REG ADD HKLM\Software\Classes\*\Shell\Notepad++ /t REG_SZ /d "%Desk_path%\Notepad++\notepad++.ico" /f > nul
) else (
	echo;ɾ��Notepad++��...
	reg delete HKLM\Software\Classes\*\Shell\Notepad++ /f >nul
)
exit /b

:ADD_REG
	reg query "HKCR\gccbinpath"
	set /p gccbinpath=[gccbinpath]:
	if defined gccbinpath REG ADD HKCR\gccbinpath /t REG_SZ /d "%gccbinpath%" /f > nul
	
	reg query "HKCR\Directory\Background\shell\Termux\Command"
	set /p Termux=[Termux]:
	if not "%Termux%"=="" REG ADD HKCR\Directory\Background\shell\Termux\Command /t REG_SZ /d "%Termux%" /f > nul
	
	reg query "HKLM\Software\Classes\*\Shell\Notepad++\Command"
	set /p notepad=[Notepad++]:
	if not "%notepad%"=="" REG ADD HKLM\Software\Classes\*\Shell\Notepad++\Command /t REG_SZ /d "%notepad%" /f > nul
	set gccbinpath=
	set Termux=
	set notepad=
	cls
goto :eof