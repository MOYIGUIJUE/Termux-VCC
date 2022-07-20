### 程序集合

>详细输入helps
>会有演示和帮助信息
>helps里面的一些，比如：
>install -vcc [path]
>      后面添加安装路径,或不添加弹出文件夹选择框
>      初次安装在弹出的管理员黑框中输入all,回车,关闭
>exec [path]
>      后面添加安装路径,这里包含3个注册项
>      gccpath、右键notepad++、右键termux

### gcc 3.4.0

>com 1.cpp
>      1.cpp如不存在则会创建一个范例1.cpp
>      然后再次输入 com 1.cpp 就会编译
>com -c [path\filename]
>      后面添加文件名,如果不存在也会创建
>      不添加,将会有一个控制台界面可供选择

### 文件命令

（.\Compile\Compile-bin）

>7z.exe         com.bat       length.exe     printf.exe     Server.exe
>ARIA2C.bat     CS.exe        link.bat       printfs.exe    Space.exe
>backup.bat     Desk_API.exe  location.exe   printfw.exe    spy++.exe
>choose.bat     download.exe  locations.exe  ResHacker.exe  table.exe
>chooses.bat    echos.exe     ls.exe         rm.exe         TopMost.exe
>Client.exe     exec.bat      modes.exe      rmdir.exe      TrayS.exe
>cmatrix.exe    gotoxy.exe    msg.exe        runtime.bat    update.bat
>colors.exe     Helps.bat     namefile.exe   scc.exe        vcc.bat
>colortype.bat  install.bat   new.bat        select.exe     vim.bat

### 宏命令

（.\termux.bat）

```shell
doskey cat=type $*
doskey clear=echo off $t cls $t modes 70 15 $t title $t colors 0x70 $t more +%splitline% %0 $t colors 0x07 $t set .= ^& set /p ".=%used%@%COMPUTERNAME%[%%cd%%]$ " ^& call %%.%% ^& set .=^& echo on
doskey cp=copy $*
doskey mv=move $*
doskey pwd=cd
doskey remove=move $1 E:\Desktop_copy\History^>nul
doskey ll=ls --color=auto $*
doskey note=D:\Notepad++\notepad++.exe $*
doskey tcc="%~dp0Compile\Compile-bin\Sourse Lib\TCC\tcc.exe" $*
doskey reboot=start cmd /c %0 $t exit
```

### 联系我们

Q群:820146120