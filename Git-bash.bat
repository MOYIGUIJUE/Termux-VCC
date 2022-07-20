@echo off
rem mode 70,15
REM setlocal enabledelayedexpansion
REM git init
REM git remote add origin https://gitee.com/cctv3058084277/main.git
REM git remote -v
git add *
git commit -m "%~1"
git push
REM git push origin master
REM git status
REM git pull --rebase origin master
REM 合并分支
REM git merge temp

REM 更新远程分支列表
REM git remote update origin --prune

REM 查看所有分支
REM git branch -a

REM 删除远程分支Chapater6
REM git push origin --delete Chapater6

REM 删除本地分支 Chapater6
REM git branch -d  Chapater6