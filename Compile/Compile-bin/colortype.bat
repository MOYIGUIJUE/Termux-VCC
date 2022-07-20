@echo off
setlocal enabledelayedexpansion
set tmp=0
for %%i in (0 1 2 3 4 5 6 7 8 9 A B C D E F) do (
	for %%j in (0 1 2 3 4 5 6 7 8 9 A B C D E F) do (
		set /a tmp+=1
		printf 0x07 " %%i%%j "
		printf 0x%%i%%j "%%i%%j"
		if !tmp! equ 10 set /a tmp = 0 & echo;
	)
)
exit /b
    0 = 黑色       8 = 灰色
    1 = 蓝色       9 = 淡蓝色
    2 = 绿色       A = 淡绿色
    3 = 浅绿色     B = 淡浅绿色
    4 = 红色       C = 淡红色
    5 = 紫色       D = 淡紫色
    6 = 黄色       E = 淡黄色
    7 = 白色       F = 亮白色