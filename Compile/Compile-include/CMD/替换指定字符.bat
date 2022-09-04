@echo off
setlocal enabledelayedexpansion
for %%j in (*.txt) do (
	cd.>$
	for /f "eol=* tokens=*" %%i in (%%j) do (
		rem 设置变量a为每行内容
		set a=%%i
		rem 如果该行有0:0，则将其改为4:0
		set "a=!a:0:0=4:0!"
		rem 把修改后的全部行存入$
		echo !a!>>$ 
	)
	rem 用$的内容替换原来index1.txt内容
	move $ D:\Desktop\qiche\规则\%%j
	echo;move $ D:\Desktop\qiche\规则\%%j
)
del $
pause
