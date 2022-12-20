---
layout: pages
title: 基于TCGA数据库的肾癌miRNA差异基因（KIRC、KIRP、KICH、SARC）分析实现
date: 2021-09-14 20:59:06
top_img: https://gitee.com/tanzicai/drawingbed/raw/master/img/image-20210919181926263.png
cover: https://gitee.com/tanzicai/drawingbed/raw/master/img/image-20210919181926263.png
categories: 医学统计
tags:	
   - TCGA
   - 基因差异分析
   - R语言
---
# 数据下载

## windows平台：gdc-client

在windows下进行TCGA数据下载，需要使用官方的一个程序：**gdc-client.exe，以及manifest.txt文件**，文末会提供下载链接，利用windows shell进行下载。

### 下载数据

比如当前目录下有gdc-client.ext，以及manifest.txt文件，那么就可以这样下载数据

当前目录下的文件

```c
C:\Users\dongl\Desktop\various\gdc_tools> dir
 驱动器 C 中的卷是 Windows
 卷的序列号是 30C8-61C9
 C:\Users\dongl\Desktop\various\gdc_tools 的目录
2019/04/21  18:08    <DIR>          .
2017/08/14  11:04        16,576,583 gdc-client.exe
2018/10/09  11:24           818,112 metadata.json
```

在当前目录下输入：

```c
gdc-client.exe download -m gdc_manifest.txt
```

自动下载数据默认至当前文件夹下，每个样本的数据都是独立的文件夹

```c
C:\Users\dongl\Desktop\various\gdc_tools> gdc-client.exe download -m gdc_manifest.txt
```

