---
layout: pages
title: 4-kotlinGradle
date: 2021-09-28 15:51:13
categories: kotlin
top_img: https://gitee.com/tanzicai/drawingbed/raw/master/img/20210928172325.png
cover: https://gitee.com/tanzicai/drawingbed/raw/master/img/20210928172402.png
tags: 
  - Kotlin Web
  - kotlin app	
  - kotlin ganmes
---

# 原始开发流程TDD

对于基本开发流程，主要是

+ 编译
+ 测试
+ 手动以来管理
+ 打包
+ 上传服务器

## 基本开发流程

编译主类

```java
public class Girl {
    public String greeting(){
        return "hello";
    }
}
```

编写测试类

```java
import org.*;

public class TestGril {
    public void sayGreeting(){
        Girl girl = new Girl();
        String actual = girl.greeting();
        Assert.assertEquals("hello",actual)
    }
}

```

编写主函数类

```java
public class Main {
    public static void main(String[] args) {
        Girl girl = new Girl();
        girl.greeting();
    }
}
```

然后到处jar包，同时写一个批处理文件,satrt.bat

```bash
java -cp greting.jar Main
```

然后双颊start.bat开始运行

## 自动化构建工具

+ Ant
+ Maven
+ Gradle

| 工具名称 | 功能                                  |
| -------- | ------------------------------------- |
| Ant      | 编译测试                              |
| Maven    | 编译测试、依赖管理                    |
| Gradle   | 编译测试、依赖管理、DSL自定义拓展任务 |

## Gradle

+ 可以使用kotlin代码控制的一种智能的自动化构建工具
+ 用代码来控制工具
+ 不是xml配置
+ 可以构造所有语言种类

![image-20210928172249763](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210928172256.png)

# Gradle

## 安装Gradle

