# 环境构建

编译原理实验的环境可采用Windows上用msys2环境、WSL2 + Ubuntu 22.04、虚拟机或者容器方式部署。

建议在Windows上部署msys2环境，部署WSL2+Ubuntu 22.04的方式，也可以采用其它方式，根据自身情况选择。

## Win10或11上部署msys2环境

### 下载msys2并安装

从中科大的镜像源中下载安装 msys2，下载网址：<http://mirrors.ustc.edu.cn/msys2/distrib/msys2-x86_64-latest.exe>

假定msys2安装在路径C:\LinuxEnv下，这样msys2的位置为：C:\LinuxEnv\msys64

### 安装开发软件

进入msys2的安装路径（C:\LinuxEnv\msys64）下，可以看到一个clang64.exe程序。双击执行 clang64.exe 程序会弹出终端窗口，
可通过cd命令进入本文件所在的路径，假定路径为D:\compilerdevenv，要执行的命令为：

```shell
cd "D:\compilerdevenv"
sh tools/msys2.sh
```

或者

```shell
cd "/D/compilerdevenv"
sh tools/msys2.sh
```

## Win10或11上部署WSL2+Ubuntu 22.04

### 安装Windows Terminal

建议从Microsoft Store中下载安装Windows Terminal。

### 安装WSL2

在 Windows PowerShell 中以管理员身份运行下面命令：

```shell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

运行完成之后，请重启电脑完成安装。

然后设置WSL发行版为2.0，启用虚拟机机制。

在 Windows PowerShell 中运行下面命令：

```shell
wsl --set-default-version 2
```

### 安装Ubuntu 22.04

在 Windows PowerShell 中执行下面的命令安装Ubuntu-22.04。

```shell
wsl --install --distribution Ubuntu-22.04
```

在下载安装完后会提示创建一个普通用户。这里为后续实验的方便，请设置用户名为code，密码根据自己情况设置。

最后会自动登录Ubuntu 22.04，请输入exit后退出Ubuntu，不过虚拟机仍在运行。

### 以root用户进入Ubuntu并安装软件

在 Windows PowerShell 中执行下面的命令以root用户进入ubuntu系统

```shell
wsl --user root --distribution Ubuntu-22.04 --cd ~
```

在进入系统后执行下面的命令，实现ubuntu.sh脚本的下载与运行，安装与配置软件。

```shell
wget -O ubuntu.sh http://10.69.45.39:30080/publicprojects/compile-exp01/-/raw/master/tools/ubuntu.sh
sh ubuntu.sh
```

### 以普通用户code进入ubuntu进行开发与测试

在 Windows PowerShell 中执行下面的命令以code用户进入ubuntu系统

``` powershell
wsl --user code --distribution Ubuntu-22.04 --cd ~
```

## VMware/VirtualBox/Qemu 安装 Ubuntu 与软件安装

可通过 VMware/VirtualBox/Qemu 等虚拟机软件安装 Ubuntu 22.04系统，建议采用Server版。

下载网址：<https://mirrors.ustc.edu.cn/ubuntu-releases/22.04/ubuntu-22.04.4-live-server-amd64.iso>

请注意创建普通用户名设置为code，密码自定。

以 root 用户进入系统Ubuntu 22.04后执行如下的指令：

```shell
cd ~
wget -O ubuntu.sh http://10.69.45.39:30080/publicprojects/compile-exp01/-/raw/master/tools/ubuntu.sh
sh ubuntu.sh
```

请注意ubuntu.sh中的USER_NAME为安装ubuntu时一般用户名，默认值为code，请根据实际情况修改。

建议开启ssh的免密钥登录方式，也就是在Windows上创建密钥，然后加入到Ubuntu的

## Docker Desktop 安装 Ubuntu 与软件安装

可通过 Docker Desktop Installer 安装 Docker 运行环境，具体参考网址：
<https://docs.docker.com/desktop/install/windows-install/>

Docker 配置运行详细见 tools/docker.md 文件。

## 下载git工具与tortoisegit

从下面的网址下载Git for Windows工具然后安装。

<https://proxy.201704.xyz/https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/Git-2.44.0-64-bit.exe>

从下面的网址下载tortoisegit，并安装。重启后，鼠标右键的菜单就会有git相关操作的菜单或者界面。

网址：<https://proxy.201704.xyz/https://download.tortoisegit.org/tgit/2.15.0.0/TortoiseGit-2.15.0.0-64bit.msi>

注意：若不能下载，则删除网址的前缀：<https://proxy.201704.xyz/>，该网址为代理，加速下载。

## vscode 下载安装与运行

请从官网下载 vscode 并安装，下载网址：<https://code.visualstudio.com/Download>

## 克隆实验一代码与Vscode插件安装、配置

通过git克隆<http://10.69.45.39:30080/publicprojects/calculator.git>的计算器代码。

在命令行窗口或者资源窗口上右键克隆计算器实验的代码，主要是为了vscode上安装插件。

```shell
git clone http://10.69.45.39:30080/publicprojects/calculator.git
```

打开vscode后选择File -> Open Folder选择克隆代码所在的文件夹进行打开，不一会儿vscode会提示安装推荐的插件，选择安装即可。

vscode根据文件.vscode/extensions.json文件进行推荐插件安装。

vscode会采用文件.vscode/settings.json进行vscode的配置，这称为workspace的配置，优先vscode的用户配置。

## dotnet安装与vscode配置

为了使VScode与cmake联动更加有效，需要下载安装dotnet-sdk 6.0。下载网址：
<https://dotnet.microsoft.com/zh-cn/download/dotnet/6.0>

确保修改.vscode/settings.json中的cmake.languageSupport.dotnetPath值为C:/Program Files/dotnet/dotnet.exe

## VSCode与WSL2联动

用 vscode + wsl 方式连接开发。确保修改.vscode/settings.json中的cmake.languageSupport.dotnetPath值为/usr/bin/dotnet

## VSCode与SSH联动

用 vscode + ssh 方式连接开发。确保修改.vscode/settings.json中的cmake.languageSupport.dotnetPath值为/usr/bin/dotnet

## VSCode与容器联动

用vscode + container方式连接开发。确保修改.vscode/settings.json中的cmake.languageSupport.dotnetPath值为/usr/bin/dotnet

## 安装优秀的字体

请进入fonts目录下安装FiraCode、JetBrainsMono和MonoLisa的字体。Windows系统下安装非常简单，直接双击文件选择安装即可。
