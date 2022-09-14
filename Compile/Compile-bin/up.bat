@echo off
setlocal enabledelayedexpansion
pushd %~dp0..\..
if "%~1"=="-v" (
	call :exists %2
	echo;[%~dp0*]--^>[!input!\Compile\Compile-bin]
	del "!input!\Compile\Compile-bin\*" /q /f
	copy /y "%~dp0*" "!input!\Compile\Compile-bin"
) else if "%~1"=="-c" (
	if exist "%~dp0%~2" (
		set "file=%~dp0%~2"
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
	echo;[!file!]--^>[!input!\Compile\Compile-bin]
	copy /y "!file!" "!input!\Compile\Compile-bin"
) else if "%~1"=="-p" (
	call :exists %3
	if "%~2"=="-a" (
		echo;[%cd%\Compile\*]--^>[!input!\Compile]
		del "!input!\Compile\*" /q /f
		copy /y .\Compile\* "!input!\Compile"
	) else if "%~2"=="-i" (
		echo;[%cd%\Compile\Compile-include\*]--^>[!input!\Compile\Compile-include]
		del "!input!\Compile\Compile-include\*" /q /f
		xcopy /e /y /h /r .\Compile\Compile-include\* "!input!\Compile\Compile-include"
	) else if "%~2"=="-g" (
		echo;[%~dp0Sourse Com\*]--^>[!input!\Compile\Compile-bin\Sourse Com]
		del "!input!\Compile\Compile-bin\Sourse Com\*" /q /f
		copy /y "%~dp0Sourse Com\*" "!input!\Compile\Compile-bin\Sourse Com"
	) else if "%~2"=="-c" (
		echo;[%~dp0Sourse Code\*]--^>[!input!\Compile\Compile-bin\Sourse Code]
		del "!input!\Compile\Compile-bin\Sourse Code\*" /q /f
		copy /y "%~dp0Sourse Code\*" "!input!\Compile\Compile-bin\Sourse Code"
	) else echo;  - 参数错误
) else if "%~1"=="-all" (
	call :exists %2
	echo;[%cd%\Compile\]--^>[!input!\Compile\Compile-bin]
	rd /s /q "!input!\Compile\"
	xcopy .\Compile\ "!input!\Compile\" /e /y /h /r
	copy Termux.bat "!input!"
) else if "%~1"=="-f" (
	call :exists %2
	echo;[%cd%\FILE\]--^>[!input!\FILE\]
	xcopy .\FILE\ "!input!\FILE\" /e /y /h /r
) else (
	echo;Usage: up [arguments] {[-v][-all][-f]} [path]
	echo;   or: up [arguments] {[-p]} {[-a][-i][-g][-c]} [path]
	echo;   or: up [arguments] {[-c]} [file] [path]
	echo;&echo;Arguments:
	echo;   -v	默认更新
	echo;		[Compile\Compile-bin\*]
	echo;   -c	指定更新
	echo;		[Compile\Compile-bin\%%1]
	echo;   -p	指定路径更新,如:E:\VCC,后面没有\
	echo;		[-a][Compile\*]
	echo;		[-i][Compile\Compile-include\]
	echo;		[-g][Compile\Compile-bin\Sourse Com\*]
	echo;		[-c][Compile\Compile-bin\Sourse Code\*]
	echo;   -f	固定文件
	echo;		[FILE]
	echo;   -all	完全更新
	echo;		[Compile]
	echo;		[Termux.bat]
)
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
