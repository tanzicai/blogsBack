---
layout: pages
title: CUDA安装教程.md
date: 2022-12-20 15:20:14
tags:
	- 环境配置
	- CUDA
	- Nvidia
categories:
	- 机器学习
---

由于一个课程设计需要用到Pytorch，所以不得不在环境上装一下CUDA，本来是打算直接使用Majaro写这一个课设的，但是由于LInux上对于通讯类软件的适配还是停留在Wine这个方法上，使用体验上也仅仅是能用，所以就不太想直接使用。

恰巧WIndows的WSL2出来了，据说挺好用的，所以就想使用WSL2写一下作业。所以记录一下WSL2配置CUDA环境的过程。

参考其他部分教程说需要安装两个驱动（WIndows11和WSL2中），但是哪个是测试版本的安装方法，在正式版本中我们只需要在Windows中安装一个驱动即可。

## 升级Nvidia驱动（WIn操作）

下载网站[DriversCollection.com](https://cn.driverscollection.com/_513518061545aa6b2deaf9211b9/%E4%B8%8B%E8%BD%BD-NVidia-GeForce-MX250-%E9%A9%B1%E5%8A%A8%E7%A8%8B%E5%BA%8F-v.430.39-%E3%80%82%E3%80%82%E3%80%82%E7%9A%84%E9%A9%B1%E5%8A%A8-Windows-10-64-bit-%E5%85%8D%E8%B4%B9)

![下载网站](https://raw.githubusercontent.com/tanzicai/OSS_IMG/main/img/image-20221220153026865.png)

你也可以到英伟达官方下载中心进行下载。下载安装后打开cmd输入一下代码查询显卡信息

```bash
nvidia-smi
```

![nvidia-smi](https://raw.githubusercontent.com/tanzicai/OSS_IMG/main/img/image-20221220153529427.png)

我们重点关注上面的信息有：

+ CUDA Version ： 这里指的是可以识别的最高版本CUDA
+ GPU Name ：GPU名字等信息将在这里显示，如果一张都没有的话，可能是没识别到。

接下来我们按照这里的版本安装CUDA。

## 安装CUDA(WSL2操作)

    参考CUDA官网，选择自己对应的版本。

[CUDA官网下载](https://developer.nvidia.cn/cuda-downloads )

按照下面的选项选择对应得版本，这里是WSL2的版本。

这里的cuda版本，要比刚才cmd中标注的CUDA version要低。

>  一定要选择红圈标注的WSL版本！！！ 

![image-20221220154212904](https://raw.githubusercontent.com/tanzicai/OSS_IMG/main/img/image-20221220154212904.png)

接下来我们就可以得到下面的安装指导，按照安装指导一步一步安装他们。

![image-20221220154310353](https://raw.githubusercontent.com/tanzicai/OSS_IMG/main/img/image-20221220154310353.png)

```bash
Installation Instructions:

wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pinsudo mv cuda-wsl-ubuntu.pin /etc/apt/preferences.d/cuda-repository-pin-600wget https://developer.download.nvidia.com/compute/cuda/12.0.0/local_installers/cuda-repo-wsl-ubuntu-12-0-local_12.0.0-1_amd64.debsudo dpkg -i cuda-repo-wsl-ubuntu-12-0-local_12.0.0-1_amd64.debsudo cp /var/cuda-repo-wsl-ubuntu-12-0-local/cuda-*-keyring.gpg /usr/share/keyrings/sudo apt-get updatesudo apt-get -y install cuda
```

