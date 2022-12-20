---
layout: pages
title: 初识kotlin
date: 2021-09-26 17:40:57
categories: kotlin
top_img: https://gitee.com/tanzicai/drawingbed/raw/master/img/20210926174339.png
cover: https://gitee.com/tanzicai/drawingbed/raw/master/img/20210926185404.png
tags: 
  - Kotlin Web
  - kotlin app	
  - kotlin ganmes
  - 全栈
---

# 初识kotlin

2021年4月SlashData 公司通过调查来自155个国家的19,000多名受访者，发布《开发者国家排名》第20版，在报告中估计，截至2021年第一季度，有2430万活跃的软件开发者。

![img](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210926174735.png)

![img](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210926174829.png)

以百分比计算，增长最快的语言社区是Kotlin。事实上，这是两个社区中的一个，另一个是Rust，在过去三年中增长了两倍多，从2017年第四季度的110万开发商增长到2021年第一季度的260万开发商。这一点从Kotlin的排名中也非常明显。

在这段时间里，Kotlin的排名从第11位上升到第8位——这一趋势主要归功于谷歌决定将Kotlin作为Android开发的首选语言。

即便如此，Kotlin要赶上移动开发的主流语言Java还有很长的路要走；目前，用Java构建应用程序的移动开发人员数量是Kotlin的两倍。

近段时间看到了DsoMusic开源音乐软件项目，从项目中看到了简洁的语法，强大的函数式编程等等思想，所以这段时间想学习一下Kotlin。

# Kotlin简介

## 由来

Kotlin是由JetBrains开发的针对JVM、Android和浏览器的静态编程语言，目前，在Apache组织的许可下已经开源。使用Kotlin，开发者可以很方便地开发移动Android应用、服务器程序和JavaScript程序。Kotlin可以将代码编译成Java字节码，也可以编译成JavaScript，方便在没有JVM的设备上运行。

Kotlin来源于一个岛屿的名字，全称是Kotlin Island，是英语【科特林岛】之意，这个小岛位于俄罗斯的圣彼得堡附近。之所以要命名为Kotlin，是因为Kotlin的主要开发工作就是由位于圣彼得堡分公司团队完成的。

在纯命令式编程时代，Sun公司创造了Java和标准库，但一直以来Sun都没有为Java提供一款好用的IDE。在这样的局面下，IBM适时地推出了一款名为Eclipse的IDE，成为对抗Sun公司的利器。

近十几年来，Eclipse凭借着开源和可扩展平台(OSGi)，战胜了一个又一个对手(JBuilder、NetBeans等)，奠定了Java标准开发环境的地位。然而，就像所有成功的产品一样，Eclipse一路荣光走来的同时也遇到了一系列的问题。所谓船大调头难，近年来，在JetBrains公司一系列产品的冲击下，Eclipse的市场份额正在慢慢下降。

作为目前广受欢迎的IDE提供商，JetBrains向开发者提供主流的软件开发环境：IntelliJ IDEA、WebStorm、PyCharm等，这些IDE几乎覆盖了目前主流的编程语言。

在开发Kotlin之前，JetBrains团队一直使用Java来创建他们的IDE以及使用Java进行业务逻辑开发。之所以开发Kotlin，是因为JetBrains 的工程师们在使用Java开发应用程序的过程中，发现了大量的问题。为了提升开发效率以及解决使用Java开发带来的问题，在借鉴了Scala、Groovy等语言后，他们决定开发一款致力于解决Java问题的编程语言Kotlin。

JetBrains深谙开发者的需求和痛处，在孜孜不倦地为开发者提供最实用、最高效的IDE的同时，也为开发者提供全新的编程语言以解决目前的技术问题。

## 发展

作为一门全新的编程语言，从项目创建到目前的1.2版本，Kotlin共经历了六年的发展。其发展历史大致如下。

- 2010年，JetBrains着手开发Kotlin项目。
- 2011年7月，JetBrains发布Kotlin项目。
- 2012年2月，JetBrains在Apache 2许可证下开源Kotlin项目源码。
- 2016年2月，JetBrains发布第一个稳定版本Kotlin 1.0，并许诺保持向后兼容。
- 2017年3月，Kotlin 1.1版本发布，正式支持JavaScript，并新增了诸多新功能和特性。
- 2017年5月，Google I/O大会上，Google官方确定支持Kotlin语言。
- 2017年11月，Kotlin 1.1.5发布，相比Kotlin1.0版本，Kotlin有关的代码数目从210万行飞升到1000多万行，对外提供的API也越来越多，使用场景也越来越多。
- 2017年12月，Kotlin 1.2版本发布，除了性能上的明显提升外，1.2版本最重要的特性就是增加了多平台代码重用的能力。

## 使用理由

如今，在软件开发领域，除了现在比较热门的人工智能技术和大数据技术之外，移动开发依然是受到大家关注的领域分支，而移动开发最重要的一门技术就是Android开发。Java作为Android开发的官方标准语言，其语法的设计思想还停留在纯命令式语言时代，在函数式语言的大背景下，Java显得有点落伍。虽然随着Java 8和Java 9版本的发布，Java也在向函数式语言靠近，但是Java8和Java9的市场份额并不高，好多的项目还停留在Java 6的时代。特别是对于Android开发者来说，想体验函数式编程的优势似乎太过遥远。所以，使用Kotlin成为最佳的选择。

