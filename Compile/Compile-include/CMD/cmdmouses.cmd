
@echo off
insert
        echo ▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌
        echo  ▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌
        echo ▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌
        echo  ▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌
        echo ▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌
        echo  ▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌
        echo ▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌
        echo  ▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌▌
:main
        call:mouse_get x,y
        echo %x% %y%
goto:main

:mouse_get
        call:mouse_save ax,ay
        call:mouse_save bx,by
        if %ax% EQU %bx% if %ay% EQU %by% (
                set /A %~1=%ax%
                set /A %~2=%ay%
        ) else (
                call:mouse_get %~1,%~2
        )
goto:eof

:mouse_save
        for /f "delims=, tokens=1,2" %%i in ( 'cmdmouse.exe' ) do (
                set /A %~1=%%i / 8
                set /A %~2=%%j / 16
        )
goto:eof


exit /b


@echo off
setlocal enabledelayedexpansion
pmos /G 
set /a X=!errorlevel!/10000
set /a Y=!errorlevel!%%10000
echo;%X%,%Y%
pmos /M 300,500
pmos /f 0,0,2,2 2,2,4,4
echo 鼠标掠过第%errorlevel%个区域
pause>NUL
exit /b
pmos [/G]|[/M [x],[y]]|[/W [key]:[time]]|[/A {parameters}]|[/H]|[/P [x],[y]]
-----------------------------------------------------------------------------
---鼠标系---
      /G                获取鼠标瞬时像素坐标
      /M  [x],[y]       移动鼠标到指定像素坐标
      /K  [key]:[time]  在[time]时间内，如果鼠标[key]键被按下，则返回像素坐标
      /F  {[x],[y],[with],[height]}  鼠标区域浮留判定

---光标系---
      /GC               获取光标坐标
      /MC [x],[y]       移动光标到指定坐标
      /KC [key]:[time]  在[time]时间内，如果鼠标[key]键被按下，则返回光标坐标
      /SC [size]        设置光标尺寸
-----------------------------------------------------------------------------

示例：
-----------------------------------------------------------------------------
pmos /G                &REM 获取鼠标瞬时像素坐标，返回值在!errorlevel!中
                        REM X=!errorlevel!/10000, Y=!errorlevel!%%10000

pmos /M 300,500        &REM 移动鼠标到像素坐标(300,500)位置。

pmos /K -1:5000        &REM 在5000毫秒内，如果鼠标左键被按下，则返回像素坐标。
                        REM [key]取值为-1、1对应鼠标左右键。

pmos /F 0,200,100,50  150,200,100,50  300,200,100,50
                       &REM 判断鼠标是否在所给的3个区域中，是则返回区域序号。
