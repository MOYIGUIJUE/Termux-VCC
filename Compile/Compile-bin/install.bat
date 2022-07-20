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
	echo;   -32: 	32λϵͳ����
	echo;   -64		64λϵͳ����
	echo;   -vcc		���Ʊ����򼯺ϵ�ָ��Ŀ¼[path]
	echo;      		������ʾ������Ϣ
	exit /b
)
call 7z x "%~dp0Sourse Lib\studentmain.7z" "-o%Desk_path%\studentmain"
call 7z x "%~dp0Sourse Lib\CHFS.7z" "-o%Desk_path%\CHFS"
pushd %Desk_path%
start studentmain\JiYuTrainer.exe
doskey note="%Desk_path%\Notepad++\notepad++.exe" $*
REM REG ADD HKCR\*\Shell\Termux /t REG_SZ /d "Termux" /f > nul
REM REG ADD HKCR\*\Shell\Termux\Command /t REG_SZ /d "\"E:\\Termux.bat\"\"%%1\"" /f > nul
REM ���µ�����Ҳ�ǿ��Ե�
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
echos 0x03 ��ѡ��װĿ¼,��װĿ¼���ܰ����ո�
call chooses input
if "%input%"=="" (
	echos 0x0c δѡ��װĿ¼
	popd
	exit /b
)
:input
echo;��װĿ¼:%input%
::/E ����Ŀ¼����Ŀ¼�������յġ�/Y ȡ����ʾ��ȷ��Ҫ��������Ŀ���ļ� ��/H Ҳ�������غ�ϵͳ�ļ���/R ��дֻ���ļ��� /Q ����ʱ����ʾ�ļ�����
xcopy .\Compile\ "%input%\Compile\" /e /y /h /r
copy Termux.bat "%input%"
exec.bat %input%
popd
REM for /f "tokens=2,*" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Desktop"') do Set a=%%j
REM echo �㵱ǰ����·����:%a%
REM REM �������޸�����·��
REM set "a=D:\����"
REM reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Desktop" /t REG_SZ /d %a%

REM HKEY_CLASSES_ROOT\Directory\Background\shell\Termux\Command