作为一款明星语言，在被Android官方宣布为支持语言之前，Kotlin早已是Android开发中的热门话题了，很多开源的项目都使用用Kotlin开发。也正是基于这些原因，在今年的Google I/O大会上，Google将Kotlin列为Android开发的官方支持语言。在最近TIOBE的热门编程语言排行榜中，一度进入编程语言前50名，在Github上也获得了超过19K的Star。相信随着Kotlin版本的持续发布和性能的优化，Kotlin一定会走的更远。

在创造Kotlin语言的过程中，Kotlin从不少编程语言那里获得灵感，比如 Java、Scala、Groovy，可以说是博采众长。使用Kotlin编写的代码，不仅编译运行速度快，而且实现相同的功能代码量远远小于Java的实现。

使用Kotlin主要有以下优势：

### **跨平台开发能力**

因为Kotlin是基于JVM开发的，所以它同时具备了Android 开发、Web浏览器开发、原生Native开发的能力。在原生Native开发方面，目前Kotlin官方在Github上开源了Native的源码(Github地址：[https://github.com/JetBrains/](https://link.zhihu.com/?target=https%3A//github.com/JetBrains/)

kotlin-native)。在Web开发方面，Kotlin可以结合Spring框架使用，也可以编译生成JavaScript模块，方便在一些JavaScript的虚拟机上编译运行。

### **开源**

20世纪80年代，自由软件运动拉开序幕，开源软件为软件行业的快速发展提供了源源不断的动力。众人拾柴火焰高，对于一门新技术、新语言，开源可以更快速地发现Bug，从而利用开源的力量更快的推动新技术的发展。在开源领域方面，Java就是一个好例子，从语言标准，到Core API、虚拟机、开发者工具，这些都能找到开放的影子。

### **100%兼容Java**

Kotlin能够和Java达到100%互通，也就是说，使用Kotlin依旧可以调用 Java已有的代码或库，也可以同时使用Java和Kotlin来混合编写代码。同时，为了方便项目的过渡，JetBrains提供的开发工具可以很简单的实现Java代码到Kotlin的转换。

### **空指针安全**

在使用Java编程的过程中，大家聊得最多的话题莫过于如何避免空指针异常(NullPointerException)。针对空指针问题，Kotlin有专门的语法来避免空指针问题。

### **语言简洁，学习成本低**

Kotlin语法简洁直观，看上去非常像Scala，但更简单易学。同时，Kotlin使用了大量的语法糖，使得代码更加简洁。Kotlin并不遵循特定的编程规范，它借鉴了函数式风格和面向对象风格的诸多优点。

### **支持Lambda表达式**

函数式编程是软件技术的发展方向，而Lambda是函数式编程最基础的内容，因此，在最近的Java 8版本中，Java加入Lambda表达式本身是符合技术发展方向的。引入Lambda，最直观的一个改进是，不用再写大量的匿名内部类。事实上，还有更多由于函数式编程本身特性带来的性能。比如，代码的可读性会更好、高阶函数引入了函数组合的概念等。

除此之外，因为Lambda的引入，集合操作也得到了极大的改善。比如，引入stream API，把map、reduce、filter这样的基本函数式编程的概念与Java集合结合起来。在大多数情况下，Java程序员在处理集合时，可以告别繁杂的for、while、if等逻辑语句。

不过，使用Lambda表达式并非只有好处没有坏处，正如C#之父Anders Hejlsberg在《编程语言大趋势》一文中所说，未来的编程语言将逐渐融合各自的特性，而不会只存在单纯的声明式语言或者单纯的函数编程语言。

### **类型推断**

使用Kotlin编程，开发人员不必为每个变量明确指定类型，编译器可以在编译的时候推导出某个参数的数据类型，从而使得代码更为简洁。Java在最近的Java 8版本中也推出这一功能。

### **支持自定义的DSL**

DSL(Domain-Specific Language)，全称领域特定语言，指的是专注于特定问题领域的计算机语言。不同于通用的计算机语言(GPL)，领域特定语言只用在某些特定的领域。

DSL语言能让开发者以一种更优雅、更简洁的方式来表达和解决领域问题。例如，gradle就是一种用groovy定义的dsl。Kotlin的lambda系统使其成为创建DSL的理想选择。

### **IDE环境的支持**

作为JetBrains旗下的产品，JetBrains旗下众多的IDE可以为Kotlin开发提供无缝支持，并相互协作，协同发展。

正式因为Kotlin的这些优势，在今年的Google I/O大会上，Google将Kotlin列为Android开发的第一语言。在不久前旧金山举行的第一届Kotlin专题会议会议上，Kotlin官方宣布将会在1.2版本中添加支持iOS开发的功能。这难道是要成为全栈语言的节奏吗。

