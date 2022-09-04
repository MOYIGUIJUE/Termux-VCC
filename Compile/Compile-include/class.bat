@echo off &title class
setlocal enabledelayedexpansion
set /a num_y=0
set /a num_n=0
cd. >1.tb
cd. >2.tb

for /f "tokens=1,2 delims= " %%j in ('more +54 "%~dpnx0"') do (
	call :names
	if !n! equ 0 (
		set /a num_n+=1
		echo;%%j %%k>>2.tb
		REM copy name.docx ..\%%j%%k.docx
	)

)

echo 已提交%num_y%人 >titles.tl
echo 未提交%num_n%人 >>titles.tl
path ..\Compile-bin;%path%
set "class=%~dp0"
table "%class:~0,-1%"
echo;^> _____________________________________________
del *.tb titles.tl
pause >nul
exit /b

:names
	set /a n=0
	for %%i in (*.docx *.doc) do (
		set "tmp=%%~ni"
		REM echo %%~ni| findstr %%k >nul && (
		call :strcmp "%%~ni" "%%k"
		if !errorlevel! equ 1 (
			if /i "%%k%%j"=="%%~ni" (
				echo;%%j %%k>>1.tb
				set /a num_y+=1
				set /a n+=1
			) else (
				ren "%%~nxi" "%%k%%j%%~xi"
				echo;%%j %%k>>1.tb
				set /a num_y+=1
				set /a n+=1
			)
			GOTO :NEXT
		)
	)
	:NEXT
goto :eof

:strcmp
set "str1=%~1"
set "str2=%~2"
if "!str1:%str2%=!"=="%str1%" (exit /b 0) else exit /b 1
num1 name1
num2 name2
num3 name3