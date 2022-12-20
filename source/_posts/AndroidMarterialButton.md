---
layout: pages
title: AndroidMarterialButton
date: 2021-10-02 15:01:23
author: tanzicai
cover: https://gitee.com/tanzicai/drawingbed/raw/master/img/20211002153610.png
top_img: https://gitee.com/tanzicai/drawingbed/raw/master/img/20211002153629.png
categroies: kotlin
tags:
  - kotlin
  - MaterialButton
  - AndroidUI
---

# 前言

Android官方为开发者提供了许多丰富的UI控件，Material 组件就是包含了这些控件的一套工具，多数时候使用它可以满足我们日常开发UI的需求，提高效率。目前Android Material 组件已经更新了1.3.0稳定版，赶紧来了解一波。

导入依赖，就可以开始了。

```java
implementation 'com.google.android.material:material:1.3.0'
```

# MaterialButton

我们平时写布局，当遇到按钮需要圆角、或者描边等，通常的方法是新建一个xml文件，在shape标签下写，然后通过android:background或setBackground(drawable)设置。这本来没什么问题，但是UI设计师会喜欢看起来和别人不一样的效果，也许是为了审（zhuang）美（bi），例如这个页面用4dp的圆角，那个页面用10dp的圆角，要有描边，颜色还不太一样……如果我们每个界面都新建个xml写shape，那么后期项目大了，维护起来就像无底洞……那么有没有这样一个控件，能在xml直接配置圆角、描边属性，满足平时开发的基本UI需求？当然有，GitHub上第三方的库大把。

