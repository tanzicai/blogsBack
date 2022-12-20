---
layout: pages
title: Web概况知识
date: 2021-04-04 23:51:01
top: fause
cover: fause
categories: 前端
tags:

  - 前端
  - HTML
  - 复习

---
# Web运行原理
原视频地址:https://www.bilibili.com/video/BV11p4y1H7eu
视频作者:奇乐编程学院
## Wen过程原理图

```sequence
人->浏览器:输入网址
浏览器->服务器: 发送http请求
服务器->浏览器: 根据请求返回对应类型文件(html)
```
![image-20210406134915633](https://i.loli.net/2021/04/06/Tzf1pVXk8cChIuj.png)

## HTML

1. HTML文件一般由`head`标签、`body标签`组成，`head`头标签一般表明文档结构的相关属性。

   ![image-20210406134950679](https://i.loli.net/2021/04/06/YXLKa7km48gQUV1.png)

2. `body`内容标签一般用来放网页的具体内容，其内还包括`\<h\>`、`\<p\>`、`\<img\>`等众多内容标签组成。

3. HTML5还提供了对原生浏览器的支持。除此之外，HTML还有例如Canvas、WebGL这些图形API的支持，通过他们我们可以在浏览器中实现一些三维游戏。

   ![image-20210406222345883](https://i.loli.net/2021/04/06/BNdwIsnbyUlgtqa.png)



## CSS层叠样式表

1. 使用样式选择器来指定css修饰的对象，然后通过css的固定属性来修饰相关的html元素的样式。例如字体的大小、字体、边框、字间距、行间距等，

   ![image-20210406222445187](https://i.loli.net/2021/04/06/Az2j7YgCUsHf4tE.png)

2. 在实际开发过程中，我们一般不需要自己写过多的css代码，我们一般选择现成的CSS框架，例如`Bootstrap`（实现移动端有好的相应布局）、`Materialize`（实现统一的`materialize`界面风格）、`Pure`（轻量框架）。

   ![image-20210406222500636](https://i.loli.net/2021/04/06/DANsvcMdCKzO42b.png)
   
   ![image-20210406233855944](https://i.loli.net/2021/04/06/QgXcwb8ofDY9FAx.png)
   
   ![image-20210406222831002](https://i.loli.net/2021/04/06/vsrLzfmpA1YX5iQ.png)


3. 除此之外，CSS还提供原生的补间动画支持，例如我们使用`animation`来定义使用动画的种类和时长、使用`@keyframes`定义动画中所用到的所有关键帧。

   ![](https://i.loli.net/2021/04/06/4tmTuRcECN7kznQ.png)

3. `CSS3`中加入了`FLexBox`（弹性盒布局）原生实现导航栏等类似效果

   ![image-20210406234002584](https://i.loli.net/2021/04/06/rFkxfngWms2XztG.png)

## Javascript （页面的脚本语言之一）
1. 使用`DOM`树修改`HTML`文档内容\

   ![image-20210406234101303](https://i.loli.net/2021/04/06/G5mvKD76qrhwSU3.png)

2. 使用`Javascript`对鼠标键盘事件做出响应

   ![image-20210406234131293](https://i.loli.net/2021/04/06/vsw8GMmRrEDijq5.png)

3. 请求远程服务器数据XHR`、`AJAX`（根据需要向服务器请求数据，根性页面数据）

   ![image-20210406234206012](https://i.loli.net/2021/04/06/8tRNv7XEgMC2OYn.png)

4. 利用`Javascript`，通过`WebSocket`、`WebRTC`代替HTTP请求，用于实现更低时延的网络通信，一般用作即时聊天、在线游戏等

5. 通过`WebGL`，实现在线的实时图像渲染

   ![](https://i.loli.net/2021/04/06/BM4cFAsqzGxD1I7.png)

## TypeScript （Javascript的一个超集）
1. 为`Javascript`中的每个对象加入了可选的类型标注，可以在编译时做到类型的检查，减少程序错误

   ![](https://i.loli.net/2021/04/06/i76GLNrEmZIA8sb.png)

## NOde（服务端Javascript）
1. 用处：
	1. 编写控制台程序
	
	   ![image-20210406234358503](https://i.loli.net/2021/04/06/7EoMCQLOwbg9csR.png)
	
	2. 原生桌面应用
	
	3. 服务器程序
	
	4. ·····
	
2. `npm`：可以使用`npm`安装第三方库

   ![image-20210406234431388](https://i.loli.net/2021/04/06/ogMrSOL4lfkAJUs.png)

## React、Angular、Vue（前端框架）
1. 界面元素组件化，提高代码复用

   ![](https://i.loli.net/2021/04/06/wVh2gdMJQjWS5ot.png)

## 后端
1. 后端主要是响应前端的请求，并向前端提供数据。

2. 现代Web主要使用`API`(应用程序接口)通信

3. API：预先商定好的通信协议或者数据模式

   ![](https://i.loli.net/2021/04/05/V9pSN6aTxRH7Yyk.png)

4. 通过`API`实现前后端逻辑的完全分离，同时android、ios可以复用API

   ![](https://i.loli.net/2021/04/05/yQOBoG51w7r48VP.png)

## API架构

1. REST架构：根据不同的HTTP请求类型对数据做对应的增删改查操作

   ![image-20210405010002813](https://i.loli.net/2021/04/05/IFeC4O3EVMtQpuR.png)

   ![image-20210405010052083](https://i.loli.net/2021/04/05/C8MdQLo6ckfzqIg.png)

2. `GraphQL`架构：比`REST`架构的灵活性和可扩展性高出很多，适合大型项目的API设计

   ![image-20210405010551659](https://i.loli.net/2021/04/05/bym6Xwse8lhZRQj.png)

## 数据库管理系统

1. 需求：大规模的对数据进行并发的读取和修改,坚固数据的完整性和安全性.

$$数据库\begin{cases}SQL\\NoSQL \end{cases}$$

2. SQL: 关系型数据库,能够使用结构化查询语言(SQL)对数据进行查询和修改

   ![image-20210405011558540](https://i.loli.net/2021/04/05/ltNyK753YcdVihD.png)
   
3. NoSQL:非关系型数据库,减少了许多强制性的检查，拥有更优的读写性能，对数据的格式要求更
加松散

4. 入门选择：推荐`PostgreSQL`和`MongoDB`

5. 使用示例
	使用Javascript对MongoDB数据进行访问
   ![image-20210405012203891](https://i.loli.net/2021/04/05/N8b3AOKQuxeinoW.png)

![image-20210405013903800](https://i.loli.net/2021/04/05/NjbGwMnrUPBs3zl.png)

## DevOps(开发+运维）

1. 主要工作内容：部署应用程序运行到最终的服务器并让所有人访问



## MERN技术栈

分别是

![image-20210406234734324](https://i.loli.net/2021/04/06/WK63v9rESPDuFNf.png)

1. 数据库：MongoDB
2. 后端服务器框架：Express
3. 前端框架：Ract
4. 服务器运行环境：Node

## Web开发资源

1. Web开发路线图：https://github.com/ccloli/developer-roadmap-zh-CN
2. 现代Web开发魔法全书：https://github.com/dexteryy/spellbook-of-modern-webdev
3. 成为Web全栈工程师：https://github.com/bmorelli25/Beome-A-Full-Stack-Web-Developer
4.  Awesome列表系列：https://github.com/sindresorhus/awesome



