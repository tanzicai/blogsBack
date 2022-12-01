---
title: JAVA核心技术(基础)-第五章继承
date: 2022-11-30 20:49:25
tags:
	- JAVA
	- JAVA核心技术
	- JAVA基础
categories:
	- JAVA
updated: 2022-11-30 20:49:25
---

本章将学习面向对象程序设计的另外一个基本概念： 继承(inheritance)。

继承的基本思想是，可以基千已有的类创建新的类。继承已存在的类就是复用（继承）这些类的方法，而且可以增加一些新的方法和字段，使新类能够适应新的情况。这是Java程序设计中的一项核心技术。

另外，本章还阐述了反射(reflection)的概念。反射是指在程序运行期间更多地了解类及其属性的能力。反射是一个功能强大的特性，不过，不可否认它也相当复杂。由千主要是开发软件工具而不是编写应用程序的程序员对反射更感兴趣，因此对千这部分内容，可以先浏览一下，待日后再返回来学习。

# 类、 超类和子类

只是普通员工在完成本职任务之后仅领取薪水，而经理在完成了预期的业绩之后还能得到奖全。这种情形就需要使用继承。为什么呢？

因为需要为经理定义一个新类Manager, 并增加一些新功能。 但可以重用Employee类中已经编写的部分代码，并 保留原来Employee类中的所有字段。

从理论上讲，在Manager与Employee之间存在着明显的 "is-a"（是）关系，每个经理都是一个员工：“is-a"关系是继承的一个明显特征。

## 定义子类

可以如下继承Employee类来定义Manager类，这里使用关键字extends表示继承。

```java
public class Manager extends Employee ｛ 
  added methods and fields 
}
```

关键字extends表明正在构造的新类派生千一个已存在的类。 

+ 这个已存在的类称为超类(super class)、基类(base class)或父类(parent class)；
+ 新类称为子类(sub class)、派生类(derived class)或孩子类(chil d class)。 

超类和子类是Java程序员最常用的两个术语，而了解其他语言的程序员可能更加偏爱使用父类和孩子类，这也能很贴切地体现 “继承“ 。

尽管Employee类是一个超类，但并不是因为它优千子类或者拥有比子类更多的功能。 实际上恰恰相反，子类比超类拥有的功能更多。

 例如，看过Manager类的源代码之后就会发现， Manager类比超类Employee封装了更多的数据，拥有更多的功能。

在Manager类中， 增加了一个用千存储奖金信息的字段，以及一个用于设置这个字段的新方法：

```java
public class Manager extends Employee {
	private double bonus; 
	public void setBonus(double bonus) {
    this.bonus= bonus; 
  }
}
```

这里定义的方法和字段并没有什么特别之处。 如果有 一个Manager对象，就可以使用 setBonus方法。

```java
Manager boss =...;  
boss.setBonus(5000); 
```

当然， 由于setBonus方法不是在Employee类中定义的， 所以属千Employee类的对象不能使用它。

然而， 尽管在Manager类中没有显式地定义 getName和getHireDay等方 法， 但是可以对 Manager对象使用这些方法，这是因为Manage「类自动地继承了超类Employee中的这些方法。

类似地， 从超类中还继承了name、salary和hireDay这3个字段。 这样一来， 每个Manager 对象就包含了4个字段：name、salary、加reDay和bonus。

通过扩展超类定义子类的时候， 只需要指出子类与超类的不同之处。 因此在设计类的时候，应该将最一般的方法放在超类中， 而将更特殊的方法放在子类中，这种将通用功能抽取到超类的做法在 面向对象程序设计中十分普遍。

## 覆盖方法

超类中的有些方法对子类Manager并不 一定适用。 

具体来说，Manager类中的 getSalary方法应该返回薪水和奖金的总和。 为此，需要提供一个新的方法来覆盖(override)超类中的这个方法：

```java
public class Manager extends Employee {
  public double getSalary () ｛ 
	...	
}
}
```

应该如何实现这个方法呢？乍看起来似乎很简单，只要返回salary和bonus字段的总和就可以了：

```java
return salary + bonus; // won't work 
```

不过，这样做是 不行的。 回想一下， 只有 Employee方法能直接访问Employee类的私有字段。 这意味着，Manager类的 getSalary方法不 能直接访问salary字段。

 如果Manager类的方法想要访问那些私有字段， 就要像所有其他方法一样使用公共接口， 在这里就是要使用Employee 类中的 公共方法getSalary。

```java
double baseSalary = getSalary(); // still won't work return 
baseSalary += bonus; 
```

上面这段代码仍然有间题。 问题出现在调用getSalary 的语句上，它只是 在调用自身，这是因为Manager类也有 一个 getSalary方法（就是我们正在实现的这个方法）， 所以这条语句将 会导致无限次地调用自己，直到整个程序最终崩溃。

这里需要指出： 我们希望调用超类Employee 中的 getSalary方法，而不是当前类的这个方法。 为此，可以使用特殊的关键字super解决这个问题：

