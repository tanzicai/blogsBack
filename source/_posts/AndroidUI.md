---
layout: pages
title: AndroidUI
date: 2021-10-02 13:24:39
cover: https://gitee.com/tanzicai/drawingbed/raw/master/img/20211002145805.png
top_img: https://gitee.com/tanzicai/drawingbed/raw/master/img/20211002145846.png
categroies: kotlin
tags:
  - kotlin
  - UI
  - 布局
---

# Android常用的基础布局容器

Android 的UI 可以分为两类，一类叫做ViewGroup容器,一类叫做View视图

View视图：(TextView,Button,ImageView)都是常用常见的视图.

ViewGroup容器：内部可以承载、放置、添加View视图

## 基础布局容器

- **LinearLayout线性布局**:横着或竖着按顺序排列
- **RelativeLayout相对布局**:起始坐标时屏幕坐上角，以同级或上级为参考系定位位置
- **FrameLayout帧布局**:像千层饼一样，一层压着一层
- **ConstraintLayout约束布局**:google于2016年新发布的一种布局方式，它不在android的基础api包里，需要额外引入
- ~~AbsoluteLayout~~绝对布局（以屏幕左上角为参考系，定位自己的位置，从android 2.2版本后废弃）
- ~~GridLayout~~网格布局（可以指定行数列数，子控件自动根据行列数进行分配位置，于android 4.0后新增进api中）
- ~~TableLayout~~表格布局（类似于网格布局，以一个TableRow标签定义为一行或一列）

### 线性布局LinearLayout

