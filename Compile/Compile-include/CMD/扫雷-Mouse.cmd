@echo off
Mode Con: Cols=80 Lines=25
::����Ϸ�����У�����benton���Կ������е���
title ������ɨ���� ֮ Խս�����   Made by netbenton from http://bbs.bathome.cn
set `=!
::ע��Ŷ����������ܹؼ���

set #for1=for /f "tokens=1-6" %%c in ("!u! !m! !d! !l! !n! !r!") do (
set #for2=for %%k in (%%c.%%f %%c.%%g %%c.%%h %%d.%%f %%d.%%h %%e.%%f %%e.%%g %%e.%%h!) do (
::���������Ϊ���������������

setlocal enabledelayedexpansion
set "ec-1=�����£ãģţƣǣȣɣʣˣ̣ͣΣϣС�"
for /l %%a in (0,1,17) do (set M%%a=!ec-1:~%%a,1!)
set ec18=��!ec-1! ���滹�������ַ���ʾ[����]��[ȡ��]
set ec-1=��!ec-1!
set ec0=������������������������������������  ����!`!dilei!`!���ף�!`!tudi!`!Ķ��
set ec17=������������������������������������  !`!over!`!!`!say!`!
set str= abcdefghijklmnop
for /l %%a in (1,1,16) do set com!str:~%%a,1!=%%a
set ��=������������Ŷ...
set ��=�����������ͷ��ĲȰ�
set ��=���ﶼ���Ҷ���Ȱ��ؼ�����ɣ�
set ��=�ų���Ҫ�������ѽ��
set ��=����Ҫ���Ļ�����ֻ�а������ˣ�
set ��=̽��������ѽ����ò�Ҫ����
set ��=С��ѽ���ų������ѽ
set ��=Σ�հ�����ñ��ˣ�
set ��=����ȫ����ѽ���𶯣�����
set n=0
for %%a in (�� �� �� �� �� �� �� ��) do (set/a n+=1&set s#=!s#!��&set !s#!=%%a&set n%%a=!n!)
set over=
set bj=@
set bj1=-1
set bj@1=1

set say=һ����޵�����ʼ��...
for /l %%a in (0,1,17) do (set r0.%%a=#&set r17.%%a=#&set r%%a.0=#&set r%%a.17=#)

:begin ���¿�ʼ
color f0
setlocal enabledelayedexpansion
for /l %%a in (1,1,40) do (
  set/a ran=!random!%%16+1
  set true=
for /l %%b in (1,1,16) do (
  set/a ram=!random!%%16+1
  if not defined true (
   if not defined L!ran!.!ram! set L!ran!.!ram!=��&set true=y&set/a dilei+=1
  )
)
)
set/a tudi=16*16-dilei
for /l %%a in (1,1,16) do (
set/a u=%%a-1,d=%%a+1
for /l %%b in (1,1,16) do (
  if not defined L%%a.%%b (
   set/a l=%%b-1,r=%%b+1
   for /f "tokens=1-6" %%c in ("!u! %%a !d! !l! %%b !r!") do (
for %%z in ("!L%%c.%%f!!L%%c.%%g!!L%%c.%%h!!L%%d.%%f!!L%%d.%%h!!L%%e.%%f!!L%%e.%%g!!L%%e.%%h!") do (set r%%a.%%b=!%%~z!)
   )
  )
)
)
for /l %%a in (1,1,16) do (
for /l %%b in (1,1,16) do (
  if not defined r%%a.%%b set "r%%a.%%b=��"
  if not defined L%%a.%%b set L%%a.%%b=!r%%a.%%b!
  set r%%a.%%b=
)
)
set benton=set "str=!`!str!`!��"

:loop ��ѭ��
for /l %%a in (1,1,16) do (
set str=
for /l %%b in (1,1,16) do (
  if defined r%%a.%%b (
     if !r%%a.%%b! equ @ (set "str=!str!��") else (set "str=!str!!`!L%%a.%%b!`!")
  ) else (
     %benton%
  )
)
set ec%%a=��!str!��
)
set benton=set "str=!`!str!`!��"

:error ����ѭ��
cls
for /l %%a in (-2,1,18) do (for %%b in ("!ec%%a!") do echo;     !M%%a!%%~b!M%%a!)
if defined over echo ��Ϸ�������밴�س�������...&color 4e&pause>nul&endlocal&goto :begin
if !tudi! leq 0 echo ��ϲ������ˣ��밴�س�������..&color 4e&pause>nul&endlocal&goto :begin
mouse > ReturnKey.ini
set /p Mouse=0<ReturnKey.ini
set "Mouse=%Mouse: =/%"
echo.%Mouse% > ReturnKey.ini
rem Nr���У�Nl����
set Click=%Mouse:~0,1%
for /f "delims=/ tokens=2" %%i in (ReturnKey.ini) do set Nr=%%i
for /f "delims=/ tokens=3" %%i in (ReturnKey.ini) do set Nl=%%i
set /a Nr-=2
set /a Nl-=10
set /a Nl_2=2-%Nl%%%2
set /a Nl+=%Nl_2%
set /a Nl/=2
set /a Nr-=1
set /a Nl-=1
set Coordinate=ABCDEFGHIJKLMNOP
set in=!Coordinate:~%Nr%,1!
set in=%in%!Coordinate:~%Nl%,1!
if %Click% neq 1 set in=%in% else set in=%in%#
set/a ver=0,m=com!in:~0,1!,n=com!in:~1,1!,ver=m*n
if !ver! equ 0 goto :error
set back=:loop

:zhilp �������Զ��򿪵أ���ʹ������ӹ���, ��:zhisub�ӹ��̺�:auto�ӹ���������ѭ���������������롣
if "!in:~2,1!" neq "" (
        if "!r%m%.%n%:@=!" neq "!r%m%.%n%!" (
                for %%a in (bj!r%m%.%n%!) do (
                        set r%m%.%n%=!%%a!
                        set/a dilei+=%%a1
                )
                goto %back%
        ) else (
                goto :error
        )
)
if defined r%m%.%n% if "!r%m%.%n%!" equ "#" (goto :zhisub) else (goto :error)
set r%m%.%n%=#
set/a tudi-=1
if "!L%m%.%n%!" equ "��" set over=  ����������
if "!L%m%.%n%!" equ "��" call :auto
set say=!L%m%.%n%!
set say=!%say%!
goto %back% �������������Ƴ�������

:zhisub ѡ���Ϊ�Ѿ��򿪵�����ʱ���Զ������򿪵� �� �ӹ���
set back=:eof
set in=
set/a u=m-1,d=m+1,l=n-1,r=n+1,zh=n!l%m%.%n%!,zh@=0,zhi=0,zh#=0
%#for1%
%#for2%
                if defined r%%k (set/a zh!r%%k!+=1) else (set/a zhi+=1)
        )
)
set/a zh#=zh@+zhi
if !zh! equ !zh@! set in=12
if !zh! equ !zh#! set in=123
if not defined in goto :error
%#for1%
%#for2%
                for /f "tokens=1,2 delims=." %%1 in ("%%k") do (set/a m=%%1,n=%%2)
                if not defined r%%k call :zhilp ѭ�����ü��ٴ��룬��ǿ�Զ���
        )
)
goto :loop

:auto  �򿪵�Ϊ�յ�ʱ�Զ��򿪵� �� �ӹ���
set/a u=m-1,d=m+1,l=n-1,r=n+1
%#for1%
%#for2%
  if not defined r%%k (
   set r%%k=#
   set/a tudi-=1
   if "!L%%k!" equ "��" (
    for /f "tokens=1,2 delims=." %%1 in ("%%k") do (set/a m=%%1,n=%%2)
    call :auto ѭ�����ü��ٴ��룬��ǿ�Զ���
   )
  )
)
)
goto :eof