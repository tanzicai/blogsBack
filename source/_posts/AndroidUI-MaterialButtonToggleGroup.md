---
layout: pages
title: AndroidUI-MaterialButtonToggleGroup
date: 2021-10-02 15:35:16
cover: https://gitee.com/tanzicai/drawingbed/raw/master/img/20211002154208.png
top_img: https://gitee.com/tanzicai/drawingbed/raw/master/img/20211002154223.png
categroies: kotlin
tags:
  - kotlin
  - MaterialButton
  - AndroidUI
---

# MaterialButtonToggleGroup

谷歌文档 -> [MaterialButtonToggleGroup](https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fdeveloper.android.google.cn%2Freference%2Fcom%2Fgoogle%2Fandroid%2Fmaterial%2Fbutton%2FMaterialButtonToggleGroup)

## 继承关系

```java
java.lang.Object
   ↳android.view.View
 	   ↳android.view.ViewGroup
 	 	   ↳android.widget.LinearLayout
 	 	 	   ↳com.google.android.material.button.MaterialButtonToggleGroup
```

- 类似一个LinearLayout，但只能添加`MaterialButton`，只有第一个子元素的最左边角和最后一个子元素的最右边角才能保留它们的形状外观或角大小，类似于iOS中的SegmentedControl， 用户可以从组中选择一个或多个选项。



## 举个栗子

```xml
<?xml version="1.0" encoding="utf-8"?>
<com.google.android.material.button.MaterialButtonToggleGroup xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:id="@+id/toggleGroup"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    app:checkedButton="@id/btn1"
    app:singleSelection="true">

    <com.google.android.material.button.MaterialButton
        android:id="@+id/btn1"
        style="@style/Widget.MaterialComponents.Button.OutlinedButton"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="选项一"
        android:theme="@style/Theme.MaterialComponents.Light.NoActionBar" />

    <com.google.android.material.button.MaterialButton
        android:id="@+id/btn2"
        style="@style/Widget.MaterialComponents.Button.OutlinedButton"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="选项二"
        android:theme="@style/Theme.MaterialComponents.Light.NoActionBar" />

    <com.google.android.material.button.MaterialButton
        android:id="@+id/btn3"
        style="@style/Widget.MaterialComponents.Button.OutlinedButton"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="选项三"
        android:theme="@style/Theme.MaterialComponents.Light.NoActionBar" />

</com.google.android.material.button.MaterialButtonToggleGroup>
```

![在这里插入图片描述](https://gitee.com/tanzicai/drawingbed/raw/master/img/20211002154329.gif)

- 以上为单选情况，多选则只需将`app:singleSelection="true"`改为`app:singleSelection="false"`即可

![在这里插入图片描述](https://gitee.com/tanzicai/drawingbed/raw/master/img/20211002154354.gif)



## 监听方法

```java
MaterialButtonToggleGroup materialButtonToggleGroup = findViewById(R.id.toggleGroup);
materialButtonToggleGroup.addOnButtonCheckedListener(new MaterialButtonToggleGroup.OnButtonCheckedListener() {
	@Override
	public void onButtonChecked(MaterialButtonToggleGroup group, int checkedId, boolean isChecked) {
		Toast.makeText(MainActivity.this, "ID：" + checkedId + ", checked：" + isChecked, Toast.LENGTH_SHORT).show();
	}
});
```



## 公开属性

| 属性                  | 描述                           | 参数       |
| --------------------- | ------------------------------ | ---------- |
| app:checkedButton     | 默认选中                       | 按钮ID     |
| app:singleSelection   | 是否单项选择                   | true/false |
| app:selectionRequired | 设置为true后，强制至少选中一个 | true/false |

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:orientation="vertical"
    android:gravity="center"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

    <com.google.android.material.button.MaterialButtonToggleGroup
        android:id="@+id/toggle1"
        android:layout_width="match_parent"
        android:layout_height="100dp"
        app:singleSelection="true"
        app:selectionRequired="true"
        app:checkedButton="@id/bu1"
        >


        <com.google.android.material.button.MaterialButton
            android:id="@+id/bu1"
            style="@style/Widget.MaterialComponents.Button.UnelevatedButton"
            app:cornerRadius="30dp"
            android:layout_width="0dp"
            android:text="@string/a"
            android:layout_marginLeft="10dp"
            android:backgroundTint="#ff30f0"
            android:layout_weight="1"
            android:layout_height="100dp"/>
        <com.google.android.material.button.MaterialButton
            android:id="@+id/bu2"
            style="@style/Widget.MaterialComponents.Button.UnelevatedButton"
            android:layout_width="0dp"
            android:text="选项B"
            android:backgroundTint="#1130f0"
            android:layout_weight="1"
            android:layout_height="100dp"/>
        <com.google.android.material.button.MaterialButton
            android:id="@+id/bu3"
            style="@style/Widget.MaterialComponents.Button.UnelevatedButton"
            android:layout_width="0dp"
            app:cornerRadius="30dp"
            app:icon="@drawable/abc_vector_test"
            android:text="选项C"
            android:backgroundTint="#4f02"
            android:layout_weight="1"
            android:layout_marginRight="10dp"

            android:layout_height="100dp"/>
    </com.google.android.material.button.MaterialButtonToggleGroup>
</LinearLayout>
```

```kotlin
package com.kotlin.testApp

import android.os.Bundle
import android.util.Log
import com.google.android.material.bottomnavigation.BottomNavigationView
import androidx.appcompat.app.AppCompatActivity
import androidx.navigation.findNavController
import androidx.navigation.ui.AppBarConfiguration
import androidx.navigation.ui.setupActionBarWithNavController
import androidx.navigation.ui.setupWithNavController
import com.google.android.material.button.MaterialButtonToggleGroup
import com.kotlin.testApp.databinding.ActivityMainBinding
import java.util.*

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(R.layout.comp_material_toogle)

//        val navView: BottomNavigationView = binding.navView
//
//        val navController = findNavController(R.id.nav_host_fragment_activity_main)
//        // Passing each menu ID as a set of Ids because each
//        // menu should be considered as top level destinations.
//        val appBarConfiguration = AppBarConfiguration(setOf(
//                R.id.navigation_home, R.id.navigation_dashboard, R.id.navigation_notifications))
//        setupActionBarWithNavController(navController, appBarConfiguration)
//        navView.setupWithNavController(navController)


        //togglr监听
       var toggle1 =  findViewById<MaterialButtonToggleGroup>(R.id.toggle1)
        toggle1.addOnButtonCheckedListener(object :MaterialButtonToggleGroup.OnButtonCheckedListener
        {
            override fun onButtonChecked(
                group: MaterialButtonToggleGroup?,
                checkedId: Int,
                isChecked: Boolean
            ) {
                Log.e("MainActivity",isChecked.toString())
            }

        })

    }
}
```

