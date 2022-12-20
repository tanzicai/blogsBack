---
title: 基于Java语言的excel文件合成操作
author: Smile
data: 2021-6-5 18:20
categories: excel操作
tags:
    - excel
    - 文件操作
    - 数据合并
    - R语言
---
# Java 嵌入 SPL 轻松实现 Excel 文件合并

>  转载自Smile
> 转载源地址：	https://zhuanlan.zhihu.com/p/54543045
[Smile](https://www.zhihu.com/people/smile-33-15)
[![Smile](https://gitee.com/tanzicai/drawingbed/raw/master/img/v2-37059d62de382089f3a44ece6df70031_b.jpg)](https://www.zhihu.com/people/smile-33-15)




大多数JAVA程序猿都选择使用POI或者HSSFWorkbook等第三方类库来实现Excel自动化合并，这样一来不仅需要噼里啪啦的敲好多代码，费事费力，而且用起来灵活度也不高，对Excel的格式要求也很严格。如果能有一个专用的外部数据工具，写简单类似SQL的脚本来实现，然后在JAVA中直接调用并返回结果集，就再好不过了。润乾集算器就是这样的机制，通过使用JDBC调用SPL脚本，使用起来方便快捷，下面就来学习下具体如何使用。



## SPL实现

**常规合并：**

A. 同一个 excel 中的多个Sheet表合并

下面的例子是一个包含了销售数据的 excel 文件，其中包含了按月划分的 3 个结构相同的 sheet 工作表，数据如下：

January_2013:

![img](https://gitee.com/tanzicai/drawingbed/raw/master/img/v2-37059d62de382089f3a44ece6df70031_b.jpg)

February_2013:

![img](https://gitee.com/tanzicai/drawingbed/raw/master/img/v2-37059d62de382089f3a44ece6df70031_b.jpg)

March_2013:

![img](https://gitee.com/tanzicai/drawingbed/raw/master/img/v2-37059d62de382089f3a44ece6df70031_b.jpg)

在合并3个Sheet的同时，我们还可以同时从每个sheet中筛选出字段Customer Name, Sale Amount。最后的效果如下：

![img](https://gitee.com/tanzicai/drawingbed/raw/master/img/v2-37059d62de382089f3a44ece6df70031_b.jpg)



**SPL** **脚本：**

![img](https://gitee.com/tanzicai/drawingbed/raw/master/img/v2-37059d62de382089f3a44ece6df70031_b.jpg)

保存脚本文件**oneExcel.dfx**(嵌入Java会用到)

脚本说明：

**A1**: 打开指定的 excel 文件，创建一个由多个 sheet 工作表组成的序列。

**A2**：利用 conj 函数遍历 A1 序列中所有的成员工作表，导入每个工作表中指定列'Customer Name','Sale Amount'，并将数据并合并。其中 xlsimport 函数导入指定列，最后一列用分号; 隔开。 参数~.stname表示指定当前工作表，由于在 conj 函数的循环中，所以就可以逐个导入所有工作表。同时，xlsimport 使用选项@t指明将工作表的第一行记录作为字段名。

**A3:** 将序表 A2 作为一个新的工作表“merge_sheets”保存到原来的 excel 文件中，同样用选项 @t 指明首行记录为标题。

这段脚本只有三句话，短小精干之余，逻辑清晰，也比较容易理解。下面我们再看看如何合并多个文件中的多个工作表。



B. 不同 excel 中的多表合并

下面是要合并的多个 excel 文件，它们都具有和上面例子相同的表结构，每个文件记录了当年的数据**：**
**SPL** **脚本：**

![img](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210606213128.jpeg)

**合并后的结果如下：**

![img](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210606213128.jpeg)

保存脚本文件**MergeExcels.dfx**(嵌入Java会用到)

脚本说明：

**A1**: 通过 for 循环，遍历指定目录下的 excel 文件，在 B1 到 B3 之间进行循环内处理。

**B1**：打开目录下的一个 excel 文件，生成序列。

**B2**：导入当前文件中的每个 sheet 工作表中指定列'Customer Name','Sale Amount'，'Purchase Date'的数据，然后合并这些数据，与前面例子中的 A2 类似。

**B3**：将序表 B2 的数据与 @表示的本网格的值进行合并。

**A4**：将序表 B3 保存到result.xlsx文件中的 merge_data 工作表中。

上面程序用两个循环就实现了多个 excel 文件数据合并，外循环 for 遍历了目录下所有的 excel 文件，内循环B1.conj则合并每个excel文件中的多个sheet工作表的数据。

C. 合并出大文件

前面第一个例子中的 A2、第二个例子中的 B3 都是在内存中装载了合并后的 Excel 的所有数据，然后一次性写出。如果文件太多太大，那么对内存的占用也会很大，甚至超出内存允许的范围。为此，我们可以在SPL脚本中采用流式追加的方式生成大文件。

**SPL脚本：**

![img](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210606213128.jpeg)

**合并后的效果如下：**

![img](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210606213128.jpeg)

保存脚本文件**BigExcel.dfx**(嵌入Java会用到)

脚本说明：

**A1**：打开指定输出的文件。

A2：遍历目录下需要合并的 excel 文件。

B2：打开一个需要合并的 excel 文件。

B3：如果输出文件不存在，读取 sheet 工作表的所有数据，包括标题行；如果输出文件已经有了，就通过 @t 选项指明第一行是标题，从第二行开始读取数据。

B4：将 B3 读取的数据以流式追加到 A1 指定的输出文件的 merger 工作表中。

通过流式逐个读取文件数据后追加写入，这个方式适合将大量小的 excel 文件合并成一个大的 excel 文件。

## JAVA调用

SPL嵌入到Java应用程序十分方便，通过JDBC调用存储过程方法加载，用**同一个excel中的多个Sheet表合并**保存的文件OneExcel.dfx，示例调用如下：

```text
...
Connection con = null;
Class.forName("com.esproc.jdbc.InternalDriver");
con= DriverManager.getConnection("jdbc:esproc:local://");//调用存储过程，其中OneExcel是dfx的文件名
st =(com. esproc.jdbc.InternalCStatement)con.prepareCall("call OneExcel()");//执行存储过程
st.execute();//获取结果集
ResultSet rs = st.getResultSet();
...
```

替换成MergeExcels.dfx/BigExcel.dfx是同样的道理，只需call MergeExcels()或者call BigExcel()即可。这里只用 Java 片段粗略解释了如何嵌入 SPL，详细步骤请参阅[Java 如何调用 SPL 脚本](https://link.zhihu.com/?target=http%3A//c.raqsoft.com.cn/article/1543657951867)，也非常简单，不再赘述。同时，SPL 也支持 ODBC 驱动，集成到支持 ODBC 的语言，嵌入过程类似。

## 拓展节选

关于Excel文件的处理除了像上面讲的普通合并外，还可以在SPL脚本中对汇总后的结果分组去重，然后再将结果集导出。

**分组汇总**

下面继续以前面的销售数据 excel 文件为例。

**A. 字段分组**

根据某个字段或多个字段实现分组计算，SPL 脚本如下：

![img](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210606213128.jpeg)

A3**的效果：**

![img](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210606213128.jpeg)

A4**的效果：**

![img](https://pic3.zhimg.com/v2-4f5beaedb6f770834652a817aa2a5c42_b.jpg)

脚本说明：

**A1**: 打开指定的 excel 文件。

**A2**：读取并合并文件中所有 sheet 工作表的数据。

**A3**：在合并后的数据上按字段 'Customer ID' 分组求销售额、平均值。

**A4**：在合并后的数据上按字段 'Customer ID', 'Purchase Date' 分组求销售额。



**B. 按序分组**

集算器在进行分组聚合时还可以和相邻数据行对比，在原数据已经有序时可以不再排序，从而节省时间，并保持原有的次序。假设原数据已经按日期排序，我们想按月份分组统计时，代码如下。

SPL 脚本：

![img](https://pic4.zhimg.com/v2-dce5b7982afd2c1a55476b052d074d53_b.jpg)

A5 分组效果：

![img](https://pic3.zhimg.com/v2-941bcfe40d33bbf5dd13269be5f16e62_b.jpg)

A6 分组效果：

![img](https://pic4.zhimg.com/v2-0ae7a1596e286167ebd1de07a6ee4d17_b.jpg)

脚本说明：

**A1至B3**: 在前面的例子中已经介绍，将同一目录下所有相同结构的 excel 文件的工作表进行合并。

**A4**：在序表 B3 的基本上重新构造了一个序表 A4，将日期拆分，新增年、月字段。

**A5**：groups 跨年度按月分组汇总销售额、平均值。

**A6**：groups@o 按年月分组汇总销售额、平均值, 带参数 @o 实现分组归并处理。

其中，A4 为数据记录明细；A5 按月统计, 不区分年；A6 则按年月统计。这三个单元格中的数据展现出了不同层次的合并汇总结果。



**C. 分段分组**

将要统计的数据按条件分成几段，统计各组的情况。

SPL 脚本：

![img](https://pic2.zhimg.com/v2-0516d7dbd089cb79d6863a97acce9c65_b.jpg)

分组效果：

![img](https://pic2.zhimg.com/v2-89d65d7b984a087b4809c4bc1407bb51_b.jpg)

代码说明：

步骤A1到 B3 之间参考前面例子的说明。

A4：字段'Sale Amount'金额的范围分成 5 段，然后累计求出各段的数量及总数。

不过，这样的写法不够方便，如果我们想调整分段方案，就需要修改 groups 函数的参数，而这个参数表达式还是比较复杂的。这时，我们还可以利用集算器中另一个 pseg 函数，更方便地实现这个功能，脚本如下：

![img](https://pic4.zhimg.com/v2-2b00295ec76d17201f06d2178bae289f_b.jpg)

当然，我们也可以根据需要，按不同字段不同要求进行分组，然后进行统计处理。例如，在统计班级考生成绩时，各科成绩可划分成优、良、中、差、及格的分数区段，一次为条件进行统计。groups 用法还有很多，可以参考函数手册中相应的章节。



**D. 大数据分组**

前面的例子中，要读取的 excel 文件都不能很大，也就是都能一次读进内存。手工处理大文件，也会有类似的要求，因为同时打开多个文件，意味着把这些文件都装入内存，很可能会超过机器的物理内存，而用 VBA 读取的情况也差不多。这时，我们就需要用流式的方法读取数据，不需一次读进内存，而是边读取边合并。

SPL 脚本：

![img](https://pic4.zhimg.com/v2-b361134dc23cfb68770d765393ee2d33_b.jpg)

筛选分组的效果：

![img](https://pic3.zhimg.com/v2-8b5a294c8c4e78b1284a1eb34533e426_b.jpg)

代码说明：

**A1**: 使用 @r 选项指明以流式打开 excel 文件。

**A2**：遍历 excel 中的 sheet 工作表。

**B2**：使用 @c 选项指明以游标方式导入数据。

**B3**：将游标B2汇集到B3序列中。

**A4**：将游标序列B3的成员合并到一起组成新的游标。

B4：序列A4按‘Customer ID’分组累计‘Sale Amount’。

A5：将结果保存。

通过游标以流的方式循环从大文件中读取一段段数据，实现对数据的分组合并。



**去重处理**

实际数据合并过程中，往往会出现数据重复的现象，重复数据肯定会影响到我们对数据的计算分析。下面介绍使用集算器 SPL 脚本去除重复数据的几种主要解决方法。

**A. 主键去重**

sales_2013中的数据，设其主键为’Invoice Number’，则根据主键去掉重复记录。

![img](https://pic3.zhimg.com/v2-d512d7d6c2cede80618898f6a563884a_b.jpg)

合并去重后的数据：

![img](https://pic4.zhimg.com/v2-ab3528f4e01da1c4c58225b4d7fae2ff_b.jpg)

代码说明：

**A1**: 打开指定的 excel 文件。

A2：导入 sheet 工作表中指定列的数据。

A3：将序表 A2 按主键'Invoice Number'分组去重处理, 其中参数 @1 表示取每一个分组的第一条记录组成排列后返回（注意是数字 1，不是字母 l）。

A4：将结果保存。

各个 sheet> 中的数据是唯一的，但合并的数据不一定是唯一的，因此采用主键方式去掉重复数据。



**B. 某字段去重**

根据数据表 sales_2013 中的某字段去重处理, 查看不同姓名的雇员记录.

![img](https://pic2.zhimg.com/v2-bc6911160e504046d24e5bd641554f41_b.jpg)

代码说明：

**A1**: 打开指定的 excel 文件。

A2：导入 sheet 工作表中指定列的数据。

A3：从序表 A2 中获取不重复姓名的记录。

A4：从序表 A2中获取不重复姓名的记录列表。

A5：将序表 A4 另存，首行记录为标题。

A3 数据去重结果：

![img](https://gitee.com/tanzicai/drawingbed/raw/master/img/v2-bea0209ec28b15a8c575262910e3d07e_b.jpg)

A4 数据去重结果：

![img](https://gitee.com/tanzicai/drawingbed/raw/master/img/v2-bea0209ec28b15a8c575262910e3d07e_b.jpg)



**C. 联合多字段去重**

有的记录虽然有主键，但判断是否为重复的记录，需要用其它几个字段来确定，此时用多个字段联合来确定是否有重复记录.

![img](https://gitee.com/tanzicai/drawingbed/raw/master/img/v2-bea0209ec28b15a8c575262910e3d07e_b.jpg)

代码说明：

**A1**: 导入指定 excel 文件的数据。

A2：同上。

A3：按字段 'Customer ID', 'Purchase Date' 合并序表 A1，A2，返回序表 A3。

A4：序表 A3 按 'Customer ID', 'Purchase Date' 分组去重。

A5：将结果保存。

当然，也可以根据需要，参考更多的字段进行分组合并，去掉重复记录。



**D. 记录级去重**

解决要合并的每个文件中的记录本身是不重复的，但合并后可能存在重复记录。

![img](https://gitee.com/tanzicai/drawingbed/raw/master/img/v2-bea0209ec28b15a8c575262910e3d07e_b.jpg)

代码说明：

**A1**: 导入 excel 文件的数据。

B1：根据字段'Invoice Number'去掉序表 A1中的重复数据。

A2、B2：同上

A3：合并序表 B1，B2 的数据，并去掉重复数据记录返回序表 A3。选项 @u 表示序表成员按顺序合并到一起组成新的序表, 去掉重复的记录。

B3：查看合并后的数据记录数。

merge@u适合对多序表合并处理, 其中序表内部有序且无重复数据。



## 总结

使用SPL处理同构/异构excel 多文件合并、分组汇总数据及数据去重时，都是只要把需要合并的字段读成集算器的集合对象就可以了。学会了用这种专业数据处理工具，不仅能合并 Excel 文件, 合并其他文本数据方法也是一致的，再也不用担心合并数据中的多文件、大文件和结构差异问题了。

## SPL优势

- **有库写 SQL，没库写 SPL**

用Java程序直接汇总计算数据，还是比较累的，代码很长，并且不可复用，很多情况数据也不在数据库里，有了SPL，就能像在Java中用SQL一样了，十分方便。

- **常用无忧，不花钱就能取得终身使用权的入门版**

如果要分析的数据是一次性或临时性的，润乾集算器每个月都提供免费试用授权，可以循环免费使用。但要和Java应用程序集成起来部署到服务器上长期使用，定期更换试用授权还是比较麻烦，润乾提供了有终身使用权的入门版，解决了这个后顾之忧，获得方式参考 [如何免费使用润乾集算器？](https://link.zhihu.com/?target=http%3A//c.raqsoft.com.cn/article/1543548311985)

- **技术文档和社区支持**

官方提供的[集算器技术文档](https://link.zhihu.com/?target=http%3A//c.raqsoft.com.cn/forward%3Fgoto%3Dhttp%3A%2F%2Fdoc.raqsoft.com.cn)本身就有很多现成的例子，常规问题从文档里都能找到解决方法。如果获得了入门版，不仅能够使用SPL的常规功能，碰到任何问题都可以去[乾学院](https://link.zhihu.com/?target=http%3A//c.raqsoft.com.cn/)上去咨询，官方通过该社区对入门版用户提供免费的技术支持。