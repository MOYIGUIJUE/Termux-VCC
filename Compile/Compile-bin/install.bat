@echo off
setlocal enabledelayedexpansion
if "%~1" == "-vcc" goto :vcc
for /f "tokens=2,*" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Desktop"') do Set Desk_path=%%j
if "%~1" == "-32" (
	call 7z x "%~dp0Sourse Lib\Notepad32.7z" "-o%Desk_path%\Notepad++"
) else if "%~1" == "-64" (
	call 7z x "%~dp0Sourse Lib\Notepad++.7z" "-o%Desk_path%\Notepad++"
) else (
	echo;Usage: install [arguments] {[-32][-64]}
	echo;   or: install [arguments] {[-vcc]} [path]
	echo;&echo;Arguments:
	echo;   -32: 	32位系统适用
	echo;   -64		64位系统适用
	echo;   -vcc		复制本程序集合到指定目录[path]
	echo;      		其余显示帮助信息
	exit /b
)
call 7z x "%~dp0Sourse Lib\studentmain.7z" "-o%Desk_path%\studentmain"
call 7z x "%~dp0Sourse Lib\CHFS.7z" "-o%Desk_path%\CHFS"
pushd %Desk_path%
start studentmain\JiYuTrainer.exe
doskey note="%Desk_path%\Notepad++\notepad++.exe" $*
REM REG ADD HKCR\*\Shell\Termux /t REG_SZ /d "Termux" /f > nul
REM REG ADD HKCR\*\Shell\Termux\Command /t REG_SZ /d "\"E:\\Termux.bat\"\"%%1\"" /f > nul
REM 以下的命令也是可以的
REM REG ADD HKLM\Software\Classes\*\Shell\Termux /t REG_SZ /d "Notepad++" /f > nul
REM REG ADD HKLM\Software\Classes\*\Shell\Termux\Command /t REG_SZ /d "%Desk_path%\Notepad++\notepad++.exe" /f > nul
REM REG DELETE HKCR\*\Shell\Notepad++ /f > nul
popd
exit /b

:vcc
pushd %~dp0..\..
if exist "%~2" (
	set "input=%~2"
	goto :input
)
set input=
echos 0x03 请选择安装目录,安装目录不能包含空格
call chooses input
if "%input%"=="" (
	echos 0x0c 未选择安装目录
	popd
	exit /b
)
:input
echo;安装目录:%input%
::/E 复制目录和子目录，包括空的。/Y 取消提示以确认要覆盖现有目标文件 。/H 也复制隐藏和系统文件。/R 改写只读文件。 /Q 复制时不显示文件名。
xcopy .\Compile\ "%input%\Compile\" /e /y /h /r
copy Termux.bat "%input%"
exec.bat %input%
popd
REM for /f "tokens=2,*" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Desktop"') do Set a=%%j
REM echo 你当前桌面路径是:%a%
REM REM 下面是修改桌面路径
REM set "a=D:\桌面"
REM reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Desktop" /t REG_SZ /d %a%

REM HKEY_CLASSES_ROOT\Directory\Background\shell\Termux\Command