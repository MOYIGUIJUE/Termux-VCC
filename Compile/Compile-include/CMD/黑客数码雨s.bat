@echo off
title made by 523066680 2008-08-08
::这一版本由www.cn-dos.net & www.bathome.net 成员523066680编辑
mode con cols=85 lines=21
color 0a
setlocal enabledelayedexpansion
set a=0
for %%m in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do (
if !a! leq 9 (set n0!a!=%%m) else (set n!b!=%%m)
set /a a+=1
set /a b=!a!-10
)
for %%M in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
set n!b!=%%M
set /a b+=1
)
for /l %%a in (1,1,20) do (
set h%%a=
for /l %%b in (1,1,20) do (
call,set code=%%n!random:~1,2!%%
if not defined code (set "code= ")
set h%%a=!code!   !h%%a!
)
)
set num=0
:a
set /a num+=1
if %num% equ 260 set num=0
ping -n>nul
cls
echo,   %h1%
echo,   %hn%
for /l %%a in (3,1,20) do echo,   !h%%a!
for /l %%a in (19,-1,1) do (
set /a n=1+%%a
set h!n!=!h%%a!
)
set hn=%h2%
set h1=
for /l %%b in (1,1,20) do (
call,set code=%%n!random:~1,2!%%
if not defined code (set "code= ")
set h1=!code!   !h1!
)

if %num% gtr 80 (if %num% lss 100 set hn=                      %h19:   = %)
if %num% gtr 140 (if %num% lss 160 set hn=                      %h19:   = %)
if %num% gtr 200 (if %num% lss 220 set hn=                      %h19:   = %)
if %num% gtr 100 (if %num% leq 130 (
set hn=%hn:~0,20%    B a t H o m e    I f _ E x i s t    %hn:~-20%
))
if %num% gtr 160 (if %num% leq 190 (
set hn=%hn:~0,19%      C n - D o s     I f _ E x i s t     %hn:~-19%
))
if %num% gtr 220 (if %num% leq 240 (
set hn=%hn:~0,19%          W W W . 3 X 4 Y . C O M        %hn:~0,19%
))
for %%a in (100 160 220) do (
if %num% equ %%a (set hn=                     =====================+================== ))
goto :a
pause
pause