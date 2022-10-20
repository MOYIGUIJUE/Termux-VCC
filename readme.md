<p align="center">
  <a href="#">
    <img alt="Termux Vcc" src="image/Termux-VCC.png" width="128">
  </a>
</p>

<p align="center">第三方命令和一些工具集合</p>
<p align="center">
  <a href="#"><img src="https://img.shields.io/badge/language-C++-blue.svg"></a>
  <a href="https://github.com/imengyu/JiYuTrainer/releases"><img src="https://img.shields.io/badge/version-1.7-greeb.svg"></a>
  <a href="https://github.com/imengyu/JiYuTrainer/blob/master/LICENSE"><img src="https://img.shields.io/badge/liscence-MIT-orange.svg"></a>
</p>

---

简介
---

本软件研发目的就是为了方便操作windows，如果你对windows桌面运用，命令行脚本感兴趣，本软件很可能会帮到你。

> 想在windows上学习linux上的命令? 想深入了解句柄、内存、命令行本质?想学习shell脚本，各个脚本之间的调用？自己写命令？

如果你被以上问题困扰，本集合可能是您非常想要的。

这是一个通过shell脚本调用运行的集合，也就是说，是以在cmd基础运行，你不仅可以使用cmd自带的命令，也还可以使用本集合提供的命令。

如果你喜欢这个软件，不妨向你的好友推荐一下吧！

如果你觉得这个软件不错，不妨加个小星星⭐吧，你的喜欢是对我最大的支持！

功能
---
* Compile-bin目录下是所有的外部命令
* 宏命令在termux.bat内定义
* Compile-include目录下收集了体积较小的 Everything 、Tcc、sqlite、spy++、NeatDM 等工具
* 发行版内的 FILE目录下收集了 notepad++8.1.0、VIM82、Gcc 3.4.0 、开源的 CuteHttpFileServer  和 JiYuTrainer 等工具

下载
---

* [下载软件最新版已编译版本](https://raw.githubusercontent.com/imengyu/JiYuTrainer/master/Release) 

提示：杀毒软件可能报毒是正常的,外部命令调用系统API才能做更多事情,安装过程种的添加注册表操作需要管理员权限

---

操作方法
---

本集合专为小白设计，默认情况下，您不需要修改任何参数，直接运行发行版exe，直接安装即可，集合会自动进行添加。

> 附加说明：本软件不依赖任何运行库，您只需安装一次 **TERMUX-VCC** 至目标电脑即可运行，安装一次即可，如果版本有更新初始页面会提示升级，运行 **install -d**即可。 

[完整帮助文档](https://raw.githubusercontent.com/imengyu/JiYuTrainer/master/帮助.png)

---

一些提示
---

**Q: 我该怎么启动此集合，安装完不知道怎么开启？** <br/>
**A: 你可以右键桌面或者资源管理器，点击Termux将在此路径下打开控制台。具体操作方法如下：** <br/>

1. win11在更多选项那里
#### 已测试稳定版本：

* 1.4.1
* 1.4.3
* 最新版

#### 操作系统版本: 

* 系统版本要求: Win7/Win8/Win8.1/Win10

> 由于精力有限、建议在64位操作系统下运行
> 如果您要在32位上使用，一些功能可能无法使用

编译以及生成
---

| 支持的编译工具：                                    |          |
| :-------------------------------------------------- | :------: |
| [Visual Studio](https://www.visualstudio.com/) 2019 |  (推荐)  |
| gcc 8.1.0 以上 + (需要自己配置环境)                 | (不推荐) |

| 如果需要编译Server.cpp，您还需要添加编译参数: |      |
| :-------------------------------------------- | :--: |
| -lwsock32                                     |      |

使用的第三方库
---

*第三方库已经包含在项目中，不需要您自己安装*

- [curl](https://github.com/curl/curl) (用于自动更新模块)
- down(用于下载更新包)

其他
---

这个项目大致功能目标已经完成了，<br/>

如果您有其他功能需求，可以fork项目之后自己研究开发。<br/>
如果你想把自己开发的特殊功能放在Termux-Vcc供大家使用的话，
你可以把功能开发完成后PullRequest让我把你的代码合并到主分支中。<br/>
<br/>
如果你喜欢这个项目，<br/>
不妨推荐给你的好友吧😉

许可
---

[MIT License](https://github.com/imengyu/JiYuTrainer/blob/master/LICENSE) (free, open source)