![数据下载目录示意图](https://gitee.com/tanzicai/drawingbed/raw/master/img/202109142354679)

**软件下载软件地址：**[https://gdc.cancer.gov/access-data/gdc-data-transfer-tool](https://links.jianshu.com/go?to=https%3A%2F%2Fgdc.cancer.gov%2Faccess-data%2Fgdc-data-transfer-tool)

## Mac平台：gdc-client

mac平台相对于Windows平台较为复杂，需要配置相关的路径。具体步骤如下：

### 下载安装

Github下载链接：https://github.com/NCI-GDC/gdc-client/releases

Docker下载链接：https://hub.docker.com/r/sbamin/gdc-client

官方下载链接：https://gdc.cancer.gov/access-data/gdc-data-transfer-tool

另外还有terminal版本的，不提供交互式页面显示，请自行选择下载

### 设置路径

方法1:——vim .zshrc(如果你是Bash，就vim .bash_profile）添加$PATH。

```
vim ~/.zshrc
 
#添加你解压官网下载好的zip解压出来的gdc-client所在的文件夹路径就可以啦：
 
export PATH="<gdc-client所在的文件夹路径>:$PATH"

```

方法2:——图管理简便的话，把解压好的gdc-client 拖入根目录的bin里，原理就是根目录的bin本来就在PATH里的。

### 测试

在terminal输入以下代码进行测试，如果输入对应的版本号就代表安装成功。接下来就可以使用它来下载数据了

```
gdc-client --version
```

### 下载数据

在terminal切换到有gdc_manifest.txt的文件夹下面运行以下代码即可下载数据，下载示意图同上。

```
gdc-client.exe download -m gdc_manifest.txt
```

## 通用平台：网页数据下载

不推荐网页下载数据，因为服务器在国外的原因，下载速度巨慢（特别在某些校园网里面更加的慢，请尝试切换到手机热点网络尝试下载）。同时在下载过程中常常因网络不稳定下载失败。使用此方法请谨慎。

TCGA数据库：https://portal.gdc.cancer.gov/

如有科学上网方法，此方法也可使用。

![GDC下载页面](https://gitee.com/tanzicai/drawingbed/raw/master/img/202109151232076.png)

# 数据库介绍与数据检索

 检索TCGA数据，以下是TCGA的数据主页。数据概况预览：包含68个项目，涉及84,609个案例，有618,198个文件等。骨髓样本最多，其次是肺组织样本。 

![TCGA首页](https://gitee.com/tanzicai/drawingbed/raw/master/img/202109151235575.png)

选择上方的Repository进入数据库，数据库中所有数据资料大小为1.14PB。根据左边的【Files】和【Cases】进行数据的检索。先筛选cases页面，再进行文件的筛选。

![image-20210915123849401](https://gitee.com/tanzicai/drawingbed/raw/master/img/202109151238473.png)

## cases筛选

在cases界面，我们将选择分析的数据类型：

我们以肾癌为例进行筛选

+ Primary指主站点，选择的是癌症发生部位，比如肾癌（kidney）、胃癌（Stomach）、膀胱癌等

+ Program指项目组织：我们主要选择TCGA组织，其他例如CPTAC为临床蛋白质组肿瘤分析协作组

+ Project指癌症的亚型：TCGA-KIRC（肾透明细胞癌），TCGA-KIRP（肾乳头状细胞癌）
  + 具体参考文章[TCGA数据库中含有的癌症名称、简写、中文名称对照表](https://tanzicai.gitee.io/2021/05/07/TCGA%E6%95%B0%E6%8D%AE%E5%BA%93%E4%B8%AD%E5%90%AB%E6%9C%89%E7%9A%84%E7%99%8C%E7%97%87%E5%90%8D%E7%A7%B0%E3%80%81%E7%AE%80%E5%86%99%E3%80%81%E4%B8%AD%E6%96%87%E5%90%8D%E7%A7%B0%E5%AF%B9%E7%85%A7%E8%A1%A8/)

+ Disease Type疾病类型：

  + adenomas and adenocarcinomas：腺瘤和腺癌
  + soft tissue tumors and sarcomas, nos：软组织肿瘤和肉瘤
  + synovial-like neoplasms：滑膜样肿瘤

  我们主要选择第一个就可以

+ 后面的性别、人种等我们不需要考虑

筛选得到27,849个文件，大小**38.19 TB**。但是显然我们并不完全需要这11,8111个文件，可以通过【Files】对文件进一步筛选。

![cases筛选后页面](https://gitee.com/tanzicai/drawingbed/raw/master/img/202109151253356.png)

## file筛选

在【file】界面，我们将对数据进行进一步筛选

+ ExperimentalStrategy数据类别: 我们对miRNA分析，故选择transcriptome profiling（转录组分析）
+ DataType数据类型：我们需要对miRNA进行分析，故选择miRNA Expression Quantification（miRNA表达量）
+ DataFormat数据格式：我们一般选择txt就好

![file筛选页面](https://gitee.com/tanzicai/drawingbed/raw/master/img/202109151302127.png)

## cart介绍

在【Cart】界面下，我们可以看到数据的详细情况：1033个files，873个cases，文件大小51.82 MB，可见有些cases是有重复的files。这373个files均是open的状态，允许下载。

1. 下载mainfest文件，在Download下拉菜单中

2. 下载metadata文件，主要包含数据的分组信息

3. 下载clinical文件，有各个数据的临床信息 

4. 下载选择的数据文件，在Download下拉菜单中cart中

   ![下载页面](https://gitee.com/tanzicai/drawingbed/raw/master/img/202109151302956.png)

# 数据分析

## 数据来源

本次研究于2021年9月15日从[TCGA数据库](https://portal.gdc.cancer.gov/)下载并整理的肾癌（包括KIRC、KIRP、KICH、SARC四种亚型）转录组的miRNA表达谱数据。

其中miRNA表达芯片数据的样本:共873例，其中包括正常样本130份，癌症样本903份

## 肾癌 miRNA 差异表达分析

利用R语言edgeR包对癌症样本和正常样本的miRNA及基因进行表达差异对比分析。

其中条件设置为

```
PLAINTEXT
PValue < 0.05 & abs(DEG2$logFC) > logFC_cutoff2,ifelse(DEG2$logFC > logFC_cutoff2
```

## 结果

对TCGA胃腺癌数据库进行分析后，以

```
PLAINTEXT
PValue < 0.05 & abs(DEG2$logFC) > logFC_cutoff2,ifelse(DEG2$logFC > logFC_cutoff2
```

为标准进行分析，在873例miRNA芯片数据样本中，共筛选出89个差异表达miRNA，上调的基因63个、下调基因26个。

# 分析过程（含代码）

## 移动文件

本过程可以和下面的提取在一起执行，为了更好的展示数据处理过程，特别分开了这两步骤，在这一步我们对下载的所有数据移动到统一的文件夹进行存放。
因为下载后的每个文件都有自己文件夹，我们首先读取了所有文件夹的名称，然后把每个文件夹里面符合“txt”文件格式的文件进行了移动。

```
R
#移动下载文件夹中的文件到一个文件夹
#author tanzicai
#time 2021.9.15 R4.0.1
#program移动文件到同一文件夹
#输入：所下载的文件夹的上级文件夹
#输出：mergeAllFileTofolder文件夹
munzip <-function(path){
  if(path == ''){
    print("请输入文件夹路径")
  }
  setwd(path)
  dir.create("../中间文件输出")
  dir.create("../中间文件输出/源文件")
  filePath = dir(path = path ,full.names = T)
  filePath = filePath[1:length(filePath)-1]
  for(wd in filePath){
    files = dir(path = wd,pattern = "txt$")
    fromFilePath = paste0(wd,"/",files)
    toFilePath = paste0("../中间文件输出/源文件/",files)
    file.copy(fromFilePath,toFilePath)
  }
  unlink("../中间文件输出/源文件/annotations.txt")
  TRUE
}
```

## 合并文件

在上一步，我们把所有的文件移动到了一个文件夹里面。那么在这一步我们，我们需要建立一个表哥，行名为每个miRNA的名称，列名为每个样本的文件名称。然后把所有的文件里面的数据进行读取，建立一个数据框。

[![image-20210916162847705](https://gitee.com/tanzicai/drawingbed/raw/master/img/202109161628939.png)](https://gitee.com/tanzicai/drawingbed/raw/master/img/202109161628939.png)

在这之中我们会遇到一些小问题，比如miRNA数据中含有多列信息，这里我们只取了第一列数据使用。

```
R
#合并下载的所有文件
#author tanzicai
#time 2021.9.15 R4.0.1
#program读取每一个文件到一个表格
#输入：文件所在的文件夹目录
#输出：合并后的表格
combin <- function(path){
  if(path == "null"){
    print("请输入目标文件地址")
  }
  setwd(path)
  countFilePath = dir(path = "../中间文件输出/源文件",pattern = "*.txt")
  counts_merge = NULL
  for (i in countFilePath) {
    x=read.delim(paste0("../中间文件输出/源文件/",i),col.names = c("miRNA_ID",substr(i,1,9),1,2))
    x=x[,1:length(x)-1]
    x=x[,1:length(x)-1]
    if(is.null(counts_merge)){
      counts_merge = x
    }
    else{
      counts_merge =merge(counts_merge,x,by = "miRNA_ID")
    }
  }
  write.csv(counts_merge,file = "../中间文件输出/源文件合并.csv")
  rownames(counts_merge)=counts_merge$miRNA_ID
  conuts_reduce = counts_merge[,-1]
  TRUE
}
```

## 注释文件提取及样本编码替换

metadata.cart文件记录了我们cart购物车中的所有样本的相关信息，包括文件名、TCGA编号等等信息，我们需要做的就是从此文件提取出一个文件名和TCGA编码的对应表格，明白这个样本的TCGA内部编码是啥，为下一步edgR差异分析做准备工作。

[![metadata.cart](https://gitee.com/tanzicai/drawingbed/raw/master/img/202109161638010.png)](https://gitee.com/tanzicai/drawingbed/raw/master/img/202109161638010.png)

```
R
#注释文件提取及样本编码替换
#author tanzicai
#time 2021.9.16 R4.0.1
#program根据meta文件提取样本数据名称
#输入：注释文件
#输出：转换后的表格
convertName <- function(path){
  if(any(grepl("rjson",installed.packages())) == FALSE){
    install.packages("rjson")
  }
  library(rjson)
  setwd(path)
  metaJSON = fromJSON(file = paste0("../",dir(path = "../",pattern = "*.json",full.names = F)))
  jsonDataInfo = data.frame(fileName = c(),TCGA_Barcode = c())
  for (i in 1:length(metaJSON)) {
    TCGA_barcode = metaJSON[[i]][["associated_entities"]][[1]][["entity_submitter_id"]]
    fileName = metaJSON[[i]][["file_name"]]
    jsonDataInfo = rbind(jsonDataInfo,data.frame(fileName = substr(fileName,1,9),TCGA_barcode = substr(TCGA_barcode,1,15)))
  }
  rownames(jsonDataInfo) = jsonDataInfo[,1]
  write.csv(jsonDataInfo,file = "../中间文件输出/文件名与TCGA编号对照表.csv")
  #获取counts矩阵
  DATA = read.csv("../中间文件输出/源文件合并.csv")
  DATA = DATA[-1]
  fileNameToTCGA_Barcode = jsonDataInfo[-1]
  jsonDataInfo = jsonDataInfo[order(jsonDataInfo$fileName),]
  data = DATA
  DATA = DATA[-1]
  colnames(DATA) = jsonDataInfo$TCGA_barcode
  DATA = cbind(data[1],DATA)
  write.csv(DATA,file = "../中间文件输出/重复名列名为TCGA编号源文件.csv")
  TRUE
}
```

## 使用edgR进行差异基因筛选

```
R
#edgR差异分析
#author tanzicai
#time 2021.9.16 R4.0.1
#使用edgR包对数据进行差异分析
#输入：表达矩阵、分组信息
#输出：差异表达结果
edgRAnalyze <- function(path){
  setwd(path)
  if(any(grepl("BiocManager",installed.packages())) == FALSE){
    install.packages("BiocManager")
  }
  library(BiocManager)
  if(any(grepl("edgeR",installed.packages())) == FALSE){
    BiocManager::install("edgeR")
    BiocManager::install("limma")
  }
  library(edgeR)
  library(limma)
  #将第一列换成行名
  DATA = read.csv("../中间文件输出/重复名列名为TCGA编号源文件.csv")
  DATA = DATA[-1]
  row.names(DATA) <- DATA[, 1]
  DATA <- DATA[, -1]
  #分组信息
  group_list <- ifelse(as.numeric(substr(colnames(DATA),14,15))<10,"tumor","normal")
  group_list <- factor(group_list,levels = c("normal","tumor"))
  table(group_list)
  dge <- DGEList(counts=DATA,group=group_list)
  #差异分析
  dge$samples$lib.size <- colSums(dge$counts)
  dge <- calcNormFactors(dge)
  design <- model.matrix(~0+group_list)
  rownames(design)<-colnames(dge)
  colnames(design)<-levels(group_list)
  dge <- estimateGLMCommonDisp(dge,design)
  dge <- estimateGLMTrendedDisp(dge, design)
  dge <- estimateGLMTagwiseDisp(dge, design)
  fit <- glmFit(dge, design)
  fit2 <- glmLRT(fit, contrast=c(-1,1))
  DEG2=topTags(fit2, n=nrow(DATA))
  DEG2=as.data.frame(DEG2)
  logFC_cutoff2 <- with(DEG2,mean(abs(logFC)) + 2*sd(abs(logFC)))
  DEG2$change = as.factor(ifelse(DEG2$PValue < 0.05 & abs(DEG2$logFC) > logFC_cutoff2,ifelse(DEG2$logFC > logFC_cutoff2 ,'UP','DOWN'),'NOT'))
  print("本次差异基因分析结果为")
  print(table(DEG2$change))
  edgeR_DEG <- DEG2
  dir.create("../最终分析文件输出")
  write.csv(edgeR_DEG,"../最终分析文件输出/差异分析结果.csv")
  TRUE
}
```

# miRNAAnalysis包的使用

```
R
#移动下载文件夹中的文件到一个文件夹
#author tanzicai
#time 2021.6.8 R4.0.1
#program移动文件到同一文件夹
#输入：所下载的文件夹的上级文件夹
#输出：mergeAllFileTofolder文件夹
munzip <-function(path){
  if(path == ''){
    print("请输入文件夹路径")
  }
  setwd(path)
  dir.create("../中间文件输出")
  dir.create("../中间文件输出/源文件")
  filePath = dir(path = path ,full.names = T)
  filePath = filePath[1:length(filePath)-1]
  for(wd in filePath){
    files = dir(path = wd,pattern = "txt$")
    fromFilePath = paste0(wd,"/",files)
    toFilePath = paste0("../中间文件输出/源文件/",files)
    file.copy(fromFilePath,toFilePath)
  }
  unlink("../中间文件输出/源文件/annotations.txt")
  TRUE
}

#合并下载的所有文件
#author tanzicai
#time 2021.6.8 R4.0.1
#program读取每一个文件到一个表格
#输入：文件所在的文件夹目录
#输出：合并后的表格
combin <- function(path){
  if(path == "null"){
    print("请输入目标文件地址")
  }
  setwd(path)
  countFilePath = dir(path = "../中间文件输出/源文件",pattern = "*.txt")
  counts_merge = NULL
  for (i in countFilePath) {
    x=read.delim(paste0("../中间文件输出/源文件/",i),col.names = c("miRNA_ID",substr(i,1,9),1,2))
    x=x[,1:length(x)-1]
    x=x[,1:length(x)-1]
    if(is.null(counts_merge)){
      counts_merge = x
    }
    else{
      counts_merge =merge(counts_merge,x,by = "miRNA_ID")
    }
  }
  write.csv(counts_merge,file = "../中间文件输出/源文件合并.csv")
  rownames(counts_merge)=counts_merge$miRNA_ID
  conuts_reduce = counts_merge[,-1]
  TRUE
}

#注释文件提取
#author tanzicai
#time 2021.6.8 R4.0.1
#program根据meta文件提取样本数据名称
#输入：注释文件
#输出：转换后的表格
convertName <- function(path){
  if(any(grepl("rjson",installed.packages())) == FALSE){
    install.packages("rjson")
  }
  library(rjson)
  setwd(path)
  metaJSON = fromJSON(file = paste0("../",dir(path = "../",pattern = "*.json",full.names = F)))
  jsonDataInfo = data.frame(fileName = c(),TCGA_Barcode = c())
  for (i in 1:length(metaJSON)) {
    TCGA_barcode = metaJSON[[i]][["associated_entities"]][[1]][["entity_submitter_id"]]
    fileName = metaJSON[[i]][["file_name"]]
    jsonDataInfo = rbind(jsonDataInfo,data.frame(fileName = substr(fileName,1,9),TCGA_barcode = substr(TCGA_barcode,1,15)))
  }
  rownames(jsonDataInfo) = jsonDataInfo[,1]
  write.csv(jsonDataInfo,file = "../中间文件输出/文件名与TCGA编号对照表.csv")
  #获取counts矩阵
  DATA = read.csv("../中间文件输出/源文件合并.csv")
  DATA = DATA[-1]
  fileNameToTCGA_Barcode = jsonDataInfo[-1]
  jsonDataInfo = jsonDataInfo[order(jsonDataInfo$fileName),]
  data = DATA
  DATA = DATA[-1]
  colnames(DATA) = jsonDataInfo$TCGA_barcode
  DATA = cbind(data[1],DATA)
  write.csv(DATA,file = "../中间文件输出/重复名列名为TCGA编号源文件.csv")
  TRUE
}

#edgR差异分析
#author tanzicai
#time 2021.6.8 R4.0.1
#使用edgR包对数据进行差异分析
#输入：表达矩阵、分组信息
#输出：差异表达结果
edgRAnalyze <- function(path){
  setwd(path)
  if(any(grepl("BiocManager",installed.packages())) == FALSE){
    install.packages("BiocManager")
  }
  library(BiocManager)
  if(any(grepl("edgeR",installed.packages())) == FALSE){
    BiocManager::install("edgeR")
    BiocManager::install("limma")
  }
  library(edgeR)
  library(limma)
  #将第一列换成行名
  DATA = read.csv("../中间文件输出/重复名列名为TCGA编号源文件.csv")
  DATA = DATA[-1]
  row.names(DATA) <- DATA[, 1]
  DATA <- DATA[, -1]
  #分组信息
  group_list <- ifelse(as.numeric(substr(colnames(DATA),14,15))<10,"tumor","normal")
  group_list <- factor(group_list,levels = c("normal","tumor"))
  table(group_list)
  dge <- DGEList(counts=DATA,group=group_list)
  
  dge$samples$lib.size <- colSums(dge$counts)
  dge <- calcNormFactors(dge)
  design <- model.matrix(~0+group_list)
  rownames(design)<-colnames(dge)
  colnames(design)<-levels(group_list)
  dge <- estimateGLMCommonDisp(dge,design)
  dge <- estimateGLMTrendedDisp(dge, design)
  dge <- estimateGLMTagwiseDisp(dge, design)
  fit <- glmFit(dge, design)
  fit2 <- glmLRT(fit, contrast=c(-1,1))
  DEG2=topTags(fit2, n=nrow(DATA))
  DEG2=as.data.frame(DEG2)
  logFC_cutoff2 <- with(DEG2,mean(abs(logFC)) + 2*sd(abs(logFC)))
  DEG2$change = as.factor(ifelse(DEG2$PValue < 0.05 & abs(DEG2$logFC) > logFC_cutoff2,ifelse(DEG2$logFC > logFC_cutoff2 ,'UP','DOWN'),'NOT'))
  print("本次差异基因分析结果为")
  print(table(DEG2$change))
  edgeR_DEG <- DEG2
  dir.create("../最终分析文件输出")
  write.csv(edgeR_DEG,"../最终分析文件输出/差异分析结果.csv")
  TRUE
}

#edgR2差异分析(未启用)
#author tanzicai
#time 2021.6.8 R4.0.1
#使用edgR包对数据进行差异分析
#输入：表达矩阵、分组信息
#输出：差异表达结果
edgRAnalyze2 <- function(){
  etwd(path)
  if(any(grepl("BiocManager",installed.packages())) == FALSE){
    install.packages("BiocManager")
  }
  library(BiocManager)
  if(any(grepl("edgeR",installed.packages())) == FALSE){
    BiocManager::install("edgeR")
    BiocManager::install("limma")
  }
  library(edgeR)
  library(limma)
  #将第一列换成行名
  DATA = read.csv("../中间文件输出/重复名列名为TCGA编号源文件.csv")
  DATA = DATA[-1]
  row.names(DATA) <- DATA[, 1]
  DATA <- DATA[, -1]
  #分组信息
  group_list <- ifelse(as.numeric(substr(colnames(DATA),14,15))<10,"tumor","normal")
  group_list <- factor(group_list,levels = c("normal","tumor"))
  table(group_list)
  #构建 DGEList 对象
  dge <- DGEList(counts=DATA,group=group_list)
  #过滤 low count 数据，例如 CPM 标准化
  keep <- rowSums(cpm(dgelist) > 1 ) >= 2
  dgelist <- dgelist[keep, , keep.lib.sizes = FALSE]
  #标准化，以 TMM 标准化为例
  dgelist_norm <- calcNormFactors(dgelist, method = 'TMM')
  #首先根据分组信息构建试验设计矩阵，分组信息中一定要是对照组在前，处理组在后
  design <- model.matrix(~group)
  #估算基因表达值的离散度
  dge <- estimateDisp(dgelist_norm, design, robust = TRUE)
  print("请选择模型拟合算法")
  print("1:负二项广义对数线性模型")
  print("2:拟似然负二项广义对数线性模型")
  choice = readline()
  # 负二项广义对数线性模型
  if(choice == 1){
    fit <- glmFit(dge, design, robust = TRUE)
    lrt <- topTags(glmLRT(fit), n = nrow(dgelist$counts))
    write.table(lrt, 'control_treat.glmLRT.txt', sep = '\t', col.names = NA, quote = FALSE)
  }else if(choice == 2){
    fit <- glmQLFit(dge, design, robust = TRUE)
    lrt <- topTags(glmQLFTest(fit), n = nrow(dgelist$counts))
    write.table(lrt, 'control_treat.glmQLFit.txt', sep = '\t', col.names = NA, quote = FALSE)
  }
  gene_diff <- read.delim('control_treat.glmLRT.txt', row.names = 1, sep = '\t', check.names = FALSE)
  #首先对表格排个序，按 FDR 值升序排序，相同 FDR 值下继续按 log2FC 降序排序
  gene_diff <- gene_diff[order(gene_diff$FDR, gene_diff$logFC, decreasing = c(FALSE, TRUE)), ]
  #log2FC≥1 & FDR<0.01 标识 up，代表显著上调的基因
  #log2FC≤-1 & FDR<0.01 标识 down，代表显著下调的基因
  #其余标识 none，代表非差异的基因
  gene_diff[which(gene_diff$logFC >= 1 & gene_diff$FDR < 0.01),'sig'] <- 'up'
  gene_diff[which(gene_diff$logFC <= -1 & gene_diff$FDR < 0.01),'sig'] <- 'down'
  gene_diff[which(abs(gene_diff$logFC) <= 1 | gene_diff$FDR >= 0.01),'sig'] <- 'none'
  #输出选择的差异基因总表
  gene_diff_select <- subset(gene_diff, sig %in% c('up', 'down'))
  write.table(gene_diff_select, file = 'control_treat.glmQLFit.select.txt', sep = '\t', col.names = NA, quote = FALSE)
  #根据 up 和 down 分开输出
  gene_diff_up <- subset(gene_diff, sig == 'up')
  gene_diff_down <- subset(gene_diff, sig == 'down')
  write.table(gene_diff_up, file = 'control_treat.glmQLFit.up.txt', sep = '\t', col.names = NA, quote = FALSE)
  write.table(gene_diff_down, file = 'control_treat.glmQLFit.down.txt', sep = '\t', col.names = NA, quote = FALSE)
}

mainAnalysis <- function(path){
  print("#########step1：移动文件中###############")
  if(munzip(path) == TRUE )print("文件移动完成")
  print("#########step2：合并文件中###############")
  if(combin(path) == TRUE )print("文件合并完成")
  print("#########step3：文件列名转换中###############")
  if(convertName(path) == TRUE )print("文件列名转换完成")
  print("#########step4：使用egdR包进行基差异分析中###############")
  if(edgRAnalyze(path) == TRUE )print("本次差异基因分析结束，请查看结果")
}
#e火山图
#author tanzicai
#time 2021.6.8 R4.0.1
#使用edgR包对数据进行差异分析
#输入：表达矩阵、分组信息
#输出：差异表达结果
paintVolcanoPlot <- function(path){
  if(any(grepl("ggplot2",installed.packages())) == FALSE){
    BiocManager::install("ggplot2")
  }
  library(ggplot2)
  
  data = read.csv("../最终分析文件输出/差异分析结果.csv")
 logFC <-data$logFC
 padj <- data$FDR
 data <- data.frame(logFC=logFC,padj=padj)
 data$sig[(data$padj > 0.05|data$padj=="NA")|(data$logFC < 0.5)& data$logFC > -0.5] <- "NO"
 data$sig[data$padj <= 0.05 & data$logFC >= 0.5] <- "up"
 data$sig[data$padj <= 0.05 & data$logFC <= -0.5] <- "DOWN"
 
 # 选最大值作为xlim的上下边界
 x_lim <- max(logFC,-logFC)
 # 绘制火山图
 p<-ggplot(temp,aes(x=temp$log_foldchange,y=-log10(temp$p_value)))+xlab("log2 Fold Change")+ylab("-log10P-Value")+
   
   geom_point(size=4,alpha=0.6)
}
```

path =下载文件的解压的文件夹路径

例如：/Users/tanzicai/Documents/test/原始文件

[![image-20210916183844888](https://gitee.com/tanzicai/drawingbed/raw/master/img/202109161838048.png)](https://gitee.com/tanzicai/drawingbed/raw/master/img/202109161838048.png)

确保文件夹中间有meta文件

[![image-20210916183936980](https://gitee.com/tanzicai/drawingbed/raw/master/img/202109161839045.png)](https://gitee.com/tanzicai/drawingbed/raw/master/img/202109161839045.png)

运行mainAnalysisi(path)输出结果

[![image-20210916184007383](https://gitee.com/tanzicai/drawingbed/raw/master/img/202109161840469.png)](https://gitee.com/tanzicai/drawingbed/raw/master/img/202109161840469.png)

**文章作者:** [谭自财](mailto:undefined)
