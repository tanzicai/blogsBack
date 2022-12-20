---
layout: pages
title: 2-kotlin基本流程和流程控制
date: 2021-09-28 13:53:50
categories: kotlin
top_img: https://gitee.com/tanzicai/drawingbed/raw/master/img/20210926174339.png
cover: https://gitee.com/tanzicai/drawingbed/raw/master/img/20210926185404.png
tags: 
  - Kotlin Web
  - kotlin app	
  - kotlin ganmes
---

## 基本类型

在java中，我们说万物皆是对象，每日有对象就`new`一个对象，那么同样的在Kotlin中，万物皆对象。

因此我们可以调用任何对象的成员函数和属性。其中一些类型拥有特殊的内部表示，例如数字，字符和布尔值可以代表运行时的原始值，在用户看起来就像普通的类。这一节中将会介绍 Kotlin 中的基本类型：数字，字符，布尔值，数组，字符串等等。

## Numbers

Kotlin 对于数字的处理和 Java 类似，但不完全相同。例如，Kotlin 不会通过隐式转换来拓宽数字的精度，并且在一些情况下字面值会略有不同。

Kotlin提供了如下几种内置类型的数字（和 Java 类似）：

|  Type  | Bit width |
| :----: | :-------: |
|  Byte  |     8     |
| Short  |    16     |
|  Int   |    32     |
|  Long  |    64     |
| Float  |    32     |
| Double |    64     |

注意字符 (character) 在 Kotlin 中不是数字。

## 字面值常量

整数类型字面值常量有以下几种 ：

- 十进制：`123` ，`Long` 型用大写 `L` 标记，`123L`
- 十六进制：`0x0f`
- 二进制：`0b00001011`

**注意：kotlin不支持八进制**

Kotlin 也支持浮点数的常规表示方法 ：

- 默认是 `Double` 类型：`123.5` ，`123.5e10`
- `Float` 类型要用 `f` 或 `F` 标记：`123.5f`

## 数字字面值的下划线 (since 1.1)

使用下划线使得数字常量更易读 ：

加上下划线不会影响数字的大小及储存方式等，只是在编译器中更利于程序员阅读而已。

在其他进制前和其他语言一样，需要做一下标志。

```kotlin
二进制：0b1110
十六进制：0xFFFEEC1
```

```kotlin
val oneMillion = 1_000_000
val creditCardNumber = 1234_5678_9012_3456L
val socialSecurityNumber = 999_99_9999L
val hexBytes = 0xFF_EC_DE_5E
val bytes = 0b11010010_01101001_10010100_10010010
```

## 表示

在 Java 平台，数值被作为 JVM 中原始数据类型物理存储，除非我们需要一个可空值的数值引用（如 `Int?` ）或者泛型。后者数字会自动装箱。

**注意 ：数字装箱不会保留同一性** ：

因为在装箱后是一个引用数据类型，指向不同的地址，所以并不是一个对象。

```kotlin
val a: Int = 10000
print(a === a) // 打印 'true'
val boxedA: Int? = a
val anotherBoxedA: Int? = a
print(boxedA === anotherBoxedA) // !!!打印 'false'!!!  不是同一个对象
```

> 问题，在实际运行中不会得到相同结果

```kotlin
fun main(args:Array<String>){
    val a:Int = 1
    val b:Int? = a
    val c:Int? =a
    println(a === a)
    println(b === c)
    println(b == c)
}
```

另一方面，它保持相等性 ：

```kotlin
val a: Int = 10000
print(a == a) // Prints 'true'
val boxedA: Int? = a
val anotherBoxedA: Int? = a
print(boxedA == anotherBoxedA) // Prints 'true'
```

## 显示转换

由于不同的表示，小类型并不是大类型的子类型，如果是的话，将会出现下列问题：

```kotlin
// 伪代码，实际不能通过编译
val a: Int? = 1 // 一个装箱后的Int (java.lang.Integer)
val b: Long? = a //隐式转变为一个装箱后的Long(java.lang.Long)
print(a == b) // Surprise!打印了false，因为Long的`equals`方法是用来检测另一部分是否也为Long的
```

因此不止同一性，甚至相等性都将丢失， 所以，小类型是不可以隐式转换为大类型的，这就意味着除了显示转换，我们无法将一个`Byte`类型的值赋给一个`Int`类型 的变量