> gradle官网:[gradle生成工具 (gradle.org)](https://gradle.org/)

> 需要java环境支持，最低版本jdk1.8

安装后需要添加环境变量（Path -- > Gradle/bin），具体自行搜索环境变量添加步骤。

然后测试如下就代表安装成功

![image-20210928193407035](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210928193507.png)

## 快读入门

先创建Gradle工程，我们可以在其中编写kotlin代码和java代码等

这一步全是辛酸历程，当前gradle版本已经到了7.2，但是我使用的教程还停留在4.0，而且许多语法已经弃用，替换成了新的语法写法。如果你要参考下面的代码，请先确定自己的gradle版本是4.0左右。如果无法确定或者不知道怎么更该gradle版本的话，请往下看

首先打开gradle官网，我们需要下载[gradle-4.10](https://gradle.org/releases/)

![image-20210929171955956](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210929172016.png)

然后把下载的文件放在一个安全不容易被删除的目录并记录下当前的路径

![image-20210929172200632](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210929172200.png)

然后在gardle生成的文件夹中`gradle-wallpaper.properties`文件中修改`distributionUrl`地址换成自己刚刚复制的地址

> 注意：由于是在windows系统下，目录路径中所有的右斜杠需要换成左斜杠，否则找不到文件。

```properties
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
distributionUrl=file\:///C:/Users/tanzicai/.gradle/wrapper/dists/gradle-4.10.2-all.zip
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists
```

然后把`build.gradle`修改成`build.gradle.kts`并删除其中的所有代码添加以下代码

```kotlin
plugins{
    application
    kotlin("jvm") version "1.4.30"
}

group = "org.example"
version = "1.0-SNAPSHOT"

application{
    mainClassName = "Hello"
}

dependencies{
    implementation(kotlin("stdlib"))
}

repositories{
    jcenter()
}
```

然后就可以创建出`src`文件夹并在其中编程自己的代码了。

![image-20210929172715781](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210929172715.png)

## gradle的project和task

### task编写

在`build.gardle.kts`中我们可以编写自己需要的任务，

```kotlin
task("hello",{
    print("hello,successful")
})
```

### task依赖

我们在执行一个任务之前必须先执行另一个任务的这个过程就叫做依赖，我们可以使用`.depensON()`来确定我们任务执行的依赖，写法如下

```kotlin
task("openDoor",{
    print("打开门")
})

task("put",{
    print("放大像")
}).dependsOn("openDoor")

task("closeDoor",{
    print("关门")
}).dependsOn("put")
```

我们在运行closeDoor任务的时候，`build`执行如下

```groovy
17:49:10: Executing task 'closeDoor'...

> Task :openDoor UP-TO-DATE
> Task :put UP-TO-DATE
> Task :closeDoor UP-TO-DATE

BUILD SUCCESSFUL in 169ms
```



### task任务的生命周期

task周期有两个

+ 扫描
+ 执行

task任务生命周期中的扫描是在`gradle build`的时候先对`build.gradle.kts`进行扫描，包括task名和闭包里面的内容，那我们需要的是在task执行的时候在运行我们的任务，而不是在扫描的时候就执行一遍，那么我们就需要通过`doFirst`和`doLast`来完成相应的需求了

```kotlin
task("openDoor",{
    doFirst{
        println("打开门")
 }})

task("put",{
    doFirst{
         println("放大像")
    }

}).dependsOn("openDoor")

task("closeDoor",{
    doFirst{
        println("关门")
    }

}).dependsOn("put")
```

这样在刷新的时候就不会执行了

```groovy
> Task :prepareKotlinBuildScriptModel UP-TO-DATE

BUILD SUCCESSFUL in 1s

```

在我们运行指定task时，就可以正常执行了

```groovy
PS C:\Users\tanzicai\IdeaProjects\testTask> gradle  closeDoor

> Configure project :
打开门
放大像
关门

BUILD SUCCESSFUL in 2s
```

即我们在task中的时间周期是这样的

```kotlin
task(Name,{
    code:扫描时执行
    doFirst{
        code:在运行时执行
    }
    doLast{
        code:运行时执行
    }
})
```

### gradle任务集

`tasks`:多个任务集合就是任务集

写法如下：

```kotlin
task{
    "task1Name"{
        
    }
    "task2Name"{
        
    }
    "task3Name"{
        
    }.dependsOn("dependsOnTaskName")
}
```

### gradle

`garadle`	由很多默认的方法和属性，这些属性我们在有些特定的开发时会进行修改，那么我我们需要看一看project究竟有哪些属性

```
parent-- null

classLoaderScope-- org.gradle.api.internal.initialization.DefaultClassLoaderScope@59171861

buildDir-- C:\Users\tanzicai\IdeaProjects\testTask\build
configurations-- configuration container

plugins-- [org.gradle.api.plugins.HelpTasksPlugin@28b86f00, org.gradle.kotlin.dsl.provider.plugins.KotlinScriptRootPlugin@449f900e, org.gradle.kotlin.dsl.provider.plugins.KotlinScriptBasePlugin@5a09c5e8]

scriptHandlerFactory-- org.gradle.api.internal.initialization.DefaultScriptHandlerFactory@7dba08e4

objects-- org.gradle.api.internal.model.DefaultObjectFactory@1611b83c

logger-- org.gradle.internal.logging.slf4j.OutputEventListenerBackedLogger@3d564c16
deferredProjectConfiguration-- org.gradle.api.internal.project.DeferredProjectConfiguration@2eb65510

rootDir-- C:\Users\tanzicai\IdeaProjects\testTask

project-- root project 'testTask'

projectRegistry-- org.gradle.api.internal.project.DefaultProjectRegistry@3a84f3ab

path-- :

normalization-- 

org.gradle.normalization.internal.DefaultInputNormalizationHandler_Decorated@17542137
repositories-- repository container

childProjects-- {}

scriptPluginFactory-- org.gradle.configuration.ScriptPluginFactorySelector@c9fabb9
state-- project state 'EXECUTING'

resourceLoader-- org.gradle.internal.resource.transfer.DefaultUriTextResourceLoader@101d61ef

serviceRegistryFactory-- org.gradle.internal.service.scopes.ProjectScopeServices$4@d19c1ec

tasks-- task set

org.gradle.kotlin.dsl.accessors.MultiProjectSchemaSnapshot-- MultiProjectSchemaSnapshot(schema=null)

group--

artifacts-- org.gradle.api.internal.artifacts.dsl.DefaultArtifactHandler_Decorated@3bf214e1

ext-- org.gradle.api.internal.plugins.DefaultExtraPropertiesExtension@4ac1b245

projectDir-- C:\Users\tanzicai\IdeaProjects\testTask

dependencyLocking-- org.gradle.internal.locking.DefaultDependencyLockingHandler_Decorated@31a8a0eb

configurationTargetIdentifier-- org.gradle.configuration.ConfigurationTargetIdentifier$1@72fd0193

projectEvaluationBroadcaster-- ProjectEvaluationListener broadcast

projectPath-- :
module-- org.gradle.api.internal.artifacts.ProjectBackedModule@26402a9f

inheritedScope-- org.gradle.api.internal.ExtensibleDynamicObject$InheritedDynamicObject@59035631
version-- unspecified
script-- false
dependencies-- org.gradle.api.internal.artifacts.dsl.dependencies.DefaultDependencyHandler_Decorated@1e9794ce
fileResolver-- org.gradle.api.internal.file.BaseDirFileResolver@6accd00f
extensions-- org.gradle.api.internal.plugins.DefaultConvention@7027b55c
modelRegistry-- org.gradle.model.internal.registry.DefaultModelRegistry@33d6d7b7
projectEvaluator-- org.gradle.configuration.project.LifecycleProjectEvaluator@11c504e7
projectConfigurator-- org.gradle.api.internal.project.BuildOperationCrossProjectConfigurator@1d85e278
name-- testTask
logging-- org.gradle.internal.logging.services.DefaultLoggingManager@504539c1
configurationActions-- org.gradle.configuration.project.DefaultProjectConfigurationActionContainer@55ab3711
buildscript-- org.gradle.api.internal.initialization.DefaultScriptHandler@6c70f37f
status-- release
processOperations-- org.gradle.api.internal.file.DefaultFileOperations@5ed45aab
subprojects-- []
components-- SoftwareComponentInternal set
asDynamicObject-- DynamicObject for root project 'testTask'
printProject-- task ':printProject'
displayName-- root project 'testTask'
identityPath-- :
parentIdentifier-- null
description-- null
antBuilderFactory-- org.gradle.api.internal.project.DefaultAntBuilderFactory@2726fb81
buildPath-- :
fileOperations-- org.gradle.api.internal.file.DefaultFileOperations@5ed45aab
pluginManager-- org.gradle.api.internal.plugins.DefaultPluginManager_Decorated@2bb943cb
standardOutputCapture-- org.gradle.internal.logging.services.DefaultLoggingManager@504539c1
defaultTasks-- []

```

### gradle增量式更新

前面我们说过gradle的打包速度明显快于`maven`，那么为什么会这样呢？

其实呀，这就来源于gradle的增量式更新的方法，gradle支持只更新更改过的文件

在`gradle`中我们需要手动添加代码完成增量式更新

+ inputs.dir()
+ outputs.dir()
+ outputs.file()
+ inputs.file()

这四个函数就是完成增量式更新的

```kotlin
plugins{
    java
}

task("getClassName",{
//    inputs.dir("src")
//    outputs.file("info.txt")
    doFirst{
        var srcdir = fileTree("src")
        var infotxt = file("info.txt")
        infotxt.writeText("")
        srcdir.forEach{
            if(it.isFile){
                Thread.sleep(1000)
                infotxt.appendText(it.absolutePath)
                infotxt.appendText("\r\b")
            }
        }

    }
})
```

我们使用了以上代码来读取我们目录中的所有文件的绝对路径，并记录在`info.txt`文件中。我们通过时间来判断是否上述代码起了作用。

+ 没有增量式代码时:

我们跑了两次代码，每次均需要4s左右时间跑完代码

```
BUILD SUCCESSFUL in 4s
1 actionable task: 1 executed
PS C:\Users\tanzicai\IdeaProjects\testTask> gradle getClassName

BUILD SUCCESSFUL in 4s
1 actionable task: 1 executed
PS C:\Users\tanzicai\IdeaProjects\testTask>

```

+ 加上增量式代码

我们加上增量式代码后发现速度确实有提升

```
BUILD SUCCESSFUL in 4s
1 actionable task: 1 executed
PS C:\Users\tanzicai\IdeaProjects\testTask> gradle getClassName

BUILD SUCCESSFUL in 2s
1 actionable task: 1 up-to-date
PS C:\Users\tanzicai\IdeaProjects\testTask> gradle getClassName

```

原理就是这两句代码会在运行时判断现在的内容是是不是和上次的内容一样，如果一样的话就不会在跑一边，有删改的话只跑删改的部分，而不全部跑完。以此来达到增加编译速度的目的。

### gradle插件

插件：`gradle`插件是包含一个或者多个任务的合集

官网插件仓库[插件商店](plugins.gradle.org)

+ java ：打包java
+ application ：打包java或者kotlin
+ war ：打包javaee项目，放在concat运行



