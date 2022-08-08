@echo off
setlocal enabledelayedexpansion
if "%~1"=="-v" (
	call :exists %2
	copy /y "%~dp0*.bat" "!input!\Compile\Compile-bin"
) else if "%~1"=="-c" (
	if exist "%~2" (
		set "file=%~2"
	) else (
		set file=
		echos 0x03 请选择更新文件
		call choose file
		if "!file!"=="" (
			echos 0x0c 未选择更新文件
			goto :end
		)
	)
	call :exists %3
	copy /y "!file!" "!input!\Compile\Compile-bin"
) else if "%~1"=="-p" (
	call :exists %2
	copy /y %~dp0* !input!\Compile\Compile-bin
	copy /y "%~dp0Sourse Code\*" "!input!\Compile\Compile-bin\Sourse Code"
	copy /y "%~dp0Sourse Com\*" "!input!\Compile\Compile-bin\Sourse Com"
	copy /y %~dp0..\* "!input!\Compile"
) else if "%~1"=="-all" (
	call :exists %2
	xcopy .\Compile\ "!input!\Compile\" /e /y /h /r
	copy Termux.bat "!input!"
) else (
	echo;Usage: update [arguments] {[-p][-all]} [path]
	echo;   or: update [arguments] {[-v]} [path]
	echo;   or: update [arguments] {[-c]} [file] [path]
	echo;&echo;Arguments:
	echo;   -v	默认更新
	echo;		[Compile\Compile-bin\*.bat]
	echo;   -c	指定更新
	echo;		[Compile\Compile-bin\%%1]
	echo;   -p	指定路径更新,如:E:\VCC,后面没有\
	echo;		[Compile\Compile-bin\*]
	echo;		[Compile\Compile-bin\Sourse Code\*]
	echo;		[Compile\Compile-bin\Sourse Com\*]
	echo;		[Compile\*]
	echo;   -all	完全更新
	echo;		[Compile]
	echo;		[Termux.bat]
)
:end
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
	echo;[%1]
exit /b

REM -------------------------------------
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
