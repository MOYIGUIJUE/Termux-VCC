@echo off &mode con cols=35 lines=8
setlocal enabledelayedexpansion
echo,p>x
for %%a in (w a s d p q) do (set de%%a=defined)
set _w=s
set _s=w
set _a=d
set _d=a
set notequ=have
:a
cls

choice /C "wasdqrp" /N /m "w a s d q(退出) r(重来) p(暂停):"
REM /T 100 /D 3
if %errorlevel%==1 set input=w
if %errorlevel%==2 set input=a
if %errorlevel%==3 set input=s
if %errorlevel%==4 set input=d
if %errorlevel%==5 set input=q
if %errorlevel%==6 set input=r
if %errorlevel%==7 set input=p



REM set /p input="w a s d q(退出) r(重来) p(暂停):"
if "%input%"=="q" (
  echo,q>x
  exit
)
if "%input%"=="r" (
  echo,r>x
)
if "%input%"=="%notequ%" (goto :a)
if not defined de%input% (goto :a)
set notequ=!_%input%!
echo %input%>x
goto :a
