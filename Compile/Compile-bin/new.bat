@echo off
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
	echo;@echo off >%1
	echo;setlocal enabledelayedexpansion>>%1
	echo;echo;�ض������ĵ��ļ���Ĭ�ϱ���ΪANSI����>>%1
	echo;pause>>%1
) Else if /i "%~x1" == ".vbs" (
	echo;msgbox^("�ض������ĵ��ļ���Ĭ�ϱ���ΪANSI����"^)>%1
	echo;set ws = createobject^("wscript.shell"^)>>%1
) Else if /i "%~x1" == ".cpp" (
	echo;#include ^<iostream^>>%1
	echo;using namespace std;>>%1
	echo;int main^(int argc,char *argv[]^)>>%1
	echo;{>>%1
	echo;	cout^<^<"hello world!"^<^<endl;>>%~1
	echo;	cout^<^<"���,����!"^<^<endl;>>%~1
	echo;	system^("pause"^);>>%1
	echo;	return 0;>>%1
	echo;}>>%1
) Else if /i "%~x1" == ".c" (
	echo;#include ^<stdio.h^>>%1
	echo;#include ^<stdlib.h^>>>%1
	echo;int main^(^)>>%1
	echo;{>>%1
	echo;	printf^("hello world! \n"^);>>%~1
	echo;	printf^("���,����! \n"^);>>%~1
	echo;	system^("pause"^);>>%1
	echo;	return 0;>>%1
	echo;}>>%1
) Else if /i "%~x1" == ".h" (
	for /f %%i in ('Str -u %~n1') do (
		echo;#ifndef %%i_H>%1
		echo;#define %%i_H>>%1
	)
	echo;>>%1
	echo;#define MAX^(x,y^) x^>y?x:y>>%1
	echo;#define STR^(x^) #x>>%~1
	echo;#define DAY^(x^) day##x>>%~1
	echo;>>%1
	echo;enum ZEO{ONE,TWO,FIVE=5};>>%1
	echo;#endif>>%1
) Else if /i "%~x1" == ".java" (
	(echo;public class %~n1 {
	echo;	public static void main^(String[] args^){
	echo;		System.out.println^("hello world"^);
	echo;		System.out.println^("���,����"^);
	echo;	}
	echo;} )>%1
) Else (
	echo;�������ĵ��ļ���Ĭ�ϱ���ΪANSI���� >%1
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
	echo;   or: new [name][.h]
	echo;   or: new [name][.java]
	echo;   or: new �޲�����ʾ������Ϣ
goto :eof


Usage: str [-c | -l | -u] string
   or: str [-i] -p string1 string2
   
	-c�����ַ����е��ַ�����count����
	-l��Сд��ʽ����ָ�����ַ�����
	-u�Դ�д��ʽ����ָ�����ַ�����
	-p����string1��string2����ʼλ�ã�-1=δ�ҵ�����
	-iָ�������ִ�Сд�ıȽϣ����������-p֮ǰ����

#include <stdio.h>
#include "in\test.h"

int main()
{
#ifdef TAG
	printf("  %%TAG%%:%d \n  FILE:%s\n  FUNCTION:%s\n  LINE:%d \n",TAG,__FILE__,__FUNCTION__,__LINE__);
#endif
	auto int day1=50;
	struct myname n;
	enum ZEO z1 = 3;
	printf(STR(\n DAY1:%d\n z1:%d\n sizeofz1:%d \n MAX:%d\n),DAY(1)%6+1,z1,sizeof(z1),MAX(4,6));
	return 0;
}

//gcc -E Ԥ����[define][include]...
//gcc -S ����(�ؼ���)
//gcc -c ���
//gcc -o ����

//gcc -DTAG === #define TAG
//gcc -Ibin === #include"bin\*"
//gcc -DTAG -I.\in test.c

//register int a;  ����һЩ���ٷ��ʱ��������ڼĴ����ϡ�[����������һ������ڼĴ�����,ֻ�Ǿ����żĴ���]
//volatile int a;  ���Ż�����

//m << n   m*2*n  ,  >> m/2*n
//4   0 0 1 0 0
//8   0 1 0 0 0