---
title: JAVA核心技术(基础)-第三章Java的基本程序设计结构
date: 2022-11-25 21:17:02
tags:
	- JAVA
	- JAVA核心技术
	- JAVA基础
categories:
	- JAVA
updated: 2022-11-25 21:17:02
---

> JAVA核心技术(基础)-第一章Java程序设计概述[GITHUB站](https://tanzicai.github.io/2022/11/25/JAVA核心技术(基础)-第一章Java程序设计概述/)   [Vercel站](https://tanzicai.github.io/2022/11/25/JAVA%E6%A0%B8%E5%BF%83%E6%8A%80%E6%9C%AF(%E5%9F%BA%E7%A1%80)-%E7%AC%AC%E4%B8%80%E7%AB%A0Java%E7%A8%8B%E5%BA%8F%E8%AE%BE%E8%AE%A1%E6%A6%82%E8%BF%B0/)
>
> JAVA核心技术(基础)-第二章JAVA程序设计环境[GITHUB站](https://tanzicai.github.io/2022/11/25/JAVA核心技术(基础)-第一章Java程序设计概述/)   [Vercel站](https://tanzicai.github.io/2022/11/25/JAVA%E6%A0%B8%E5%BF%83%E6%8A%80%E6%9C%AF(%E5%9F%BA%E7%A1%80)-%E7%AC%AC%E4%B8%80%E7%AB%A0Java%E7%A8%8B%E5%BA%8F%E8%AE%BE%E8%AE%A1%E6%A6%82%E8%BF%B0/)
>
> JAVA核心技术(基础)-第三章Java的基本程序设计结构[GITHUB站](https://tanzicai.github.io/2022/11/25/JAVA核心技术(基础)-第一章Java程序设计概述/)   [Vercel站](https://tanzicai.github.io/2022/11/25/JAVA%E6%A0%B8%E5%BF%83%E6%8A%80%E6%9C%AF(%E5%9F%BA%E7%A1%80)-%E7%AC%AC%E4%B8%80%E7%AB%A0Java%E7%A8%8B%E5%BA%8F%E8%AE%BE%E8%AE%A1%E6%A6%82%E8%BF%B0/)
>
> [JAVA基础笔记集锦](https://tanzicai.vercel.app/categories/)

# 一个简单的Java应用程序

下面是一个最简单的JAVA应用程序

```java
public class FirstSample {
    public static void main(String[] args) {
        System.out.println("test");
    }
}
```

我们对这个最小程序做一些解释：

1. Java区分大小写。 如果出现了大小写拼写错误。程序将无法运行。
2. 关键字`public`称为访问修饰符(access modifier)， 这些修 饰符用千控制程序的其他部分对这段代码的访问级别。
3. 关键字`class`表明Java程序中的全部内容都包含在类中。 
4. 关键字`class`后面紧跟类名。 Java中定义类名的规则很宽松。 名字必须以字母开头， 后面可以跟字母和数字的任意组合。 长度基本上没有限制。 但是不能使用Java保留字
5.  Java中定义类名标准的 命名规：骆驼命名法，即每个单词的 第一个字母都应该大写。
6. 源代码的文件名必须与公共类的名字相同， 并用.java作为扩展名。所以本文件为`FirstSample.java`
7. 如果巳经正确地命名了这个文件，并且源代码中没有任何录入错误，在编译 这段源代码之后就会得到一个包含这个 类字节码的文件。Java 编译器将字节码文件自动地命名为 FirstSample. class,并存储在源文件的同一个目录下。
8. 使用下面这行命令运行 这个程序：`java FirstSample` ,请记住， 不要添加`.class`扩展名。
9. 运行已编译的程序时，Java虚拟机总是从指定类中的 main方法的代码开始执行。

+ 根据Java语言规范，main方法必须声明为public，可是当main方法不是public时，有些版本的Java解释器也可以执行Java应用程序。 

+ 大括号的放置方式一般有两种，两种方式均可。分别如下

  + ```java
    public class FirstSample {
        public static void main(String[] args) {
            System.out.println("test");
        }
    }
    ```

  + ```java
    public class FirstSample 
    {
        public static void main(String[] args) 
         {
            System.out.println("test");
        }
    }
    ```

    

+ 如果main方法正常退出，那么`Java`应用程 序的退出码为0，表示成功地运行了程序。如果希望在终止程序时返回其他的退出码， 那就需要使用`System.exit`方法。

接下来我们重点看下一下`main`方法里面的内容

```java
{
  System.out.println("test");
}
```

1. 一对大括号表示方法体的开始与结束，在这个方法中只包含一条语句。

2. 在Java中，每个句子必须用分号结束。特别需要说明，回车不是语句的结束标志，因此，如果需要可以将一条语句写在多行上。

3. 我们使用System.out对象并调用了它的println方法。注意，点号 （．）用于调用方法。Java使用的通用语法是

   ```java
   object. method (parameters) 
   ```

4. 调用了`println`方法并 传递给它 一个字符串参数。 这个方法将传递给它的字符串参数显示在控制台上。

5. 与其他程序设计语言中的函数一样， Java 中的方法可以没有参数， 也可以有一个或多个 参数（有的程序员把参数叫做实参）。 即使一个方法没有参数， 也需要使用空括号。

# 注释

Java 中的注释不会出现在可执行程序中。 因此， 可以在 源程序中根据需要添加任意多的注释， 而不必担心可执行代码会膨胀。 

在 Java 中， 有3种标记注释的方式。 分别如下：

1. 使用`\\`表示。注释内容从／／开始到本行结尾。

2. 使用`/*` 和`*/`表示，注释内容为两字符中间。

3. 使用`/**` 和`*/`表示，为文档注释，可以用来自动地生成文档。注释内容为两字符中间。

   ```java
   /**
    *  This is the fi.rst sample program in Core Java Chapter 3
    *  @version 1.01 1997-03-22
    *  @author Gary Cornell
    */
   ```

   值得注意的是，中间的每一行的`*`可以省略，只是`IDEA`会自动加上。

+ 警告：在 Java 中，／＊ ＊／(第二种)注释不能嵌套。 也就是说， 不能简单地把代码用／＊ 和＊／括起。因为中间可能含有`*/`结束字符。

# 数据类型

Java是一种强类型语言。 这就意味着必须为每一个变量声明一种类型。 在Java 中，共有8种基本类型(primitive type)，其中有 4种整型、2种浮点类型、1种字符类型`char`和1种用于表示真值的`boolean`类型 。

## 整形

整型用于表示没有小数部分的数值，允许是负数。Java提供了4种整型，具体内容如表所示。

![image-20221125223238008](https://raw.githubusercontent.com/tanzicai/OSS_IMG/main/202211252232108.png)

1. 在常情况下int类型最常用。但如果想 表示整个地球的居住人口就使用long类型了。
2. 在Java中，整型的范围与运行Java代码的机器无关。 这就解决了软件从一个平台移植到另一个平台， 或者在同一个平台中的不同操作系统之间进行移植给程序员带来的诸多问题。 
3. 长整型数值有一个后缀L或l （如4000000000L)。 
   1. 十六进制数值有一个前缀0x或0X（如 0xCAFE)。 
   2. 八进制有一个前缀0, 例如，010对应十进制中的8。 
   3. 加上前缀0b或0B就可以写二进制数。 （从Java 7开始）
4. 可以为数字字面量加下划线，如用1_000_000（0b11_0100_0010_0100_0000)表示100万。这些下划线只是为了让人更易读。Java编译器会去除这些下划线 。（从Java 7开始）

## 浮点类型



![image-20221125223833137](/Users/zicaitan/Library/Application%20Support/typora-user-images/image-20221125223833137.png)

1. double表示这种类型的数值精度是float类型的两倍（有人称之为双精度数值）。在很多情况下，float类型的精度(6 7位有效数字）并不能满足需求。
2. 只有很少的情况适合使用float类型，例如，需要单精度数的库，或者需要存储大量数据时。
3. float类型的数值有一个后缀F或f （例如，3.14F)。没有后缀F的浮点数值 （如3.14)总是默认为double 类型 。当然，也可以在浮点数值后面添加后缀D或d（例如，3.14D)。
4. 所有的浮点数值 计算都遵循IEEE 754规范。具体来说，下面是用千表示溢出和出错清况 的三个特殊的浮点数值：
   1. 正无穷大
   2. 负无穷大
   3. NaN（不是一个数字,计算0/0或者负数的平方根结果为 NaN，所有 “非数佳” 的值都认为是不相同的。判断是否是NaN需要调用`Double.isNaN(x)`来验证。
