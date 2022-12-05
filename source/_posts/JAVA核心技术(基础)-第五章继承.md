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

## 阻止继承： final 类和方法

有时候， 我们可能希望阻止人们利用某个类定义子类。

不允许扩展的类被称为final类。如果在定义类的时候使用了final修饰符就表明这个类是final类。

```java
public final class Executive extends Manager {
  ...
}
```

类中的某个特定方法也可以被 声明为final。 如果这样做， 子类就不能覆盖这个方法 (final类中的所有方法自动地成 为final方法）。 例如

```java
public class Employee {
  public final String getName(){
    ...
  }
}
```

> 前面曾经说过， 字段也可以声明为final。 对于final宇段来说， 构造对象之后就不允许改变它们的值了。 不过， 如果将一个类声明为final, 只有其中的方法自动地 成为final, 而不包括字段。

将方法或类声明为final的主要原因是： 确保它们不会在子类中改变语义。 

Calendar类中的getTime 和setTime方法都 声明为final。 这表明Calendar类的设计者负责实现Date类与日历状态之间的转换， 而不允许子类来添乱。 同样地，String类也是final类，这意味着不允许任何人定义String 的子类。 换言之， 如果有 一个String 引用， 它引用的一定是一 个String对象， 而不可能是其他类的对象。

## 强制类型转换

将一个类型强制转换成另外一个类型的过程称为强制类型转换。Java 程序设计语言为强制类型转换提供了一种特殊的表示法。

有时候也可能需要将某个类的对象引用转换 成另外一个类的对象引用。 要完成对象引用的强制类型转换， 转换语法与数值表达式的强制类型转换类似，仅需要用一对圆括号将目标类名括起来，并放置在需要转换的对象引用之前就可以了。

```java
Manager boss= (Manager) staff[8]; 
```

进行强制类型转换的唯一原因是：要在暂时忽视对象的实际类型之后使用对象的全部功能。 

将一个值存入变批时，编译器将检查你是否承诺过多。

+ 如果将一个子类的引用赋给一个超类变量，编译器是允许的。 
+ 但将一个超类的引用赋给一个子类变量时，就承诺过多了。 必须进行强制类型转换， 这样才能够通过运行时的检查。当Java运行时系统将注意到你的承诺不符，并产生一个 ClassCastException 异常。 

因此， 应该养成这样一个良好的程序设计习惯：在进行强制类型转换之前， 先查看是否能够成功地转换。 为此只需要使用 instanceof 操作符就可以实现。

```java
if (staff[1] instanceof Manager) 
{
  boss = (Manager)staff[1]; 
}
```

最后，如果这个类型转换不可能成功，编译器就不会让你完成这个转换。 

综上所述：

1. 只能在继承层次内进行强制类型转换。
2. 在将超类强制转换成子类之前，应该使用instanceof进行检查。

实际上，通过强制类型转换 来转换对象的类型通常并不是一种好的做法。应该自问超类的设计是否合理。 一般情况下，最好尽量少用强制类型转换和instanceof运算符。

## 抽象类

如果自下而上在类的继承层次结构中上移，位于上层的类更具有一般性，可能更加抽 象。

从某种角度看，祖先类更有一般性，人们只将它作为派生其他类的基类，而不是用来构造你想使用的 特定的实例。 

再增加一个getDescription方法，它可以返回对一个人的简短描述。在Employee类 和Student类中实现这个方法很容易。 但是在Person类中应该提供什么内容呢？除了姓名之外，`Person`类对这个人一 无所知。 当然，可以让`Person.getDescription(）`返回一个空字符串。 不过还有一个更好的方法， 就是使用**abstract**关键字， 这样就完全不需要实现这个方法了。

```java
public abstract String getDescription(); 
// no implementation required 
```

为了提高程序的清晰度， 包含一个或多个抽象方法的类本身必须被声明为抽象的。

```java
public abstract class Person {
  public abstract String getDescription(); 
		// no implementation required 
}
```

除了抽象方法之外， 抽象类还可以包含字段和具体方法。 例如，Person类还保存着一个 人的姓名， 另外有一个返回姓名的具体方法。

```java
public abstract class Person {
  private String name; 
	public Person(String name) ｛ 
		this.name= name; 
	}
  
  public abstract String getDescription(); 
		// no implementation required 
}
```

抽象方法充当着占位方法的角色， 它们在子类中具体实现。

+ 在子类中保留抽象类中的部分或所有抽象方法仍未定义， 这样就必须将子类也标记为抽象类
+ 定义全部方法， 这样一来， 子类就不是抽象的了

在学习抽象类的时候你可能会感到疑惑？是否可以干脆省略 Person 超类中的抽象方法， 而仅在 Employee 和 Student 子类中定义 getDescription 方法呢？

其实如果这样做， 就不能在变量 p 上调用 getDescription 方法了。 编译器只允许调用在类中声明的方法。

在 Java 程序设计语言中， 抽象方法是一个重要的概念。 在接口 (interface) 中将会看到更多的抽象方法。 

## 受保护访问

最好将类中的字段标记为private, 而方法标记为public。 任何声明为 private的内容对其他类都是不可见的。 前面巳经看到，这对千子类来说也完全适用， 即子类也不能访问超类的私有字段。

不过，在有些时候，你可能希望限制超类中的某个方法只允许子类访问， 或者更少见地， 可能希望允许子类的方法访问超类的某个字段。 为此， 需要将这些类方法或字段声明为受保护(protected)。 

在实际应用中，要谨慎使用 受保护字段。 假设你的类要提供给其他程序员使用， 而你在设计这个类时设置了一些 受保护字段。 你不知道的是， 其他程序员可能会由这个类再派生出新类， 并开始访问你的受保护字段。 在这种情况下， 如果你想修改你的类的实现， 就势必会影响那些程序员。 这违背了OOP提倡数据封装的精神。

受保护的方法更具有实际意义。 如果需要限制某个方法的使用， 就可以将它声明为protected。这表明子类（可能很熟悉祖先类）得到了信任， 可以正确地使用这个方法， 而其他类则不行。

# Object: 所有类的超类

Object类是Java中所有类的始祖， 在Java中每个类都扩展了Object。

如果没有明确地指出超类，Object就被认为是这个类的超类。 由千在Java中每个类都是 由Object类扩展而来的， 所以， 熟悉这个类提供的所有服务十分重要。 

## Object类型的变量

可以使用Object类型的变量引用任何类型的对象：

```java
Object obj = new Employee("Harry Hacker", 35000); 
```

当然，Object类型的变量只能用千作为各种值的一个泛型容器。 要想对其中的内容进行具体的操作， 还需要清楚对象的原始类观， 并进行相应的强制类型转换：

```java
Employee e = (Employee) obj; 
```

在Java中， 只有基本类型(primitive type)不是对象， 例如， 数值、 字符和布尔类型的 值都不是对象。

所有的数组类型， 不管是`对象数组`还是`基本类型`的`数组`都扩展了`Object`类。

```java
Employee[] staff= new Employee[10]; 
obj = staff; // OK 
obj= new int[l9]; // OK 
```

## equals方法

Object类中的equals方法用千检测一个对象是否等千另外一个对象。

Object类中实现的equals方法将确定两个对象引用是否相等。 这是一个合理的默认行为： 如果两个对象引用相等， 这两个对象肯定就相等。

不过， 经常需要基千状态检测对象的相等性， 如果两个对象有相同的状态， 才认为这两个对象是相等的。

在子类中定义equals方法时， 首先调用超类的equals。如果检测失败， 对象就不 可能相等。 如果超类中的字段都相等， 就需要比较子类中的实例字段。

```java
public class Manager extends Employee {
  	public boolean equals(Object otherObject) {
      if (!super.equals(otherObject)) return false; 
				// super.equals checked that this and otherObject belong to the same class 
      Manager	other= (Manager) otherObject; 
		  return bonus== other.bonus;
    }
  }
```

## 相等测试与继承

如果隐式和显式 的参数不属千同一个类， equals方法将如何处理呢？这是一个很有争议 的问题。 在前面的例子中，如果发现类不匹配， equals方法就返回false。 但是， 许多程序员却喜欢使用instanceof进行检测：

```java
if (! (otherObject instanceof Employee)) return false; 
```

这样就允许otherObject属千一个子类。但是这种方法可能会招致一些麻烦。 正因为这些麻烦， 所以建议不要采用这种处理方式 。Java语言规范要求equals方法具有下面的特性：

+ 自反性 ： 对千任何非空引用x, x.equals(x)应该返回true。
+ 对称性 ： 对于任何引用x和Y, 当且仅当y.equals(x)返回true 时，x.equals(y)返回true。 
+ 传递性 ： 对千任何引用x、y和z, 如 果x.equals(y)返 回true, y. equals (z)返 回true,x.equals(z)也应该返回true。
+ 一致性 ： 如果x和y引用的对象没有发生变化， 反复调用x.equals(y)应该返回同样的 结果。
+ 对于任意非空引用x, x. equals (null)应该返回false。

下面给出编写一个完美的equals方法的建议：

1. 显式参数命名为otherObject,稍后需要将它强制转换成另一个名为other的变量。 

2. 检测this与otherObject是否相等：这条语句只是一个优化。实际上，这是一种经常 采用的形式。 因为检 查身份要比逐个比较字段开销小。

   ```java
   if (this== otherObject) return true;
   ```

3. 检测otherObject是否为null,如果为null,返回false。这项检测是很必要 的。

   ```java
   if (otherObject == null) return false; 
   ```

4. 比较this与othe rOb j ect的类。如果equals的语义可以在子类中改变，就使用getClass检测：

   ```java
   if (getClass() != otherObject.getClass()) return false; 
   ```

   如果所有的子类都有相同的相等性语义，可以使用instanceof检测：

   ```java
   if (!(other Objectinstanceof ClassName)) return false; 
   ```

5. 将otherObject强制转换为相应类类型的变量：

   ```java
   ClassName other= (ClassName) otherObject 
   ```

6. 现在根据相等性概念的要求来比较字段。使用＝比较基本类型字段，使用Objects.比较对象字段。如果所有的字段都匹配，就返回true;否则返回false

   ```java
   return fieldl == other. fieldl
     && Objects.equals(field2, othe「.field2) 
   	&& ...
   ```

   如果在子类中重新定义equals,就要在其中包含一个super.equals(other)调用。

##  hashCode方法

散列码(hash code)是由对象导出的一个整型值。 散列码是没有规律的。 如果x和y是两个不同的对象，x.hashCode()与y.hashCode(）基本上不会相同。

由千hashCode方法定义在 Object类中，因此每个对象都有一个默认的散列码， 其值由对 象的存储地址得出。 

如果重新定义了equals方法， 就必须为用户可能插入散列表的对象重新定义hashCode方法（有关散列表的内容将在第9章中讨论）。

hashCode方法应该返回一个整数（也可以是负数）。 要合理地组合实例字段的散列码， 以便能够让不同对象产生的散列码分布更加均匀。

例如， 下面是Employee类的 hashCode方法。

```java
public class Employee {
  publics int hashCode(){
    return 7 * name.hashCode() 
      +	11 * new Double(salary).hashCode()
			+	13 * hireDay.hashCode();
  }
}
```

不过， 还可以做得更好。首先， 最好使用null安全的方法 Objects.hashCode。 

如果其参数为null, 这个方法会返回0, 否则返回对参数调用hashCode的结果。另外， 使用静态方法 Double.hashCode来避免创建Double对象：

```java

public class Employee {
  publics int hashCode(){
 		 return 7 * Objects.hashCode (name) 
 		 +	11 * Double.hashCode(salary)
		 +	13 * Objects.hashCode(hireDay);
  }
}
```

还有更好的做法是， 需要组合多个散列值时， 可以调用Objects.hash并提供所有这些参数。 这个方法会对各个参数调用Objects.hashCode, 并组合这些散列值。这样Employee.hashCode 方法可以简单地写为：

```java
return Objects.hash(name, salary, hireDay); 
```

equals与hashCode的定义必须相容： 如果 x.equals(y)返回true, 那么x.hashCode(） 就必须 与y.hashCode(）返回相同的值。 

## toString方法

在Object中还有一个重要的方法，就是toString方法，它会返回表示对象值的一个字符串。

绝大多数（但不是全部）的toString方法都遵循这样的格式：类的名 字，随后是一对方括号括起来的字段值。

实际上，还可以设计得更好一些。最好通过调用getClass().getName(）获得类名的字符串， 而不要将类名硬编码写到 toString方法中。

```java
return getClass().getName()+
  +"[name="+ name 
  +",salary="+ salary
 	+ "reDay=" + hireDay
  + "]"

```

这样 toString方法也可以由子类调用。
当然，设计子类的程序员应该定义自己的toString方法，并加入子类的字段。

随处可见toString方法的主要原因是：只要对象与一个字符串通过操作符 ” + ” 连接起来， Java编译器就会自动地调用 toString方法来获得这个对象的字符串描述。 例如，

```java
var p = new Point(l0, 28); 
String message = "The current pos让ion is " + p; 
// automatically invokes p.toString() 
```

如果x是一个任意对象， 并调用System. out. println (x); println方法就会简单地调用x.toString(）， 并打印输出得到的字符串。Object类定义了toString方法， 可以打印对象的类名和散列码。

# 泛型数组列表

在许多程序设计语言， 特别是在 CIC+＋语言中， 必须在编译时就确定整个数组的大小。在Java中， 情况就好多了。 它允许在运行时确定数组的大小。

```java
int actualSize =... ; 
var staff = new Employee[actualSize]; 
```

当然， 这段代码并没有完全解决运行时动态更改数组的问题。 一旦确定 了数组的大小，就不能很容易地改变它了。 

在Java中， 解决 这个间题最简单的方法是使用Java中的另外一 个类， 名为Arraylist。 Arraylist类类似千数组， 但在添加或删除元素时， 它能够自动地调整数组容量， 而不需要为此编写任何代码。

Arraylist是一个有类型参数(typeparameter) 的泛型类(generic class)。 为了指定数组列表保存的元素对象的类型， 需要用一对尖括号将类名括起来追加到 Arraylist后面， 例如，`Arraylist <Employee>`。

## 声明数组列表

