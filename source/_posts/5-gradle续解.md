---
layout: pages
title: 5-gradle续解
date: 2021-09-30 08:22:49
categories: kotlin
top_img: https://gitee.com/tanzicai/drawingbed/raw/master/img/20210928172325.png
cover: https://gitee.com/tanzicai/drawingbed/raw/master/img/20210928172402.png
tags: 
  - Kotlin Web
  - kotlin app	
  - kotlin ganmes
---

## gradle依赖管理

接下来我们将通过一个小小的爬虫示例来示范如何通过gradle依赖管理进行开发，我们需要的准备工作如下

- 使用http-client3.1进行 爬取
- 下载所有的图片
- 图片地址为：[下载地址](https://scpic.chinaz.net/files/pic/pic9/202109/apic35376.jpg)

有了gradle依赖管理后，我们不需要在进行每个jar包的配置，只需要找的http-client的依赖就可以

> 问题:plugins:application报错,解决方法,重新新建工程,在建工程时必须勾选kotlin和java两个才能够自动导入application的模块,否则会报错
>
> ```kotlin
> plugins{
>     application
> }
> ```

> 问题:kotlin("jvm")报错,解决方法kotlin必须指定版本,例如像下面的方法一样
>
> ```kotlin
> kotlin("jvm")version("1.5.10")
> ```

那我们开始编写下载程序

```kotlin
fun main(args:Array<String>){
    var client = HttoClient()
   	var method = GetMethod("url")
    client.excecuteMethod(method)
    var responseBody  = method.getResponseBody()
    method.rleaseConnection()
    var file = File("1.jpg")
    file.writeBytes(responseBody)
}
```

> gradle报错
>
> ```
> Execution failed for task ':run'.
> Process 'command 'C:\Users\tanzicai\.jdks\azul-1.8.0_302\bin\java.exe'' finished with non-zero exit value 1
> * Try:
>   Run with --stacktrace option to get the stack trace. Run with --info or --debug option to get more log output. Run with --scan to get full insights.
> ```

**解决方法**:

点击左边的strackde右键rerun 'projectName'.run可以看到详细的报错信息

![image-20210930195008917](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210930195009.png)

```
> Task :run FAILED
错误: 找不到或无法加载主类  MainKt
```

这个错误是没有在这个文件中找到主函数,所以我们在Main.kt文件中写入主函数`main`就行

所以我们写入主函数就ok

```kotlin
fun main(args:Array<String>){
    var client = HttoClient()
   	var method = GetMethod("url")
    client.excecuteMethod(method)
    var responseBody  = method.getResponseBody()
    method.rleaseConnection()
    var file = File("1.jpg")
    file.writeBytes(responseBody)
}
```

## 依赖管理冲突

Boss: 我需要AB来干活

A:我需要1.0的版本C

B:我需要1.2的版本C

那Boss该去C的1.0还是1.2的版本呢?

这个就叫做冲突管理

我们可以使用exclude()关键字来剔除不需要的jar包

```kotlin
implementation("org.apache.httpcomponents","httpclient","4.5.2"){
		exclude("commons-loging","commons-loging")
}
```

