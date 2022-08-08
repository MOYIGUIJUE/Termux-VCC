@echo off
setlocal enabledelayedexpansion
if "%~1"=="" goto :help
if exist "%~1" echo;该文件已存在&exit /b
if /i "%~x1" == ".bat" (
	echo;@echo off ^& title >%~dpnx1
	echo;rem mode 70,15>>%~dpnx1
	echo;setlocal enabledelayedexpansion>>%~dpnx1
	echo;echo;hello world>>%~dpnx1
	echo;pause>>%~dpnx1
) Else if /i "%~x1" == ".cmd" (
	echo;@echo off ^& title >>%1
	echo;rem mode con:cols=70 lines=15>>%1
	echo;setlocal enabledelayedexpansion>>%1
	echo;echo;hello world>>%1
	echo;pause>>%1
) Else if /i "%~x1" == ".vbs" (
	echo;msgbox^("hello world"^)>>%1
	echo;set ws = createobject^("wscript.shell"^)>>%1
) Else if /i "%~x1" == ".cpp" (
	echo;#include ^<iostream^>>%1
	echo;using namespace std;>>%1
	echo;int main^(int argc,char *argv[]^)>>%1
	echo;{>>%1
	echo;	cout^<^<"hello world!"^<^<endl;>>%~1
	echo;	system^("pause"^);>>%1
	echo;	return 0;>>%1
	echo;}>>%1
) Else if /i "%~x1" == ".c" (
	echo;#include ^<stdio.h^>>%1
	echo;#include ^<stdlib.h^>>>%1
	echo;int main^(^)>>%1
	echo;{>>%1
	echo;	printf^("hello world! \n"^);>>%~1
	echo;	system^("pause"^);>>%1
	echo;	return 0;>>%1
	echo;}>>%1
) Else if /i "%~x1" == ".java" (
	echo;public class %~n1 { >>%1
	echo;	public static void main^(String[] args^){ >>%1
	echo;		System.out.println^("hello world"^);>>%1
	echo;	}>>%1
	echo;}>>%1
) Else (
	cd.>%1
)
REM powershell.exe -command "dir *.txt -R|foreach-object{(Get-Content $_.FullName -Encoding Default) | Set-Content $_.FullName -Encoding ANSI }"
exit /b
:help
	echo;Usage: new [name] 文件全名
	echo;   or: new [name][.bat]
	echo;   or: new [name][.cmd]
	echo;   or: new [name][.vbs]
	echo;   or: new [name][.cpp]
	echo;   or: new [name][.c]
	echo;   or: new [name][.java]
	echo;   or: new 无参宿显示帮助信息
goto :eof