---
layout: pages
title: cocos2d-x安装配置
date: 2021-09-30 14:47:17
catagroies: cocos2d-x
cover: https://gitee.com/tanzicai/drawingbed/raw/master/img/20210930154156.png
top_img: https://gitee.com/tanzicai/drawingbed/raw/master/img/20210930154253.png
tags:
  - 游戏
  - cocos2d-x
  - 游戏引擎
---

Cocos2d-x 是一套成熟的开源跨平台游戏开发框架。引擎提供了图形渲染、GUI、音频、网络、物理、用户输入等丰富的功能， 被广泛应用于游戏开发及交互式应用的构建。其核心采用 C++ 编写，支持使用 C++、Lua 或 JavaScript 进行开发。

本次是课程原因我们需要使用cocos2d-x进行期末大作业的开发,特在此记录一下在开发过程中遇到的问题.便于以后的总结.

![image-20210930151606581](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210930151846.png)

# 安装及配置

## 下载

官方下载地址:[雅基软件 —— Cocos 引擎官方团队](雅基软件 —— Cocos 引擎官方团队，)

![image-20210930151856467](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210930151857.png)



点击下载后选择`cocos2d-x`后可以看到当前的最新版本为4.0,那么我们就下载4.0版本

![image-20210930151948755](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210930151949.png)

在官方手册中说明了该引擎运行的环境如下

#### MacOS

- OpenGL
  - 模拟器 - macOS 10.13+, Xcode 10+, CMake 3.1+
  - 真机 - macOS 10.13+, Xcode 10+, CMake 3.1+
- Metal
  - 模拟器 - macOS 10.15+, Xcode 11+, CMake 3.15+
  - 真机 - macOS 10.14+, Xcode 10+, CMake 3.15+
- Python 2.7.5+, **建议 Python 2,7.10**, **而不是 Python 3+**

#### Linux

- Ubuntu 16.04
- CMake 3.1+ (使用 **apt install** 获取最新版本)
- Python 2.7.5+, **P建议 ython 2,7.10,** 而不是 Python 3+__

#### Windows

- Windows 7+
- VS 2017+
- CMake 3.1+
- Python 2.7.5+, **P建议 ython 2,7.10,** 而不是 Python 3+__

#### Android

- Python 2.7.5+, **P建议 ython 2,7.10,** 而不是 Python 3+__
- NDK r91c+ (使用 r19c 测试过) **在 Android Studio 里叫 \**19.2.xx\****
- Android Studio 3.4+(使用 3.0 测试过)
- CMake 3.1+

那我们根据以上的环境选择以下环境下配置

+ windows10
+ [vs2019社区版](https://visualstudio.microsoft.com/zh-hans/vs/)
+ [Cmake3.21.3]([Download | CMake](https://cmake.org/download/))
+ [python2.7.10](https://www.python.org/downloads/release/python-2710/)

除了python2.7.10官网下载速度比较慢,其他速度均可,所以建议python使用国内下载地址

## 安装

### Python2.7.10

安装后天降环境变量,不会的请百度

安装完成后打开cmd运行python

```
python
```

![image-20210930153510517](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210930153510.png)

出现如图所示代码输出就代表安装成功

### Cmack

