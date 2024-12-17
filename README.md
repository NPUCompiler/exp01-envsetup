# 环境构建

强烈推荐在Windows 10或11上构建WSL2 + Ubuntu 22.04的开发与运行环境。

当然，如PC或者笔记本使用Linux系统或者Mac系统，建议用Docker Desktop + Ubuntu 22.04容器。

## WSL2+Ubuntu 22.04

### 安装Windows Terminal

建议从Microsoft Store中下载安装Windows Terminal。

### 安装WSL

以管理员身份运行Windows Terminal后，运行下面命令：

```shell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

运行完成之后，请重启电脑完成安装。

## 配置WSL为2.0

运行Windows Terminal后，运行下面命令：

```shell
wsl --set-default-version 2
```

### 安装Ubuntu 22.04

运行Windows Terminal后，运行下面命令安装Ubuntu-22.04：

```shell
wsl --install --distribution Ubuntu-22.04
```

在下载安装完后会提示创建一个普通用户。

这里为后续实验的方便，请设置用户名为code，密码根据自己情况设置。

最后会自动登录Ubuntu 22.04，请输入exit后退出Ubuntu，但是虚拟机仍在运行。

### 以root用户进入Ubuntu并安装软件

在Windows Terminal中执行下面的命令以root用户进入ubuntu系统

```shell
wsl --user root --distribution Ubuntu-22.04 --cd ~
```

在进入系统后，执行下面的命令后先下载ubuntu.sh脚本，然后进行软件的安装。

```shell
wget -O ubuntu.sh http://10.69.45.39:30080/publicprojects/compile-exp01/-/raw/master/tools/ubuntu.sh
sh ubuntu.sh
```

### 以普通用户code进入ubuntu进行开发与测试

在Windows Terminal 中执行下面的命令以code用户进入ubuntu系统

``` powershell
wsl --user code --distribution Ubuntu-22.04 --cd ~
```

## Docker Desktop + Ubuntu

### 容器环境的建立

Windows系统一般选择安装Docker Desktop，其下载的网址为：
<https://mirrors.aliyun.com/docker-toolbox/windows/docker-for-windows/stable/Docker%20Desktop%20Installer.exe>

Linux系统建议安装docker-ce和docker-compose，请自行查询相关资料：

macOS系统下需要安装Docker Desktop，其下载的网址为：
<https://mirrors.aliyun.com/docker-toolbox/mac/docker-for-mac/stable>

然后根据mac系统的CPU选择合适的软件下载，新版的mac一般为ARM CPU，请选择arm64下的Docker.dmg，老版的mac一般为Intel CPU，请选择amd64下的Docker.dmg。

有关Docker Desktop的帮助文档可参阅下面的网址：

<https://docs.docker.com/desktop/install/windows-install/>

## Docker Desktop的配置

打开Docker Desktop设置 > Docker Engine。

默认情况下配置如图所示：

![DockerDesktop-Setting-Engine-Before](tools/pictures/DockerDesktop-Setting-Engine-Before.png)

增加registry-mirrors键值，如有buildkit则修改buildkit的值为false，然后点击"Apply & restart"。

具体的信息如下所示：

```yaml
{
  "builder": {
    "gc": {
      "defaultKeepStorage": "20GB",
      "enabled": true
    }
  },
  "experimental": false,
  "features": {
    "buildkit": false
  },
  "registry-mirrors": [
    "https://registry.docker-cn.com",
    "https://docker.mirrors.ustc.edu.cn",
    "http://hub-mirror.c.163.com"
  ]
}
```

![DockerDesktop-Setting-Engine-After](tools/pictures/DockerDesktop-Setting-Engine-After.png)

由于网络的限制，不能直接从Docker的官方网站上下载容器，后续提供一个做好的容器，请导入后使用。

## 下载Ubuntu镜像并配置环境

在命令行界面进入tools目录下，然后执行如下的命令：

```shell
docker build -t ubuntu2204-dev .
```

在该镜像中会创建一个普通用户code，其密码为password，供开发时使用。

## 创建容器并运行Ubuntu容器

```shell
docker run -id --restart unless-stopped --name ubuntu-compile --hostname ubuntu-compile ubuntu2204-dev
```

## VSCode联动

若在打开本项目时推荐的插件已安装则不需要再次安装Dev Containers插件后，否则请安装。

在通过vscode连接容器时，请务必要事先打开Docker Desktop并运行容器ubuntu2204-dev。

可以连接到容器上进行软件开发。

## 容器的其它命令，需要时查询

## 进入Ubuntu容器查看

```shell
docker exec -it ubuntu-compile /bin/zsh
```

### 停止Ubuntu容器

```shell
docker stop ubuntu-compile
```

### 启动Ubuntu容器

```shell
docker start ubuntu-compile
```

### 重启Ubuntu容器

也就是先停止后启动容器

```shell
docker restart ubuntu-compile
```

### 删除镜像

```shell
docker rmi ubuntu2204-dev
```

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
