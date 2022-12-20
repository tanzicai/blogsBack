---
layout: pages
title: 1-kotlin基本语法及编码规范
date: 2021-09-26 18:53:32
categories: kotlin
top_img: https://gitee.com/tanzicai/drawingbed/raw/master/img/20210926174339.png
cover: https://gitee.com/tanzicai/drawingbed/raw/master/img/20210926185404.png
tags: 
  - Kotlin Web
  - kotlin app	
  - kotlin ganmes
---

> 本文参考kotlin官方[开发手册](http://kotlinlang.org/docs/reference/basic-syntax.html)
>
> 本文参考kotlin[开发手册翻译版本](http://kotlinlang.org/docs/reference/basic-syntax.html)

# 基本语法

## 包

包名在源文件顶部定义 ：

```kotlin
package my.demo

import java.util.*

// ...
```

包名不需要和目录相匹配，源文件可以存在文件系统的任何位置。

## 函数

两个 `Int` 参数，返回值是 `Int` 的函数 ：

在`kotlin`中，`fun`是函数的标志，是固定使用的。这一点和很多解释语言相似。

```kotlin
fun sum(a: Int, b: Int): Int {
    return a + b
}
```

表达式作为函数体，自动推断返回值类型的函数 ：

```kotlin
fun sum(a: Int, b: Int) = a + b
```

返回无意义值的函数 ：

在PHP中也有这种以`$`标定变量的形式。

```kotlin
fun printSum(a: Int, b: Int): Unit {
    println("sum of $a and $b is ${a + b}")
}
```

返回类型是 `Unit` 时，可省略 ：

```kotlin
fun printSum(a: Int, b: Int) {
    println("sum of $a and $b is ${a + b}")
}
```

## 局部变量

常量( `assign-once` `read-only` ) ：

使用关键字`val`标志常量

```
val a: Int = 1
val b = 1   // 自动推断 Int 类型
val c: Int  // 没有提供初始值，必须声明类型
c = 1       // 延迟赋值
```

变量 ：

`var`可以自动匹配数据类型

```
var x = 5 // 自动推断 Int 类型
x += 1
```

## 注释

和 Java , JacaScript 一样，Kotlin 也支持行注释和块注释 ：

```
// This is an end-of-line comment

/* This is a block comment
   on multiple lines. */
```

**与 Java 不同的是，Kotlin 的块注释可以嵌套。**

## 使用字符串模板

```kotlin
var a = 1
// simple name in template:
val s1 = "a is $a"

a = 2
// arbitrary expression in template:
val s2 = "${s1.replace("is", "was")}, but now is $a"
```

## 使用条件表达式

```kotlin
fun maxOf(a: Int, b: Int): Int {
    if (a > b) {
        return a
    } else {
        return b
    }
}
```

使用 `if` 作为表达式 ：

```kotlin
fun maxOf(a: Int, b: Int) = if (a > b) a else b
```

## 使用可空变量以及空值检查

当引用可能为空时必须显式标识这个引用是可空的。

如果 `str` 不是数字，则返回空 ：

`kotlin`可以使用null匹配，`java`中使用`equals`进行匹配

```kotlin
fun parseInt(str: String): Int? {
    // ...
}
```

返回可空值的函数 ：

```kotlin
fun printProduct(arg1: String, arg2: String) {
    val x = parseInt(arg1)
    val y = parseInt(arg2)

    // 直接使用 `x * y` 可能会报错，因为它们可能持有空值
    if (x != null && y != null) {
        // x , y 经过空值检查后会自动转化为非空值
        println(x * y)
    }
    else {
        println("either '$arg1' or '$arg2' is not a number")
    }    
}
```

或者

```kotlin
  // ...
    if (x == null) {
        print("Wrong number format in '${args[0]}'")
        return
    }
    if (y == null) {
        print("Wrong number format in '${args[1]}'")
        return
    }

    // x , y经过空值检查后会自动转化为非空值
    print(x * y)
```

### 使用类型检测和自动类型转换

`is` 操作符用来检测某个表达式是否**是某个类型的实例**。如果一个不可变的局部变量或者属性值经过类型检测为特定类型后，就没有必要再显示转换 ：

```kotlin
fun getStringLength(obj: Any): Int? {
    if (obj is String) {
        // obj 自动转换为 `String` 类型
        return obj.length
    }

    //在类型检查分支外，obj仍然是 `Any` 类型
    return null
}
```

or

```kotlin
fun getStringLength(obj: Any): Int? {
    if (obj !is String) return null

    // obj 自动转换为 `String` 类型
    return obj.length
}
```

or even

```kotlin
fun getStringLength(obj: Any): Int? {
    // 在`&&`之后的语句中，obj已经自动转化为 `String` 类型
    if (obj is String && obj.length > 0) {
        return obj.length
    }
    return null
}
```

### 使用for循环

```kotlin
val items = listOf("apple", "banana", "kiwi")
for (item in items) {
    println(item)
}
```

or

>indices指索引，返回值为Int类型，相当于c语言数组的下标值。

```kotlin
val items = listOf("apple", "banana", "kiwi")
for (index in items.indices) {
    println("item at $index is ${items[index]}")
}
```

### 使用while循环

```kotlin
val items = listOf("apple", "banana", "kiwi")
var index = 0
while (index < items.size) {
    println("item at $index is ${items[index]}")
    index++
}
```

### 使用when表达式

```kotlin
fun describe(obj: Any): String =
when (obj) {
    1          -> "One"
    "Hello"    -> "Greeting"
    is Long    -> "Long"
    !is String -> "Not a string"
    else       -> "Unknown"
}
```

### 使用 ranges

使用 `in` 操作符检测某个数字是否在指定范围内 ：

```kotlin
val x = 10
val y = 9
if (x in 1..y+1) {
    println("fits in range")
}
```

判断数字是否在指定范围之外 ：

```kotlin
val list = listOf("a", "b", "c")

if (-1 !in 0..list.lastIndex) {
    println("-1 is out of range")
}
if (list.size !in list.indices) {
    println("list size is out of valid list indices range too")
}
```

遍历 ：

```kotlin
for(x in 1..5){
  print(x)
}
```

over a progression ：

```kotlin
for (x in 1..10 step 2) {
    print(x)
}
for (x in 9 downTo 0 step 3) {
    print(x)
}
```

### 使用集合

迭代一个集合 ：

```kotlin
for(name in names){
    println(name)
}
```

使用 `in` 操作符判断一个对象是否在集合中 ：

```kotlin
when {
    "orange" in items -> println("juicy")
    "apple" in items -> println("apple is fine too")
}
```

使用 lambda 表达式来过滤（filter）和变换（map）集合 ：

```kotlin
fruits
.filter { it.startsWith("a") }
.sortedBy { it }
.map { it.toUpperCase() }
.forEach { println(it) }
```

### 创建类和实例 ：

```kotlin
val rectangle = Rectangle(5.0, 2.0) //no 'new' keyword required
val triangle = Triangle(3.0, 4.0, 5.0)
```

# 习惯写法

## 惯用语法

Kotlin 中的一些常用惯用语法。

### 创建数据传输对象 (POJOs/POCOs)

```kotlin
data class Customer(val name:String,val email:String)
```

`Customer` 类具有以下函数 ：

- 对所有属性的 getters（对于变量提供 setters 方法）
- `equals()`
- `hashCode()`
- `toString()`
- `copy()`
- `component1()` , `component2()` , … , for all properties 

### 函数参数默认值

```kotlin
fun foo(a: Int = 0, b: String = "") { ... }
```

### 过滤 list

```kotlin
val positives = list.filter { x -> x > 0 }
```

even shorter ：

```kotlin
val positives = list.filter { it > 0 }
```

### 字符串插入

```kotlin
println("Name $name")
```

### 类型检查

```kotlin
when (x) {
    is Foo -> ...
    is Bar -> ...
    else   -> ...
}
```

### 遍历 map/键值对集合

```kotlin
for ((k, v) in map) {
    println("$k -> $v")
}
```

`k` , `v` 可以任意命名

### 使用 ranges

```kotlin
for (i in 1..100) { ... }  // 闭合 range: 包括100
for (i in 1 until 100) { ... } // 半开 range: 不包括100
for (x in 2..10 step 2) { ... }
for (x in 10 downTo 1) { ... }
if (x in 1..10) { ... }
```

### 只读 list

```kotlin
val list = listOf("a", "b", "c")
```

### 只读 map

```kotlin
val map = mapOf("a" to 1, "b" to 2, "c" to 3)
```

### 访问 map

```kotlin
println(map["key"])
map["key"] = value
```

### 懒属性

```kotlin
val p: String by lazy {
    // compute the string
}
```

### 扩展函数

```kotlin
fun String.spaceToCamelCase() { ... }

"Convert this to camelcase".spaceToCamelCase()
```

### 创建单例

```kotlin
object Resource{
   val name="Name"
}
```

### if not null 简写

```kotlin
val files = File("Test").listFiles()

println(files?.size)
```

### if not null and else 简写

```kotlin
val files = File("Test").listFiles()

println(files?.size ?: "empty")
```

### 为 null 时执行

```kotlin
val data = ...
val email = data["email"] ?: throw IllegalStateException("Email is missing!")
```

### 不为null时执行

```kotlin
val data = ...

data?.let {
    ... // not null 时执行
}
```

### 不为 null 时返回非 null map

```kotlin
val value = ...
val mapped = value?.let { transformValue(it) } ?: defaultValueIfValueIsNull
```

### 返回 when 表达式

```kotlin
fun transform(color: String): Int {
    return when (color) {
        "Red" -> 0
        "Green" -> 1
        "Blue" -> 2
        else -> throw IllegalArgumentException("Invalid color param value")
    }
}
```

### try/catch 表达式

```kotlin
fun test() {
    val result = try {
        count()
    } catch (e: ArithmeticException) {
        throw IllegalStateException(e)
    }

    // Working with result
}
```

### if 表达式

```kotlin
fun foo(param: Int) {
    val result = if (param == 1) {
        "one"
    } else if (param == 2) {
        "two"
    } else {
        "three"
    }
}
```

### Builder-style usage of methods that return Unit

```kotlin
fun arrayOfMinusOnes(size: Int): IntArray {
    return IntArray(size).apply { fill(-1) }
}
```

### 单一表达式函数

```kotlin
fun theAnswer() = 42
```

等价于

```kotlin
fun theAnswer(): Int {
    return 42
}
```

可以和其他习惯用法有效结合，简化代码，例如when表达式 ：

```kotlin
fun transform(color: String): Int = when (color) {
    "Red" -> 0
    "Green" -> 1
    "Blue" -> 2
    else -> throw IllegalArgumentException("Invalid color param value")
}
```

### 使用 with 调用一个对象的多个方法

```kotlin
class Turtle {
    fun penDown()
    fun penUp()
    fun turn(degrees: Double)
    fun forward(pixels: Double)
}

val myTurtle = Turtle()
with(myTurtle) { //draw a 100 pix square
    penDown()
    for(i in 1..4) {
        forward(100.0)
        turn(90.0)
    }
    penUp()
}
```

### Java 7's try with resources

```kotlin
val stream = Files.newInputStream(Paths.get("/some/file.txt"))
stream.buffered().reader().use { reader ->
    println(reader.readText())
}
```

### 需要泛型类型信息的泛型函数的简便形式

```kotlin
//  public final class Gson {
//     ...
//     public <T> T fromJson(JsonElement json, Class<T> classOfT) throws JsonSyntaxException {
//     ...

inline fun <reified T: Any> Gson.fromJson(json): T = this.fromJson(json, T::class.java)
```

### 使用可空 Boolean 值

```kotlin
val b: Boolean? = ...
if (b == true) {
    ...
} else {
    // b为false  或者 null
}
```

# 编码规范

包含了 Kotlin 语言当前代码风格。

### 命名风格

如有不确定，默认使用 Java 的编码风格，例如 ：

- 使用驼峰命名法（命名避免使用下划线）
- 类型名称首字母大写
- 方法和属性名首字母小写
- 缩进使用4个空格
- 公共函数需要写文档，以便在Kotlin Doc中查看

### 冒号

类型和父类型之间的冒号前需要有空格，实例和类型之间的冒号前不需要空格 ：

```kotlin
interface Foo<out T : Any> : Bar{
    fun foo(a: Int): T
}
```

### Lambdas

在 lambda 表达式中，花括号附近需要使用空格，分离函数体中参数和表达式的箭头两侧需要空格，尽可能把表达式写在圆括号外。

```kotlin
list.filter { it > 10 }.map { element -> element * 2 }
}
```

在简短非嵌套的 lambda 表达式中，通常建议不要显示声明参数，而使用 `it` 代替。反之，在嵌套的Lambdas表达式中，总是应该显式声明属性。

### 类头格式化

仅有几个参数的类可以缩写为一行代码 ：

```kotlin
class Person(id: Int, name: String)
```

头很长的类需要进行格式化。每一个主构造器参数单独一行并缩进，右括号也需单独一行。如果我们使用继承，父类构造器的调用或者实现的接口列表应和右括号处于同一行 ：

```kotlin
class Person(
    id: Int,
    name: String,
    surname: String
) : Human(id, name) {
    // ...
}
```

### Unit

如果一个函数返回 `Unit` ，应该被省略 ：

```kotlin
fun foo() { // ": Unit" is omitted here

}
```

### 函数 vs 属性

某些情况下无参函数和只读属性是可以互换的。尽管语义上相似，但是在具体取舍上还是有格式上的规范的。

底层算法更偏向于属性 ：

- 不会抛出异常
- `O(1)` 复杂度
- 计算廉价 (或者第一次运行时进行缓存)
- 多次调用返回相同的结果
