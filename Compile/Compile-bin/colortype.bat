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
    0 = ��ɫ       8 = ��ɫ
    1 = ��ɫ       9 = ����ɫ
    2 = ��ɫ       A = ����ɫ
    3 = ǳ��ɫ     B = ��ǳ��ɫ
    4 = ��ɫ       C = ����ɫ
    5 = ��ɫ       D = ����ɫ
    6 = ��ɫ       E = ����ɫ
    7 = ��ɫ       F = ����ɫ