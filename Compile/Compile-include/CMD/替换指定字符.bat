@echo off
setlocal enabledelayedexpansion
for %%j in (*.txt) do (
	cd.>$
	for /f "eol=* tokens=*" %%i in (%%j) do (
		rem ���ñ���aΪÿ������
		set a=%%i
		rem ���������0:0�������Ϊ4:0
		set "a=!a:0:0=4:0!"
		rem ���޸ĺ��ȫ���д���$
		echo !a!>>$ 
	)
	rem ��$�������滻ԭ��index1.txt����
	move $ D:\Desktop\qiche\����\%%j
	echo;move $ D:\Desktop\qiche\����\%%j
)
del $
pause
