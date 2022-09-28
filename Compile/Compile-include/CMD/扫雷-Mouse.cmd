@echo off
Mode Con: Cols=80 Lines=25
::在游戏过程中，输入benton可以看清所有地雷
title 批处理扫地雷 之 越战清道夫   Made by netbenton from http://bbs.bathome.cn
set `=!
::注意哦，这个变量很关键，

set #for1=for /f "tokens=1-6" %%c in ("!u! !m! !d! !l! !n! !r!") do (
set #for2=for %%k in (%%c.%%f %%c.%%g %%c.%%h %%d.%%f %%d.%%h %%e.%%f %%e.%%g %%e.%%h!) do (
::这个定义是为了缩减代码和提速

setlocal enabledelayedexpansion
set "ec-1=　ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰ　"
for /l %%a in (0,1,17) do (set M%%a=!ec-1:~%%a,1!)
set ec18=　!ec-1! 后面还有其它字符表示[插旗]或[取旗]
set ec-1=　!ec-1!
set ec0=■■■■■■■■■■■■■■■■■■  还有!`!dilei!`!个雷，!`!tudi!`!亩地
set ec17=■■■■■■■■■■■■■■■■■■  !`!over!`!!`!say!`!
set str= abcdefghijklmnop
for /l %%a in (1,1,16) do set com!str:~%%a,1!=%%a
set ∷=今天运气不错哦...
set ①=生死由命，就放心踩吧
set ②=这里都不敢动，劝你回家种田吧！
set ③=团长，要看清想好呀。
set ④=这里要动的话，就只有半条命了！
set ⑤=探到不少雷呀，最好不要赌了
set ⑥=小心呀！团长，想好呀
set ⑦=危险啊！最好别动了！
set ⑧=这里全是雷呀！别动！！！
set n=0
for %%a in (① ② ③ ④ ⑤ ⑥ ⑦ ⑧) do (set/a n+=1&set s#=!s#!★&set !s#!=%%a&set n%%a=!n!)
set over=
set bj=@
set bj1=-1
set bj@1=1

set say=一个艰巨的任务开始了...
for /l %%a in (0,1,17) do (set r0.%%a=#&set r17.%%a=#&set r%%a.0=#&set r%%a.17=#)

:begin 重新开始
color f0
setlocal enabledelayedexpansion
for /l %%a in (1,1,40) do (
  set/a ran=!random!%%16+1
  set true=
for /l %%b in (1,1,16) do (
  set/a ram=!random!%%16+1
  if not defined true (
   if not defined L!ran!.!ram! set L!ran!.!ram!=★&set true=y&set/a dilei+=1
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
  if not defined r%%a.%%b set "r%%a.%%b=∷"
  if not defined L%%a.%%b set L%%a.%%b=!r%%a.%%b!
  set r%%a.%%b=
)
)
set benton=set "str=!`!str!`!□"

:loop 主循环
for /l %%a in (1,1,16) do (
set str=
for /l %%b in (1,1,16) do (
  if defined r%%a.%%b (
     if !r%%a.%%b! equ @ (set "str=!str!▼") else (set "str=!str!!`!L%%a.%%b!`!")
  ) else (
     %benton%
  )
)
set ec%%a=■!str!■
)
set benton=set "str=!`!str!`!□"

:error 出错循环
cls
for /l %%a in (-2,1,18) do (for %%b in ("!ec%%a!") do echo;     !M%%a!%%~b!M%%a!)
if defined over echo 游戏结束，请按回车键继续...&color 4e&pause>nul&endlocal&goto :begin
if !tudi! leq 0 echo 恭喜你过关了，请按回车键继续..&color 4e&pause>nul&endlocal&goto :begin
mouse > ReturnKey.ini
set /p Mouse=0<ReturnKey.ini
set "Mouse=%Mouse: =/%"
echo.%Mouse% > ReturnKey.ini
rem Nr是行，Nl是列
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

:zhilp 主动或自动打开地，均使用这个子过程, 与:zhisub子过程和:auto子过程有联合循环动作，即有重入。
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
if "!L%m%.%n%!" equ "★" set over=  光荣牺牲了
if "!L%m%.%n%!" equ "∷" call :auto
set say=!L%m%.%n%!
set say=!%say%!
goto %back% 依靠变量来控制程序走向

:zhisub 选择点为已经打开的数字时，自动插旗或打开地 的 子过程
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
                if not defined r%%k call :zhilp 循环调用减少代码，增强自动化
        )
)
goto :loop

:auto  打开的为空地时自动打开地 的 子过程
set/a u=m-1,d=m+1,l=n-1,r=n+1
%#for1%
%#for2%
  if not defined r%%k (
   set r%%k=#
   set/a tudi-=1
   if "!L%%k!" equ "∷" (
    for /f "tokens=1,2 delims=." %%1 in ("%%k") do (set/a m=%%1,n=%%2)
    call :auto 循环调用减少代码，增强自动化
   )
  )
)
)
goto :eof