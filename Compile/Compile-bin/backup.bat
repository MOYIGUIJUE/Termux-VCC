@echo off
pushd %~dp0..\..
set dates=%date:~,-3%
set "choose_path=E:\MAIN\CCTV_History"
if not exist "%choose_path%\vcc.log" cd.>%choose_path%\vcc.log
for /f "usebackq tokens=1,2 delims=|" %%a in ("%choose_path%\vcc.log") do set "vcc_version=%%b"
if "%vcc_version%"=="" set vcc_version=0.0.0
if "%~1" == "to" (
	echos 0x03 %dates:/=-%.zip
	7z a "%~3\%dates:/=-%.%2" "%~dp0..\..\Compile\" "%~dp0..\..\Termux.bat"
) else if "%~1" == "for" (
	echos 0x03 %dates:/=-%-%~n2.zip
	7z a "%choose_path%\%dates:/=-%-%~n3.%2" %3
) else if "%~1" == "-all" (
	call :vcc_version_add "All-%dates:/=-%%~2.7z"
	echos 0x03 All-%dates:/=-%%~2.7z
	7z a "%choose_path%\All-%dates:/=-%%~2.7z" "%~dp0..\..\Compile\" "%~dp0..\..\Termux.bat"
) else if "%~1" == "-7z" (
	call :vcc_version_add "%dates:/=-%%~2.7z"
	echos 0x03 %dates:/=-%%~2.7z
	7z a "%choose_path%\%dates:/=-%%~2.7z" "%~dp0..\..\Compile\" "%~dp0..\..\Termux.bat"
) else if "%~1" == "-zip" (
	call :vcc_version_add "%dates:/=-%%~2.zip"
	echos 0x03 %dates:/=-%%~2.zip
	7z a "%choose_path%\%dates:/=-%%~2.zip" "%~dp0..\..\Compile\" "%~dp0..\..\Termux.bat"
	REM 7z a -tzip "E:\MAIN\CCTV_History\%dates:/=-%.zip" "SQL Server\" Compile\ Termux.bat -xr!File-ZIP\
) else if "%~1" == "-dir" (
	ls %choose_path% &echo;
	printf 0x0e "vcc version %vcc_version%"
) else if "%~1" == "-log" (
	more "%choose_path%\vcc.log"
) else (
	echo;Usage: backup [arguments] {[-zip][-7z][-all]} [name]
	echo;   or: backup [arguments] {[to][for]} {[7z][zip]} [drive:][path/filename]
	echo;   or: backup [arguments] {[-dir][-log]}
	echo;&echo;Arguments:
	echo;   选定路径: 	%choose_path% [%dates:/=-%]
	echo;   -zip		以zip格式备份到选定路径
	echo;   -7z		以7z格式备份到选定路径
	echo;   -all		以7z格式备份所有文件到选定路径
	echo;   -dir		查看选定路径文件列表
	echo;   -log		查看日志
	echo;   to		备份到自选路径
	echo;   for		自选文件或目录备份到选定路径
	echo;   name		自定义文件名部分,%dates:/=-%name.zip
)
popd
exit /b

:vcc_version_add
for /f "tokens=1,2,3 delims=." %%i in ("%vcc_version: =%") do (
	set tal=%%i
	set mid=%%j
	set low=%%k
)
set /a low+=1
if %low% GTR 9 set /a mid+=1 & set low=0
if %mid% GTR 9 set /a tal+=1 & set mid=0
echo;%dates% %time:~0,-3% %~1 ^| %tal%.%mid%.%low% >> "%choose_path%\vcc.log"
echo;%dates% %time:~0,-3% %~1 ^| %tal%.%mid%.%low% >> "%~dp0vcc.bat"
set vcc_version=
goto :eof