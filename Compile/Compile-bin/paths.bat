@echo off
setlocal enabledelayedexpansion
set num=0
if "%~1"=="-" call :sour &exit /b
if "%~1"=="-s" call :sourse_s
if "%~1"=="-u" call :sourse_u
if "%~1"=="-a" call :sourse

:paths
if "%paths%"=="" set "paths=%path%"

REM �ⲿʵ��
REM echo;%paths% | sed "s/;/\n/g" | sed "/^$/d" | nl

set num=0

set "paths=%paths:;=" "%"
call :loop "%paths%"
exit /b

:loop
	set tmps=%1
	if not defined tmps exit /b
	if "%~1"=="" (
		shift
		goto :loop
	)
	set /a num+=1
	echo;  [%num%]	%~1
	if not exist "%~1" echo;  - %~1 [ERROR]
	shift
goto :loop

:sourse_u
for /f "tokens=3* delims= " %%i in ('reg query HKCU\Environment /v path') do (
	if "%%j"=="" ( set "paths=%%i" ) else set "paths=%%i %%j"
	exit /b
)

:sourse_s
for /f "tokens=3* delims= " %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v path') do (
	if "%%j"=="" ( set "paths=%%i" ) else set "paths=%%i %%j"
	exit /b
)

:sourse
for /f "tokens=3* delims= " %%i in ('reg query HKCU\Environment /v path') do (
	for /f "tokens=3* delims= " %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v path') do (
		if "%%j"=="" ( set "path_user=%%i" ) else set "path_user=%%i %%j"
		if "%%b"=="" ( set "path_sys=%%a" ) else set "path_sys=%%a %%b"
		set "paths=!path_user!!path_sys!"
		exit /b
	)
)

:sour
choice /C us /N /M "[u:�û��������� s:ϵͳ��������]"
if %errorlevel% equ 1 call :environment_u
if %errorlevel% equ 2 call :environment_s
:loops
set choose=
set /p "choose=[������Ų鿴���� +/-]: "
if "%choose%"=="" exit /b
if "%choose:~0,1%"=="-" ( set "chooses=%choose:~1%" 
) else if "%choose:~0,1%"=="+" ( set "chooses=%choose:~1%" 
) else set chooses=%choose%

if "!environment%chooses%!"=="" (
	echo;  - �����ʽ����,����Ų�����
	goto :loops
)
set "paths=!paths%chooses%!"
if "!paths!"=="" ( call :loop_p "" ) else call :loop_p "%paths:;=" "%"
if not "%chooses%"=="%choose%" call :environment%choose:~0,1%
set num=0
set chooses=0
set choose=0
set environment=
exit /b

:loop_p
	set a=%1
	if not defined a goto :eof
	if "%~1"=="" (
		shift
		goto :loop_p
	)
	set /a num+=1
	echo;  - %~1 [%num%]
	shift
goto :loop_p

:environment_u
set nums=0
set "environment=HKCU\Environment"
for /f "tokens=1,2,3* delims= " %%i in ('reg query "%environment%"') do (
	if NOT !nums! equ 0 (
		if "%%l"=="" ( set "paths!nums!=%%k" ) else set "paths!nums!=%%k %%l"
		if "%%k"=="" ( echo;  [!nums!]	%%i	%%j	�� ) else call echo;  [!nums!]	%%i	%%j	%%paths!nums!:~0,30%% ...
		set "environment!nums!=%%i"
	)
	set /a nums+=1
)
exit /b

:environment_s
set nums=0
set "environment=HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"
for /f "tokens=1,2,3* delims= " %%i in ('reg query "%environment%"') do (
	if NOT !nums! equ 0 (
		if "%%l"=="" ( set "paths!nums!=%%k" ) else set "paths!nums!=%%k %%l"
		if "%%k"=="" ( echo;  [!nums!]	%%i	%%j	�� ) else call echo;  [!nums!]	%%i	%%j	%%paths!nums!:~0,30%% ...
		set "environment!nums!=%%i"
	)
	set /a nums+=1
)
exit /b

:environment-
if "%chooses%"=="" (
	echo;  - REG DELETE "%environment%" /v "[����������]" /f
	echo;  - REG ADD "%environment%" /v "[����������]" /t [ֵ����] /d "[��������ֵ]" /f
) else (
	echo;  - REG delete "%environment%" /v "!environment%choose:~1%!" /f
	REG delete "%environment%" /v "!environment%choose:~1%!" /f 2>nul>nul && echo;  - ɾ���ɹ� || echo;  - ɾ���˻���������Ҫ����ԱȨ��
)
exit /b

:environment+
if "%chooses%"=="" (
	set add_environment_content=
	set add_environment=
	set /p "add_environment=--> �������µĻ�������: "
	if "!add_environment!"=="" exit /b
	if not "!add_environment: =!"=="!add_environment!" echo;�������������пո� & goto :environment+
	set /p "add_environment_content=--> �������µĻ�������������: "
	REG ADD "!environment!" /v "!add_environment!" /t REG_SZ /d "!add_environment_content!" /f 2>nul>nul && echo;  - ��ӳɹ� || echo;  - ��Ӵ˻���������Ҫ����ԱȨ��
) else (
	set revise_environment=
	set /p "revise_environment=--> �������µ�����: "
	echo;  - REG ADD "%environment%" /v !environment%choose:~1%! /t REG_SZ /d "!revise_environment!" /f
	REG ADD "%environment%" /v !environment%choose:~1%! /t REG_SZ /d "!revise_environment!" /f 2>nul>nul && echo;  - �޸ĳɹ� || echo;  - �޸Ĵ˻���������Ҫ����ԱȨ��
)
exit /b
