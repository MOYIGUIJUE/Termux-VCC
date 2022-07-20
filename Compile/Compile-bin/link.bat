@echo off
setlocal enabledelayedexpansion
if /i "%~1" == "-l" (
	call :links %2 %3
) else if /i "%~1" == "-Desk" (
	call :desks %2 %3
) else (
	echo;Usage: link [arguments] -Desk [快捷方式全名.lnk] [目标文件路径及名字]
	echo;   or: link [arguments] -l [文件路径及快捷方式名.lnk] [目标文件路径及名字] 
)
exit /b
:links
	rem 发送快捷方式到桌面
	REM mshta VBScript:Execute("Set a=CreateObject(""WScript.Shell""):Set b=a.CreateShortcut(a.SpecialFolders(""Desktop"") & ""\快捷方式名字.lnk""):b.TargetPath=""程序路径"":b.WorkingDirectory=""%~dp0"":b.Save:close")
	set "WrkDir=%~dp2"
	set "LinkName=%~1"
	set "ThePath=%~2"
	mshta VBScript:Execute("Set Shell=CreateObject(""WScript.Shell""):Set Link=Shell.CreateShortcut(""%LinkName%""):Link.TargetPath=""%ThePath%"":Link.WorkingDirectory=""%WrkDir%"":Link.Save:close"^)
	REM mshta VBScript:Execute("Set Shell=CreateObject(""WScript.Shell""):Set Link=Shell.CreateShortcut(""E:\Desktop_copy\History\rr.lnk""):Link.TargetPath=""E:\Desktop\12.cpp"":Link.WorkingDirectory=""E:\Desktop_copy\History"":Link.Save:close"^)
exit /b

:desks
mshta VBScript:Execute("Set a=CreateObject(""WScript.Shell""):Set b=a.CreateShortcut(a.SpecialFolders(""Desktop"") & ""\%~1""):b.TargetPath=""%~2"":b.WorkingDirectory=""%~dp2"":b.Save:close") 
goto :eof
rem -----------------------------url 快捷方式---------------------------------
@echo off
set "path=C:\BatMPlayer\BatMPlayer.bat"
set "name=我的BatMPlayer"
set m="%USERPROFILE%\桌面\%name%.url"
echo [InternetShortcut] >>%m%
echo URL="%path%" >>%m%
echo IconIndex=10 >>%m%
echo IconFile=C:\windows\system32\shell32.dll >>%m%
pause

mshta VBScript:Execute("Set a=CreateObject(""WScript.Shell""):Set b=a.CreateShortcut(a.SpecialFolders(""盘符比如c:"") & ""快捷方式路径及名字""):b.TargetPath=""文件路径及名字"":b.WorkingDirectory=""启始路径"":b.Save:close")

REM 生成的快捷方式是一个url链接，用记事本打开，得到以下内容：
REM [InternetShortcut]
REM URL="C:\BatMPlayer\BatMPlayer.bat"
REM IconIndex=17
REM IconFile=C:\WINDOWS\system32\SHELL32.dll

REM [InternetShortcut]         ；快捷方式。
REM URL="C:\BatMPlayer\BatMPlayer.bat"          ；快捷方式的程序路径。
REM IconIndex=99         ；快捷方式使用的图标的顺序号（此处为系统文件中的图标的顺序，位于以下的IconFile文件夹中，具体查看第三部分的《Shell32.Dll 图标资源对照表》）。
REM IconFile=%SystemRoot%\system32\SHELL32.dll         ；快捷方式图标的位置（此处为系统文件路径，常见系统快捷方式的图标存放位置）。
REM "%USERPROFILE%\桌面\BatMPlayer.url"        ； 快捷方式创建位置（此处为桌面），注意双引号和后缀名。

set "WrkDir=起始路径"
set "LinkName=C:\name.lnk"
set "ThePath=C:\mychrome.exe"
mshta VBScript:Execute("Set Shell=CreateObject(""WScript.Shell""):Set Link=Shell.CreateShortcut(""%LinkName%""):Link.TargetPath=""%ThePath%"":Link.WorkingDirectory=""%WrkDir%"":Link.Save:close"^)