5. 浮点数值不适用于无法接受舍入误差的金融计算。如果在数值计算中不允许有任何舍入误差， 就应该使用BigDecimal类。

## char（字符）类型

char类型原本用于表示单个字符。 不过 现在情况已经有所变化。 如今， 有些Unicode 字符可以用一个char值描述，另外一些Unicode字符则需要两个char值。这个我们后面介绍。[Unicode和char类型](#test2)

char类型的字面量值要用单引号括起来。 例如：＇A＇ 是编码值为65的字符常量。 它与 "A” 不同，“A”是包含一个字符A的字符串。char类型的值可以表示为十六进制值， 其范酣从 \u0000到＼uFFFF。例如，＼u2122表示商标符号(™ ), \u03C0表示希腊字母 'lT 。

![image-20221125224725306](https://raw.githubusercontent.com/tanzicai/OSS_IMG/main/202211252247402.png)

注意：一定要当心注释中的＼u，下面的注释内容会出错。因为＼u后面并没有跟着4个十六进制数。

```java
// look inside c:\users 
```

## Unicode和char类型

<a id="test2">Unicode和char类型</a>：要想弄清char类型， 就必须了解Unicode编码机制。 我们先了解一下编码机制。

在Unicode出现之前， 已经有许多种不同的标准： 美国的ASCII、 西欧语言中的 ISO 8859-1、 俄罗斯的KOI-8、 中国的GB1 803 0和BIG-5等。 

如果你学过`C语言`的话，你肯定对ASCII很熟悉，我们很多地方都会用到。但是他其实很小，只有小写大写26个字母、一部分符号和一些控制字符，没有其他国家的字符。其他国家也发展的属于自己国家的编码。这时候问题就出来了。

1. 一个是对于任意给定的代码值， 在不同的编码方案下有可能对应不同的字母，
2. 二是采用大字符集的语言其编码长度有可能不同。

比如我们学习`C语言`常见的的`锟斤拷`和`烫烫烫`，就是GBK编码和UTF-8编码相互读取出现的问题、

设计Unicode编码的目的就是要解决这些问题。 在20世纪80年代开始启动统一工作时， 人们认为两个字节的代码宽度足以对世界上各种语言的所有字符进行编码，并有足够的空间留给未来扩展， 当时所有人都这么想。 在1991 年发布了Unicode1.0, 当时仅占用65 536个 代码值中不到一半的部分。 

在设计 Java时决定采用16位的Unicode字符集， 这比使用 8位字符集的其他程序设计语言有了很大的改进。

即使这样，还是出现了问题。 经过一段时间后， Unicode字符超过了65 536 个， 其主要原因是增加了大址的汉语、 日语和韩语中的表意文字。 现在，16位的char类型已 经不能满足描述所有Unicode字符的需要了。

那我们怎么解决呢？

Java语言从Java 5开始如何解决这个问题。 

+ 码点(code point)：是指与一个编码表中的某个字符对应的代码值。 在Unicode标准中， 码点采用十六进 制书写， 并加上前缀U+， 例如 U+ 0041就是拉丁字母A的码点。 
+ Unicode的码点可以分成17个 代码平面(code plane)。 第一个代码平面称为基本多语言平面(basic multilingual plane)， 包括码点从U+0000到 U+FFFF的 “经典“ Unicode代码；

具体是怎么样的呢？

UTF-16编码采用不同长度的编码表示所有Unicode码点。 在基本多语言平面中，每个字符用16位表示， 通常称为代码单元(code unit)；最重要的是在基本多语言平面中我们有2048个字符没有使用，例如：

+ U+D800 ~ U+DBFF用千第一个代码单元
+ U+DC00~ U+DFFF用千第二个代码单 元

那么我们就很简单的分辨一个代码单元是一个字符的编码， 还是一个辅助字符的第一或第二部分。

例如：码点为U+1D546, 编码为两个代码单元 U+D835和U+DD46。

现在基本了解了Unicode编码了，也更清楚了在Java中，char类型描述了UTF-16编码中的一个代码单元。所以我们知道前面说的char可以表示一个字符，也可以表示一个字符的2部分中的一个部分了吧。

但是最后还是要说明：强烈建议不要在程序中使用 char类型，除非确实需要处理UTF-16代码单元。 最好将字符串作为抽象数据类型处理，也就是`Char`类型。我们将在后面讨论他。

## boolean类型

boolean（布尔）类型有 两个值：false和true, 用来判定逻辑条件。 但是与C/C++不同，整型值和布尔值之间不能进行相互转换。

#  变量与常量

与所有程序设计语言一样，Java也使用变最来存储值。常量就是值不变的变量 。简单的讲变量就是可以改变的量，长量就是不可以改变的量。

## 声明变量

首先，我们看一下例子：

```java
double salary;
int vacationDays; 
long earthPopulation; 
boolean done; 
```

所以我们可以总结出JAVA的声明变量方式：

```java
variableType variableName; 
```

1. 可以看到， 每个声明都以分号结束 。声明是一条完整的Java语句，所以必须有分号。
2. 变盘名必须是一个以字母开头并由字母或数字构成的序列。 但是与很多语言不同的是，由于JAVA使用了Unicode编码，所以我们的范围更大一下：母包括'A'~'Z'、'a'~'z'、'_＇、＇$ ＇或在某种语言中表示字母的任何Unicode字符。
3. 但是’+‘和'©'这样的符号不能出现在变量名中， 空格也不行，不能使用Java保留字作为变量名。 单下划线`_`不能作为变量名。 
4. 变量名中所有的字符都是有意义的（便于阅读理解）， 并且大小写敏感。
5. 变扯名的长度基本上没有限制。
6. 尽管＄是是合法的，但是不建议使用，他是JAVA编译器和其他生成工具使用的。

## 变量初始化

声明一个变量之后， 必须用赋值语句对变量进行显式初始化， 千万不要使用未初始化的变量的值。 例如，Java编译器认为下面的语句序列（在方法中使用）是错误的：

```java
int vacationDays; 
System.out.println(vacationDays); // ERROR--variable not initialized 
```

初始化赋值的格式如下：

```java
variableType variableName = variableValue;
ariableName = variableValue;
```

可以直接声明的时候初始化，也可以先声明在初始化。这两者没什么不同。

从`JAVA10`开始， 对于局部变量， 如果可以从变量的初始值推断出它的类型，就不再需要声明类型。只需要使用关键宇var而无须指定类型。这是非常有用且推荐使用的。

最后在Java中可以将声明放在代码中的任何地方。但是为了便于阅读，尽量声明变量在使用变量的附近。

## 常量

在Java中，利用关键字final指示常量。使用格式如下：

```java
final variableType variableName = variableValue;
```

关键字final表示这个变扯只能被赋值一次。一旦被赋值之后，就不能够再更改了。 习惯上，常扯名使用全大写。

同时，在Java中，经常希望某个常扯可以在一个类的多个方法中使用， 通常将这些常量称为类常量(class constant)。可以使用关键字`static final`设置一个类常置。格式如下：

```java
static final variableType variableName = variableValue;
```

需要注意，他的位置在类里面，但是在方法外。

常量被声明为public, 那么其他类的方法也可以使用这个常量。 后面我们会详细介绍这个：

```java
public static final variableType variableName = variableValue;
```

## 枚举类型

变量的取值只在一个有限的集合内。

 例如，销售的服装或比萨只有小、中、 大和超大这四种尺寸。 当然，可以将这些尺寸分别编码为1、2、3、4或5、M、L、X。 但这种设 置很容易出错。 很可能在变量中保存的是一个错误的值（如0或m)。

针对这种情况，可以自定义枚举类型。 枚举类型包括有限个命名的值。 例如:

```java
enum Size { SMALL, MEDIUM, LARGE, EXTRA_LARGE };
```

现在，可以声明这种类型的变量：
```java
Sizes = Size.MEDIUM; 
```

沁ze类型的变量只能存储这个类型声明中给定的某个枚举值，或者特殊值`null` ，null表示这个变量没有设置任何值。

后面我们会详细介绍这种类型。

# 运算符

运算符用千连接值。 Java提供了一组丰富的算术、逻辑运算符以及数学函数。

## 算术运算符

在Java中，使用算术运算符＋、一、＊、／表示加、减、乘、除运算。 

+ 当参与`/`运算的两个操作数都是整数时，表示整数除法；
+ 否则，表示浮点除法。 
+ 整数的求余操作（有时称为取模）用％表示。

注意：整数被0除将会产生一个异常，而浮点数被0除将会得到无穷大或NaN结果。

## 数学函数与常量

在Math类中， 包含了各种各样的数学函数。 在编写不同类别的程序时， 可能需要的函数也不同。一个数值的平方根， 可以使用sqrt方法：

```java
double x = 4; 
double y = Math.sqrt(x); 
System.out.println(y); // prints 2.0 
```

`floorMod`方法是的一个数对一个正数取模使总会得到一个正数，

```java
floorMod(position+ adjustment, 12 ) // 总会得到一个  11 之间的数。
```

Math类提供了一些常用的三角函数：

````java
Math.sin()
Math.cos()
Math.tan()
Math.atan()
Math.tan2()
````

还有指数函数以及它的反函数一自然对数以及以10为底的对数：

```java
Math.exp()
Math.log()
Math. log10() 
```

最后，Java还提供了两个用于表示 7l' 和e常量的最接近的近似值：

```java
Math.PI 
Math.E 
```

## 数值类型之间的转换

![image-20221126005531662](https://raw.githubusercontent.com/tanzicai/OSS_IMG/main/202211260055889.png)

+ 在图中有6个实线箭头， 表示无信息丢失的转换；
+ 另外有3个虚线箭头， 表示可能有精度损失的转换。

当用一个二元运算符连接两个值时（例如 n + f, n是整数， f是浮点数）， 先要将两个操作 数转换为同一种类型， 然后再进行计算。

+ 如果两个操作数中有一个是double类型， 另一个操作数就会转换为double类型。
+ 否则， 如果其中一个操作数是float类型， 另一个操作数将会转换为float类型。
+ 否则， 如果其中一个操作数是long类型， 另一个操作数将会转换为long类型。
+ 否则， 两个操作数都将被转换为int类型。

## 强制类型转换

在必要的时候，int类型的值将会自动地转换为double类型。

但另 一方面，有时也需要将double转换成int。在Java中，允许进行这种数值之间的类型转换，当然，有可能会丢失一些信息。这种可能损失信息的转换要通过`强制类型转换`(cast)来完成。格式如下：

```java
targetVariableType newVariableName = (targetVariableType) oldVariableName; 
```

注意：不要在boolean类型与任何数值类型之间进行强制类型转换，这样可以防止发生一些常见的错误。只有极少数的情况才需要将布尔类型转换为数值类型，这时可以使用条件表达式b? 1:8。

## 结合赋值和运算符

可以在赋值中使用二元运算符，这是一种很方便的简写形式。`a+=b`：等于`a=a+b`

## 自增与自减运算符

程序员都知道加1、减1是数值变批最常见的操作。

+ `a++`：变量使用后+1
+ `++a`：变量+1后使用
+ `a--`：变量使用后-1
+ `--a`：变量-1后使用

## 关系和boolean运算符

Java包含丰富的关系运算符。 要检测相等性， 可以使用两个等号`==`。要检测不相等性， 可以使用`!=`。

```java
3 == 7 ;//boolean = false
3 != 7 ;//boolean = true
```

最后， 还有经常使用的 ＜ （小于）、 ＞ （大于）、 ＜＝ （小于等千）和＞＝ （大千等于）运算符。 

JAVA使用&&表示逻辑 ”与 “ 运算符， 使用 11表示逻辑 ”或“ 运算符。 从！＝运算符可以想到， 感叹号！就是逻辑非运算符。

其中，&&和||运算符是按照 “短路” 方式来求值的：如果第一个操作数已经能够确定表达式的值， 第二个操作数就不必计算了。如果用&&运算符合并两个表达式，使用格式为：

```java
expression1 & &expression2 
```

且已经计算得到第一个表达式的真值为false , 那么结果就不可能为true。

最后一点， Java支持三元操作符`?:`， 这个操作符有时很有用。使用如下：

```java
condition ? expression1 : expression2 
```

+ condition：true时，调用expression1
+ condition：false时，调用expression2

## 位运算符

处理整型类型时， 可以直接对组成整数的各个位完成操作。 这意味着可以使用掩码技术得到整数中的各个位，位运算符包括：

1. & ：("and") 
2. | ：("or") 
3. ^ ：("xor")
4. -：("not")

另外，还有＞＞和＜＜运算符可以将位模式左移或右移。＞＞＞运算符会用0填充高位，这与＞＞不同，它会用符号位填充高位。 但是不存在＜＜＜运 算符。

如果你学过二进制相关内容，这对你而言应该很容易理解。

## 括号与运算符级别

表给出了运算符的优先级。 

1. 如果使用圆括号，优先计算。
2. 如果不使用圆括号，就按照给出的运算符优先级次序进行计算。 
3. 同一个级别的运算符按照从左到右的次序进行计算 （右结合运算符除外）。

![image-20221126010915185](https://raw.githubusercontent.com/tanzicai/OSS_IMG/main/202211260109375.png)

## 字符串

从概念上讲，Java字符串就是Unicode字符序列。例如，字符串''Java\u2122"由5个Unicode字符J、a、V、a和TM组成。

但是记住Java没有内置的字符串类型，而是在标准Java类库中提供了一个预定义类，很自然地叫做String。但是他并不是基本类型。

我们认为每个用双引号括起来的字符串都是String类的 一个实例：

```java
String e = "";//an empty string 
String greeting = "Hello"; 
```

### 子串

St ring类的substring方法可以从一个较大的字符串提取出一个子串。记住JAVA大部分函数的参数实行的是左闭右开，也就是说左边的是有效的第一个数字，右边的无效的第一个数字。

```java
String greeting = "Hello"; 
String s = greeting.substring(0, 3); //Hel
```

### 拼接

与绝大多数程序设计语言一样，Java语言允许使用＋号连接（拼接） 两个字符串。（字符串之间没有空格，＋号完全按照给定的次序将两个字符串拼接起来）

```java
String expletive = "Expletive"; 
String PG13 = " deleted"; 
String message= expletive+ PG13; //Expletivedeleted
```

当将一个字符串与一个非字符串的值进行拼接时，后者会转换成字符串

```java
int age = 13; 
String rating = "PG" + age; 
System.out.println("The answer is "+ answer); //The answer is PG13
```

### 不可变字符串

St ring类没有提供修改字符串中某个字符的方法。 所以在Java文档中将String类对象称为是`不可变的(immutable)`，注意这里并不是说变量不可变，只是变量指向的字符串序列不可变。我们有必要区分一下。

同时为了提高效率，JAVA编译器可以让字符串共享。可以想象将各种字符串存放在公共的存储池中。字符串变量指向存储池中相应的位置。 如果复制一个字符串变址， 原始字符串与复制的字符串共享相同的字符。

那我们不要的字符串会不会产生内存泄漏呢？毕竟， 原始字符串在堆中分配。 十分幸运，Java 将自动地进行垃圾回收。 如果一个内存块不再使用了， 系统最终会将其回收。程序员不需要关注这些。

### 检测字符串是否相等

可以使用equals方法检测两个字符串是否相等。使用方法

```java
String1.equals(String1);
```

+ 如果字符串s与字符串t相等， 则返回true;
+ 否则， 返回false。

需要注意的是，s与t可 以是字符串变量， 也可以是字符串字面量(即直接使用双引号引起来的字符串)。

要想检测两个字符串是否相等， 而不区分大小写， 可以使用`equalslgnoreCase`方法。 使用方法和上边一样。

注意一定不要使用`==`运算符检测两个字符串是否相等！这个运算符只能够确定两个字符串是否存放在同一个位置上，即稚嫩检测他们是不是同一个人，而不能检测他们是不是长得一样。

诶，这时候你可能会有疑问：上面不是说了字符串是共享的吗？那不是一样的字符串肯定是同一个字符串咯？

当然虚拟机始终将相同的字符串共享， 就可以使用`==`运算符检测是否相等。 但实际上只有字符串字面量是共享的， 而`＋`或`substring`等操作得到的字符串并不共享。他们会重新创建在堆中。

### 空串与Null串

我们先区分一下概念：

+ 空串 ”“ 是长度为0的字符串。 空串是一个Java对象，有自己的串长度(0)和内容（空）
+ String变量还可以存放一个特殊的值，名为null, 表示目前没有任何对象与该变量关联。

### 码点与代码单元

我们在上面讨论过，char数据类型是一个采用UTF-16 编码表示Unicode码点的代码单元。最常用的Unicode字符使用一个代码单元就可以表示，而辅助字符需要一对代码单元表示（也就是两个char）。

而`length`方法将返回采用UTF-16编码表示给定字符串所需要的代码单元数量。 也就是可以用多少个char表示。

要想得到实际的长度， 即码点数量， 可以调用codePointCount()

```java
int cpCount = greeting.codePointCount(0, greeting.length()); 

char first= greeting.charAt(0); // first is 'H' 
char last= greeting.charAt(4); // last is'o' 
```

调用`s.charAt (n)`将返回位置n的代码单元，n介千0 ~ s. length () -1之间。 

### String API 

Java中的 String类包含了50多个方法。 令人惊讶的是它们绝大多数都很有用， 可以想见 使用的频率非常高。 

在这里， 一般不列出某个类的所有方法， 而是选择一些最常用的方法， 并以简洁的方式 给予描述。 部分版本需要8以上的，都会标注使用最低版本。

+ char charAt(int index)：返回给定位置的代码单元。除非对底层的代码单元感兴趣， 否则不需要调用这个方法。
+ int codePointAt(int index) ：返回从给定位置开始的码点 。
+ int off setByCodePoints (int sta rtlndex, int cpCount)：返回从startlndex码点开始，cpCount个码点后的码点索引。
+ int comp a re To (String other) ：
  + 按照字典顺序，如果字符串位于other之前， 返回一个负数；
  + 如果字符串位于other之后， 返回一个正数；
  + 如果两个字符串相等， 返回0。
+ Int Stream codePoints ()：将这个字符串的码点作为一个流返回。 调用toArray将它们放在个数组中。
+ new St ring (int [] codePoints, int offset, int count)：用数组中 从offset开始的count个码点构造一字符串。
+ boo lean empty() ： 如果字符串为空， 返回true。
+ 【11】boolean blank()： 如果字符串为者由空格组成， 返回true。
+ boolean equals(Object other)：如果字符串与other相等， 返回true。
+ boo lean equa lslgnoreCase (String other)：如果字符串与other相等（忽略大小写）， 返回true。
+ boolean startsWith(String prefix)
+ boolean endsWith(String suffix)：如果字符串以prefix开头或 以suffix或结尾， 则返回true。
+ int indexOf (String str)
+ int indexOf (String st r, int f rornlndex)
+ int indexOf (int c p)
+ int indexOf(int cp, int frornlndex)：返回与字符串str或码点cp匹配 的第一个子串的开始位置 。从索引 0或 frornlndex开始匹配。 如果在原始字符串中不存在str,则返回－1。
+ int lastlndexOf(String str)
+ int lastindexOf (St ring st r, int from Index)
+ int lastindexOf (int cp)•
+ int lastindexOf(int cp, int frornlndex)：返回与字符串str或码点cp匹配 的最后一个子串的开始位置。 从原始字符串末尾或 frornlndex开始匹配。
+ int length ()：返回字符串代码单元的个数。
+ int codePointCount (int sta rtlndex, int end Index)：返回startlndex和endlndex-1之间的码点个数。
+ String rep lace(CharSequenceo ldString, CharSequence newSt ring)：返回一个新字符串。这个字符串用newString 代替原始字符串中所有的 oldString。可以 用String或StringBuffer对象作为 CharSequence参数。
+ String substring(int beginlndex)
+ String substring (int begin Index, int end Index)：返回一个新字符串。这个字符串包含原始字符串中从 beginIndex 到字符串未尾或endlndex-1的所有代码单元。
+ String tolowerCase()
+ String toUpperCase()：返回一个新字符串。这个字符串将原始字符串中的大写字母改为小写 ， 或者将原始字 符串中的所有小写字母改成大写字母。
+ String trim()
+ 【11】String strip() ：返回一个新字符串。这个字符串将删除原始字符串头部和尾部小于等千 U+0020 的字 符(trim)或空格(strip)。
+ String join(CharSequence delimiter,CharSequence... elements) ：返回一个新字符串，用给定的定界符连接所有元素。
+ 【11】Stringrepeat (int count) ：返回一个字符串，将当前字符串重复count次。

### 构建字符串

如果需要用许多小段的字符串来构建一个字符串，那么应该按照下列步骤进行。

```java
StringBuilder builder= new StringBuilder();
//当每次需要添加一部分内容时，就调用append方法。
builder.append (ch) ; / / appends a sing le character 
builder.append (string) ； /／appends a string 
String completedString = builder.toString ();//
```

`StringBuilder`类在Java 5中引入。 这两个类的API是一样的。

+ StringBuilder前身是`StringBuffer`，它的效率稍有些低，但允许采用多线程的方式添加或删除宇符。
+ 如果所有字符串编辑操作都在单个线程中执行（通常都是这样），则应该使用StringBuilder。

下面的 API注释包含了StringBuilder类中的重要方法。

+ StringBuilder()：构造一个空的字符串构建器。
+ int length ()：返回构建器或缓冲器中的代码单元数量。
+ StringBuilder append (String str)：追加一个字符串并返回this。
+ StringBuilde r append (char c)：追加一个代码单元并返回this。
+ StringBuilder appendCodePoint(int cp)：追加一个码点并将其转换为一个 或两个代码单元并返回this。
+ void setCharAt(int i, char c)：将第i个代码单元设置为c。
+ StringBuilder insert(int offset, String str)：在 offset位置插入一个字符串并返回this。
+ StringBuilder insert(int offset, char ch)：在 offset位置插入一个代码单元并返回this。
+ St ringBuilder delete(int startindex, int endindex)：删除偏移量从startindex到 endindex-1的代码单元并返回this。
+ String toSt ring ()：返回一个与构建器或缓冲器内容相同的字符串。

# 输入与输出

为了增加后面示例程序的趣味性， 需要程序能够接受输入， 并适当地格式化程序输出。 当然， 现代的程序都使用GUI收集用户的输入。

## 读取输入

要想通过控制台进行输入， 首先需要构造一个与 “标准输入流“ System.in关联的Scanner对象。

```java
Scanner in = new Scanner(System.in); 
```

现在， 就可以使用Scanner 类的各种方法读取输入了。 例如， nextline方法将读取一行输入。

```java
System.out.print("What is your name?"); 
String name = in.nextLine (); 
```

在这里，使用nextline方法是因为在 输入行中有可能包含空格。 要想读取一个单词（以空白符作为分隔符）， 可以调用

```java
String firstName = in.next(); 
```

要想读取一个整数， 就调用nextlnt方法。

```java
System.out.print("How old are you?"); 
int age = in.next!nt () ; 
```

因为输入是可见的， 所以Scanner类不适用于从控制台读取密码。JAVA6引入了Console来实现：

```java
Console cons = System.console(); 
String username = cons.readline ("User name: ");
char[] passwd = cons.readPassword("Password: "); 
```

为安全起见，必须每次读取一行输入， 而没有能够读取单个单词或数值的方法。

1.  返回的密码存放在 一个宇符数组中， 而不是宇符串中。 
2. 在对密码处理完成之后， 应该马上用一个填充值覆盖数组元素。

## 格式化输出

在早期的Java版本中，格式化数值曾引起过 一些争议。庆幸的是，Java 5沿用了C语言函数库中的printf方法。 这对你而言，应该很好理解了。

```java
System.out.printf("Hello, %s. Next year, you'll be %d", name, age); 
```



![image-20221126015251038](https://raw.githubusercontent.com/tanzicai/OSS_IMG/main/202211260152346.png)

![image-20221126015344984](https://raw.githubusercontent.com/tanzicai/OSS_IMG/main/202211260153239.png)

可以使用静态的String. format方法创建一个格式化的字符串，而不打印输出：
```java
String message= String.format("Hello, %s. Next year, you'll be %d", name, age); 
```

printf方法中日期与时间的格式化选项已经不再使用。 对千新的代码， 应当使用卷java.time包的方法。

## 文件输入与输出

要想读取一个文件， 需要构造一个Scanner对象， 如下所示：

```java
Scanner in= new Scanner(Path.of("myfile.txt"), StandardCharsets.UTF_8);
```

如果文件名中包含反斜杠符号， 就要记住在每个反斜杠之前再加一个额外的反斜杠转义： “c:\\\mydirectory\\\myfile.txt ”。

要想写入文件， 就需要构造一个PrintWriter对象。 在构造器(constructor)中， 需要提供 文件名和字符编码：

```java
PrintWriter out = new PrintWrite 「("myfile.txt", StandardCharsets.UTF_8);
```

如果文件不存在， 创建该文件。可以像输出到System.out 一样使用print、println以及 printf命令。

# 控制流程

对于控制流程这里和其他语言一样，我们简单介绍：

## 条件语句

1. if (condition) statement ：单条件语句
2. if (condition) statement1 else statement2 双条件语句
3. if (condition) statement1 if (condition) statement2 else statement3 多条件语句

## 循环

1. while (condition) statement 
2. do statement while (condition); 
3. for循环

## 多重选择：switch语句

在处理多个选项时，使用if/else 结构显得有些笨拙。Java有一个与CIC+＋完全一样的 switch语句。但是不建议使用。

# 大数

如果基本的整数和浮点数精度不能够满足需求， 那么可以使用］ava.math包中两个很有用 的类 ： Biglnteger 和BigDecimal。

这两个类可以处理包含任意长度数字序列的数值。

+ Biglnteger 类实现任意精度的整数运算
+ BigDecimal实现任意精度的浮点数运算。

使用静态的valueOf方法可以将普通的数值转换为大数：

```java
Biglnteger a= Biglnteger.value0f(l00); 
```

对千更大的数， 可以使用一个带字符串参数的构造器：

```java
Biginteger reallyBiginteger
= new Biginteger("222232244629420445529739893461909967206666939096499764990979600"); 
```

遗憾的是， 不能使用人们熟悉的算术运算符（如： ＋和＊）处理大数， 而需要使用大数类中的add和multiply方法。

```java
Biginteger c = a.add(b); // c =a+ b 
Biginteger d = c.multiply(b.add(Biginteger.value0f(2))); // d = c * (b + 2) 
```

# 数组

## 声明数组

数组是一种数据结构， 用来存储同一类型值的集合。 通过一个整型下标 (index, 或称索引）可以访问数组中的每一个值。 例如 如果a是一个整型数组，a[i ]就是数组中下标为1的整数.

```java
int[] a= new int[100]; // or var a= new int[100]; 
int[] smallPrimes = { 2, 3, 5, 7, 11, 13 }; 
int[] smallPrimes = new int[] { 17, 19, 23, 29, 31, 37 };
```

## 访问数组元素

前面的数组元素的下标为从0~ 99（不是I~100)。一旦创建了数组，就可以在数组中填入元素。

```java
int [] a = new int I 100]; 
for (int i = 0; i < 10(); i++) 
a[i] = i; // fills the array with numbers 0 to 99 
```

+ 创建一个数字数组时，所有元素都初始化为0。
+ boolean数组的元素会初始化为false。
+ 对象数组会初始化为null，表示这些元素（还）未存放任何对象。

##  foreach循环

Java有一种功能很强的循环结构，可以用来依次处理数组（或者其他元素集合）中的每个元素，而不必考虑指定下标值 。

这种增强的for循环的 语句格式为：
```java
for (variable : collection) statement 
```

它定义一个变械用千暂存集合中的每一个元素， 并执行相应的 语句（当然， 也可以是语句块）。collection这一集合表达式必须是一个数组或者 是一个实现了Iterable接口的类对象（例如Arraylist )。我们将在后面讨论。

for each循环语句的循环变量将会遍历数组中的每个元素， 而不是下标值。

## 数组拷贝

在Java中， 允许将一个数组变量拷贝到另一个数组变量。 这时， 两个变量将引用同一个数组：

```java
int[] luckyNumbers = smallPrimes; 
luckyNumbers[S] = 12; // now smallPrimes[S] is also 12 
```

但是请记住这种方法是共享的一个数组，如果需要将一个数组的所有值拷贝到一个新的数组去，就需要使用`Arrays`类的`copyOf`方法：

```java
int[] copiedluckyNumbers = Arrays.copyOf(luckyNumbers, luckyNumbers.length); 
```

+ 如果数组元素是数值型， 那么额外的元素将被赋值为0 ;
+ 如果数组元素是布尔型， 则将赋值为false。 
+  如果长度小千原始数组的长度， 则只拷贝前面的值。

## 命令行参数

```java

public class FirstSample {
    public static void main(String[] args) {
        if (args.length ==0||args[0].equals("h"))
        System.out.print("Hello,");
        else if (args[0].equals("-g"))
        System.out.print("Goodbye,");
        for (int i = 0; i < args.length; i++) {
            System.out.print(" "+ args[0]);
        }
        System.out.println("!");
    }
}
```

如果使用下面这种形式调用这个程序：`java Message -g cruel world `

args数组将包含以下内容：

```bash
args[0]: "-g" 
args[l]: "cruel" 
args[2]: "world" 
```

这个程序会显示下面这个消息：

```bash
Goodbye, cruel world' 
```

## 数组排序

要想对数值型数组进行排序，可以使用A「rays类中的sort方法：

```java
int[] a= new int[l(l000]; 
Arrays.sort(a);
```

这个方法使用了优化的快速排序 (QuickSort) 算法。 快速排序算法对于大多数数据集合来说都是效率比较高的。

+ static String toString(xxx[] a)：
  返回包含a中元素的一个字符串， 这些元素用中括号包围， 并用逗号分隔。 在这个方法以及后面的方法中， 数组元素类型XXX可以是int、long、short、char、byte、 boolean、float或double。
+ static xxx[] copyOf(xxx[] a, int end)
+ static xxx[] copyOfRange(xxx[] a, int start, int end)
  返回与a类型相同的一个数组， 其长度为length或者end-start,数组元素为a的值。 如果end大于a.length,结果会填充0或false值。
+ static void sort(xxx[] a)
  使用优化的快速排序算法对数组进行排序。
+ static int bin a rySearch(xxx[] a,.:1了xx v)
+ static int binarySearch(xxx[] a, int start, int end, xxx v) 
  使用二分查找算法在有序数组a中查找值v。 如果找到V, 则返回相应的下标；否则， 返个负数值r 。 千1是v应插入的位置（为保持a有序）。

+ static void fill(xxx[] a, xxx v)
  将数组的所有数据元素设置为v。
+ static boolean equals(xxx[] a, xxx[] b)
  如果两个数组大小相同， 并且下标相同的元素都对应相等， 返回true。

## 多维数组

多维数组将使用多个下标访问数组元素， 它适用千表示表格或更加复杂的排列形式。

for each循环语句不能自动处理二维数组的每一个元素。 它会循环处理行， 而这些行本身就是一维数组。 要想访问二维数组a的所有元素， 需要使用两个嵌套的循环， 如下所示：

在Java中， 声明一个二维数组相当简单。 例如：
```java
double[][] balances; 
balances= new double[NYEARS][NRATES]; 
```

如果知道数组元素， 就可以不调用new, 而直接使用简写形式对多维数组进行初始化。 例如：

```java
int[][] magicSquare = {{1,2,3},{4,5,6}};
```

一旦数组初始化， 就可以利用两个中括号访问各个元素，例如，`balances[i][j]`

for each循环语句不能自动处理二维数组的每一个元素。 它会循环处理行， 而这些行本身就是一维数组。 

## 不规则数组

到目前为止， 我们看到的数组与其他程序设计语言中提供的数组没有多大区别。

 但在底层实际存在着一些细微的差异， 有时你可以充分利用这一点：Java实际上没有多维数组， 只有一维数组。 多维数组被解释为 “数组的数组” 。而存在数组的数组可以是不同长度的数组。

