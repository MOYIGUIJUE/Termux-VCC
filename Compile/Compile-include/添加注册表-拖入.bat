%2start mshta vbscript:createobject("shell.application").shellexecute("""%~0""","%1 ::",,"runas",1)(window.close)&exit
@echo off
if "%1"=="::" exit
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "%~n1" 1>nul 2>nul
if errorlevel 1 (
	reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v "%~n1" /t REG_SZ /d "%~1" /f
) else (
	reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /f /v "%~n1"
)
exit /b
rem HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
rem HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run
rem HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
rem C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp
rem C:\Users\30580\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup

REM 右键文件选择菜单
REM REG ADD HKCR\*\Shell\Termux /t REG_SZ /d "Termux" /f > nul
REM REG ADD HKCR\*\Shell\Termux\Command /t REG_SZ /d "\"E:\\Termux.bat\"\"%%1\"" /f > nul
REM 以下的命令也是可以的
REM REG ADD HKLM\Software\Classes\*\Shell\Termux /t REG_SZ /d "Notepad++" /f > nul
REM REG ADD HKLM\Software\Classes\*\Shell\Termux\Command /t REG_SZ /d "E:\Termux.bat" /f > nul
REM 右键选择菜单
REM REG ADD HKEY_CLASSES_ROOT\Directory\Background\shell\Termux /t REG_SZ /d "Termux" /f > nul
REM REG ADD HKEY_CLASSES_ROOT\Directory\Background\shell\Termux\Command /t REG_SZ /d "E:\Termux.bat" /f > nul
REM 删除注册表
REM REG DELETE HKCR\*\Shell\Notepad++ /f > nul
REM REG DELETE HKEY_CLASSES_ROOT\Directory\Background\Termux /f > nul