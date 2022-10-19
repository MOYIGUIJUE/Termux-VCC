@echo off
setlocal enabledelayedexpansion
if "%~1"=="-c" (
	call :exists %3
	if exist "!input!\Compile\Compile-bin\%~2" (
		set "file=!input!\Compile\Compile-bin\%~2"
	) else (
		set file=
		echos 0x03 请选择要同步的文件
		call choose file
		if "!file!"=="" (
			echos 0x0c 未选择要同步文件
			goto :end
		)
	)
	echo;[!file!]--^>[%~dp0]
	copy /y "!file!" "%~dp0"
) else if "%~1"=="-p" (
	goto :paths
) else if "%~1"=="-a" (
	goto :exts
) else if "%~1"=="-h" (
	echo;Usage: cn [arguments] {[-h]} 查看此信息
	echo;   or: cn [arguments] {[-c]} [file] [path] 同步文件
	echo;   or: cn [arguments] {[-p]} 管理环境变量 [+num/-num][keyword]
	echo;   or: cn [arguments] {[-a]} [keyword] 查看环境变量下所有的可执行文件
	echo;        
	
) else call :disk

:end
popd
set input=
set file=
exit /b

:exists
	if exist "%~1" (
		set "input=%~1"
	) else (
		set input=
		echos 0x03 请选择更新目录
		call chooses input
		if "!input!"=="" (
			echos 0x0c 未选择更新目录
			goto :end
		)
	)
exit /b

:disk
	>DiskCalc1.vbs echo WSCript.Echo "盘符" ^& Chr(9) ^& "总容量(GB)" ^& Chr(9) ^& "已用空间(GB)" ^& Chr(9) ^& "剩余空间(GB)" ^& Chr(9) ^& "使用率"
	>DiskCalc2.vbs echo DeviceID = Wscript.Arguments(0)
	>>DiskCalc2.vbs echo SizeAvail = Wscript.Arguments(1) / (1024 * 1024 * 1024)
	>>DiskCalc2.vbs echo SizeTotal = Wscript.Arguments(2) / (1024 * 1024 * 1024)
	>>DiskCalc2.vbs echo SizeUsed = SizeTotal - SizeAvail
	>>DiskCalc2.vbs echo SizeRate = SizeUsed / SizeTotal * 100
	>>DiskCalc2.vbs echo WSCript.Echo DeviceID ^& Chr(9) ^& Round(SizeTotal,1) ^& Chr(9) ^& Chr(9) ^& Round(SizeUsed,1) ^& Chr(9) ^& Chr(9) ^& _
	>>DiskCalc2.vbs echo Round(SizeAvail,1) ^& Chr(9) ^& Chr(9) ^& Round(SizeRate,1) ^& "%%"
	cscript //nologo DiskCalc1.vbs
	(for /f "tokens=1-3" %%a in ('wmic LogicalDisk get DeviceID ^, Size ^, FreeSpace ^| findstr ":"') do (
		set /a num+=1
		cscript //nologo DiskCalc2.vbs %%a %%b %%c
	))
	del DiskCalc*.vbs
exit /b

REM 管理环境变量
:paths
for /f "tokens=3* delims= " %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v path') do (
	if "%%j"=="" ( printf 0x07 "%%i">path.tmp ) else printf 0x07 "%%i %%j">path.tmp
)
type path.tmp | sed "s/\(.*\)\(.\)/\1\n/g" | sed "s/;/\n/g" | sed "/^$/d" >paths.tmp
nl paths.tmp
echo;
set chooses=
set choose=
set /p "choose=[+/-]: "
if "%choose%"=="" exit /b
if "%choose:~0,1%"=="-" ( 
	set "chooses=%choose:~1%" 
	call :chooses
) else if "%choose:~0,1%"=="+" (
	set "chooses=%choose:~1%" 
	call :chooses_add
) else (
	echo;  - 输入格式错误 [+num][-num][+][-][-keyword]
)
del path*.tmp 2>nul
exit /b
REM ---
:chooses
cd.>path.tmp
if "%chooses%"=="" (
	call notepad paths.tmp
	for /f "delims=" %%i in (paths.tmp) do printf 0x07 "%%~i;">>path.tmp
	goto :write
)
for /f "delims=" %%j in ('echo;%chooses%@^| sed "s/[0-9]//g"') do (
	if "%%j"=="@" (
		for /f "delims=" %%i in ('sed "%chooses% d" paths.tmp') do (
			printf 0x07 "%%~i;">>path.tmp
		)
		goto :write
	) else (
		cd.>path.tmp
		for /f "delims=" %%i in (paths.tmp) do (
			echo;%%~i| find /i "%chooses%" >nul || ( printf 0x07 "%%~i;">>path.tmp & echo;%%~i )
		)
		goto :write
	)
)
exit /b

:chooses_add
if not "%chooses%"=="" (
	cd.>path.tmp
	sed -n "%chooses%p" paths.tmp
	set inputpath=
	set /p "inputpath=--> 修改: "
	if "!inputpath!"=="" exit /b
	echo;sed "%chooses%c !inputpath!" paths.tmp
	for /f "delims=" %%i in ('sed "%chooses%c !inputpath!" paths.tmp') do (
		printf 0x07 "%%~i;">>path.tmp
	)
	goto :write
) else (
	set add_environment=
	set /p "add_environment=--> 请输入新的环境变量: "
	if not "!add_environment!"=="" printf 0x07 "!add_environment!;">>path.tmp
	goto :write
)
exit /b

:write
timeout 2 >nul
for /f "delims=" %%i in (path.tmp) do setx /M PATH "%%i" 2>nul>nul && echo;  + PATH 添加成功 ||echo;  - 需要管理员权限
exit /b

REM 查看环境变量下所有的可执行文件
:exts
if not exist "%temp%\allpath" md %temp%\allpath
cd.>%temp%\paths.txt
echo;*.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC | sed "s/;/ */g" > %temp%\allpath\PATHEXT.txt
set /p EXTS=<%temp%\allpath\PATHEXT.txt 
REM echo;dir /b %EXTS%
set num=1
for /f "delims=" %%i in ('path ^| sed "s/;/\n/g" ^| sed "/^$/d"') do (
	if !num! equ 1 (
		set "tmp=%%i"
		cd /d !tmp:~5!
		dir /b %EXTS% >%temp%\allpath\!num!.txt 2>nul
		if exist "!tmp:~5!" ( echo;!num! - !tmp:~5! >>%temp%\paths.txt ) else echo;!num! - !tmp:~5! [ERROR]>>%temp%\paths.txt 
	) else (
		cd /d %%i
		dir /b %EXTS% >%temp%\allpath\!num!.txt 2>nul
		if exist "%%~i" ( echo;!num! - %%i >>%temp%\paths.txt ) else echo;!num! - %%i [ERROR]>>%temp%\paths.txt 
	)
	set /a num+=1
)
timeout 1 >nul
if "%~2"=="" exit /b
for /f "tokens=1,2,3 delims=:" %%i in ('findstr /i "%~2" "%temp%\allpath\*.txt"') do (
	sed -n "%%~njp" "%temp%\paths.txt"
	echo;  + %%k
)
REM del /f /q "%temp%\paths.txt"
REM rd /s /q "%temp%\allpath"
exit /b
