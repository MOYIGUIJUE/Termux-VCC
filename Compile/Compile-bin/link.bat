@echo off
setlocal enabledelayedexpansion
if /i "%~1" == "-l" (
	call :links %2 %3
) else if /i "%~1" == "-Desk" (
	call :desks %2 %3
) else (
	echo;Usage: link [arguments] -Desk [��ݷ�ʽȫ��.lnk] [Ŀ���ļ�·��������]
	echo;   or: link [arguments] -l [�ļ�·������ݷ�ʽ��.lnk] [Ŀ���ļ�·��������] 
)
exit /b
:links
	rem ���Ϳ�ݷ�ʽ������
	REM mshta VBScript:Execute("Set a=CreateObject(""WScript.Shell""):Set b=a.CreateShortcut(a.SpecialFolders(""Desktop"") & ""\��ݷ�ʽ����.lnk""):b.TargetPath=""����·��"":b.WorkingDirectory=""%~dp0"":b.Save:close")
	set "WrkDir=%~dp2"
	set "LinkName=%~1"
	set "ThePath=%~2"
	mshta VBScript:Execute("Set Shell=CreateObject(""WScript.Shell""):Set Link=Shell.CreateShortcut(""%LinkName%""):Link.TargetPath=""%ThePath%"":Link.WorkingDirectory=""%WrkDir%"":Link.Save:close"^)
	REM mshta VBScript:Execute("Set Shell=CreateObject(""WScript.Shell""):Set Link=Shell.CreateShortcut(""E:\Desktop_copy\History\rr.lnk""):Link.TargetPath=""E:\Desktop\12.cpp"":Link.WorkingDirectory=""E:\Desktop_copy\History"":Link.Save:close"^)
exit /b

:desks
mshta VBScript:Execute("Set a=CreateObject(""WScript.Shell""):Set b=a.CreateShortcut(a.SpecialFolders(""Desktop"") & ""\%~1""):b.TargetPath=""%~2"":b.WorkingDirectory=""%~dp2"":b.Save:close") 
goto :eof
rem -----------------------------url ��ݷ�ʽ---------------------------------
@echo off
set "path=C:\BatMPlayer\BatMPlayer.bat"
set "name=�ҵ�BatMPlayer"
set m="%USERPROFILE%\����\%name%.url"
echo [InternetShortcut] >>%m%
echo URL="%path%" >>%m%
echo IconIndex=10 >>%m%
echo IconFile=C:\windows\system32\shell32.dll >>%m%
pause

mshta VBScript:Execute("Set a=CreateObject(""WScript.Shell""):Set b=a.CreateShortcut(a.SpecialFolders(""�̷�����c:"") & ""��ݷ�ʽ·��������""):b.TargetPath=""�ļ�·��������"":b.WorkingDirectory=""��ʼ·��"":b.Save:close")

REM ���ɵĿ�ݷ�ʽ��һ��url���ӣ��ü��±��򿪣��õ��������ݣ�
REM [InternetShortcut]
REM URL="C:\BatMPlayer\BatMPlayer.bat"
REM IconIndex=17
REM IconFile=C:\WINDOWS\system32\SHELL32.dll

REM [InternetShortcut]         ����ݷ�ʽ��
REM URL="C:\BatMPlayer\BatMPlayer.bat"          ����ݷ�ʽ�ĳ���·����
REM IconIndex=99         ����ݷ�ʽʹ�õ�ͼ���˳��ţ��˴�Ϊϵͳ�ļ��е�ͼ���˳��λ�����µ�IconFile�ļ����У�����鿴�������ֵġ�Shell32.Dll ͼ����Դ���ձ�����
REM IconFile=%SystemRoot%\system32\SHELL32.dll         ����ݷ�ʽͼ���λ�ã��˴�Ϊϵͳ�ļ�·��������ϵͳ��ݷ�ʽ��ͼ����λ�ã���
REM "%USERPROFILE%\����\BatMPlayer.url"        �� ��ݷ�ʽ����λ�ã��˴�Ϊ���棩��ע��˫���źͺ�׺����

set "WrkDir=��ʼ·��"
set "LinkName=C:\name.lnk"
set "ThePath=C:\mychrome.exe"
mshta VBScript:Execute("Set Shell=CreateObject(""WScript.Shell""):Set Link=Shell.CreateShortcut(""%LinkName%""):Link.TargetPath=""%ThePath%"":Link.WorkingDirectory=""%WrkDir%"":Link.Save:close"^)
