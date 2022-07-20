@echo off
echo wscript.sleep 20>sleep.vbs
start direction.bat
title made by 523066680
:action
color 07
setlocal enabledelayedexpansion
mode con cols=65 lines=35
for /l %%a in (1,1,60) do (set space= !space!)
for /l %%a in (1,1,30) do (set L%%a=%space%)
set /a line=15,col=29,i=0,long=9
:loop
:::::::::::::::控制蛇长，判断是否建立食物部分
if %i% lss %long% (set /a i+=1) else (set i=1)
if defined cut%i% (
     if not defined dot (call :dot)
     !cut%i%:"=!
     set "L%a%=!L%a%:~0,%b%! !L%a%:~%c%!"
     set "%a%_%b%="
)
:pausego
    :::::::显示
    cls
    echo, %space: =_%__
    for /l %%a in (1,1,30) do echo,│!L%%a!│
    echo, %space: =-%--
    echo,- 分数:%fen%00  %echo%
    for /l %%a in (1,1,3) do (start /wait sleep.vbs >nul)
::::::::::::::::读取数据，分析部分
:typex
set /p way=<x
if %way%==q (exit)
if %way%==r (endlocal &set echo=按wasd方向键激活。&goto :action) else (set echo=)
if %way%==p (ping -n 2 127.0>nul &set echo=按wasd方向键激活。&goto :pausego) else (set echo=)
if %way%==w (set /a line-=1)
if %way%==s (set /a line+=1)
if %way%==a (set /a col-=1)
if %way%==d (set /a col+=1)
    if defined %line%_%col% (goto :gameover)
    if %line% equ 31 (goto :gameover) 
    if %line% equ 0 (goto :gameover) 
    if %col% equ -1 (goto :gameover) 
    if %col% equ 60 (goto :gameover)
:::::::::::::::设置部分,描点,记录点坐标。
set /a C2=col+1
set "L%line%=!L%line%:~0,%col%!▉!L%line%:~%C2%!"
set cut%i%="set /a a=%line%,b=%col%,c=%C2%"
set "%line%_%col%=exist"
if "%line%_%col%"=="%dotl%_%dotc%" (set /a long+=3,fen+=1 &set dot=)
goto :loop
  ::::::::::::建立食物O的调用部分
  :dot
  set /a dotl=%random%%%28+2,dotc=%random%%%58+1
  if defined %dotl%_%dotc% (goto :dot)
  set dot=%dotl%_%dotc%
  set /a dotc2=dotc+1
  set "L%dotl%=!L%dotl%:~0,%dotc%!▉!L%dotl%:~%dotc2%!"
  goto :eof
:gameover
echo,p>x
color 0a
ping -n 2 127.0>nul
cls
echo,game over 在控制台按q结束游戏,r再玩一次,然后按任意方向键激活暂停状态
ping -n 3 127.0>nul
endlocal
goto :action
