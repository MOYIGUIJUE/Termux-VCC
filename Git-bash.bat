@echo off & title 
rem mode 70,15
setlocal enabledelayedexpansion
REM git init
REM git revote add origin https://...
REM git revote -v
git add *
git commit -m "%~1"
git push
REM git push -u origin master
REM git status
REM git pull --rebase origin master