不过Google官方在SDK28的时候也推出了一个新控件 —— [**MaterialButton**](https://developer.android.google.cn/reference/com/google/android/material/button/MaterialButton)，但是我发现很多人还不知道，今天就来安利下。
先来看一波效果图：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200828153413660.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21hZ2ljMDkwOA==,size_16,color_FFFFFF,t_70#pic_center)

![按压水波纹，支持设置波纹颜色](https://img-blog.csdnimg.cn/20190921175702727.png)
按压水波纹，支持设置波纹颜色。

MaterialButton继承AppCompatButton，在原来Button的基础上做了一些扩展，如圆角、描边、前置和后置icon（icon支持设置Size、Tint、Padding、Gravity等），还支持按压水波纹并且设置color，基本能满足日常的需求。

公开属性如下：

| 属性                   | 描述                 |
| ---------------------- | -------------------- |
| app:backgroundTint     | 背景着色             |
| app:backgroundTintMode | 着色模式             |
| app:strokeColor        | 描边颜色             |
| app:strokeWidth        | 描边宽度             |
| app:cornerRadius       | 圆角大小             |
| app:rippleColor        | 按压水波纹颜色       |
| app:icon               | 图标icon             |
| app:iconSize           | 图标大小             |
| app:iconGravity        | 图标重心             |
| app:iconTint           | 图标着色             |
| app:iconTintMode       | 图标着色模式         |
| app:iconPadding        | 图标和文本之间的间距 |

## 关于background

在1.2版本以前，MaterialButton只能通过app:backgroundTint属性设置背景色，该属性接收color state list。不能通过android:background设置自定义drawable。
1.2版本后，官方已修复此问题。如果未设置自定义背景，则 MaterialShapeDrawable 仍将用作默认背景。
也就是说，如果按钮背景是纯色，可以通过app:backgroundTint指定；如果按钮背景是渐变色，则需要自己定义drawable，然后通过android:background设置。

注意：如果要使用android:background设置背景，则需要将backgroundTint设置为@empty，否则background不会生效。

```xml
<com.google.android.material.button.MaterialButton
    android:background=”@drawable/custom_background”
    app:backgroundTint=”@empty” />
123
```

指定@empty后，Android Studio会出现红色警告，可以正常运行，忽略就好。不过既然已经自定义drawable，就没必要使用MaterialButton，直接用普通的Button甚至用TextView就好了。

## 关于insetTop、insetBottom

看下面的代码：

```xml
<com.google.android.material.button.MaterialButton
	android:id="@+id/btn1"
    android:layout_width="150dp"
    android:layout_height="50dp"
    android:textColor="@android:color/white"
    android:textSize="18sp"
/>
1234567
```

xml预览图：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190921163120853.png)
有没有感觉怪怪的？貌似button上下多了一个padding！咦！代码里面明明没有设置padding啊！看了源码发现，MaterialButton默认在style指定了insetTop和insetBottom为6dp，使得height看起来并没有Button实际设置值一样高，可以在xml将MaterialButton的insetTop和insetBottom都设置为0dp，这样MaterialButton的高度就和实际设置的高度一致了。

## 关于阴影

MD组件默认都是自带阴影的，MaterialButton也不例外。但是有时候我们并不想要按钮有阴影，那么这时候可以指定style为
style="@style/Widget.MaterialComponents.Button.UnelevatedButton"，这样就能去掉阴影，让视图看起来扁平化。

## 关于theme

在MDC1.1.0以后，使用MaterialButton可能会出现闪退的问题，原因就是使用了MD控件，但是未将them设置为MaterialComponents。解决方法可以有几种：
先在style.xml自定义MaterialComponents_Theme

```xml
 <style name="MaterialComponents_Theme" parent="Theme.MaterialComponents.Light.NoActionBar">
        <!-- Customize your theme here. -->
        ...
    </style>
1234
```

**方法一：**
AndroidManifest里application节点下配置，作用域为整个应用

```xml
<application
        ...
        android:theme="@style/MaterialComponents_Theme"
123
```

**方法二：**
只在当前activity配置，作用域为当前activity

```xml
<activity
        ...
        android:theme="@style/MaterialComponents_Theme"
123
```

**方法三：**
为每个在使用到MD控件的地方配置，作用域只针对当前控件

```xml
<com.google.android.material.button.MaterialButton
	...
    android:theme="@style/Theme.MaterialComponents.Light.NoActionBar" />
123
```

## 关于在Android Studio中预览

如下代码

```xml
<com.google.android.material.button.MaterialButton
        android:id="@+id/btn_send"
        style="@style/Widget.MaterialComponents.Button.UnelevatedButton"
        android:layout_width="@dimen/dp_80"
        android:layout_height="@dimen/dp_30"
        android:layout_marginStart="@dimen/dp_12"
        android:insetTop="0dp"
        android:insetBottom="0dp"
        android:padding="0dp"
        android:text="@string/dispatch_room_text_upper_mic"
        android:textColor="@color/white"
        android:textSize="@dimen/font_12"
        app:backgroundTint="@color/c_6D56FF"
        app:cornerRadius="@dimen/dp_15"
        app:layout_constraintBottom_toBottomOf="@id/iv_head"
        app:layout_constraintStart_toEndOf="@id/iv_head" />
12345678910111213141516
```

xml预览
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200901103420345.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21hZ2ljMDkwOA==,size_16,color_FFFFFF,t_70#pic_center)
可以看到xml预览效果和代码是不匹配的，这时候可以将预览的主题指定为MaterialComponents
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200901103612600.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21hZ2ljMDkwOA==,size_16,color_FFFFFF,t_70#pic_center)
这样效果就和xml代码一致了
![在这里插入图片描述](https://img-blog.csdnimg.cn/2020090110365721.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21hZ2ljMDkwOA==,size_16,color_FFFFFF,t_70#pic_center)

# ShapeableImageView

来波效果图：
![在这里插入图片描述](https://gitee.com/tanzicai/drawingbed/raw/master/img/20211002150316.png)
以往我们实现图片圆角、描边等需求，多数时候是使用第三方或者自定义，Glide也有个扩展库，能很轻松帮我们实现。不过在MDC1.2.0中，已经有了一套官方的实现方案。那就是ShapeableImageView。
ShapeableImageView继承自ImageView，可以为image添加描边大小、颜色，以及圆角、裁切等，这得益于它新增了一个属性shapeAppearance，具体实现在ShapeAppearanceModel，可以通过style来配置，也可以通过代码实现。

## style配置：

```xml
<style name="StyleShapeAppearanceImage" parent="">
    <item name="cornerFamily">rounded</item>
    <item name="cornerSize">16dp</item>
    <item name="cornerSizeTopRight">10dp</item>
    <item name="cornerSizeBottomRight">0dp</item>
</style>
  ...
<com.google.android.material.imageview.ShapeableImageView
    app:shapeAppearance="@style/StyleShapeAppearanceImage"
    ...
    />
1234567891011
```

## 代码设置：

```java
imageView?.shapeAppearanceModel = ShapeAppearanceModel.builder()
            .setAllCorners(CornerFamily.ROUNDED,20f)
            .setTopLeftCorner(CornerFamily.CUT,RelativeCornerSize(0.3f))
            .setTopRightCorner(CornerFamily.CUT,RelativeCornerSize(0.3f))
            .setBottomRightCorner(CornerFamily.CUT,RelativeCornerSize(0.3f))
            .setBottomLeftCorner(CornerFamily.CUT,RelativeCornerSize(0.3f))
            .setAllCornerSizes(ShapeAppearanceModel.PILL)
            .setTopLeftCornerSize(20f)
            .setTopRightCornerSize(RelativeCornerSize(0.5f))
            .setBottomLeftCornerSize(10f)
            .setBottomRightCornerSize(AbsoluteCornerSize(30f))
            .build()
123456789101112
```

代码接收一个ShapeAppearanceModel，通过构建者模式实现，setTopLeft表示处理左上角，其他同理。
cornerSize表示设置的大小，有RelativeCornerSize和AbsoluteCornerSize，RelativeCornerSize构造方法接收一个百分比，范围0-1；AbsoluteCornerSize构造方法接收一个具体数值，这个数值就是圆角的数值。
这里还有个CornerFamily，它表示处理的方式，有ROUNDED和CUT两种，ROUNDED是圆角，CUT是直接将圆角部分裁切掉。setAllCornerSizes(ShapeAppearanceModel.PILL)可以直接实现圆形效果。

## 关于Stroke

ShapeableImageView指定strokeWidth描边的时候，其描边会被覆盖掉一半，如strokeWidth=4dp，上下左右会被覆盖，实际的效果是只有2dp被显示。如图，
![在这里插入图片描述](https://gitee.com/tanzicai/drawingbed/raw/master/img/20211002150316.png)
github有人反馈了类似问题，[点我跳转](https://github.com/material-components/material-components-android/issues/1489)，我的处理方法是在设置了strokeWidth的同时，设置相应的pading，这样描边就不会被覆盖了。

```xml
<com.google.android.material.imageview.ShapeableImageView
		...
        app:strokeWidth="4dp"
        android:padding="4dp"
1234
```

# Slider（加强版的SeekBar）

效果图：
![在这里插入图片描述](https://gitee.com/tanzicai/drawingbed/raw/master/img/20211002150316.png)
![在这里插入图片描述](https://gitee.com/tanzicai/drawingbed/raw/master/img/20211002150316.png)
Slider的父类BaseSlider，直接继承View，重新实现逻辑。此外BaseSlider还有个子类RangeSlider，用它来实现图1效果2
Slider可以实现滑块头部数字变化效果，还可以实现类似刻度尺效果，比原生的SeekBar加强了不少。
常用属性如下：

| 属性              | 描述                              |
| ----------------- | --------------------------------- |
| android:valueFrom | 进度起点                          |
| android:valueTo   | 进度终点                          |
| android:value     | 当前进度点                        |
| android:stepSize  | 步长（必须大于0）                 |
| app:values        | 配置多个slider节点                |
| app:labelBehavior | slider 滑动时顶部是否显示变化效果 |
| app:labelStyle    | 配置slider节点顶部view style      |

其他属性还有haloColor、haloRadius、thumbColor等，用来配置一些外观

# BottomNavigationView

![在这里插入图片描述](https://gitee.com/tanzicai/drawingbed/raw/master/img/20211002150316.png)
BottomNavigationView相比之前要完善了很多，可以设置icon大小，添加红点和未读消息数，以及超过3个item，切换效果也不会出现问题，通过LabelVisibilityMode.LABEL_VISIBILITY_LABELED指定。

以上主要列举了几个常用的控件，基本可以满足一些UI开发了，更多关于MDC的内容，大家可以到github去
