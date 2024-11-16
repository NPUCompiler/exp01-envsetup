#!/bin/sh

# 若Windows系统已经安装有JDK，这里就不需要安装，设置为OFF或者注释掉
JDK_NEED_INSTALL=ON

# 代理URL，必须最后含有字符/，没有时请设置为空
PROXY_URL="https://proxy.201704.xyz/"

# 两种选择：基于gcc的底层运行库和基于llvm的底层运行库
# 基于gcc的底层运行库选择mingw-w64-x86_64
# 基于llvm的底层运行库选择mingw-w64-clang-x86_64
# 这里选择mingw-w64-clang-x86_64
MSYS2_KIND=mingw-w64-clang-x86_64

# 指定安装antlr4的版本
ANTLR4_VERSION=4.12.0

# 安装常用的软件
pacman -S --noconfirm zsh vim git unzip

# 安装flex和bison
pacman -S --noconfirm flex bison

# 安装python以及python-pip
pacman -S --noconfirm ${MSYS2_KIND}-python ${MSYS2_KIND}-python-pip ${MSYS2_KIND}-python-numpy

# 安装boost
pacman -S --noconfirm ${MSYS2_KIND}-boost

# 安装cmake和ninja
pacman -S --noconfirm ${MSYS2_KIND}-cmake ${MSYS2_KIND}-ninja

# 安装doxygen
pacman -S --noconfirm ${MSYS2_KIND}-doxygen

# 安装texlive，支持中文和英文
pacman -S --noconfirm ${MSYS2_KIND}-texlive-lang-chinese ${MSYS2_KIND}-texlive-lang-english ${MSYS2_KIND}-texlive-latex-extra ${MSYS2_KIND}-texlive-science ${MSYS2_KIND}-texlive-plain-generic

# 安装gcc和gdb
pacman -S --noconfirm ${MSYS2_KIND}-gcc ${MSYS2_KIND}-gdb ${MSYS2_KIND}-gdb-multiarch

# 安装clang和lldb
pacman -S --noconfirm ${MSYS2_KIND}-llvm ${MSYS2_KIND}-clang ${MSYS2_KIND}-clang-tools-extra ${MSYS2_KIND}-clang-analyzer ${MSYS2_KIND}-lldb

# 安装graphviz
pacman -S --noconfirm ${MSYS2_KIND}-graphviz

# 安装RISCV的交叉编译环境
pacman -S --noconfirm ${MSYS2_KIND}-riscv64-unknown-elf-gcc

# 安装arm的交叉编译环境
pacman -S --noconfirm ${MSYS2_KIND}-arm-none-eabi-gcc

# 安装qemu软件，只有system模式，没有user模式，因此运行后端运行请在Linux上进行
# pacman -S --noconfirm ${MSYS2_KIND}-qemu
# wget -O ~/qemu-w64-setup-20231214.exe ${PROXY_URL}https://qemu.weilnetz.de/w64/2023/qemu-w64-setup-20231214.exe

# 安装antlr4-runtime-cpp-4.12.0
pacman -U --noconfirm https://mirrors.ustc.edu.cn/msys2/mingw/clang64/${MSYS2_KIND}-antlr4-runtime-cpp-${ANTLR4_VERSION}-1-any.pkg.tar.zst 
wget -O /usr/bin/antlr-${ANTLR4_VERSION}-complete.jar ${PROXY_URL}https://github.com/antlr/website-antlr4/blob/gh-pages/download/antlr-${ANTLR4_VERSION}-complete.jar

# 安装oh-my-zsh
git clone ${PROXY_URL}https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
git clone ${PROXY_URL}https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
git clone ${PROXY_URL}https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
sed -i 's/^plugins=(/plugins=(zsh-autosuggestions zsh-syntax-highlighting z /' ~/.zshrc

# 如果Windows已经安装JDK，这里就不需要安装了

if [ "${JDK_NEED_INSTALL}" = "ON" ] || [ "${JDK_NEED_INSTALL}" = "On" ] || [ "${JDK_NEED_INSTALL}" = "on" ];
then
    # 安装openjdk，这里选择微软发布的openjdk 17.0.9
    # wget -O ~/openlogic-openjdk-17.0.9+9-windows-x64.zip https://builds.openlogic.com/downloadJDK/openlogic-openjdk/17.0.9+9/openlogic-openjdk-17.0.9+9-windows-x64.zip
    wget -O ~/microsoft-jdk-17.0.9-windows-x64.zip https://aka.ms/download-jdk/microsoft-jdk-17.0.9-windows-x64.zip
    unzip ~/microsoft-jdk-17.0.9-windows-x64.zip -d /opt

    # 追加Java的可执行路径到PATH环境变量中
    if [ -f ~/.bashrc ];
    then
        echo "export PATH=/opt/jdk-17.0.9+8/bin:$PATH" >> ~/.bashrc
    fi

    if [ -f ~/.zshrc ];
    then
        echo "export PATH=/opt/jdk-17.0.9+8/bin:$PATH" >> ~/.zshrc
    fi
fi
