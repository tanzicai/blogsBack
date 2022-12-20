---
title: 基于R语言的excel文件合成操作
author: 谭自财
data: 2021-6-5 18:20
categories: excel操作
tags:
    - excel
    - 文件操作
    - 数据合并
    - R语言
---
## 主要实现效果

> 元数据文件

![image-20210606210235695](https://gitee.com/tanzicai/drawingbed/raw/master/img/%E5%85%83%E6%95%B0%E6%8D%AE%E6%96%87%E4%BB%B61.png)

> 元数据文件2

![image-20210606210334771](https://gitee.com/tanzicai/drawingbed/raw/master/img/%E5%85%83%E6%95%B0%E6%8D%AE%E6%96%87%E4%BB%B62.png)

> 合成后文件

![image-20210606210435148](https://gitee.com/tanzicai/drawingbed/raw/master/img/%E5%90%88%E6%88%90%E5%90%8E%E6%96%87%E4%BB%B6.png)

### 安装需要的包

```R
#读写excel1文件相关的包
install.packages("readxl")
#对数据进行整理的包，包括管道符号的使用
install.packages("tidyverse")
```

### 数据处理
```R
#记得切换工作目录
list.files(pattern = "*.xlsx",full.names = TRUE)%>%
lapply(readxl::read_excel)%>%
reduce(full_join,by="miRNA")%>%
arrange(miRNA)%>%
select(contains("RNA")|contains("Gene"))->df
df = df[!is.na(df$Gene),]
write.csv(df,file = "处理后数据.csv",quote = F ,row.names=T,na="")


'list.files':遍历目录下的文件
'pattern' :文件名筛选
'full.names' :是否带完整路径读入
'%>%'(管道符):将读取的数据传递给下一个函数，作为下一函数的初始数据
'lapply'：循环读取每一个文件里面的数据，并以数组[1][2]。。。分别把每个文件的表格读取进来
'by':通过by后面的关键词进行合并
'reduce'：以关键词进行排序
'select':选择有效列
'file' = "文件名"
'quote':字符串数据导出是否带引号

## 其他情况实例
### 多个数据表列名相同按行合并

**注意：当数据文件分布在多个子文件夹时，可以使用 recursive = TRUE读取该文件夹下的所有文件（包括子文件夹里面）**

​```R
files = list.files(pattern = "xlsx", full.names = TRUE)
df = map_dfr(files, read_xlsx)    # 批量读取+按行堆叠合并
```
### 多个sheet（工作表）列名相同按行合并

```R
#path=path = "路径/文件名.xlsx"
df <- map_dfr(excel_sheets(path),read_xlsx(path, sheet = .x))  # 批量读取+按行堆叠合并  
```
### 多个数据表列名不完全相同，进行数据连接(本文实现情况)
```R
files = list.files("datas/", pattern = "xlsx", full.names = TRUE)
df = map(files, read_xlsx) %>% 
  reduce(full_join, by = "人名")                  # 读入并依次做全连接
```

### 多个sheet列名不完全相同，进行数据连接(本文实现情况)

```R
#path = 路径/文件名.xlsx
df <- map(excel_sheets(path), read_xlsx(path, sheet = .)) %>% 
  reduce(full_join, by = "人名")              # 读入并依次做全连接
```

## 数据修改
### 安装包及导入数据
R中，XLConnnect和openxlsx包来处理Excel文件，XLConnnect依赖于Java，我们选择openxlsx包。R在导入源数据的时候注意导入路径，如果路径过长，中文等，会出现导入错误。
```R
#首先安装并且导入openxlsx包
> install.packages("openxlsx")
Installing package into ‘D:/用户目录/我的文档/R/win-library/3.3’(as ‘lib’ is unspecified)
trying URL
'https://cran.rstudio.com/bin/windows/contrib/3.3/openxlsx_4.0.0.zip'
Content type 'application/zip' length
2379870 bytes (2.3 MB)
downloaded 2.3 MB
package ‘openxlsx’ successfully unpacked
and MD5 sums checked
The downloaded binary packages are in
      C:\Users\Administrator\AppData\Local\Temp\RtmpiKWFIy\downloaded_packages 
#导入数据 
> library("openxlsx")
> readFilepath <- "文件路径/文件名.xlsx"
#注意路径书写，绝对路径、相对路径均可，注意相对路径的时候工作区的设置
> exceldata <- read.xlsx(readFilepath,"Sheet1")#读入数据
> View(exceldata)
#查看导入的Excel数据
```
### 数据预处理

#### 列名重命名

列名重命名：源数据中列名都是中文，为了保证编码的正常运行，对其进行英文重命名
```R
 names(exceldata) <- c("time","cardno","drugId","drugName","saleNumber","virtualmoney","actualmoney")
```
### 删除缺失值

删除缺失值：缺失值以符号NA
```R
exceldata <- exceldata[!is.na(exceldata$time),]
```

### **处理日期**

**处理日期**：源数据中time列日期是以字符串的形式出现的（日期+星期），为了便于数据分析，需要将字符串拆分为相应的单列字符。

```R
str_split_fixed 函数使用前，先使用 nstall.packages (stringr) 安装，再使用 library (stringr) 引用该包
library(stringr)
timesplit <-str_split_fixed(exceldata$time," ",n=2)
# time里的字符串被成功分成两列字符
exceldata$time <- timesplit[,1]
```
![img](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210606212216.png)

字段拆分：

```R
字段分割函数： str_split_fixed (x, split, n)
x：需要处理的字段/字符
split：用于分割的字符串
n：分隔为多少列
返回值： data.frame
4、数据类型转换：由于运算的需要，需将Time中的字符型向量由“character”转换为以数值形式存储的日期变量，函数as.Date（）用于执行这种转化。
> exceldata$time <-
as.Date(exceldata$time,"%Y-%m-%d")
> class(exceldata$time)
[1] "Date"
#销售数量、应收金额以及实收金额（"SaleNumber"、"Virtualmoney"以及"Actualmoney"）这些数据也都可以转换为数值类型

> exceldata$saleNumber  <-
as.numeric(exceldata$saleNumber)
> class(exceldata$saleNumber)
[1] "numeric"
> exceldata$virtualmoney <-
as.numeric(exceldata$virtualmoney)
> exceldata$actualmoney <- as.numeric(exceldata$actualmoney)
```



## 数据排序

```R
exceldata <- exceldata[order(exceldata$time,decreasing=FALSE),]
```



![img](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210606212216.png)

# 本文使用工具包手册参考地址
[tidyverse](https://tidyverse.tidyverse.org/)

# 部分参考片段
### Overview

The tidyverse is a set of packages that work in harmony because they share common data representations and API design. The **tidyverse** package is designed to make it easy to install and load core packages from the tidyverse in a single command.

If you’d like to learn how to use the tidyverse effectively, the best place to start is [R for data science](https://r4ds.had.co.nz/).

### Installation



```
# Install from CRAN
install.packages("tidyverse")

# Or the development version from GitHub
# install.packages("devtools")
devtools::install_github("tidyverse/tidyverse")
```

### Usage

`library(tidyverse)` will load the core tidyverse packages:

- [ggplot2](https://ggplot2.tidyverse.org/), for data visualisation.
- [dplyr](https://dplyr.tidyverse.org/), for data manipulation.
- [tidyr](https://tidyr.tidyverse.org/), for data tidying.
- [readr](https://readr.tidyverse.org/), for data import.
- [purrr](https://purrr.tidyverse.org/), for functional programming.
- [tibble](https://tibble.tidyverse.org/), for tibbles, a modern re-imagining of data frames.
- [stringr](https://github.com/tidyverse/stringr), for strings.
- [forcats](https://github.com/tidyverse/forcats), for factors.

You also get a condensed summary of conflicts with other packages you have loaded:



```
library(tidyverse)
#> ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.1 ──
#> ✓ ggplot2 3.3.3     ✓ purrr   0.3.4
#> ✓ tibble  3.1.0     ✓ dplyr   1.0.5
#> ✓ tidyr   1.1.3     ✓ stringr 1.4.0
#> ✓ readr   1.4.0     ✓ forcats 0.5.1
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> x dplyr::filter() masks stats::filter()
#> x dplyr::lag()    masks stats::lag()
```

You can see conflicts created later with `tidyverse_conflicts()`:



```
library(MASS)
#> 
#> Attaching package: 'MASS'
#> The following object is masked from 'package:dplyr':
#> 
#>     select
tidyverse_conflicts()
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> x dplyr::filter() masks stats::filter()
#> x dplyr::lag()    masks stats::lag()
#> x MASS::select()  masks dplyr::select()
```

And you can check that all tidyverse packages are up-to-date with `tidyverse_update()`:



```
tidyverse_update()
#> The following packages are out of date:
#>  * broom (0.4.0 -> 0.4.1)
#>  * DBI   (0.4.1 -> 0.5)
#>  * Rcpp  (0.12.6 -> 0.12.7)
#> Update now?
#> 
#> 1: Yes
#> 2: No
```

### Packages

As well as the core tidyverse, installing this package also installs a selection of other packages that you’re likely to use frequently, but probably not in every analysis. This includes packages for:

- Working with specific types of vectors:
  - [hms](https://github.com/tidyverse/hms), for times.
  - [lubridate](https://github.com/tidyverse/lubridate), for date/times.
- Importing other types of data:
  - [feather](https://github.com/wesm/feather), for sharing with Python and other languages.
  - [haven](https://github.com/tidyverse/haven), for SPSS, SAS and Stata files.
  - [httr](https://github.com/r-lib/httr), for web apis.
  - [jsonlite](https://github.com/jeroen/jsonlite) for JSON.
  - [readxl](https://github.com/tidyverse/readxl), for `.xls` and `.xlsx` files.
  - [rvest](https://github.com/tidyverse/rvest), for web scraping.
  - [xml2](https://github.com/r-lib/xml2), for XML.
- Modelling
  - [modelr](https://github.com/tidyverse/modelr), for modelling within a pipeline
  - [broom](https://github.com/tidymodels/broom), for turning models into tidy data

### Code of Conduct

Please note that the tidyverse project is released with a [Contributor Code of Conduct](https://tidyverse.tidyverse.org/CODE_OF_CONDUCT.html). By contributing to this project, you agree to abide by its terms.