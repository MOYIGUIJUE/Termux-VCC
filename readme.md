### 第三方命令程序集合

>详细输入helps
>会有演示和帮助信息
>helps里面的一些，比如：
>install -vcc [path]
>      后面添加安装路径,或不添加弹出文件夹选择框
>      初次安装在弹出的管理员黑框中输入all,回车,关闭
>exec [path]
>      后面添加安装路径,这里包含3个注册项
>      gccpath、右键notepad++、右键termux

![1658592295777](https://gitee.com/cctv3058084277/main/raw/master/image/1658591667591.png)

### gcc 3.4.0

>com 1.cpp
>      1.cpp如不存在则会创建一个范例1.cpp
>      然后再次输入 com 1.cpp 就会编译
>com -c [path\filename]
>      后面添加文件名,如果不存在也会创建
>      不添加,将会有一个控制台界面可供选择

![1658591667591](https://gitee.com/cctv3058084277/main/raw/master/image/1658591667591.png)

![1658591709398](https://gitee.com/cctv3058084277/main/raw/master/image/1658591709398.png)

### 文件命令

> (.\Compile\Compile-include\tables.bat)

![1658592015776](https://gitee.com/cctv3058084277/main/raw/master/image/1658592015776.png)

>\> vim82 (这里不做宏命令主要是想在文件里记录一些vim的命令)

![1658592460727](https://gitee.com/cctv3058084277/main/raw/master/image/1658592460727.png)

### 宏命令

（.\termux.bat）

```shell
doskey cat=type $*
doskey cp=copy $*
doskey mv=move $*
doskey rv=recycle $*
doskey pwd=cd
doskey cds=cd /d $*
doskey ll=ls --color=auto $*
doskey note="%~dp0Compile\Compile-bin\Sourse Lib\Notepad++\notepad++.exe" $*
doskey tcc="%~dp0Compile\Compile-bin\Sourse Lib\TCC\tcc.exe" $*
doskey ip=printf 0x07 "%IPv4%" ^| clip ^& echos 0x03 --[%IPv4%]已复制至剪切板-- 
doskey ca=set /a ca_result=$*
```

>\> note宏命令

![1658592552448](https://gitee.com/cctv3058084277/main/raw/master/image/1658592552448.png)

>剩余的自己去探索吧

### 联系我们

Q群:820146120