---
layout: pages
title: 3-类和对象
date: 2021-09-28 15:20:14
categories: kotlin
top_img: https://gitee.com/tanzicai/drawingbed/raw/master/img/20210926174339.png
cover: https://gitee.com/tanzicai/drawingbed/raw/master/img/20210926185404.png
tags: 
  - Kotlin Web
  - kotlin app	
  - kotlin ganmes
---

# 类与继承

## 类

Kotlin 中使用关键字 *class* 声明类

class Invoice { /*……*/ }

类声明由类名、类头（指定其类型参数、主构造函数等）以及由花括号包围的类体构成。类头与类体都是可选的； 如果一个类没有类体，可以省略花括号。

```
class Empty
```

### 构造函数

在 Kotlin 中的一个类可以有一个**主构造函数**以及一个或多个**次构造函数**。主构造函数是类头的一部分：它跟在类名（与可选的类型参数）后。

```kotlin
class Person constructor(firstName: String) { /*……*/ }
```

如果主构造函数没有任何注解或者可见性修饰符，可以省略这个 *constructor* 关键字。

```kotlin
class Person(firstName: String) { /*……*/ }
```

主构造函数不能包含任何的代码。初始化的代码可以放到以 *init* 关键字作为前缀的**初始化块（initializer blocks）**中。

在实例初始化期间，初始化块按照它们出现在类体中的顺序执行，与属性初始化器交织在一起：

```kotlin
class InitOrderDemo(name: String) {
    val firstProperty = "First property: $name".also(::println)
    
    init {
        println("First initializer block that prints ${name}")
    }
    
    val secondProperty = "Second property: ${name.length}".also(::println)
    
    init {
        println("Second initializer block that prints ${name.length}")
    }
}
```

Target platform: JVMRunning on kotlin v. 1.5.31

请注意，主构造的参数可以在初始化块中使用。它们也可以在类体内声明的属性初始化器中使用：

```kotlin
class Customer(name: String) {
    val customerKey = name.toUpperCase()
}
```

事实上，声明属性以及从主构造函数初始化属性，Kotlin 有简洁的语法：

```kotlin
class Person(val firstName: String, val lastName: String, var age: Int) { /*……*/ }
```