```kotlin
val b: Byte = 1 // OK, 字面值是静态检测的
val i: Int = b // ERROR
```

我们可以通过显式转换来拓宽数字精度

```kotlin
val i: Int = b.toInt() // OK: explicitly widened
```

每个数字类型都支持如下转换：

- toByte(): Byte
- toShort(): Short
- toInt(): Int
- toLong(): Long
- toFloat(): Float
- toDouble(): Double
- toChar(): Char

隐式转换的缺少一般并不容易被发现，因为可以从上下文推断类型，并且算术运算会做适当的转换，例如：

```kotlin
val l = 1L + 3 // Long + Int => Long
```

## 运算

Kotlin支持标准的数字运算，这些运算符被看做合适的类的成员（但是编译器将函数调用优化为相应的指令）。 对于位运算，Kotlin中没有特殊的字符来表示，而是提供了以中缀形式命名的函数，如下所示：

这一点与Python并不相同，python把and等当作了二元运算符并且等。

```kotlin
val x = (1 shl 2) and 0x000FF000
```

下面是全部的位运算操作符（只可用于`Int`和`Long`）：

- shl(bits) – signed shift left (Java's <<) 有符号左移
- shr(bits) – signed shift right (Java's >>) 有符号右移
- ushr(bits) – unsigned shift right (Java's >>>) 无符号右移
- and(bits) – bitwise and 与
- or(bits) – bitwise or 或
- xor(bits) – bitwise xor 异或
- inv() – bitwise inversion 非

## 字符

字符用`Char`类型表示，不可以直接当做数字使用

```kotlin
fun check(c: Char) {
    if (c == 1) { // ERROR: incompatible types
        // ...
    }
}
```

字2符的字面值通常是单一的引用，如 `'1'`，特殊字符可以通过反斜杠转义，如下字符支持转义：`\t`, `\b`, `\n`, `\r`, `\'`, `\"`, `\\\\,`$。编译其他字符，使用Unicode转移语法，`\uFF00` 我们可以把字符显式转换为`Int`

```kotlin
fun decimalDigitValue(c: Char): Int {
    if (c !in '0'..'9')
        throw IllegalArgumentException("Out of range")
    return c.toInt() - '0'.toInt() // Explicit conversions to numbers
}
```

和数字一样，当需要一个可空引用时，字符会自动装箱，装箱后同一性不会保留

## 布尔值

布尔值用`Boolean`类型表示，只有`true`和`false`两个值 当需要一个可空引用时，布尔值会被装箱 布尔值的内置运算有：

- || – lazy disjunction
- && – lazy conjunction
- ! - negation

## 数组

数组用`Array`类型表示，拥有`set` `get`方法（通过运算重载可以转变为`[]`），`size`属性，还有一些有用的成员函数：

```kotlin
class Array<T> private constructor() {
    val size: Int
    fun get(index: Int): T
    fun set(index: Int, value: T): Unit

    fun iterator(): Iterator<T>
    // ...
}
```

我们使用库函数`arrayOf()`来创建数组并传值进去，例如使用`arrayOf(1,2,3)`可以创建数组`[1,2,3]`。库函数`arrayOfNulls()`可以创建一个指定大小的空数组 另一种创建方式是使用工厂函数`Array()`，这个函数需要两个参数，数组大小和一个函数来返回每个元素的值，如下:

```
// Creates an Array<String> with values ["0", "1", "4", "9", "16"]
val asc = Array(5, { i -> (i * i).toString() })
```

如上面说过的，`[]`运算符代表调用了`set` `get`方法 

> Note: 与Java不同，Kotlin中数组是不可变的，这就意味着我们不能将`Array<String>`转化为`Array<Any>`，以防止可能的运行时错误（但是可以使用`Array<out Any>`） 
>
>  Kotlin有专门的类来表示原始数据类型的数组，避免过度装箱，`ByteArray`, `ShortArray`, `IntArray`等等。这些类和`Array`类没有继承关系，但是和`Array`类具有同样的方法和属性，另外都具有相应的工厂方法

```kotlin
val x: IntArray = intArrayOf(1, 2, 3)
x[0] = x[1] + x[2]
```

## 字符串

字符串由`String`类表示，`String`是不可变的，它的每一个字符元素可以通过下标获取：`s[i]`，字符串可以通过for循环迭代：

```kotlin
for (c in str) {
    println(c)
}
```

### 字符串字面值

Kotlin有两种字符串字面值，转义字符串和原始字符串。转义字符串含有转义字符。原始字符串可以包含换行和任意文本

```kotlin
val s = "Hello, world!\n"
```

转义以反斜杠形。

原始字符串由`"""`界定，不包含转义字符，可以包含换行和其他文本

```kotlin
val text = """
    for (c in "foo")
        print(c)
"""
```

你可以使用`trimMargin()`方法移除字符开头的空格

```kotlin
val text = """
    |Tell me and I forget.
    |Teach me and I remember.
    |Involve me and I learn.
    |(Benjamin Franklin)
    """.trimMargin()
```

> 默认情况下' | '用作边距前缀，但您可以选择另一个字符并将其作为参数传递，如' trimMargin(">") 

字符串可以包含模板表达式，即一些求值的代码段并且求值结果会被拼接到字符串中。模板表达式以美元符`$`开头，并且包含一个简单的名字：

```kotin
val i = 10
val s = "i = $i" // evaluates to "i = 10"
```

或者在花括号中包含任意表达式：

```kotlin
val s = "abc"
val str = "$s.length is ${s.length}" // evaluates to "abc.length is 3"
```

在原始字符串和转义字符串内部都支持模板表达式。你可以使用以下表达式在原始字符串中代表美元符（转义字符串中不支持）

```kotlin
val price = """
${'$'}9.99
"""
```

# 包

源文件通常以包声明开头:

```kotlin
package org.example

fun printMessage() { /*……*/ }
class Message { /*……*/ }

// ……
```

源文件所有内容（无论是类还是函数）都包含在声明的包内。 所以上例中 `printMessage()` 的全名是 `org.example.printMessage`， 而 `Message` 的全名是 `org.example.Message`。

如果没有指明包，该文件的内容属于无名字的默认包。

## 默认导入

有多个包会默认导入到每个 Kotlin 文件中：

- [kotlin.*](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/index.html)
- [kotlin.annotation.*](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.annotation/index.html)
- [kotlin.collections.*](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/index.html)
- [kotlin.comparisons.*](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.comparisons/index.html) （自 1.1 起）
- [kotlin.io.*](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.io/index.html)
- [kotlin.ranges.*](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.ranges/index.html)
- [kotlin.sequences.*](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.sequences/index.html)
- [kotlin.text.*](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.text/index.html)

根据目标平台还会导入额外的包：

- JVM:
  - java.lang.*
  - [kotlin.jvm.*](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.jvm/index.html)
- JS:
  - [kotlin.js.*](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.js/index.html)

## 导入

除了默认导入之外，每个文件可以包含它自己的导入指令。 导入语法在[语法](https://www.kotlincn.net/docs/reference/grammar.html#importHeader)中讲述。

可以导入一个单独的名字，如.

```kotlin
import org.example.Message // 现在 Message 可以不用限定符访问
```

也可以导入一个作用域下的所有内容（包、类、对象等）:

```kotlin
import org.example.* // “org.example”中的一切都可访问
```

如果出现名字冲突，可以使用 *as* 关键字在本地重命名冲突项来消歧义：

```kotlin
import org.example.Message // Message 可访问
import org.test.Message as testMessage // testMessage 代表“org.test.Message”
```

关键字 `import` 并不仅限于导入类；也可用它来导入其他声明：

- 顶层函数及属性；
- 在[对象声明](https://www.kotlincn.net/docs/reference/object-declarations.html#对象声明)中声明的函数和属性;
- [枚举常量](https://www.kotlincn.net/docs/reference/enum-classes.html)。

## 顶层声明的可见性

类、对象、接口、构造函数、方法、属性和它们的 setter 都可以有 *可见性修饰符*。 （getter 总是与属性有着相同的可见性。） 在 Kotlin 中有这四个可见性修饰符：`private`、 `protected`、 `internal` 和 `public`。 如果没有显式指定修饰符的话，默认可见性是 `public`。

在本页可以学到这些修饰符如何应用到不同类型的声明作用域。

### 包

函数、属性和类、对象和接口可以在顶层声明，即直接在包内：

```kotlin
// 文件名：example.kt
package foo

fun baz() { …… }
class Bar { …… }
```

- 如果你不指定任何可见性修饰符，默认为 `public`，这意味着你的声明将随处可见；
- 如果你声明为 `private`，它只会在声明它的文件内可见；
- 如果你声明为 `internal`，它会在相同[模块](https://www.kotlincn.net/docs/reference/visibility-modifiers.html#模块)内随处可见；
- `protected` 不适用于顶层声明。

注意：要使用另一包中可见的顶层声明，仍需将其[导入](https://www.kotlincn.net/docs/reference/packages.html#导入)进来。

例如:

```kotlin
// 文件名：example.kt
package foo

private fun foo() { …… } // 在 example.kt 内可见

public var bar: Int = 5 // 该属性随处可见
    private set         // setter 只在 example.kt 内可见
    
internal val baz = 6    // 相同模块内可见
```

### 类和接口

对于类内部声明的成员：

- `private` 意味着只在这个类内部（包含其所有成员）可见；
- `protected`—— 和 `private`一样 + 在子类中可见。
- `internal` —— 能见到类声明的 *本模块内* 的任何客户端都可见其 `internal` 成员；
- `public` —— 能见到类声明的任何客户端都可见其 `public` 成员。

请注意在 Kotlin 中，外部类不能访问内部类的 private 成员。

如果你覆盖一个 `protected` 成员并且没有显式指定其可见性，该成员还会是 `protected` 可见性。

例子:

```kotlin
open class Outer {
    private val a = 1
    protected open val b = 2
    internal val c = 3
    val d = 4  // 默认 public
    
    protected class Nested {
        public val e: Int = 5
    }
}

class Subclass : Outer() {
    // a 不可见
    // b、c、d 可见
    // Nested 和 e 可见

    override val b = 5   // “b”为 protected
}

class Unrelated(o: Outer) {
    // o.a、o.b 不可见
    // o.c 和 o.d 可见（相同模块）
    // Outer.Nested 不可见，Nested::e 也不可见
}
```

### 构造函数

要指定一个类的的主构造函数的可见性，使用以下语法（注意你需要添加一个显式 *constructor* 关键字）：

```kotlin
class C private constructor(a: Int) { …… }
```

这里的构造函数是私有的。默认情况下，所有构造函数都是 `public`，这实际上等于类可见的地方它就可见（即 一个 `internal` 类的构造函数只能在相同模块内可见).

### 局部声明

局部变量、函数和类不能有可见性修饰符。

### 模块

可见性修饰符 `internal` 意味着该成员只在相同模块内可见。更具体地说， 一个模块是编译在一起的一套 Kotlin 文件：

- 一个 IntelliJ IDEA 模块；
- 一个 Maven 项目；
- 一个 Gradle 源集（例外是 `test` 源集可以访问 `main` 的 internal 声明）；
- 一次 `<kotlinc>` Ant 任务执行所编译的一套文件。

# 控制流

## If 表达式

在 Kotlin 中，*if*是一个表达式，即它会返回一个值。

 因此就不需要三元运算符（条件 ? 然后 : 否则），因为普通的 *if* 就能胜任这个角色。

```kotlin
// 传统用法
var max = a 
if (a < b) max = b

// With else 
var max: Int
if (a > b) {
    max = a
} else {
    max = b
}
 
// 作为表达式
val max = if (a > b) a else b
```

*if* 的分支可以是代码块，最后的表达式作为该块的值：

此写法比较像解释语言，例如R语言就是这样去返回值的，只是在这里用在了if上

```kotlin
val max = if (a > b) {
    print("Choose a")
    a
} else {
    print("Choose b")
    b
}
```

如果你使用 *if* 作为表达式而不是语句（例如：返回它的值或者把它赋给变量），该表达式需要有 `else` 分支。

## When 表达式

*when* 表达式取代了类 C 语言的 switch 语句。其最简单的形式如下：

```kotlin
when (x) {
    1 -> print("x == 1")
    2 -> print("x == 2")
    else -> { // 注意这个块
        print("x is neither 1 nor 2")
    }
}
```

*when* 将它的参数与所有的分支条件顺序比较，直到某个分支满足条件。 *when* 既可以被当做表达式使用也可以被当做语句使用。如果它被当做表达式， 符合条件的分支的值就是整个表达式的值，如果当做语句使用， 则忽略个别分支的值。（像 *if* 一样，每一个分支可以是一个代码块，它的值是块中最后的表达式的值。）

如果其他分支都不满足条件将会求值 *else* 分支。 如果 *when* 作为一个表达式使用，则必须有 *else* 分支， 除非编译器能够检测出所有的可能情况都已经覆盖了［例如，对于 [枚举（*enum*）类](https://www.kotlincn.net/docs/reference/enum-classes.html)条目与[密封（*sealed*）类](https://www.kotlincn.net/docs/reference/sealed-classes.html)子类型］。

如果很多分支需要用相同的方式处理，则可以把多个分支条件放在一起，用逗号分隔：

```kotlin
when (x) {
    0, 1 -> print("x == 0 or x == 1")
    else -> print("otherwise")
}
```

我们可以用任意表达式（而不只是常量）作为分支条件

```kotlin
when (x) {
    parseInt(s) -> print("s encodes x")
    else -> print("s does not encode x")
}
```

我们也可以检测一个值在（*in*）或者不在（*!in*）一个[区间](https://www.kotlincn.net/docs/reference/ranges.html)或者集合中：

```kotlin
when (x) {
    in 1..10 -> print("x is in the range")
    in validNumbers -> print("x is valid")
    !in 10..20 -> print("x is outside the range")
    else -> print("none of the above")
}
```

另一种可能性是检测一个值是（*is*）或者不是（*!is*）一个特定类型的值。注意： 由于[智能转换](https://www.kotlincn.net/docs/reference/typecasts.html#智能转换)，你可以访问该类型的方法与属性而无需任何额外的检测。

```kotlin
fun hasPrefix(x: Any) = when(x) {
    is String -> x.startsWith("prefix")
    else -> false
}
```

*when* 也可以用来取代 *if*-*else* *if*链。 如果不提供参数，所有的分支条件都是简单的布尔表达式，而当一个分支的条件为真时则执行该分支：

```kotlin
when {
    x.isOdd() -> print("x is odd")
    y.isEven() -> print("y is even")
    else -> print("x+y is odd.")
}
```

自 Kotlin 1.3 起，可以使用以下语法将 *when* 的主语（subject，译注：指 `when` 所判断的表达式）捕获到变量中：

```kotlin
fun Request.getBody() =
        when (val response = executeRequest()) {
            is Success -> response.body
            is HttpError -> throw HttpException(response.status)
        }
```

在 *when* 主语中引入的变量的作用域仅限于 *when* 主体。

## For 循环

*for* 循环可以对任何提供迭代器（iterator）的对象进行遍历，这相当于像 C# 这样的语言中的 `foreach` 循环。语法如下：

```kotlin
for (item in collection) print(item)
```

循环体可以是一个代码块。

```kotlin
for (item: Int in ints) {
    // ……
}
```

如上所述，*for* 可以循环遍历任何提供了迭代器的对象。即：

- 有一个成员函数或者扩展函数

  ```kotlin
  iterator()
  ```

  ，它的返回类型

  - 有一个成员函数或者扩展函数 `next()`，并且
  - 有一个成员函数或者扩展函数 `hasNext()` 返回 `Boolean`。

这三个函数都需要标记为 `operator`。

如需在数字区间上迭代，请使用[区间表达式](https://www.kotlincn.net/docs/reference/ranges.html):

```kotlin
for (i in 1..3) {
    println(i)
}
for (i in 6 downTo 0 step 2) {
    println(i)
}
```

对区间或者数组的 `for` 循环会被编译为并不创建迭代器的基于索引的循环。

如果你想要通过索引遍历一个数组或者一个 list，你可以这么做：

```kotlin
for (i in array.indices) {
    println(array[i])
}
```

Target platform: JVMRunning on kotlin v. 1.5.31

或者你可以用库函数 `withIndex`：

```kotlin
for ((index, value) in array.withIndex()) {
    println("the element at $index is $value")
}
```

Target platform: JVMRunning on kotlin v. 1.5.31

参见 [*for* 语法](https://www.kotlincn.net/docs/reference/grammar.html#forStatement)。

## While 循环

*while* 与 *do*..*while* 照常使用

```kotlin
while (x > 0) {
    x--
}

do {
  val y = retrieveData()
} while (y != null) // y 在此处可见
```

# 返回和跳转

Kotlin 有三种结构化跳转表达式：

- *return*。默认从最直接包围它的函数或者[匿名函数](https://www.kotlincn.net/docs/reference/lambdas.html#匿名函数)返回。
- *break*。终止最直接包围它的循环。
- *continue*。继续下一次最直接包围它的循环。

所有这些表达式都可以用作更大表达式的一部分：

```kotlin
val s = person.name ?: return
```

这些表达式的类型是 [Nothing 类型](https://www.kotlincn.net/docs/reference/exceptions.html#nothing-类型)。

## Break 与 Continue 标签

在 Kotlin 中任何表达式都可以用标签（*label*）来标记。 标签的格式为标识符后跟 `@` 符号，例如：`abc@`、`fooBar@`都是有效的标签（参见[语法](https://www.kotlincn.net/docs/reference/grammar.html#label)）。 要为一个表达式加标签，我们只要在其前加标签即可。

```kotlin
loop@ for (i in 1..100) {
    // ……
}
```

现在，我们可以用标签限制 *break* 或者*continue*：

```kotlin
loop@ for (i in 1..100) {
    for (j in 1..100) {
        if (……) break@loop
    }
}
```

标签限制的 break 跳转到刚好位于该标签指定的循环后面的执行点。 *continue* 继续标签指定的循环的下一次迭代。

## 返回到标签

Kotlin 有函数字面量、局部函数和对象表达式。因此 Kotlin 的函数可以被嵌套。 标签限制的 *return* 允许我们从外层函数返回。 最重要的一个用途就是从 lambda 表达式中返回。回想一下我们这么写的时候：

```kotlin
fun foo() {
    listOf(1, 2, 3, 4, 5).forEach {
        if (it == 3) return // 非局部直接返回到 foo() 的调用者
        print(it)
    }
    println("this point is unreachable")
}
```

Target platform: JVMRunning on kotlin v. 1.5.31

这个 *return* 表达式从最直接包围它的函数即 `foo` 中返回。 （注意，这种非局部的返回只支持传给[内联函数](https://www.kotlincn.net/docs/reference/inline-functions.html)的 lambda 表达式。） 如果我们需要从 lambda 表达式中返回，我们必须给它加标签并用以限制 *return*。

```
fun foo() {
    listOf(1, 2, 3, 4, 5).forEach lit@{
        if (it == 3) return@lit // 局部返回到该 lambda 表达式的调用者，即 forEach 循环
        print(it)
    }
    print(" done with explicit label")
}
```

Target platform: JVMRunning on kotlin v. 1.5.31

现在，它只会从 lambda 表达式中返回。通常情况下使用隐式标签更方便。 该标签与接受该 lambda 的函数同名。

```kotlin
fun foo() {
    listOf(1, 2, 3, 4, 5).forEach {
        if (it == 3) return@forEach // 局部返回到该 lambda 表达式的调用者，即 forEach 循环
        print(it)
    }
    print(" done with implicit label")
}
```

Target platform: JVMRunning on kotlin v. 1.5.31

或者，我们用一个[匿名函数](https://www.kotlincn.net/docs/reference/lambdas.html#匿名函数)替代 lambda 表达式。 匿名函数内部的 *return* 语句将从该匿名函数自身返回

```kotlin
fun foo() {
    listOf(1, 2, 3, 4, 5).forEach(fun(value: Int) {
        if (value == 3) return  // 局部返回到匿名函数的调用者，即 forEach 循环
        print(value)
    })
    print(" done with anonymous function")
}
```

Target platform: JVMRunning on kotlin v. 1.5.31

请注意，前文三个示例中使用的局部返回类似于在常规循环中使用 *continue*。并没有 *break* 的直接等价形式，不过可以通过增加另一层嵌套 lambda 表达式并从其中非局部返回来模拟：

```
fun foo() {
    run loop@{
        listOf(1, 2, 3, 4, 5).forEach {
            if (it == 3) return@loop // 从传入 run 的 lambda 表达式非局部返回
            print(it)
        }
    }
    print(" done with nested loop")
}
```

Target platform: JVMRunning on kotlin v. 1.5.31

当要返一个回值的时候，解析器优先选用标签限制的 return，即

```kotlin
return@a 1
```

意为“返回 `1` 到 `@a`”，而不是“返回一个标签标注的表达式 `(@a 1)`”。
