@echo off & setlocal enabledelayedexpansion
path=%path%;.\Compile-bin
modes 70 15
title 
if "%~1"=="" (
	:null
	set /p input=������������ļ���:
	if "!input!"=="" (
		call choose input
		set "input=!input:"=!"
		if "!input!"=="" (
			goto :null
		)
		call :names "!input!"
		goto :start
	)
	call :names "!input!"
	goto :start
) else (
	set "input=%~1"
	call :names "!input!"
)

:start
title %input:"=%
for %%i in (%input:"=%) do cd /d %%~dpi
:datas
echo;
echo;sqlcmd^> show databases; &echo;
call :databases
set /p "sql_sk=sqlcmd> use "
echo;     -^> show tables;&echo;
call :tables %sql_sk%

title %sql_sk% - %input:"=%
set num=0
:loop
printf 0x03 "��%num%��"
choice /C 12345 /N /M "[1]���� [2]��ѡ���ݿ� [3]����sqlcmd���� [4]��ѡ�ļ� [5]����̨" &echo;
if %errorlevel% equ 1 set /a num+=1 & sqlcmd -d %sql_sk% -i "%input%" &echo; &goto :loop
if %errorlevel% equ 2 goto :datas
if %errorlevel% equ 3 start cmd /k "title Console & sqlcmd -d %sql_sk%" &goto :loop
if %errorlevel% equ 4 set input= & goto :null
if errorlevel 5 start %~dp0..\Termux.bat &goto loop
rem ---------------------------databases--------------------------
:databases
set /a MAX_NUM_X = 0
set /a arr_len = 9
set tmp=0
set X=0
for /f "tokens=1,2 delims= " %%i in ('sqlcmd -Q "Select Name FROM Master..SysDatabases orDER BY Name"') do (
	if !tmp! GTR 1 (
		set /a X+=1
		set "arr[!X!]=%%i %%j"
	)
	if !X! GEQ !MAX_NUM_X! set MAX_NUM_X=!X!
	set /a tmp+=1
)
set /a MAX_NUM_X-=1
rem --����ַ�������--
for /l %%i in (1,1,%MAX_NUM_X%) do (
	call length "!arr[%%i]!"
	if !errorlevel! GTR !arr_len! set /a arr_len = !errorlevel!
)
rem --��ӡ���--
call :cout
printf 0x07 "| "
	printf 0x07 "Database"
	call length "Database"
	set /a tmp=!arr_len!-!errorlevel!
	printfs "0x07" "!tmp!" " "
	echo;^|
call :cout
for /l %%j in (1,1,%MAX_NUM_X%) do (
	printf 0x07 "| "
	printf 0x07 "!arr[%%j]!"
	call length "!arr[%%j]!"
	set /a tmp=!arr_len!-!errorlevel!
	printfs "0x07" "!tmp!" " "
	echo;^|
)
call :cout
set /a MAX_NUM_X+=1
echo;&echo;!arr[%MAX_NUM_X%]! &echo;
goto :eof
rem ---------------------------tables--------------------------
:tables
set /a MAX_NUM_X = 0
set /a arr_len = 7
set tmp=0
set X=0
for /f "tokens=1,2 delims= " %%i in ('sqlcmd -Q "use %1;SELECT NAME FROM SYSOBJECTS WHERE XTYPE='U' ORDER BY NAME"') do (
	if !tmp! GTR 2 (
		set /a X+=1
		set "arr[!X!]=%%i %%j"
	)
	if !X! GEQ !MAX_NUM_X! set MAX_NUM_X=!X!
	set /a tmp+=1
)
set /a MAX_NUM_X-=1
rem ----����ַ�������----
for /l %%i in (1,1,%MAX_NUM_X%) do (
	call length "!arr[%%i]!"
	if !errorlevel! GTR !arr_len! set /a arr_len = !errorlevel!
)
rem ---��ӡ���--
call :cout
printf 0x07 "| "
	printf 0x07 "Tables"
	call length "Tables"
	set /a tmp=!arr_len!-!errorlevel!
	printfs "0x07" "!tmp!" " "
	echo;^|
call :cout
for /l %%j in (1,1,%MAX_NUM_X%) do (
	printf 0x07 "| "
	printf 0x07 "!arr[%%j]!"
	call length "!arr[%%j]!"
	set /a tmp=!arr_len!-!errorlevel!
	printfs "0x07" "!tmp!" " "
	echo;^|
)
call :cout
set /a MAX_NUM_X+=1
echo;&echo;!arr[%MAX_NUM_X%]! &echo;
goto :eof

rem ------------------------cout-----------------------
:cout
	printf 0x07 "+"
	set /a len=!arr_len!+1
	printfs "0x07" "!len!" "-"
	echo;+
goto :eof

:names
if /i "%~x1" == ".sql" (
	if not exist "%~1" cd. >%1
) Else (
	echos 0x0c "��������ȷ�ļ�����"
	set input=
	goto :null
)
exit /b 1

REM location 530 700
REM sqlcmd -i %1
REM osql -S . -U sa -P 0000 -i %1
REM sqlcmd -S . -U sa -P sa -d database -i d:\data.sql
REM ����˵����-S ��������ַ -U �û��� -P ����  -d ���ݿ����� -i �ű��ļ�·�� 

REM osql -S . -U sa -P sa -i C:\Users\user\Desktop\2.sql
REM osqlΪSQL Server�����
REM ��cmd��ִ�и����
REM ��װ��SQL Server��������Ӧ��·�����Զ���ӵ�ϵͳ����������
REM ����ͨ��osql -? ����鿴����
REM -S ��ʾҪ���ӵ����ݿ������
REM -U��ʾ��¼���û�ID
REM -P��ʾ��¼����
REM -i��ʾҪִ�еĽű��ļ�·��
REM -o��ʾ����ļ�·��
REM ������-o,ֱ����cmd������������-o��cmd������������д��-o���·���У�
REM ���ִ�Сд��Ŷ
REM ----1. ��ȡ���е����ݿ���-----
REM --SELECT NAME 'data' FROM MASTER.DBO.SYSDATABASES ORDER BY NAME
 
REM -----2. ��ȡ���еı���------
REM --SELECT NAME FROM SYSOBJECTS WHERE XTYPE='U' ORDER BY NAME
REM --XTYPE='U':��ʾ�����û���;
REM --XTYPE='S':��ʾ����ϵͳ��;
REM --SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND SYSSTAT = '83'
REM ----ע�⣺һ�����ֻ��ҪTYPE = 'U'������ʱ�����ϵͳ��������У���֪��ʲôԭ�򣩣����Ϻ���һ������ɾ����Щϵͳ���ˡ�
REM ----��ȡ��ǰ���ݿ���----
REM --Select Name From Master..SysDataBases Where DbId=(Select Dbid From Master..SysProcesses Where Spid = @@spid)
