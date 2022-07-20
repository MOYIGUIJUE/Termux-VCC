::又叫井字棋
::当然玩法上可能会有差别
::CODE BY wxcute AT BBS.bathome.net
@echo off
mode con lines=12 cols=37
setlocal enabledelayedexpansion
for /l %%s in (1,1,7) do set SP=　!sp!
title .%SP%井字棋

goto :start
::变量说明
argument是否显示为提示棋盘的指针
fate下子总计数
special是否进行总计数
Turn更换选手指针
sub_flag选手指针
input输入
record下子记录
remain剩下的位置
winflag胜利标记

::标签说明
start进入
newGame新游戏
begin循环开始
Machine电脑下子
T_flash下子棋盘更新

:start
::设置棋盘棋子
set chs1=●
set chs0=×
set L7=┏━━┳━━┳━━┓
set L6=┃７┃８┃９┃
set L5=┣━━╋━━╋━━┫
set L4=┃４┃５┃６┃
set L3=┣━━╋━━╋━━┫
set L2=┃１┃２┃３┃
set L1=┗━━┻━━┻━━┛

::============================================================
::开始
:newGame
color 72
setlocal
set argument=1
set/a whoFirst=%random%%%2
set "remain= 1 2 3 4 5 6 7 8 9"
::----------------------------------------
:begin
cls
call :show
::调用胜负判断
if "%fate%" geq "5" call :judgeVic
if defined winflag goto :end
if "%fate%" geq "9" goto :end
::计算下子数与判断下子方
if not defined special (
　set/a fate+=1,Turn="(whoFirst+fate+1)%%2"
) else set special=
if %Turn% equ 0 goto :Machine

::下子
set sub_flag=%Turn%
set input=
set/p input=%SP:~3%等待您的选择：
if not defined input goto :judgeIn
if %input% lss 1 goto :judgeIn
if %input% gtr 9 goto :judgeIn
if defined _%input% (
:judgeIn
　call :err
　set special=1
　goto :begin
)
goto :T_flash

::电脑下子
:Machine
set sub_flag=%Turn%
if %fate% gtr 1 call :PCI
::电脑随机下子
:PCR
set Rc=
if defined bN (set/a Rc=%random%%%bN) else set/a Rc="%random%%%(9-fate)"
if not defined Best set Best=%remain: =%
set input=!Best:~%Rc%,1!
set/p=%SP:~3%电脑正在思考 <nul
set "cir=/-\|"
set CN=&set cirN=
:lp
if "%cirN%" geq "4" set/a cirN=0,CN+=1
set/p= !cir:~%cirN%,1!<nul
set/a cirN+=1
ping -n 1 127.1>nul
if "%CN%" leq "3" goto :lp

::下子后棋盘更新
:T_flash
set _%input%=%sub_flag%
set record=%record%%input%
set remain=!remain:%input%=!
set/a m=(input-1)/3+1,n=(input-1)%%3+1
set/a m2=m*2,n2=n*2,ln=n2-1
set LL=!L%m2%!
set/a pie="(sub_flag+whoFirst)%%2"
set L%m2%=!LL:~,%ln%!!chs%pie%!!LL:~%n2%!
goto :begin
::----------------------------------------

::结果显示
:end
set player1=你&set color1=color 3a
set player0=电脑&set color0=color 7e
if defined winflag (echo.%SP:~1%!player%sub_flag%!赢了。&!color%sub_flag%!) else echo.%SP%平局。
set/p=%sp:~3%按任意键重来……<nul
pause>nul
endlocal
goto :newGame
::============================================================

::调用标签
::显示棋盘
:show
echo+
for /l %%i in (7 -1 1) do echo %SP:~2%!L%%i!
if defined argument (
　set argument=
　set L=%L2:~,1%
　set L2=!L!　!L!　!L!　!L!
　set L4=!L2!
　set L6=!L2!
)
goto :eof

::错误
:err
echo 输入错误，或该位置上已有棋子。请重新输入……
ping -n 2 127.1>nul
goto :eof

::结束判断，胜负平
::最笨的列举法
:judgeVic
for %%i in (123 456 789 147 258 369 159 357) do (
　set had=%%i
　set had=!had:~,1! !had:~1,1! !had:~-1!
　for /f "tokens=1-3" %%j in ("!had!") do (
　　if "!_%%j!!_%%k!!_%%l!"=="%sub_flag%%sub_flag%%sub_flag%" set winflag=%sub_flag%
　)
)
goto :eof

::电脑智能下子
:PCI
::echo Remain%remain%
set/a _subFlag=(sub_flag+1)%%2
set bN=
set ept=&set Epx=
set Best=
set input=
set d_3flag=
for %%c in (%remain%) do (
　set d1=&set d2=&set d3=
　set d_1=&set d_2=&set d_3=
　for %%i in ("1 2 3" "4 5 6" "7 8 9" "1 4 7" "2 5 8" "3 6 9" "1 5 9" "3 5 7") do (
　　set isFlag=
　　set noFlag=&set _noFlag=
　　set/a baseN=1,_baseN=1
　　for %%j in (%%~i) do (
　　　if "%%j"=="%%c" set isFlag=1
　　　if "!_%%j!"=="%_subFlag%" set/a noFlag=1,_baseN+=1
　　　if "!_%%j!"=="%sub_flag%" set/a baseN+=1,_noFlag=1
　　)
　　if defined isFlag (
　　　if not defined noFlag set/a d!baseN!+=1
　　　if not defined _noFlag set/a d_!_baseN!+=1
　　)
　　if defined d3 set Best=%%c&set bN=1&goto :eof
　　if defined d_3 set d_3flag=%%c
　)
　set/a ept=baseN+d!baseN!+_baseN+d_!_baseN!
　if "!Epx!" equ "!ept!" set Best=%%c!Best!&set/a bN+=1
　if "!Epx!" lss "!ept!" set Epx=!ept!&set Best=%%c&set bN=1
)
if defined d_3flag set Best=%d_3flag%&set bN=1
goto :eof
