@echo off & setlocal enabledelayedexpansion
path=%path%;.\Compile-bin
modes 70 15
title 
if "%~1"=="" (
	:null
	set /p input=请输入或拖入文件名:
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
printf 0x03 "【%num%】"
choice /C 12345 /N /M "[1]运行 [2]重选数据库 [3]运行sqlcmd代码 [4]重选文件 [5]控制台" &echo;
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
rem --最大字符串长度--
for /l %%i in (1,1,%MAX_NUM_X%) do (
	call length "!arr[%%i]!"
	if !errorlevel! GTR !arr_len! set /a arr_len = !errorlevel!
)
rem --打印表格--
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
rem ----最大字符串长度----
for /l %%i in (1,1,%MAX_NUM_X%) do (
	call length "!arr[%%i]!"
	if !errorlevel! GTR !arr_len! set /a arr_len = !errorlevel!
)
rem ---打印表格--
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
	echos 0x0c "请输入正确文件名称"
	set input=
	goto :null
)
exit /b 1

REM location 530 700
REM sqlcmd -i %1
REM osql -S . -U sa -P 0000 -i %1
REM sqlcmd -S . -U sa -P sa -d database -i d:\data.sql
REM 参数说明：-S 服务器地址 -U 用户名 -P 密码  -d 数据库名称 -i 脚本文件路径 

REM osql -S . -U sa -P sa -i C:\Users\user\Desktop\2.sql
REM osql为SQL Server的命令，
REM 在cmd中执行该命令，
REM 安装完SQL Server后该命令对应的路径会自动添加到系统环境变量中
REM 可以通过osql -? 命令查看帮助
REM -S 表示要连接的数据库服务器
REM -U表示登录的用户ID
REM -P表示登录密码
REM -i表示要执行的脚本文件路径
REM -o表示输出文件路径
REM （不加-o,直接在cmd命令窗口输出，加-o，cmd命令不再输出，都写到-o后的路径中）
REM 区分大小写的哦
REM ----1. 获取所有的数据库名-----
REM --SELECT NAME 'data' FROM MASTER.DBO.SYSDATABASES ORDER BY NAME
 
REM -----2. 获取所有的表名------
REM --SELECT NAME FROM SYSOBJECTS WHERE XTYPE='U' ORDER BY NAME
REM --XTYPE='U':表示所有用户表;
REM --XTYPE='S':表示所有系统表;
REM --SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND SYSSTAT = '83'
REM ----注意：一般情况只需要TYPE = 'U'，但有时候会有系统表混在其中（不知道什么原因），加上后面一句后就能删除这些系统表了。
REM ----获取当前数据库名----
REM --Select Name From Master..SysDataBases Where DbId=(Select Dbid From Master..SysProcesses Where Spid = @@spid)
