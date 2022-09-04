@echo off
color a
title 电脑保存的Wifi密码查看器
:loop
cls

set num=2
echo =====================================
for /f "tokens=3*" %%c in ('netsh wlan show profiles ^| findstr "所有用户配置文件"') do set /a num+=3&echo WiFi : %%c %%d
echo =====================================
:nam
set /p name=请输入以上列表中的WiFi 名字(SSID):
if "%name%" == ""   echo 请输入WIFI名称 & goto nam
(for /f "tokens=1* delims=:" %%a in ('netsh wlan show profiles name^="%name%" key^=clear ^| findstr "关键内容"') do echo;密码:%%b)||echo WIFI不存在
set name=
echo =====================================
set temp=y
set /p temp=是否一键查看所有WIFI及密码(默认:y/n):
mode con cols=50 lines=%num%
if "%temp%"=="y" goto all
set temp=
goto loop
:all
@echo off
color a
title WiFi密码查看器
for /f "tokens=3*" %%i in ('netsh wlan show profiles ^| findstr "所有用户配置文件"') do (
    call :GetPass %%i %%j
)
echo;是否继续
pause >nul
goto loop
goto :eof
:GetPass
echo WiFi : %*
for /f "tokens=1* delims=:" %%a in ('netsh wlan show profile name^="%*" key^=clear ^| findstr "关键内容"') do (
    echo;密码:%%b
    echo;===========================
)
goto :eof

for /f "skip=10 tokens=1* delims=:" %a in ('netsh wlan show profiles') do @for /f "tokens=*" %c in ("%b") do @for /f "tokens=1* delims=:" %d in ('netsh wlan show profiles "%c" key^=clear^|findstr /r "关键内容"') do @echo;&@echo;SSID： %c 密码：%e