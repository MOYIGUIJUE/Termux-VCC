@echo off
setlocal enabledelayedexpansion
if "%~1"=="" goto :help
if exist "%~1" echo;���ļ��Ѵ���&exit /b
if /i "%~x1" == ".bat" (
	echo;@echo off ^& title >%~dpnx1
	echo;rem mode 70,15>>%~dpnx1
	echo;setlocal enabledelayedexpansion>>%~dpnx1
	echo;for /r "%%~dp0" %%%%j in ^(*.txt^) do ^(>>%~dpnx1
	echo;	REM for /f "delims=" %%%%i in ^('type "%%%%~j"'^) do ^(>>%~dpnx1
	echo;	for /f "usebackq eol=; skip=1 tokens=* " %%%%i in ^("%%%%~j"^) do ^(>>%~dpnx1
	echo;		echo;%%%%i >>%~dpnx1
	echo;	^)>>%~dpnx1
	echo;^)>>%~dpnx1
	echo;set /p.=�޻�����ʾ^<nul >>%~dpnx1
	echo;echo;hello world>>%~dpnx1
	echo;pause>>%~dpnx1
) Else if /i "%~x1" == ".cmd" (
	echo;@echo off >>%1
	echo;setlocal enabledelayedexpansion>>%1
	echo;>>%1
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
	cd. >%1
	ren "%~1" "%*" 2>nul >nul
)
REM powershell.exe -command "dir *.txt -R|foreach-object{(Get-Content $_.FullName -Encoding Default) | Set-Content $_.FullName -Encoding ANSI }"

exit /b
:help
	echo;Usage: new [name] �ļ�ȫ��
	echo;   or: new [name][.bat]
	echo;   or: new [name][.cmd]
	echo;   or: new [name][.vbs]
	echo;   or: new [name][.cpp]
	echo;   or: new [name][.c]
	echo;   or: new [name][.java]
	echo;   or: new �޲�����ʾ������Ϣ
goto :eof