![img](https://gitee.com/tanzicai/drawingbed/raw/master/img/20211002134003.webp)

线性布局就是**从左到右**或**从上到下**按**顺序排列**的一种布局。下面讲一讲LinearLayout的基础属性。

![img](https://gitee.com/tanzicai/drawingbed/raw/master/img/20211002133710.webp)

### 部分属性

内部控件排列方式:`android:orientation`,`vertical`:`垂直`,`horizontal`:水平

背景颜色设置:`android:background="#fff000"`,android:background:`@color/black`

内部文件相对位置:`android:gravity="center"`

相对于父控件的相对位置:`android:layout_gravity="end"`

子控件背景颜色:`android:backgroundTint="#ff1111"`background无效

子控件分配比例:`android:layout_weight="1"`除了设置了宽高的,其他的按比例分配



### 效果展示

- android:orientation ="vertical"所有子视图纵向摆放

![img](https://gitee.com/tanzicai/drawingbed/raw/master/img/20211002134257.webp)



```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:gravity="center"          //子视图相对父视图居中显示
    android:orientation="vertical">   //所有子视图纵向摆放

    <Button
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="普通按钮" />

    <Button
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="普通按钮" />

    <Button
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="普通按钮" />

    <Button
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="普通按钮" />

</LinearLayout>
```

- android:orientation ="horizontal"所有子视图横向摆放

![img](https://gitee.com/tanzicai/drawingbed/raw/master/img/20211002133710.webp)



```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:gravity="center"            //子视图相对父视图居中显示
    android:orientation="horizontal">   //所有子视图横向摆放
     .........  省略
</LinearLayout>
```

## 相对布局RelativeLayout

相对布局在摆放子视图位置时，按照**指定的参考系**来摆放子视图的位置，**默认以屏幕左上角(0,0)位置**作为**参考系**摆放位置

- **相对于父元素 **7个常用属性

| 属性                     | 可选值     | 说明                               |
| ------------------------ | ---------- | ---------------------------------- |
| layout_alignParentTop    | true/false | 是否让控件**相对于父容器顶部**对齐 |
| layout_alignParentBottom | true/false | 是否让控件**相对于父容器底部**对齐 |
| layout_alignParentLeft   | true/false | 是否让控件**相对于父容器左边**对齐 |
| layout_alignParentRight  | true/false | 是否让控件**相对于父容器右边**对齐 |
| layout_centerHorizontal  | true/false | 相对父容器水平居中显示             |
| layout_centerVertical    | true/false | 相对父容器垂直居中显示             |
| centerInParent           | true/false | 相对父容器居中显示                 |

- **相对于兄弟元素 **4个常用属性

| 属性                     | 可选值 | 说明                     |
| ------------------------ | ------ | ------------------------ |
| layout_above             | @+id/  | 指定在那个控件的**上侧** |
| layout_below             | @+id/  | 指定在那个控件的**下侧** |
| android:layout_toLeftOf  | @+id/  | 指定在那个控件的**左侧** |
| android:layout_toRightOf | @+id/  | 指定在那个控件的**右侧** |

- **相对于兄弟元素的对齐方式**

| 属性               | 可选值 | 说明                                         |
| ------------------ | ------ | -------------------------------------------- |
| layout_alignLeft   | @+id/  | 该控件的**左边沿**与指定控件的**左边对齐**   |
| layout_aliginRight | @+id/  | 该控件的**右边沿**与指定控件的**右边对齐**   |
| layout_alignTop    | @+id/  | 该控件的**上边沿**与指定控件的**上边沿对齐** |
| layout_alignBottom | @+id/  | 该控件的**下边沿**与指定控件的**下边沿对齐** |

### 效果演示

![img](https://upload-images.jianshu.io/upload_images/2229471-27baaf7aa7fffd6b.png?imageMogr2/auto-orient/strip|imageView2/2/w/544/format/webp)

使用layout_below使得后面一个组件位于前面一个组件的下方

配合layout_toRightOf使得后面一个组件位于前面一个组件的右方

```xml
<?xml version="1.0" encoding="utf-8"?>
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

    <Button
        android:id="@+id/btn1"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="普通按钮1" />

    <Button
        android:id="@+id/btn2"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_below="@+id/btn1"
        android:layout_toRightOf="@+id/btn1"
        android:text="普通按钮2" />

    <Button
        android:id="@+id/btn3"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_below="@+id/btn2"
        android:layout_toRightOf="@+id/btn2"
        android:text="普通按钮3" />

    <Button
        android:id="@+id/btn4"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_below="@+id/btn3"
        android:layout_toRightOf="@+id/btn3"
        android:text="普通按钮4" />
</RelativeLayout>
```

## 帧布局FrameLayout

组件的默认位置都是左上角，组件之间可以重叠。像千层饼一样，一层压着一层 可以设置上下左右的对齐、水平垂直居中、设置方式与线性布局相似

- **常用属性**

| 属性                | 可选值                                   | 说明                 |
| ------------------- | ---------------------------------------- | -------------------- |
| layout_gravity      | center/center_vertical/center_horizontal | 组件相对父容器的位置 |
| layout_marginLeft   | 具体的数值100dp                          | 左侧外间距           |
| layout_marginTop    | 具体的数值100dp                          | 上侧外间距           |
| layout_marginRight  | 具体的数值100dp                          | 右侧外间距           |
| layout_marginBottom | 具体的数值100dp                          | 下侧外间距           |

### 效果演示

![img](https://gitee.com/tanzicai/drawingbed/raw/master/img/20211002145549.webp)



```xml
<?xml version="1.0" encoding="utf-8"?>
<FrameLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

   <!--    android:background="@color/purple_200"设置文本的背景色
            android:gravity="center_horizontal"       // 文本中的文字对齐方式
            android:paddingTop="100dp"                // 文本的上边内间距
            android:text="layout_gravity:center"      // 现实的文本内容
            android:textSize="30dp" />                // 文本字号大小-->
    <TextView
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:layout_gravity="center"
        android:background="@color/purple_200"    
        android:gravity="center_horizontal"       
        android:paddingTop="100dp"                
        android:text="layout_gravity:center"     
        android:textSize="30dp" />                

    <TextView
        android:layout_width="300dp"
        android:layout_height="360dp"
        android:layout_gravity="center"
        android:background="@color/purple_500" />

    <TextView
        android:layout_width="240dp"
        android:layout_height="240dp"
        android:layout_gravity="center"
        android:background="@color/purple_700" />

    <TextView
        android:layout_width="140dp"
        android:layout_height="140dp"
        android:layout_gravity="center"
        android:background="@color/teal_700" />

    <TextView
        android:layout_width="60dp"
        android:layout_height="60dp"
        android:layout_gravity="center"
        android:background="#ffffff"
        android:gravity="center" />
</FrameLayout>
```

## 总结

![img](https://gitee.com/tanzicai/drawingbed/raw/master/img/20211002145610.webp)

