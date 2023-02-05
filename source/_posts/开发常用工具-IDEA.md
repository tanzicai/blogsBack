---
layout: pages
title: 开发常用工具-IDEA
date: 2023-02-01 15:51:06
tags:
---

## 插件

> IDEA插件推荐

### Maven Helper

![Maven Helper](https://raw.githubusercontent.com/tanzicai/OSS_IMG/main/img/202302011552593.png)

#### 作用

+ 分析和排除冲突依赖关系的简单方法
+ 为包含当前文件的模块或根模块运行/调试maven目标的操作
+ 操作以在当前maven模块路径上打开终端
+ 运行/调试当前测试文件的操作。

#### 用法

+ 右键单击编辑器|运行Maven
+ 右键单击项目视图工具栏|(运行|调试)Maven
+ CTRL + ALT + R -“运行Maven目标”弹出(你可以使用删除键弹出)
+ CTRL + SHIFT + ALT + R -“在根模块上运行Maven目标”弹出(你可以在弹出框中使用删除键)
+ 自定义目标:设置|其他设置| Maven Helper
+ 定义快捷方式:设置| Keymap |插件| Maven Helper
+ 打开pom文件，单击“Dependency Analyzer”选项卡，右键单击树进行上下文操作。