You can use a [trailing comma](https://www.kotlincn.net/docs/reference/coding-conventions.html#trailing-commas) when you declare class properties:

```kotlin
class Person(
    val firstName: String,
    val lastName: String,
    var age: Int, // trailing comma
) { /*...*/ }
```

与普通属性一样，主构造函数中声明的属性可以是可变的（*var*）或只读的（*val*）。

如果构造函数有注解或可见性修饰符，这个 *constructor* 关键字是必需的，并且这些修饰符在它前面：

```kotlin
class Customer public @Inject constructor(name: String) { /*……*/ }

```

#### 次构造函数

类也可以声明前缀有 *constructor*的**次构造函数**：

```kotlin
class Person {
    var children: MutableList<Person> = mutableListOf()
    constructor(parent: Person) {
        parent.children.add(this)
    }
}
```

如果类有一个主构造函数，每个次构造函数需要委托给主构造函数， 可以直接委托或者通过别的次构造函数间接委托。委托到同一个类的另一个构造函数用 *this* 关键字即可：

```kotlin
class Person(val name: String) {
    var children: MutableList<Person> = mutableListOf()
    constructor(name: String, parent: Person) : this(name){
        parent.children.add(this)
    }
}
```

请注意，初始化块中的代码实际上会成为主构造函数的一部分。委托给主构造函数会作为次构造函数的第一条语句，因此所有初始化块与属性初始化器中的代码都会在次构造函数体之前执行。即使该类没有主构造函数，这种委托仍会隐式发生，并且仍会执行初始化块：

```kotlin
class Constructors {
    init {
        println("Init block")
    }

    constructor(i: Int) {
        println("Constructor")
    }
}
```

Target platform: JVMRunning on kotlin v. 1.5.31

如果一个非抽象类没有声明任何（主或次）构造函数，它会有一个生成的不带参数的主构造函数。构造函数的可见性是 public。如果你不希望你的类有一个公有构造函数，你需要声明一个带有非默认可见性的空的主构造函数：

```kotlin
class DontCreateMe private constructor () { /*……*/ }
```

> **注意**：在 JVM 上，如果主构造函数的所有的参数都有默认值，编译器会生成 一个额外的无参构造函数，它将使用默认值。这使得 Kotlin 更易于使用像 Jackson 或者 JPA 这样的通过无参构造函数创建类的实例的库。

> ```kotlin
> class Customer(val customerName: String = "")
> ```

### 创建类的实例

要创建一个类的实例，我们就像普通函数一样调用构造函数：

```
val invoice = Invoice()

val customer = Customer("Joe Smith")
```

注意 Kotlin 并没有 *new* 关键字。

创建嵌套类、内部类与匿名内部类的类实例在[嵌套类](https://www.kotlincn.net/docs/reference/nested-classes.html)中有述。

### 类成员

类可以包含：

- [构造函数与初始化块](https://www.kotlincn.net/docs/reference/classes.html#构造函数)
- [函数](https://www.kotlincn.net/docs/reference/functions.html)
- [属性](https://www.kotlincn.net/docs/reference/properties.html)
- [嵌套类与内部类](https://www.kotlincn.net/docs/reference/nested-classes.html)
- [对象声明](https://www.kotlincn.net/docs/reference/object-declarations.html)

## 继承

在 Kotlin 中所有类都有一个共同的超类 `Any`，这对于没有超类型声明的类是默认超类：

```
class Example // 从 Any 隐式继承
```

`Any` 有三个方法：`equals()`、 `hashCode()` 与 `toString()`。因此，为所有 Kotlin 类都定义了这些方法。

默认情况下，Kotlin 类是最终（final）的：它们不能被继承。 要使一个类可继承，请用 `open` 关键字标记它。

```
open class Base // 该类开放继承
```

如需声明一个显式的超类型，请在类头中把超类型放到冒号之后：

```
open class Base(p: Int)

class Derived(p: Int) : Base(p)
```

如果派生类有一个主构造函数，其基类可以（并且必须） 用派生类主构造函数的参数就地初始化。

如果派生类没有主构造函数，那么每个次构造函数必须使用 *super* 关键字初始化其基类型，或委托给另一个构造函数做到这一点。 注意，在这种情况下，不同的次构造函数可以调用基类型的不同的构造函数：

```
class MyView : View {
    constructor(ctx: Context) : super(ctx)

    constructor(ctx: Context, attrs: AttributeSet) : super(ctx, attrs)
}
```

### 覆盖方法

我们之前提到过，Kotlin 力求清晰显式。因此，Kotlin 对于可覆盖的成员（我们称之为*开放*）以及覆盖后的成员需要显式修饰符：

```
open class Shape {
    open fun draw() { /*……*/ }
    fun fill() { /*……*/ }
}

class Circle() : Shape() {
    override fun draw() { /*……*/ }
}
```

`Circle.draw()` 函数上必须加上 *override* 修饰符。如果没写，编译器将会报错。 如果函数没有标注 *open* 如 `Shape.fill()`，那么子类中不允许定义相同签名的函数， 不论加不加 **override**。将 *open* 修饰符添加到 final 类（即没有 *open* 的类）的成员上不起作用。

标记为 *override* 的成员本身是开放的，也就是说，它可以在子类中覆盖。如果你想禁止再次覆盖，使用 *final* 关键字：

```
open class Rectangle() : Shape() {
    final override fun draw() { /*……*/ }
}
```

### 覆盖属性

属性覆盖与方法覆盖类似；在超类中声明然后在派生类中重新声明的属性必须以 *override* 开头，并且它们必须具有兼容的类型。 每个声明的属性可以由具有初始化器的属性或者具有 `get` 方法的属性覆盖。

```
open class Shape {
    open val vertexCount: Int = 0
}

class Rectangle : Shape() {
    override val vertexCount = 4
}
```

你也可以用一个 `var` 属性覆盖一个 `val` 属性，但反之则不行。 这是允许的，因为一个 `val` 属性本质上声明了一个 `get` 方法， 而将其覆盖为 `var` 只是在子类中额外声明一个 `set` 方法。

请注意，你可以在主构造函数中使用 *override* 关键字作为属性声明的一部分。

```
interface Shape {
    val vertexCount: Int
}

class Rectangle(override val vertexCount: Int = 4) : Shape // 总是有 4 个顶点

class Polygon : Shape {
    override var vertexCount: Int = 0  // 以后可以设置为任何数
}
```

### 派生类初始化顺序

在构造派生类的新实例的过程中，第一步完成其基类的初始化（在之前只有对基类构造函数参数的求值），因此发生在派生类的初始化逻辑运行之前。

```
open class Base(val name: String) {

    init { println("Initializing Base") }

    open val size: Int = 
        name.length.also { println("Initializing size in Base: $it") }
}

class Derived(
    name: String,
    val lastName: String,
) : Base(name.capitalize().also { println("Argument for Base: $it") }) {

    init { println("Initializing Derived") }

    override val size: Int =
        (super.size + lastName.length).also { println("Initializing size in Derived: $it") }
}
```

Target platform: JVMRunning on kotlin v. 1.5.31

这意味着，基类构造函数执行时，派生类中声明或覆盖的属性都还没有初始化。如果在基类初始化逻辑中（直接或通过另一个覆盖的 *open* 成员的实现间接）使用了任何一个这种属性，那么都可能导致不正确的行为或运行时故障。设计一个基类时，应该避免在构造函数、属性初始化器以及 *init* 块中使用 *open* 成员。

### 调用超类实现

派生类中的代码可以使用 *super* 关键字调用其超类的函数与属性访问器的实现：

```
open class Rectangle {
    open fun draw() { println("Drawing a rectangle") }
    val borderColor: String get() = "black"
}

class FilledRectangle : Rectangle() {
    override fun draw() {
        super.draw()
        println("Filling the rectangle")
    }

    val fillColor: String get() = super.borderColor
}
```

在一个内部类中访问外部类的超类，可以通过由外部类名限定的 *super* 关键字来实现：`super@Outer`：

```
class FilledRectangle: Rectangle() {
    override fun draw() { 
        val filler = Filler()
        filler.drawAndFill()
    }

    inner class Filler {
        fun fill() { println("Filling") }
        fun drawAndFill() {
            super@FilledRectangle.draw() // 调用 Rectangle 的 draw() 实现
            fill()
            println("Drawn a filled rectangle with color ${super@FilledRectangle.borderColor}") // 使用 Rectangle 所实现的 borderColor 的 get()
        }
    }
}
```

Target platform: JVMRunning on kotlin v. 1.5.31

### 覆盖规则

在 Kotlin 中，实现继承由下述规则规定：如果一个类从它的直接超类继承相同成员的多个实现， 它必须覆盖这个成员并提供其自己的实现（也许用继承来的其中之一）。 为了表示采用从哪个超类型继承的实现，我们使用由尖括号中超类型名限定的 *super*，如 `super<Base>`：

```
open class Rectangle {
    open fun draw() { /* …… */ }
}

interface Polygon {
    fun draw() { /* …… */ } // 接口成员默认就是“open”的
}

class Square() : Rectangle(), Polygon {
    // 编译器要求覆盖 draw()：
    override fun draw() {
        super<Rectangle>.draw() // 调用 Rectangle.draw()
        super<Polygon>.draw() // 调用 Polygon.draw()
    }
}
```

可以同时继承 `Rectangle` 与 `Polygon`， 但是二者都有各自的 `draw()` 实现，所以我们必须在 `Square` 中覆盖 `draw()`， 并提供其自身的实现以消除歧义。

## 抽象类

类以及其中的某些成员可以声明为 *abstract*。 抽象成员在本类中可以不用实现。 需要注意的是，我们并不需要用 `open` 标注一个抽象类或者函数——因为这不言而喻。

我们可以用一个抽象成员覆盖一个非抽象的开放成员

```
open class Polygon {
    open fun draw() {}
}

abstract class Rectangle : Polygon() {
    abstract override fun draw()
}
```

## 伴生对象

如果你需要写一个可以无需用一个类的实例来调用、但需要访问类内部的函数（例如，工厂方法），你可以把它写成该类内[对象声明](https://www.kotlincn.net/docs/reference/object-declarations.html)中的一员。

更具体地讲，如果在你的类内声明了一个[伴生对象](https://www.kotlincn.net/docs/reference/object-declarations.html#伴生对象)， 你就可以访问其成员，只是以类名作为限定符。
