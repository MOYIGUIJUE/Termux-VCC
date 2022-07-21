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

>7z.exe         CS.exe        location.exe   printfw.exe    table.exe
>ARIA2C.bat     Desk_API.exe  locations.exe  ResHacker.exe  TopMost.exe
>backup.bat     download.exe  ls.exe         rm.exe         TrayS.exe
>choose.bat     echos.exe     modes.exe      rmdir.exe      update.bat
>chooses.bat    exec.bat      msg.exe        runtime.bat    vcc.bat
>Client.exe     gotoxy.exe    namefile.exe   scc.exe        vim.bat
>cmatrix.exe    Helps.bat     new.bat        select.exe
>colors.exe     install.bat   paths.bat      Server.exe
>colortype.bat  length.exe    printf.exe     Space.exe
>com.bat        link.bat      printfs.exe    spy++.exe

### 宏命令

（.\termux.bat）

```shell
doskey cat=type $*
doskey clear=echo off $t cls $t modes 70 15 $t title $t colors 0x70 $t more +%splitline% %0 $t colors 0x07 $t set .= ^& set /p ".=%used%@%COMPUTERNAME%[%%cd%%]$ " ^& call %%.%% ^& set .=^& echo on
doskey cp=copy $*
doskey mv=move $*
doskey pwd=cd
doskey ll=ls --color=auto $*
doskey note=D:\Notepad++\notepad++.exe $*
doskey tcc="%~dp0Compile\Compile-bin\Sourse Lib\TCC\tcc.exe" $*
doskey reboot=start cmd /c %0 $t exit
```

### 联系我们

Q群:820146120