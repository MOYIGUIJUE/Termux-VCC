@echo off
color a
title ���Ա����Wifi����鿴��
:loop
cls

set num=2
echo =====================================
for /f "tokens=3*" %%c in ('netsh wlan show profiles ^| findstr "�����û������ļ�"') do set /a num+=3&echo WiFi : %%c %%d
echo =====================================
:nam
set /p name=�����������б��е�WiFi ����(SSID):
if "%name%" == ""   echo ������WIFI���� & goto nam
(for /f "tokens=1* delims=:" %%a in ('netsh wlan show profiles name^="%name%" key^=clear ^| findstr "�ؼ�����"') do echo;����:%%b)||echo WIFI������
set name=
echo =====================================
set temp=y
set /p temp=�Ƿ�һ���鿴����WIFI������(Ĭ��:y/n):
mode con cols=50 lines=%num%
if "%temp%"=="y" goto all
set temp=
goto loop
:all
@echo off
color a
title WiFi����鿴��
for /f "tokens=3*" %%i in ('netsh wlan show profiles ^| findstr "�����û������ļ�"') do (
    call :GetPass %%i %%j
)
echo;�Ƿ����
pause >nul
goto loop
goto :eof
:GetPass
echo WiFi : %*
for /f "tokens=1* delims=:" %%a in ('netsh wlan show profile name^="%*" key^=clear ^| findstr "�ؼ�����"') do (
    echo;����:%%b
    echo;===========================
)
goto :eof

for /f "skip=10 tokens=1* delims=:" %a in ('netsh wlan show profiles') do @for /f "tokens=*" %c in ("%b") do @for /f "tokens=1* delims=:" %d in ('netsh wlan show profiles "%c" key^=clear^|findstr /r "�ؼ�����"') do @echo;&@echo;SSID�� %c ���룺%e