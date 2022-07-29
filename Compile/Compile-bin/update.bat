@echo off
setlocal enabledelayedexpansion
if "%~1"=="-v" (
	if "%~2"=="" echo;未选择路径&exit /b
	copy /y "%~dp0*.bat" "%~2\Compile\Compile-bin"
) else if "%~1"=="-p" (
	if exist "%~2" (
		set "input=%~2"
	) else (
		set input=
		echos 0x03 请选择更新目录
		call chooses input
		if "!input!"=="" (
			echos 0x0c 未选择更新目录
			exit /b
		)
	)
	set "VCC_HOME=!input!"
	copy /y %~dp0* !VCC_HOME!\Compile\Compile-bin
	copy /y "%~dp0Sourse Code\*" "!VCC_HOME!\Compile\Compile-bin\Sourse Code"
	copy /y "%~dp0Sourse Com\*" "!VCC_HOME!\Compile\Compile-bin\Sourse Com"
	copy /y %~dp0..\* !VCC_HOME!\Compile
	exit /b
) else if "%~1"=="-all" (
	if "%~2"=="" goto :default
	if exist "%~2" (
		set "input=%~2"
	) else (
		set input=
		echos 0x03 请选择更新目录
		call chooses input
		if "!input!"=="" (
			echos 0x0c 未选择更新目录
			exit /b
		)
		set "input=%~2"
	)	
	set "VCC_HOME=!input!"
	:default
	pushd %~dp0..\..
	xcopy .\Compile\ "!VCC_HOME!\Compile\" /e /y /h /r
	copy Termux.bat "!VCC_HOME!"
	popd
) else (
	echo;Usage: update [arguments] {[-p][-all]} [path]
	echo;   or: update [arguments] {[-v]} [path] 没有路径选项框
	echo;&echo;Arguments:
	echo;   -v		默认更新
	echo;		[!VCC_HOME!\Compile\Compile-bin\*.bat]
	echo;   -p		指定路径更新,如:E:\VCC,后面没有\
	echo;		[!VCC_HOME!\Compile\Compile-bin\*]
	echo;		[!VCC_HOME!\Compile\Compile-bin\Sourse Code\*]
	echo;		[!VCC_HOME!\Compile\Compile-bin\Sourse Com\*]
	echo;		[!VCC_HOME!\Compile\*]
	echo;   -all	完全更新
	echo;		[!VCC_HOME!\Compile]
	echo;		[!VCC_HOME!\Termux.bat]
)
exit /b

:date_version
for /f "tokens=1,2,3 delims=." %%i in ('%VCC_HOME%\Compile\Compile-bin\vcc -v') do (
	set /a tal=%%i
	set /a mid=%%j
	set /a low=%%k
)
for /f %%i in ('vcc -v') do set "Lastest=%%i"
echo;[%Lastest%]	^<Judge^>	[%tal%.%mid%.%low%]
if %Lastest:.=% GTR %tal%%mid%%low% (
	echo;%date:~0,-3% %time:~0,-3% %~1 ^| %Lastest% >> %VCC_HOME%\Compile\Compile-bin\vcc.bat
	echo;%date:~0,-3% %time:~0,-3% %~1 ^| %Lastest%
	copy /y %~dp0update.bat %VCC_HOME%\Compile\Compile-bin
	goto :eof
)
set /a low+=1
if %low% GTR 9 set /a mid+=1 & set low=0
if %mid% GTR 9 set /a tal+=1 & set mid=0
echo;%date:~0,-3% %time:~0,-3% %~1 ^| %tal%.%mid%.%low% >> "%~dp0vcc.bat"
echo;%date:~0,-3% %time:~0,-3% %~1 ^| %tal%.%mid%.%low% >> %VCC_HOME%\Compile\Compile-bin\vcc.bat
echo;%date:~0,-3% %time:~0,-3% %~1 ^| %tal%.%mid%.%low%
echo;:%tal%.%mid%.%low% >>"%~dp0update.bat"
copy /y %~dp0update.bat %VCC_HOME%\Compile\Compile-bin
goto :eof
:1.3.0 
