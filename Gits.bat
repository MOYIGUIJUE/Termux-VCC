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
REM �ϲ���֧
REM ʹ��git log����鿴��֧�ύ��ʷ��ȷ����Ҫ���˵İ汾
REM ʹ��git reset --hard commit_id������а汾����
REM ʹ��git push origin���������Զ�̷�֧
REM ������

REM �����ϸ��汾��git reset --hard HEAD^ 
REM ��ע��HEAD��ָ��ǰ�汾��ָ�룬HEAD^��ʾ�ϸ��汾,HEAD^^��ʾ���ϸ��汾��

REM ����Զ�̷�֧�б�
REM git remote update origin --prune

REM git reset --hard HEAD

REM �鿴���з�֧
REM git branch -a

REM ɾ��Զ�̷�֧Chapater6
REM git push origin --delete Chapater6

REM ɾ�����ط�֧ Chapater6
REM git branch -d  Chapater6