```java
super.getSalary();
```

这个语句调用的是Employee类中的 getSalary方法。 下面是 Manager类中getSalary方法的正 确版本：

```java
public double getSalary() {
  dauble baseSalary = super.getSalary() ;
  return baseSalary + bonus; 
}
```

正像前面所看到的那样， 在子类中可以增加字段、 增加方法或覆盖超类的方法， 不过， 继承绝对不会删除任何字段或方法。

## 子类构造器

在例子的最后， 我们来提供一个构造器。
```java
public Manager(String name, double salary, int yea「,int month, int day) {
  super(name, salary, year, month, day); 
  bonus= 8; 
}
```

这里的关键字super具有不同的含义。语句

```java
super(name, salary, year, month, day); 
```

“调用超类 Employee中带有n、S、year、month和day参数的构造器 ” 的简写形式。

由千Manager类的构造器不能访问Employee类的私有字段， 所以必须通过一个构造器来初始化这些私有字段。 

可以利用特殊的 super语法调用这个构造器 。使用 super调用构造器的语句必须是子类构造器的第一条语句。

如果子类的构造器没有显式地调用超类的构造器， 将自动地调用超类的无参数构造器。 如果超类没有无参数的构造器， 并且在子类的构造器中又没有显式地调用超类的其他构造器，Java编译器就会报告一个错误。

## 继承层次

继承并不仅限于一个层次。

 例如， 可以由Manager类派生Executive类。

由一个公共超类派生出来的所有类的集合称为继承 层次(inheritance hierarchy

在继承层次中， 从某个特定的类到其祖先的路径称为该类的继承链(inheritance chain) 。通常， 一个祖先类可以有多个子孙链。 

## 多态

有一个简单规则可以用来判断是否应该将数据设计为继承关系， 这就是`is-a`它指出子类的每个对象也是超类的对象。

例如， 每个经理都是员工， 因此， 类是有道理的；反之则不然， 并不是每名员工都是经理。

`"is-a" `规则的另一种表述是`替换原则`(substitution principle) 。 它指出程序中出现超类对象的任何地方都可以使用子类对象替换。

```java
//例如， 可以将子类的对象赋给超类变量。
Employee e; 
e = new Employee(...); // Employee object expected 
e = new Manage「(. ..) ; // OK, Manage「 can be used as well 

```

在Java程序设计语言中， 对象变量是多态的(polymorphic.) 。一个Employee类型的变量既可以引用一个Employeei类型的对象， 也可以引用Employee类的任何一个子类的对象（例如，Manager、Executive、Secretary等）。

```java
Manager boss = new Mana<ier(...) ; 
Employee[] staff = new Employee[3]; 
staff[0]= boss; 
```

在这个例子中， 变量staff[0]与boss引用同一个对象。 但编译器只将staff[0]看成是一个Employee对象。

这意味着， 可以这样调用

```java
boss.setBonus(5000); // OK 
// 但不能这样调用
staff[0].setBonus(5000); // ERROR 
```

这是因为 staff[0]声明的类型 是Employee, 而setBonus不是Employee类的方法。不过， 不能将超类的引用赋给子类变量。 例如， 下面的赋值是非法的：

```java
Manager m = staff[i]; // ERROR 
```

原因很清楚： 不是所有的员工都是经理。 如果赋值成功，m有可能引用了一个不是经理的Employee对象， 而在后面有可能会调用m.setBonus(．．．）， 这就会发生运行时错误。

## 理解方法调用

准确地理解如何在对象上应用方法调用非常重要。 下面假设要调用x.f(args)， 隐式参数 x声明为类C的一个对象 。 下面是调用过程的详细描述：

1. 编译器查看对象的声明类型和方法名。 

   需要注意的是：有可能存在多个名字为f但参数 类型不一样的方法。 

   编译器将会一一列举C类中所有名为f的方法和其超类中所有名为f而且可访问的方法（超类的私有方法不可访问）。

   至此， 编译器已知道所有可能被调用的候选方法。

2. 接下来 编译器要确定方法调用中提供的参数类型。 如果在所有名为f的方法中存在一个与所提供参数类型完全匹配的方法， 就选择这个方法。这个过程称为重载解析”(overloading resolution) 。

   如果编译器没有找到与参数类匹配的方法，或者发现经过类型转换后有多个方法与之匹配， 编译器就会报告一个错误。

   至此， 编译器已经知道需要调用的方法的名字和参数类型。

3. 如果是 private方法、static方法、final方法或者构造器，那么编译器将可以准确地知道应该调用哪个方法。这称为静态绑定(static binding)。 

   如果要调用的方法依赖于隐式参数的实际类型， 那么必须在运行 时使用动态绑定。

4. 程序运行并且采用动态绑定调用方法时， 虚拟机必须调用与x所引用对象的实际类型对应的那个方法。假设x的实际类型是D, 它是C类的子类。如果D类定义了方法f(String), 就会调用这个方法；否则， 将在D类的超类中寻找f (String)， 以此类推。

