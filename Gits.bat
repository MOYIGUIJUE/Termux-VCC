@echo off
rem mode 70,15
REM setlocal enabledelayedexpansion
REM git init
REM git remote add origin https://gitee.com/cctv3058084277/main.git
REM git remote -v
if "%~1"=="" (
	git status
	exit /b
)
REM git diff
git add *
git commit -m "%~1"
git push
REM git push origin master
REM git pull --rebase origin master
REM 合并分支
REM 使用git log命令，查看分支提交历史，确认需要回退的版本
REM 使用git reset --hard commit_id命令，进行版本回退
REM 使用git push origin命令，推送至远程分支
REM 快捷命令：

REM 回退上个版本：git reset --hard HEAD^ 
REM 【注：HEAD是指向当前版本的指针，HEAD^表示上个版本,HEAD^^表示上上个版本】

REM 更新远程分支列表
REM git remote update origin --prune

REM git reset --hard HEAD

REM 查看所有分支
REM git branch -a

REM 删除远程分支Chapater6
REM git push origin --delete Chapater6

REM 删除本地分支 Chapater6
REM git branch -d  Chapater6