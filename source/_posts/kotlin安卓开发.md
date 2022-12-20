---
layout: pages
title: kotlin安卓开发
date: 2021-10-02 12:31:11
cover: https://gitee.com/tanzicai/drawingbed/raw/master/img/20211002132143.png
top_img: https://gitee.com/tanzicai/drawingbed/raw/master/img/20211002132205.jpeg
categroies: kotlin
tags: 
  - kotlin
  - 安卓开发
  -	jet pack
---

# 开发环境搭建

## 下载AndroidStudio

[Google官方下载地址](https://developer.android.google.cn/studio/index.html)

下载后进行安装,安装后打开可能会有提示信息

![image-20211002124503696](https://gitee.com/tanzicai/drawingbed/raw/master/img/20211002124511.png)

该页面是未找到SDKs,如果有的话点击setupProxy设置SDK路径,如果没有SDK就点击cancel即可自动下载SDK.

![image-20211002124642458](https://gitee.com/tanzicai/drawingbed/raw/master/img/20211002124642.png)

到这里我们软件就安装完成了

一路点击next我们就来到了下载组件的地方,我们全部下载就行.并等待下载完成.

![image-20211002124817567](https://gitee.com/tanzicai/drawingbed/raw/master/img/20211002124817.png)

但finish亮起时就代表下载完成,安装过程中可能会请求管理员权限,

![image-20211002125318383](https://gitee.com/tanzicai/drawingbed/raw/master/img/20211002125318.png)

到这里我们的软件安装就结束了

![image-20211002125331168](https://gitee.com/tanzicai/drawingbed/raw/master/img/20211002125331.png)

## Tab项目创建

![image-20211002125524350](https://gitee.com/tanzicai/drawingbed/raw/master/img/20211002125524.png)

点击新建项目后,我们选择`Button Navigation Activity`创建我们的第一个项目工程,这个模板是带有多tab导航切换的,也是最为熟悉的一种样式.

![image-20211002125704449](https://gitee.com/tanzicai/drawingbed/raw/master/img/20211002125704.png)

按照仔细的需求填写上面的各种信息就好,本次语言我们选择kotlin进行开发,miniSDK一般选择5.0就好,这里指定的是最低安卓安装版本.

> 注意不要勾选Use legacy Android.support libraries,我们将使用google开源库

![image-20211002125953097](https://gitee.com/tanzicai/drawingbed/raw/master/img/20211002125953.png)

![image-20211002130200866](https://gitee.com/tanzicai/drawingbed/raw/master/img/20211002130201.png)

等待下载需要的库和其他配置,右下角有进度条

![image-20211002131122362](https://gitee.com/tanzicai/drawingbed/raw/master/img/20211002131122.png)

安装完成并初始化后就是这个界面,界面左边是文件目录树,中间是可视化控件区域,右边则是属性区域.

接下来就是目录结构探究了

# Android Studio工程目录

**1、.gradle和.idea**
    这两个目录下放置的都是Android Studio自动生成的一些文件，我们无须关心，也不要去手动编辑。
**2、app**
    项目中的代码、资源等内容几乎都是放置在这个目录下的，我们后面的开发工作也基本都是在这个目录下进行的，待会儿还会对这个目录单独展开进行讲解。
**3、build**
    这个目录你也不需要过多关心，它主要包含了一些在编译时自动生成的文件。
**4、gradle**
    这个目录下包含了gradle wrapper的配置文件，使用gradle wrapper的方式不需要提前将gradle下载好，而是会自动根据本地的缓存情况决定是否需要联网下载gradle。Android Studio默认没有启动gradle wrapper的方式，如果需要打开，可以点击Android Studio导航栏 --> File --> Settings --> Build，Execution，Deployment --> Gradle，进行配置更改。
**5、.gitignore**
    这个文件是用来将指定的目录或文件排除在版本控制之外的。
**6、build.gradle**
    这是项目全局的gradle构建脚本，通常这个文件中的内容是不需要修改的。下面会详细分析gradle构建脚本中的具体内容。
**7、gradle.properties**
    这个文件是全局的gradle配置文件，在这里配置的属性将会影响到项目中所有的gradle编译脚本。
**8、gradlew和gradlew.bat**
    这两个文件是用来在命令行界面中执行gradle命令的，其中gradlew是在Linux或Mac系统中使用的，gradlew.bat是在Windows系统中使用的。
**9、HelloWorld.iml**
    iml文件是所有IntelliJ IDEA项目都会自动生成的一个文件(Android Studio是基于IntelliJ IDEA开发的)，用于标识这是一个IntelliJ IDEA项目，我们不需要修改这个文件中的任何内容。
**10、local.properties**
    这个文件用于指定本机中的Android SDK路径，通常内容都是自动生成的，我们并不需要修改。除非你本机中的Android SDK位置发生了变化，那么就将这个文件中的路径改成新的位置即可。
**11、settings.gradle**
    这个文件用于指定项目中所有引入的模块。由于HelloWorld项目中就只有一个app模块，因此该文件中也就只引入了app这一个模块。通常情况下模块的引入都是自动完成的，需要我们手动去修改这个文件的场景可能比较少。

# app目录结构

------

现在整个项目的外层目录结构已经介绍完了。你会发现，除了app目录之外，大多数的文件和目录都是自动生成的，我们并不需要进行修改。想必你已经猜到了，app目录下的内容才是我们以后的工作重点，展开之后结构如下：

![img](https://gitee.com/tanzicai/drawingbed/raw/master/img/20211002131733.png)
    那么下面我们就来对app目录下的内容进行更为详细的分析。
**1、build**
    这个目录和外层的build目录类似，主要也是包含了一些在编译时自动生成的文件，不过它里面的内容会更多更杂，我们不需要过多关系。
**2、libs**
    如果你的项目中使用到了第三方jar包，就需要把这些jar包都放在libs目录下，放在这个目录下的jar包都会被自动添加到构建路径里去。
**3、AndroidTest**
    此处是用来编写Android Test测试用例的，可以对项目进行一些自动化测试。
**4、java**
    毫无疑问，java目录是放置我们所有java代码的地方，展开该目录，你将看到我们刚才创建的HelloWorldActivity文件就在里面。
**5、res**
    这个目录下的内容就有点多了。简单点说，就是你在项目中使用到的所有图片，布局，字符串等资源都要存放在这个目录下。当然这个目录下还有很多子目录，图片放在drawable目录下，布局放在layout目录下，字符串放在values目录下，所以你不用担心会把整个res目录弄得乱糟糟的。
**6、AndroidManifest.xml**
    这是你整个Android项目的配置文件，你在程序中定义的所以四大组件都需要在这个文件里注册，另外还可以在这个文件中给应用程序添加权限声明。
**7、test**
    此处是用来编写Unit Test测试用例的，是对项目进行自动化测试的另一种方式。
**8、.gitignore**
    这个文件用于将app模块内的指定的目录或文件排除在版本控制之外，作用和外层的.gitignore文件类似。
**9、app.iml**
    IntelliJ IDEA项目自动生成的文件，我们不需要关心或修改这个文件中的内容。
**10、build.gradle**
    这是app模块的gradle构建脚本，这个文件中会指定很多项目构建相关的配置。
**11、proguard-rules.pro**
    这个文件用于指定项目代码的混淆规则，当代码开发完成后打成安装包文件，如果不希望代码被别人破解，通常会将代码混淆，从而让破解者难以阅读。

# 项目中的资源

------

如果你展开res目录看一下，其实里面的东西还是挺多的，很容易让人看得眼花缭乱:

+ 所有以drawable开头的文件夹都是用来放图片的，
+ 所有以mipmap开头的文件夹都是用来放应用图标的，
+ 所有以values开头的文件夹都是用来放字符串、样式、颜色等配置的，
+ layout文件夹是用来放布局文件的。

就明白了
