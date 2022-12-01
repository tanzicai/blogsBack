---
title: JAVA核心技术(基础)-第四章对象与类
date: 2022-11-26 21:07:21
tags:
	- JAVA
	- JAVA核心技术
	- JAVA基础
categories:
	- JAVA
updated: 2022-11-26 21:07:21
---

JAVA核心技术(基础)-第一章Java程序设计概述[GITHUB站](https://tanzicai.github.io/2022/11/25/JAVA核心技术(基础)-第一章Java程序设计概述/)   [Vercel站](https://tanzicai.github.io/2022/11/25/JAVA%E6%A0%B8%E5%BF%83%E6%8A%80%E6%9C%AF(%E5%9F%BA%E7%A1%80)-%E7%AC%AC%E4%B8%80%E7%AB%A0Java%E7%A8%8B%E5%BA%8F%E8%AE%BE%E8%AE%A1%E6%A6%82%E8%BF%B0/)

JAVA核心技术(基础)-第二章JAVA程序设计环境[GITHUB站](https://tanzicai.github.io/2022/11/25/JAVA核心技术(基础)-第一章Java程序设计概述/)   [Vercel站](https://tanzicai.github.io/2022/11/25/JAVA%E6%A0%B8%E5%BF%83%E6%8A%80%E6%9C%AF(%E5%9F%BA%E7%A1%80)-%E7%AC%AC%E4%B8%80%E7%AB%A0Java%E7%A8%8B%E5%BA%8F%E8%AE%BE%E8%AE%A1%E6%A6%82%E8%BF%B0/)

JAVA核心技术(基础)-第三章Java的基本程序设计结构[GITHUB站](https://tanzicai.github.io/2022/11/25/JAVA核心技术(基础)-第一章Java程序设计概述/)   [Vercel站](https://tanzicai.github.io/2022/11/25/JAVA%E6%A0%B8%E5%BF%83%E6%8A%80%E6%9C%AF(%E5%9F%BA%E7%A1%80)-%E7%AC%AC%E4%B8%80%E7%AB%A0Java%E7%A8%8B%E5%BA%8F%E8%AE%BE%E8%AE%A1%E6%A6%82%E8%BF%B0/)

[JAVA基础笔记集锦](https://tanzicai.vercel.app/categories/)

# 面向对象程序设计概述

学过C语言的都知道，在C语言里里面没有类这些概念，而是过程性描述，这种结构在小型项目中很

面向对象程序设计 (object-oriented programming, OOP) 是当今主流的程序设计范型， 它取代了 20 世纪 70 年代的 “结构化” 或过程式编程技术。 由千 Java 是面向对象的， 所以你必须熟悉 OOP 才能够很好地使用 Java。

面向对象的程序是由对象组成的， 每个对象包含对用户公开的特定功能部分和隐藏的实现部分。 

程序中的很多对象来自标准库， 还有一些是自定义的。 究竟是自己构造对象， 还是从外界购买对象完全取决于开发项目的预算和时间。

![image-20221126212230325](https://raw.githubusercontent.com/tanzicai/OSS_IMG/main/202211262122424.png)

## 类

类 (class) 是构造对象的模板或蓝图。 我们可以将类想象成制作小甜饼的模具 ， 将对象 想象为小甜饼。 由类构造 (construct) 对象的过程称为创建类的实例 (instance) 。

+ 封装 (encapsulation, 有时称为数据隐藏）是处理对象的一个重要概念。 从形式上看， 封装就是将数据和行为组合在一个包中， 并对对象的使用者隐藏具体的实现方式。 
  + 对象中的数据称为实例宇段 (instance field)
  +  操作数据的过程称为方法 (method) 
  + 作为一个类的实例， 特定对象都有一组特定的实例字段值。 这些值的集合就是这个对象的当前状态 (state) 。
  + 无论何时， 只要在对象上调用一个方法， 它的状态就有可能发生改变。

+ 实现封装的关键在于， 绝对不能让类中的方法直接访问其他类的实例字段。 程序只能通过对象的方法与对象数据进行交互。 
+ OOP 的另一个原则是 可以通过扩展其他类 来构建新类。 
  + 在扩展一个巳有的类时， 这个扩展后的新类具有被扩展的类的全部属性和方法。 
  + 你只需 要在新类中提供适用于这个新类的新方法和数据字段就可以了。
  + 通过扩展一个类来建立另外一个类的过程称为继承 (inheritance)

## 对象

要想使用OOP, 一定要清楚对象的三个主要特性：

1. ·对象的行为(beh avior) 一可以对对象完成哪些操作， 或者可以对对象应用哪些方法？
2. 对象的状态(state) －当调用那些方法时， 对象会如何响应？
3. 对象的标识(identity) 一如何区分具有相同行为与状态的不同对象？

同一个类的所有对象实例， 由于支持相同的行为而具有家族式的相似性。 对象的行为是用可调用的方法来定义的。

 每个对象都保存着描述当前状况的信息。 这就是对象的状态。 对象的状态可能会随着时间而发生改变， 但这种改变不会是自发的。 对象状态的改变必须通过调用方法实现。

对象的状态并不能完全描述一个对象。 每个对象都有一个唯一的标识(identity,或称身份）。作为同一个类的实例， 每个对象的标识总是不同的， 状态也往往存在着差异。

## 识别类

首先从识别类开始， 然后再为各个类添加方法。

识别类的一个简单经验是在分析问题的过程中寻找名词， 而方法对应着动词。

## 类之间的关系

在类之间，最常见的关系有

+ 依赖("uses-a")
+ 聚合("has-a")
+ 继承("is-a")

依赖(dependence)， 即 “ uses-a" 关系 ， 是一种最明显的、最常见的关系。 如果一个类的方法使用或操纵另一个 类的对象， 我们就说一个类依赖于另一个类。

聚合(aggregation)，即 “ has-a" 关系， 很容易理解， 因为这种关系很具体。 一个 对象包含另一些对象。 包容关系意味着类A的对象包含类B的对象。

继承(inheritance)， 即 “ is-a" 关系， 表示一个更特殊的类与一个更一般的类之间的关 系。 如果类A扩展类B, 一般类A不但包含从类B继承的方法， 还会有一些额外的功能。

![image-20221126215548460](https://raw.githubusercontent.com/tanzicai/OSS_IMG/main/202211270042199.png)

# 使用预定义类

在Java中， 没有类就无法做任何事情， 我们前面曾经接触过几个类。 然而 并不是所有的类都表现出面向对象的典型特征。 例如，Math类。 

## 对象与对象变量

要想使用对象， 首先必须构造对象， 并指定其初始状态。 然后对对象应用方法。

在Java程序设计语言中， 要使用构造器(constructor, 或称构造函数） 构造新实例。 构造器是一种特殊的方法， 用来构造并初始化对象。

 下面看一个例子。 在标准Java库中包含一个Date类。它的对象可以描述一个时间点，例如，“December 31, 1999, 23:59:59 GMT"。

构造器的名字应该与类名相同。因此Date类的构造器名为Date。要想构造一个Date对 需要在构造器前面加上new操作符，如下所示：
```java
new Date();
```

这个表达式构造了一个新对象。 这个对象被初始化为当前的日期和时间。
如果需要的话，也可以将这个对象传递给一个方法：

```java
System.out.println (new Date()); 
```

或者，也可以对刚刚创建的对象应用一个方法。Date类中有一个toString方法。 这个方法将返回日期的字符串描述。 下面的语句可以说明如何对新构造的Date对象应用toString 方法。

```java
Strings= new Date().toString(); 
```

在这两个例子中 构造的对象仅使用了一次。 通常，你会希望构造的对象可以多次 使用， 因此，需要将对象存放在一个变量中：

```java
Date birthday= new Date(); 
```

定义了一个对象变量birthday, 它可以引用Date类型的对象。 但是， 一定要认识到： 变量 birthday不是一个对象，而且实际上它也没有引用任何对象。 此时还不能在这个变量上使用 任何Date方法。

在Java中， 任何对象变量的值都是对存储在另外一个地方的某个对象的引用。new操作符的返回值也是一个引用。上面的语句中有两个部分。 表达式new Date(）构造了一个Date类型的对象，它的值是对新创建对象的一个引用。 这个引用存储在变量birthday中。

可以显式地将对象变扯设置为null, 指示这个对象变量目前没有引用任何对象。

```java
birthday = null; 
```

## Java类库中的LocalDate类

Date类的实例有一个状态， 即特定的时间点。尽管在使用Date类时不必知道这一点， 但时间是用距离一个固定时间点的毫秒数（可 正可负） 表示的， 这个时间点就是所谓的`纪元(epoch)`， 它是UTC时间 1970 年 1 月 1 日00:00:00。

类库设计者决定将保存时间与给时间点命名分开。 

+ 一 个是用来表示时间点的Date类；
+ 一 个是用大家熟悉的日历表示法表示日期的LocalDate类

但是不要使用构造器来构造LocalDate类的对象。 实际上， 应当使用静态工厂方法(factory method)， 它会代表你调用构造器。 下面的表达式：

```java
LocalDate.now() 
```

即使用静态方法构造一个新对象， 表示构造这个对象时的日期。

可以提供年、月和日来构造对应一个特定日期的对象：

```java
LocalDate newYearsEve = Loca1Date.of(1999, 12, 31) 
```

一旦有了一个LocalDate对象， 可以用方法getYear、getMonthVa1ue和getDayOfMonth得到年、 月和日：

```java
int year = newYearsEve.getYear(); // 1999 
int month = newYearsEve.getMonthValue(); // 
12 int day = newYearsEve.getDayOfMonth (); // 31 
```

看起来这似乎没有多大的意义， 因为这正是构造对象时使用的那些值。 

不过，有时可能有一个计算得到的日期， 然后你希望调用这些方法来了解它的更多信息。 

例如，`plusDays`方法会得到一个新的`LocalDate`,如果把应用这个方法的对象称为当前对象，这个新日期对象则是距当前对象指定天数的一个新日期：

```java
LocalDate aThousandDayslater = newYearsEve.plusDays(1000); 
year= aThousandDayslater.getYear(); // 2002 
month = aThousandDayslater.getMonthValue (); / / 09 
day= aThousandDayslater.getDayOfMonth(); // 26 
```

## 更改器方法与访间器方法

上面的plusDays调用之后newYearsEve会有什么变化？它会改为l000天之后的日期吗？

事实上，并没有。plusDays方法会生成一个新的LocalDate对象，然后把这个新对象赋给aThousandDayslater变址。原来的对象不做任何改动。

我们把只访问对象而不修改对象的方法有时称为访问器方法(accessormethod)，与LocalDate.plusDays方法不同，GregorianCalendar.add方法是一个更改器方法(mutatormethod)。 调用这个方法后，someDay对象的状态会改变。

```java
year= someDay.get(Calendar.YEAR); // 2002 
month= someDay.get(Calendar.MONTH) + 1; // 09 
day= someDay.get(Calendar.DAY_OF_MONTH); // 26 
```

```java
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.Month;

public class CalendaTest {
    public static void main(String[] args) {
        LocalDate now = LocalDate.now();
        int month = now.getMonthValue();
        int dayOfMonth = now.getDayOfMonth();
        LocalDate localDate = now.minusDays(dayOfMonth - 1);
        DayOfWeek dayOfWeek = localDate.getDayOfWeek();
        int value = dayOfWeek.getValue();
        System.out.println("Mon Tue Wed Thu Fri Sat Sun");
        for (int i = 1; i < value; i++) {
            System.out.print("    ");
        }
        while(localDate.getMonthValue() == month){
            System.out.printf("%4d",localDate.getDayOfMonth());
            localDate = localDate.plusDays(1);
            if(localDate.getDayOfWeek().getValue() == 1)System.out.println("");
        }
    }
}
```

```bash
Mon Tue Wed Thu Fri Sat Sun
       1   2   3   4   5   6
   7   8   9  10  11  12  13
  14  15  16  17  18  19  20
  21  22  23  24  25  26  27
  28  29  30
Process finished with exit code 0

```

+ static LocalDate now()
  构造一个表示当前日期的对象。

+ static Loe a lDate of (int year, int month, int day)
  构造一个表示给定日期的对象。

+ int getYear()

+ int getMonthValue()

+ int getDayOfMonth() 
  得到当前日期的年、 月和日。

+ DayOfWeek ge tDayOfWeek
  得到当前日期是星期几， 作为DayOfWeek类的一个实例返回。 调用getValue来得到 1 ~ 7之间的一个数， 表示这是星期几， 1表示星期一， 7表示星期日。

+ LoecalDateplusDays (int n)

+ Loca lDate minusDays (int n)

  生成当前日期之后或之前n天的日期。

## 用户自定义类

自定义员工类，首先们编写以下代码：

```java

class Employee{
    private String name;
    private double salary;
    private LocalDate localDate;

    public Employee(String name,double salary,int year,int month,int day){
        this.name = name;
        this.salary = salary;
        this.localDate = LocalDate.of(year,month,day);
    }

    public String getName() {
        return name;
    }

    public double getSalary() {
        return salary;
    }

    public LocalDate getLocalDate() {
        return localDate;
    }

    @Override
    public String toString() {
        return "Employee{" +
                "name='" + name + '\'' +
                ", salary=" + salary +
                ", localDate=" + localDate +
                '}';
    }
}
```

我们会在后面再详细解释每一个部分的作用，现在我们首先看一下这个自定义的类怎么使用：

```java

public class EmployeeTest {
    public static void main(String[] args) {
        Employee[] employees  = new Employee[3];

        employees[0] = new Employee("zahngsan",3000,1999,12,12);
        employees[1] = new Employee("lisi",3000,2300,12,12);
        employees[2] = new Employee("wangwu",3400,2000,12,12);

        for (Employee employee:employees) {
            System.out.println(employee.toString());
        }

    }
}
```

在这个程序中， 我们构造了一个Employee数组， 并填入了3个Employee对象：

```java
Employee[] employees  = new Employee[3];
employees[0] = new Employee("zahngsan",3000,1999,12,12);
employees[1] = new Employee("lisi",3000,2300,12,12);
employees[2] = new Employee("wangwu",3400,2000,12,12);
```

然后调用toString方法打印每个员工的详细信息。

```java
  for (Employee employee:employees) {
            System.out.println(employee.toString());
        }
```

完整程序如下：

```java
import java.time.LocalDate;

public class EmployeeTest {
    public static void main(String[] args) {
        Employee[] employees  = new Employee[3];

        employees[0] = new Employee("zahngsan",3000,1999,12,12);
        employees[1] = new Employee("lisi",3000,2300,12,12);
        employees[2] = new Employee("wangwu",3400,2000,12,12);

        for (Employee employee:employees) {
            System.out.println(employee.toString());
        }

    }
}


class Employee{
    private String name;
    private double salary;
    private LocalDate localDate;

    public Employee(String name,double salary,int year,int month,int day){
        this.name = name;
        this.salary = salary;
        this.localDate = LocalDate.of(year,month,day);
    }

    public String getName() {
        return name;
    }

    public double getSalary() {
        return salary;
    }

    public LocalDate getLocalDate() {
        return localDate;
    }

    @Override
    public String toString() {
        return "Employee{" +
                "name='" + name + '\'' +
                ", salary=" + salary +
                ", localDate=" + localDate +
                '}';
    }
}
```

在这个文件中，我们定义了两个类，

mployee类和带有publi c访问修饰符的EmployeeTest 类。EmployeeTest类包含了main方法，其中使用了前面介绍的指令。

源文件名是EmployeeTest.java, 这是因为文件名必须与public类的名字相匹配。 在文件中， 只能有一个公共类， 但可以有任意数目的非公共类。

## 剖析Employee类

点击IDEA这个按钮我们就可以看到详细的方法列表，我们来看看我们之前编写的Employee类是怎么样的吧。

![image-20221130145217915](https://raw.githubusercontent.com/tanzicai/OSS_IMG/main/202211301452051.png)

点击之后会出现

![image-20221130145420340](https://raw.githubusercontent.com/tanzicai/OSS_IMG/main/202211301454435.png)

关键字private确保只有Employee类自身的方法能够访问这些实例字段，而其他类的方法 不能够读写这些字段。

## 从构造器开始

```java
    public Employee(String name,double salary,int year,int month,int day){
        this.name = name;
        this.salary = salary;
        this.localDate = LocalDate.of(year,month,day);
    }
```

可以看到， 构造器与类同名。 在构造Employee类的对象时， 构造器会运行， 从而将实例字段初始化为所希望的初始状态。

构造器与其他方法有一个重要的不同。 构造器总是结合new运算符来调用。 不能对一个已经存在的对象调用构造器来达到重新设置实例字段的目的。 

总结一下，构造器有以下特点：

1. 构造器与类同名。
2. 每个类可以有一个以上的构造器。
3. 构造器可以有0个、1个或多个参数。
4. 构造器没有返回值。
5. 构造器总是伴随着new操作符一起调用。

## 用var声明局部变量

在Java 10中， 如果可以从变量的初始值推导出它们的类型， 那么可以用var关键字声明`局部变量`， 而无须指定类型。 例如，可以这样声明：

```java
var harry= new Employee("Harry Hacker", 50000, 1989, 10, 1); 
```

不过我们不会对数值类型使用var, 如 int、long或double, 使你不用当0、0L和0.0之间的区别。 对Java API有了更多使用经验后， 你可能会希望更多地使 用var关键字。

## 使用null引用

在4.2.1节中我们已经了解到， 一个对象变量包含一个对象的引用， 或者包含一个特殊值 null，后者表示没有 引用任何对象 。

听上去这是一种处理特殊情况 的便捷机制 ， 如未知的名字或雇用日期。 不过使用null值时要非常小心。

如果对null值应用一个方法， 会产生一个NullPointerException异常。

```java
LocalDate b订thday =, null; 
String s = birthday.toString() ; / / Nu llPointerException 
```

这是一个很严重的错误 ， 类似千 “索引越界“ 异常。 如果你的程序没有 捕获“ 异常， 程序就会终止。 正常情况下， 程序并不捕获这些异常， 而是依赖千程序员从一开始就不要带 来异常。定义一个类时 ， 最好清楚地知道哪些字段可能为null。 

在我们的例子中， 我们不希望 name 或hireDay字段为null。（不用担心salary字段 。 这个字段是基本类型， 所以不可能 是 null。)

hireDay字段肯定是非null的， 因为它初始化为一个新的LocalDate对象。 但是name可能为 null, 如果调用构造器时为n提供的实参是null, name就会是null。

hireDay字段肯定是非null的， 因为它初始化为一个新的LocalDate对象。 但是name可能为 null, 如果调用构造器时为n提供的实参是null, name就会是null。

对此有两种解决方法。 “宽容型” 方法是把null参数转换为一个适当的 非null值：

```jAVA
if (n == null) name = "unknown"; else name = n; 
```

在Java 9中，Objects 类对此提供了一个便利方法：

```java
name = Objects.requireNonNullElse(name,"unknown");
//严格性
name = Objects.requireNonNull(name,"the name can't be null");
```

上面的方法指明要是name对象是null的话，就把name的值设置为unknown，而下面的方法则是如果传入的name是null的话，则抛出异常，message信息显示为the name can't be null。

乍看上去这种做法好像不太有用。不过这种方法有两个好处：

1. 异常报告会提供这个问题的描述。
2. 异常报告会准确地指出问题所在的位置， 否则NullPointerException异常可能在其他地 方出现，而很难追踪到真正导致问题的这个构造器参数。

## 隐式参数与显式参数

```java
    public void raiseSalary(double byPecent){
        double raise = this.salary * byPecent ;
        this.salary += raise;
    }
```

raiseSalary 方法有两个参数。

1. 第一个参数称为隐式(implicit)参数，是出现在方法名前的Employee类型的对象。 
2. 第二个参数是位千方法名后面括号中的数值， 这是一个显式 (explicit)参数。（有人把隐式参数称为方法调用的目标或接收者。）

在每一个方法中，关键字this指示隐式参数。 如果喜欢的话，可以如下改写raiseSalary 方法：

## 封装的优点

```java

    public String getName() {
        return name;
    }

    public double getSalary() {
        return salary;
    }
    
    public LocalDate getLocalDate() {
        return localDate;
    }
```

这些都是典型的访问器方法。

 由千它们只返回实例字段值， 因此又称为宇段访问器。如果将name、salary和hireDay字段标记为公共， 而不是编写单独的访问器方法， 难道不 是更容易一些吗？

不过，name是一个只读字段。 一旦在构造器中设置， 就没有任何办法可以对它进行修改，这样我们可以确保name字段不会受到外界的破坏。

虽然salary不是只读字段， 但是它只能用raiseSala ry方法修改。 特别是一旦这个值出现了错误， 只需要调试这个方法就可以了。如果salary字段是公共的， 破坏这个字段值的捣乱者有可能会出没在任何地方（那就很难调试了）。

有些时候，可能想要获得或设置实例字段的值。 那么你需要提供下面三项内容：

+ 一个私有的数据字段；
+ 一个公共的字段访问器方法；
+ 一 个公共的字段更改器方法。

这样做要比提供一个简单的公共数据字段复杂些， 但却有着下列明显的好处：

首先， 可以改变内部实现， 而除了该类的方法之外， 这不会影响其他代码。

这里简单解释一下，在Java中的赋值引用类型，几个变量引用的是同一个堆中的变量，如果我们想要的是克隆堆中的对象，我们需要使用的`clone`方法来完成。 

![返回可变数据字段的引用](https://raw.githubusercontent.com/tanzicai/OSS_IMG/main/202211301541555.png)

## 基于类的访问权限

从前面巳经知道， 方法可以访问调用这个方法的对象的私有数据。 一个方法可以访问所属类的所有对象的私有数据， 这令很多人感到奇怪！例如， 下面看一下用来比较两个员工的 equals 方法。

```java
public boolean equals(Employee other) ｛ 
  return name.equals(other.name); 
}
```

## 私有方法

在实现一个类时， 由于公共数据非常危险， 所以应该将所有的数据字段都设置为私有的。 然而， 方法又应该如何设计呢？

尽管绝大多数方法都被设计为公共的， 但在某些特殊情况下， 将方法设计为私有可能很有用。 

有时， 你可能希望将一个计算代码分解成若干个独立的辅助方法。 通常， 这些辅助方法不应该成为公共接口的一部分， 这是由千它们往往与当前实现关系非常紧密， 或者需要一个特殊协议或者调用次序。 最好将这样的方法设计为私有方法。

在Java中， 要实现私有方法， 只需将关键字pub lic改为 private即可。

通过将方法设计为私有， 如果你改变了方法的实现方式， 将没有义务保证这个方法依然可用。 如果数据的表示发生了变化， 这个方法可能会变得难以实现， 或者不再需要；这并不重要。 重点在千， 只要方法是私有的， 类的设计者就可以确信它不会在别处使用， 所以可以将其删去。 如果一个方法是公共的， 就不能简单地将其删除， 因为可能会有其他代码依赖这个方法。

## final实例字段

可以将实例字段定义为final。 这样的字段必须在构造对象时初始化。 也就是说， 必须确保在每一个构造器执行之后， 这个字段的值已经设置， 并且以后不能再修改这个字段。 例 如， 可以将Employee类中的name字段声明为final, 因为在对象构造之后， 这个值不会再 改变， 即没有setName方法。

# 静态字段与静态方法

在前面给出的示例程序中，main方法都被标记了static修饰符。 下面来讨论这个修饰符的含义 。

## 静态字段

如果将一个字段定义为static, 每个类只有一个这样的字段。 而对千非静态的实例字段， 每个对象都有自己的一个副本。 例如，假设需要给每一个员工赋予唯一的标识码。 这里给 Employee类添加一个实例字段沁和一个静态字段nextld:

```java
pub lie void set!d (){
  private static int nextld = l; 
private int id; 
}

```

## 静态常量

静态变量使用得比较少，但静态常量却很常用。例如在Math类中定义一个静态常量：

```java
public static final double PI= 3.14159265358979323846;
```

在程序中， 可以用Math.PI来访问这个常量。

如果省略关键字static, PI就变成了Math类的一个实例字段。也就是说， 需要通过Math 类的一个对象来访问PI, 并且每一个Math对象都有它自己的一个PI副本。

你已经多次使用的另一个静态常矗是System.out。 它在System类中声明如下：

```java
public class System{
  public static final PrintStream out =... ; 
}
```

前面曾经多次提到过，由千每个类对象都可以修改公共字段， 所以， 最好不要有公共字 段。然而， 公共常量（即final字段）却没问题。因为out被声明为final, 所以， 不允许再将它重新赋值为另一个打印流：

```java
System.out =  new PrintStream(...); // ERROR--out is final 
```

> 注释：如果查看System类， 就会发现有一个 setOut方法可以将System.out设置为不同的流。 你可能会感到奇怪， 为什么这个方法可以修改final变量的值。原因在于，setOut 方法是一个原生方法， 而不是在Java语言中实现的。原生方法可以绕过Java语言的 访问控制机制。这是一种特殊的解决方法， 你自己编写程序时不要模仿这种做法。

## 静态方法

静态方法是不在对象上执行的方法。例如，Math类的 pow方法就是一个静态方法。表式Math.pow(x, a) 会计算幕x.。在完成运算时， 它并不使用任何Math对象。换句话说， 它没有隐式参数。

可以认为静态方法是没有this参数的方法（在一个非静态的方法中， this参数指示这个 方法的隐式参数， 参见4.3.7节）。Emp loyee类的静态方法不能访问id实例字段， 因为 它不能在对象上执行操作。但是，静态方法可以访问静态字段。

在下面两种情况下可以使用静态方法：

+ 方法不需要访问对象状态，因为它需要的所有参数都通过显式参数提供（例如：Math. pow)。
+ 方法只需要访问类的静态字段（例如：Employee.getNextld)。

## 工厂方法

静态方法还有另外一种常见的用途。类似LocalDate和NumberFormat的类使用静态工厂方法 (factory method)来构造对象 。你已经见过工厂方法LocalDate.now和LocalDate.of。NumberFo rmat 类如下生成不同风格的格式化对象 ：

```java
NumberFormat currencyFormatter = NumberFormat.getCurrencyinstance(); 
NumberFormat percentFormatter = NumberFormat.getPercentlnstance(); 
double x = 0.1; 
System.out.println(currencyFormatte「 .format(x)); // prints $0.10 
System.out.println(pe「centFormatter.format (x)); // prints 10% 
```

为什么NumberFormat类不利用构造器完成这些操作呢？这主要有两个原因：

+ 无法命名构造器。 构造器的名字必须与类名相同。 但是，这里希望有两个不同的名 字， 分别得到货币实例和百分比实例。
+ 使用构造器时， 无法改变所构造对象的`类型`。 而工厂方法实际上将返回DecimalFormat类的对象， 这是NumberFormat的一个子类（有关继承的更多详细内容请参看第5章）。

## main方法

需要注意， 可以调用静态方法而不需要任何对象。

main方法不对任何对象进行操作。 事实上， 在启动程序时还没有任何对象。 静态的main 方法将执行并构造程序所需要的对象。

>  每一个类可以有一个main方法。 这是常用于对类进行单元测试的一个技巧。 

# 方法参数

首先回顾一下在程序设计语言中关于如何将参数传递给方法（或函数） 的一些专业术 语。 

+ 按值调用(callby value)表示方法接收的是调用者提供的`值`

+ 按引用调用(call by reference)表示方法接收的是调用者提供的`变量地址`。

**Java程序设计语言总是采用按值调用。** 

也就是说， 方法得到的是所有参数值的一个副本。 具体来讲， 方法不能修改传递给它的任何参数变量的内容。

但是在java中，我们要分别认识以下以下两种参数的区别。

+ 基本数据类型（数字、 布尔值）。
+ 对象引用。

 一个方法不可能修改基本数据类型的参数， 而对象引用作为参数就不同了， 可以很容易改变。

可以看到， 实现一个改变对象参数状态的方法是完全可以的， 实际上也相当常见。 理由很简单， 方法得到的是对象引用的副本， 原来的对象引用和这个副本都引用同一个对象。

下面总结一下在Java中对方法参数能做什么和不能做什么：

+ 方法不能修改基本数据类型的参数（即数值型或布尔型）。
+ 方法可以改变对象参数的状态。
+ 方法不能让一个对象参数引用一个新的对象。

# 对象构造

前面已经学习了编写简单的构造器， 可以定义对象的初始状态。但是， 由千对象构造非常重要， 所以Java提供了多种编写构造器的机制。 下面将详细介绍这些机制。

## 重载

有些类有多个构造器。 例如， 可以如下构造一个空的StringBuilde r对象：

```java
//
var messages = new StringBuilder(); 
// 可以指定一个初始字符串：
var todolist = new StringBuilder("To do:\n"); 
```

如果多个方法（比如， StringBuilder构造器方法）有相同的名字、 不同的参数， 便出现了重载。 

编译器必须挑选出具体调用哪个方法。 它用各个方法首部中的参数类型与特定方法调用中所使用的值类型进行匹配， 来选出正确的方法。

如果编译器找不到匹配的参数， 就会产生编译时错误， 因为根本不存在匹配， 或者没有一个比其他的更好（这个查找匹配的过程被称为重载解析(overloading resolution)）。

##  默认字段初始化

如果在构造器中没有显式地为字段设置初值， 那么就会被自动地赋为默认值：数值为0、 布尔值为false、对象引用为null。 

>  如果不明确地对字段进行初始化，就会影响程序代码的可读性。

对于引用类型，  这并不是一个好主意。 如果此时调用getName方法或getHireDay方法，就会得到一 个null引用， 这应该不是我们所希望的结果：

```java
LocalDate h = harry.getHireDay(); 
int year = h.getYear(); // throws exception if his null 
```

## 无参数的构造器

很多类都包含一个无参数的构造器， 由无参数构造器创建对象时， 对象的状态会设置为适当的默认值。 例如，以下是Employee类的无参数构造器：

```java
pub lie Employee () {
  name = ""; 
  salary= 0; 
  hireDay = LocalDate.now (); 
}
```

如果写一个类时没有编写构造器， 就会为你提供一个无参数构造器。 这个构造器将所 有的实例字段设置为默认值。 

于是， 实例字段中的数值型数据设置为0, 布尔型数据设置为 false, 所有对象变最将设置为null。

但是，注意如果类中提供了至少一个构造器，但是没有提供无参数的构造器， 那么构造对象时如果
不提供参数就是不合法的。

## 显式字段初始化

通过重载类的构造器方法， 可以采用多种形式设置类的实例字段的初始状态。 

不管怎样调用构造器， 每个实例字段都要设置个有意义的初值， 确保这点总是个好主意。

在执行构造器之前先完成这个赋值操作。 如果一个类的所有构造器都希望把某个特定的实例字段设置为同一个值， 这个语法就特别有用。

## 参数名

在编写很小的构造器时（这十分常见）， 常常在参数命名时感到困惑。我们通常喜欢用单个字母作为参数名：

```java
public Employee(String n, double s) {
  name = n;
  salary = s;
}
```

但这样做有一个缺点： 只有阅读代码才能够了解参数n和参数s的含义。“

有些程序员在每个参数前面加上一个前缀 a":

还是可以用this. salary访问实例字段。 回想一下，this指示隐式参数， 也就是所构造的对象。 下面是一个

```java
public Employee(String n, double s) {
	this.name= name; 
	this.salary= salary; 
}

```

## 调用另一个构造器

关键字this指示一个方法的隐式参数。 不过，这个关键字还有另外一个含义 。

如果 构造器的第一个语句形如this(...），这个构造器将调用同一个类的另一个构造器。 下面是一个典型的例子：

```java
public Employee(double s) {
  // calls  Employee(String, double) 
  this("Employee #" + nextld, s); 
  nextld++; 
}
```

当调用newEmployee(60000)时，Employee(double)构造器将调用Employee(String,double)构造器。

采用这种方式使用this关键字非常有用， 这样对公共的构造器代码只需要编写一次即可。

## 初始化块

前面已经讲过两种初始化数据字段的方法：

+ 在构造器中设置值；
+ 在声明中赋值。

实际上，Java还有第三种机制， 称为初始化块(initialization block)。 在一个类的声明中， 可以包含任意多个代码块。 只要构造这个类的对象， 这些块就会被执行。 例如，

```java
class Employee {
  private static int next!d; 
	private int id; 
	private String name; 
	private double salary; 
	// object initialization block 
  {
    nextid++; 
    id = nextid; 
  }
}
```

在这个示例中， 无论使用哪个构造器构造对象，id字段都会在对象初始化块中初始化。

首先运行初始化块， 然后才运行构造器的主体部分。这种机制不是必需的， 也不常见。 通常会直接将初始化代码放在构造器中。

由于初始化数据字段有多种途径， 所以列出构造过程的所有路径可能让人很困惑。 下面 是调用构造器的具体处理步骤：

1. 如果构造器的第一行调用了另一个构造器， 则基千所提供的参数执行第二个构造器。
2. 否则
   1. 所有数据字段初始化为其默认值(0、false或null)。
   2. 按照在类声明中出现的顺序， 执行所有字段初始化方法和初始化块。
3. 执行构造器主体代码。

当然， 应该精心地组织好初始化代码， 这样有利千其他程序员理解。 例如， 如果让类的构造器依赖千数据字段声明的顺序， 那就会显得很奇怪并且容易引起错误。

可以通过提供一个初始值， 或者使用一个静态的初始化块来初始化静态字段。 前面已经介绍过第一种机制：

```JAVA
static{
  var generator = new Random () ;
  nextld = generator.nextlnt(10000); 
}
```

在类第一次加载的时候， 将会进行静态字段的初始化。 

与实例字段一样， 除非将静态字段显式地设置成其他值， 否则默认的初始值是0、false或null。 

所有的静态字段初始化方法以及静态初始化块都将依照类声明中出现的顺序执行。

## 对象析构与finalize方法

有些 面向对象的程序设计语言， 特别 是C+＋， 有显式的析构器方法， 其中放置 些 当对象不再使用时需要执行的清理代码。

在析构器中，最常见的操作是回收分配给对象的存储空间。 由千Java会完成自动的垃圾回收，不需要人工回收内存，所以Java不支持析构器。

当然，某些对象使用了内存之外的其他资源， 例如，文件或使用了系统资源的另象的句柄。在这种情况下，当资源不再需要时，将 其回收和再利用显得十分重要。

如果一个资源一旦使用完就需要立即关闭，那么应当提供个close 方法来完成必要的清理工作。可以在对象使用完时调用这个close方法。第7章将介绍如何确保自动调用这个方法。

如果可以等到虚拟机退出，那么可以用方法Runtime.addShutdownHook增加一关闭钩(shutdown hook)。在Java9中，可以使用Cleaner类注册一个动作，当对象不再可达时（除了清洁器还能访问，其他对象都无法访问这个对象），就会完成这个动作。

在实际中这些情况很少见。

# 包

Java允许使用包(package) 将类组织在一个集合中。借助包可以方便地组织自己的代码，并将自己的代码与别人提供的代码库分开管理。下面我们将介绍如何使用和创建包。

## 包名

使用包的主要原因是确保类名的唯一性。假如两个程序员不约而同地建立了Employee类。只要将这些类放置在不同的包中，就不会产生冲突。事实上，为了保证包名的绝对唯一 ，要用个因特网域名（这显然是唯一的）的）以逆序的形式作为包名，然后对千不同的工程使用不同的子包。

例如，考虑域名horstmann.com。如果逆序来写，就得到了包名com.horstmann。然个工程名com.horstmann.corejava。 如果再把Employee类放在这个包里，那么这个类的 名就是com.horstmann.corejava.Employee。

## 类的导入

一个类可以使用所属包中的所有类， 以及其他包中的公共类(public class)。我们可以采用两种方式访问另 一个包中的公共类。 第一种方式就是使用完全限定名(fully qualified name)；就是包名后面跟着类名。 

```java
java.time.LocalDate today = java.time.LocalDate.now{); 
```

这显然很烦琐。 更简单且更常用的方式是使用`import`语句。import语句是一种引用包中各个类的简捷方式。 一旦使用了import语句， 在使用类时，就不必写出类的全名了。

可以使用import语句导入一个特定的类或者整个包。import语句应该位千源文件的顶部（但位于package语句的后面 ）。 例如， 可以使用下面这条语句导入java.util包中的所有类。

```java
import java.time.*;

//then 
LocalDate today = LoealDate.now() ; 
```

但是， 需要注意的是，只能使用星号（＊） 导入一个包， 而不能使用import j ava.＊或import java.＊．＊导入以］ava为前缀的所有包。在大多数情况下， 可以只导入你需要的包， 并不必过多地考虑它们。

 但在发生命名冲突 的时候， 就要注意包了。 例如，］ava.util和］ava.sql包都有Date类。 如果在程序中导入了这两个包：

```java
import java.util.*; 
import java.sql.*; 
//在程序中使用Date类的时候，就会出现一个编译错误：

Date today; // ERROR-一java.util.Date or java.sql.Date? 
```

此时编译器无法确定你想使用的是哪一个Date类。可以增加一个特定的import语句来解决这个问题：

```java
import java. util. *; 
import java.sql.*; 
import java.util.Date ; 
```

如果这两个Date类都需要使用， 又该怎么办呢？答案是 ，在每个类名的前面加上完整的包名。

```java
var deadline = new java.util.Date (); 
var today = new java,sql.Date (...) ; 
```

在包中定位类是编译器(compiler)的工作。类文件中的字节码总是使用完整的包名引用其他类。

## 静态导入

有一种import语句允许导入静态方法和静态字段，而不只是类。

 例如，如果在源文件顶部，添加一条指令：

```java
import static java.lang.System.*; 
```

就可以使用`System`类的静态方法和静态字段，而不必加类名前缀：

```java
out.println("Goodbye, Worl d!");
// i.e., System.out 
exit(0); // i.e., System.ex江
```

另外，还可以导入特定的方法或字段：

```java
import static java.lang.System.out; 
```

实际上， 是否有很多程序员想要用简写System.out或System.exit()， 这一点很让人怀疑。这样写出的代码看起来不太清晰。不过，清晰得多。

```java
sqrt(pow(x, 2) + pow(y, 2))
  //来比
Math.sqrt(Math.pow(x, 2) + Math.pow(y, 2)) 
```

## 在包中增加类

要想将类放入包中，就必须将包的名字放在源文件的开头，即放在定义这个包中各个类 的代码之前。

 例如， 程序清单4-7中的文件Employee. java开头是这样的 ：

```java
package com.horstmann.corejava; 
public class Employee 
{
  ...
｝ 
```

如果没有在源文件中放置 package语句，这个源文件中的类就属千无名包(unnamed package)。无名包没有包名 。到目前为止， 我们定义 的所有类都在这个无名包中。

将源文件放到与完整包名匹配的子目录中。 例如，com.horstmann.corejava包中的所有源文件应该放置在子目录com/horstmann/corejava 中(Windows中则是 com\horstmann\corejava)。 编译器将类文件也放在相同的目录结构中。

## 包访问

前面已经接触过访问修饰符 public 和 private。标记为 public 的部分可以由任意类使用；标记为 private的部分只能由定义它们的类使用。 如果没有指定 public 或 private, 这个部分（类、 方法或变量）可以被同一个包中的所有方法访问。下面

## 类路径

在前面已经看到， 类存储在文件系统的子目录中。 类的路径必须与包名匹配。

另外， 类文件也可以存储在 JAR (Java归档）文件中。 在一个 JAR 文件中， 可以包含多个压缩形式的类文件和子目录， 这样既可以节省空间又可以改善性能。在程序中用到第三方的库文件时， 你通常要得到一个或多个需要包含的 JAR 文件。

# JAR文件

在将应用程序打包时，你一定希望只向用户提供一个单独的文件， 而不是一个包含大量 类文件的目录结构，Java归档(JAR)文件就是为此目的而设计的。

一个JAR文件既可以包 含类文件，也可以包含诸如图像和声音等其他类型的文件。此外，JAR文件是压缩的，它使用了我们熟悉的ZIP压缩格式。

## 创建JAR文件

可以使用jar工具制作JAR文件（在默认的JDK安装中，这个工具位千丿dk/bin目录下）。 创建一个新JAR文件最常用的命令使用以下语法：

```bash
jar cvf jarFileName file1 file2...
```

通常，jar命令的格式如下：

```bash
jar options ftle1 ftle2... 
```

可以将应用程序和代码库打包在JAR文件中。例如，如果想在一个Java程序中发送邮 件，就可以使用打包在文件］javax.ma认，jar中的一个库。

## 清单文件

除了类文件、 图像和其他资源外， 每个JAR 文件还包含一个清单文件(manifest)， 用于描述归档文件的特殊特性。

清单文件被命名为MANIFEST.MF, 它位于 JAR 文件的一个特殊的META-INF子目录中。 符合标准的最小清单文件极其简单：

```xml
Manifest-Version: 1. 0 
```

复杂的清单文件可能包含更多条目。 这些清单条目被分成多个节。 第一节被称为主节 (main section) 。 它作用于整个JAR 文件。 随后的条目用来指定命名实体的属性， 如单个文 件、 包或者URL。 它们都必须以一个Name条目开始。 节与节之间用空行分开。 例如：

```xml
Manifest-Version: 1. 0 
lines describing this archive 
Name: Woozle.class 
lines describing this file 
Name: com/mycompany/mypkg/ 
lines describing this package 
```

要想编辑清单文件， 需要将希望添加到清单文件中的行放到文本文件中， 然后运行：

```bash
jar cfm丿arFileName manifestFileName... 
```

例如， 要创建一个包含清单文件的JAR 文件， 应该运行：

```java
jar cfm MyArchive.jar manifest.mt com/mycompany/mypkg/*.class 
```

要想更新一个已有的JAR 文件的清单， 则需要将增加的部分放置到一个文本文件中， 然后执行以下命令：

```java
jar ufm MyArchive.jar manifest-additions.mf 
```

## 可执行JAR文件

可以使jar命令中的-e选项指定程序的入口点， 即通常需要在调用java程序启动器 时指定的类

```bash
jar cvfe MyProgram.j盯 com.mycompany, my pkg. MainAppClass files to add 
```

或者， 可以在清单 文件中指定程序的主类， 包括以下形式的语句

```bash
Main-Class: com.mycompany,mypkg.MainAppClass 
```

>  不要为主类名增加扩展名．class。

不论使用哪一种方法，用户可以简单地通过下面的命令来启动程序

```java
java -jar MyProgram.jar 
```

# 文档注释

JDK包含一个很有用的工具，叫做javadoc,它可以由源文件生成一个HTML文档。 事实上，在第3章介绍的联机API文档就是通过对标准Java类库的源代码运行）avadoc 生成的。

如果在源代码中添加以特殊定界符／＊＊ 开始的注释 ， 你也可以很容易地生成一个看上去具有专业水准的文档。 这是一种很好的方法， 因为 这样可以将代码与注释放在一个地方。如果将文档存放在一个独立的文件中， 就有可能会随着时间的推移出现代码和注释 不一致的问题。 然而， 由于文档注释与源代码在同一个文件中， 在修改源代码的同时， 重新运行）javadoc 就可以轻而易举地保持两者的一致性。

## 注释的插入

javadoc实用工具从下面几项中抽取信息：

+ 模块；
+ 包；
+ 公共类与接口；
+ 公共的和受保护的字段；
+ 公共的和受保护的构造器及方法。

可以（而且应该）为以上各个特性编写注释 。 注释放置在所描述特性的前面。 注释以／＊＊开始， 并以＊／结束。

每个／＊＊ ＊／文档注释包含标记以及之后紧跟着的自由格式文本(free-form text)。 标记以＠开始， 如＠since或＠pa ram。

+ 自由格式文本的笫一句应该是一个概要性的句子 。javadoc工具自动地将这些句子抽取出 来生成概要页。
+ 在自由格式文本中， 可以使用HTML修饰符， 例如， 用于强调的<em>...</em>、 用于着重 强调的<strong>...</ strong>、用于项目符号列表的<ul>/<li >以及用千包含图像的<img...＞ 等。 要键入等宽代码， 需要使用{@code...}而不是<code>...</ code>--－这样一来， 就不用操心对 代码中的＜字符转义了。

## 类注释

类注释必须放在import语句之后， 类定义之前。下面是一个类注释的例子：

```java
/**
*	A {@code Card} object represents a playing card, such
*	as "Queen of Hearts". A ca rd has a suit (Diamond, Heart,
*	Spade or Club) and a value (1 = Ace, 2... 10, 11 = Jack,
*	12 = Queen, 13 = King)
*/
public class Card
｛
  ...
}
```

## 方法注释

每一个方法注释必须放在所描述的方法之前。 除了通用标记之外， 还可以使用下面的标记：

+ @pa ram variable description
  这个标记将给当前方法的parameters"（参数）部分添加一个条目。 这个描述可以占据多行， 并且可以使用 HTML 标记。 一个方法的所有＠param标记必须放在一起。
+ @return description
  这个标记将给当前方法添加returns"（返回）部分。 这个描述可以跨多行， 并且可以 使用 HTML 标记。
+ @throws class description
  这个标记将添加一个注释， 表示这个方法有可能抛出异常。 有关异常的详细内容将在 第7章中讨论

下面是一个方法注释的示例：

```java
/**
*	Raises the salary of an employee.
*	@param byPercent the percentage by which to raise the salary (e.g., 18 means 10%)
*	@return the amount of the raise
*/
public double raiseSalary(double byPercent(){
	double raise= salary * byPercent / 100; 
  salary += raise; 
return raise; 
}
```

## 字段注释

只需要对公共字段（通常指的是静态常量）建立文档。 例如，

```java
 /** 
 * The "Hearts" card suit
 */
public static final int HEARTS= l;
```

## 通用注释

标记＠sincetext会建立 一个 “ since"（始于）条目。text（文本）可以是引入这个特性的版 本的任何描述。 例如，＠since 1. 7.1。

下面的标记可以用在类文档注释中。

+ @author name
  这个标记将产生一个 “ author"（作者）条目。可以使用多个＠author标记， 每个@author 标记对应一个作者。 并不是非得使用这个标记， 你的版本控制系统能够更好地跟踪作 者。

+ @version text
  这个标记将产生一个 “ version"（版本）条目。 这里的文本可以是对当前版本的任何描述。

+ @see

+ ＠link

  通过＠see和＠link标记， 可以使用超链接， 链接到］avadoc文档的相关部分或外部文档。

  这会建立一个链接到com.horstmann.corejava.Employee类的 raiseSalary(double)方法的超链接。 可 以省略包名， 甚至把包名和类名都省去， 这样一来， 这会位千当前包或当前类中。

需要注意， 一定要使用井号（＃）， 而不要使用句号（．） 分隔类名与方法名， 或类名与变量名。Java编译器自身可以熟练地确定句点在分隔包、 子包、 类、 内部类与方法和变量时的不同含义。 但是 ］avadoc工具就没有这么聪明了， 因此必须对它 提供帮助。

## 包注释

可以直接将类、 方法和变最的注释放置在Java源文件中， 只要用／＊＊ ．．． ＊／文档注释界定就可以了。 但是， 要想产生包注释， 就需要在每一个包目录中添加 一个单独的文件。 可以 有如下两个选择：

1. 提供一个名为package-info. java的Java文件。 这个文件必须包含一个初始的以／＊＊ 和 ＊／界定的Javadoc注释， 后面是一个package语句。 它不能包含更多的代码或注释。
2. 提供一 个名为package.html 的HTML文件。 会抽取标记<body>...</body>之间的所有 文本。

# 类设计技巧

我们不会面面俱到， 也不希望过于沉闷， 所以在这一章结束之前先简单地介绍几点技 巧。 应用这些技巧可以使你设计的类更能得到专业OOP圈子的认可。

1. 一定要保证数据私有。
2. 一定要对数据进行初始化。
3. 不要在类中使用过多的基本类型。
4. 不是所有的宇段都需要单独的字段访问器和宇段更改器。
5. 分解有过多职责的
6. 类名和方法名要能够体现它们的职责。
7. 优先使用不可变的类 。
