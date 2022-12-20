---

title: 基于TCGA数据库筛选和肾癌（KIRC亚型）差异基因（实现）
date: 2021-06-07 19:25:00
author: 谭自财
summary: TCGA 的差异基因分析的一些介绍
categories: 医学统计
tags:
  - TCGA
  - RNA-Seq
  - 肾癌
---

## 1.数据下载

### 1.1 网页下载

![癌症选择](https://gitee.com/tanzicai/drawingbed/raw/master/img/%E7%99%8C%E7%97%87%E9%80%89%E6%8B%A9.png)

![数据库及癌症亚型选择](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210608002010.png)

![下载文件选择](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210608002419.png)

### 1.2 TCGABiolinks下载

```R
setwd("D:\Bioinformatics data analysis")
if (!requireNamespace("BiocManager", quietly = TRUE)) 
  install.packages("BiocManager") 
BiocManager::install("TCGAbiolinks") 
library(TCGAbiolinks)
query <- GDCquery(project = "TCGA-KIRC",
                  data.category = "Transcriptome Profiling",
                  data.type = "Gene Expression Quantification", 
                  workflow.type = "HTSeq - Counts")
```

` BiocManager ` ：管理旗下的所有R包，具有少依赖，即时更行的特点

`TCGAbiolinks ` ：TCGA的一个官方数据包，详细教程参考[TCGA数据下载—TCGAbiolinks包参数详解](https://mp.weixin.qq.com/s?__biz=MzAxMDkxODM1Ng==&mid=2247489671&idx=2&sn=9c30f309bb038d53672ab8ccf27870ce&chksm=9b48583cac3fd12a1e75a7052bd6cd9546623347f832a5be77cbcd4ba050a7768190e27f5246&cur_album_id=1630936920258052103&scene=190#rd)

`project`：可以使用`TCGAbiolinks:::getGDCprojects()$project_id)`得到各个癌种的项目id，总共有45个ID值。对应中文参考[TCGA数据库中含有的癌症名称、简写、中文名称对照表](https://tanzicai.gitee.io/2021/05/07/tcga-shu-ju-ku-zhong-han-you-de-yan-zheng-ming-cheng-jian-xie-zhong-wen-ming-cheng-dui-zhao-biao/)

![癌种的项目id](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210609005249.png)

`data.category`：可以使用`TCGAbiolinks:::getProjectSummary(project)`查看`project`中有哪些数据类型，表达谱'data.category="Transcriptome Profiling'

| 序号 | 类型[英]                    | 类型[中]             |
| ---- | --------------------------- | -------------------- |
| 1    | Transcriptome Profiling     | 转录组分析           |
| 2    | Copy Number Variation       | 拷贝数变异           |
| 3    | Simple Nucleotide Variation | 简单的核苷酸变异     |
| 4    | DNA Methylation             | DNA甲基化            |
| 5    | Clinical                    | 临床数据             |
| 6    | Sequencing Reads            | 测序(机翻：可能有错) |
| 7    | Biospecimen                 | 生物标本             |

`data.type`：筛选要下载的文件的数据类型

![参数对应关系](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210609010336.png)

`workflow.type`：不同的数据类型，有其对应的参数可供选择。`workflow.type` 有三种类型分别为：

- HTSeq - FPKM-UQ：FPKM上四分位数标准化值
- HTSeq - FPKM：FPKM值/表达量值
- HTSeq - Counts：原始count数

本次需要count数，即`workflow.type=“HTSeq - Counts”`。

## 2. 数据预处理

### 2.1数据组合

---

![下载文件解压后内容](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210609010754.png)

![其中文件夹内容](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210609010826.png)

![压缩包内即为counts](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210609010921.png)

所以我们要做的就是把下载得到的所有文件夹里面的压缩包移动到同一个文件夹，然后把他们解压，让所有的counts文件放在一起，便于我们后面的导入。

* **疑问**：`paste()`函数拼接字符串总是有空格，`seq`参数设置为`""`也无法解决

```R
##################数据文件解压、组合#######################
#移动文件夹中的所有压缩包到同一个文件夹，再解压
#2021.6.8 R4.0.1
setwd("D:/Bioinformatics")
dir.create("mergeAllFileTofolder")
filePath = dir(path = "./dataBase_TCGA-KIRC",full.names = T)
filePath = filePath[1:length(filePath)-1]
for(wd in filePath){
  files = dir(path = wd,pattern = "gz$")
  fromFilePath = paste0(wd,"/",files)
  toFilePath = paste0("./mergeAllFileTofolder/",files)
  file.copy(fromFilePath,toFilePath)
}
setwd("./mergeAllFileTofolder")
countsFiles = dir(path = "./",pattern = "gz$")
library(R.utils)
sapply(countsFiles,gunzip)
```

得到的文件夹如下图所示，下面就便于导入数据了。

![处理后的存放所有counts的文件夹](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210609011935.png)

### 2.2counts矩阵生成

---

我们需要把上一步得到的所有文件导入到同一个表中，其中为EnsembleID，行名为TCGA编码。

* 疑问：

  ![同名变量问题](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210609020446.png)

* 疑问：

```R
#################counts转换矩阵#####################
#导入所有counts文件，然后根据JOSN数据修改列名为TCGA编码，以及去掉EnsembleID的版本号，便于后面进行ID转换
#2021.6.8 R4.0.1
#文件读取
setwd("D:/Bioinformatics")
countFilePath = dir(path = "./test_Samplecounts",pattern = "*.counts")
counts_merge = NULL
for (i in countFilePath) {
  x=read.delim(paste0("./test_Samplecounts/",i),col.names = c("ID",substring(i,1,9)))
  if(is.null(counts_merge)){
    counts_merge = x
  }
  else{
    counts_merge =merge(counts_merge,x,by = "ID")
  }
}

#转换行名
rownames(counts_merge)=counts_merge$ID
counts_reduce = counts_merge[-(1:5),]
conuts_reduce = counts_merge[,-1]
rownames(counts_reduce) = counts_merge$ID[-(1:5)]
#head(counts_reduce,10)[,1:3]

#注释分组信息提取
#加载meta文件
metaJSON = fromJSON(file = './metadata.cart.2021-06-08.json')
jsonDataInfo = data.frame(fileName = c(),TCGA_Barcode = c())
for (i in 1:length(metaJSON)) {
 TCGA_barcode = metaJSON[[i]][["associated_entities"]][[1]][["entity_submitter_id"]]
 fileName = metaJSON[[i]][["file_name"]]
 jsonDataInfo = rbind(jsonDataInfo,data.frame(fileName = fileName,TCGA_barcode = TCGA_barcode))
}
rownames(jsonDataInfo) = jsonDataInfo[,1]
write.csv(jsonDataInfo,file = "./fileNameToTCGA_Borcode.csv")
#获取counts矩阵
fileNameToTCGA_Barcode = josnDataInfo[-1]
countsFilesName =list.files(path = "./test_Samplecounts",pattern = "*.counts")
allSampleCounts = data.frame()
for (file in countsFilesName) {
  sampleCounts = read.table(paste0("./test_Samplecounts/",file),header = F)
  rownames(sampleCounts) = sampleCounts[,1]
  sampleCounts = sampleCounts["V2"]
  #根据上面文件的对应关系命名列名
  colnames(sampleCounts) = fileNameToTCGA_Barcode[paste0(file,".gz"),1]
  if(dim(allSampleCounts)[1] == 0){
    allSampleCounts = sampleCounts
  }else{
    allSampleCounts = cbind(allSampleCounts,sampleCounts)
  }
}
write.csv(allSampleCounts,file = "./ENSG_TCGABarcode.csv")
ENSG_ID = substr(row.names(allSampleCounts),1,15)
rownames(allSampleCounts) = ENSG_ID
write.csv(allSampleCounts,file = "./ENSG_TCGABarcode_RowNameSubstr1_15.csv")
```

在转换行名中，由于counts文件有5行的注释信息，记得删除5行数据

![image-20210609013556994](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210609013557.png)

由于我们的文件名均是以`01ae4201-f15c-4790-a7ea-41290808c5fa.htseq`的方式存在，而我们需要的是TCGA编码信息，所以我们需要下载对应的JSON数据进行转换

![metaJOSN文件下载](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210609013920.png)

![metaJOSN文件](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210609014228.png)

![R下导入的JSON文件](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210609015243.png)

建立filename与TCGA编码的对应关系，然后根据对应关系替换掉对应的列名

![filename与TCGA编码的对应关系](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210609015813.png)

由于EnsembleID中含有版本号，在下一步的ID转换中我们的数据与`EnsembleID-GeneName`对照表中EnsembleID的版本号不对应，所以我们需要去掉这里的版本信息，同样的，在后面的对应关系中我们也需要去掉版本号。

![EnsembleID和TCGA编码矩阵数据](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210609021158.png)

![EnsembleID（去掉版本号后）和TCGA编码矩阵数据](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210609021517.png)

### 2.3ID转换

---

在进行ID转换前，我们首先需要得到一张`EnsembleID-GeneName`对照表，我们有三种方式进行获取。

#### 2.3.1`EnsembleID-GeneName`转换表获取

---

##### 2.3.1.1 R包：`GeoTcgaData`

 GeoTcgaData包中有一个id转换的函数：`id_conversion_vector()` , 它可以对人类的各种基因id进行转换。2019年9月第一次发布，目前这个包在CRAN的下载量为1633次,2020年2月20日我在github和CRAN上对它进行了更新，支持转换的id种类更多！同时它对基因id的转换率也很不错。

它支持的种类中就有EnsembleID，所以我们可以使用此方法来转换ID

![支持的ID种类](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210609023118.png)

使用方法也很简单

```R
#从Ensembl ID 转到 uniprot id
uni <- id_conversion_vector("ensembl_gene_id", "uniprot_ids", ense) 
#从Ensembl ID 转到 entrez id
ent <- id_conversion_vector("ensembl_gene_id", "entrez_id", ense) 
uni
ent

[1] "A8K2U0"    ""            "Q9NPC4"      "Q8NGH7"    "Q9NRG9"
[1] "144568"   "100874108"    "53947"       "338751"    "8086"
```

##### 2.3.1.1 GTF文件替换

---



##### 2.3.1.3 org.Hs.eg.db包

```dart
library(org.Hs.eg.db)
g2s=unique(toTable(org.Hs.egSYMBOL))
head(g2s)
```

提取出SYMBOL信息

```undefined
g2e=unique(toTable(org.Hs.egENSEMBL)) 
head(g2e)
```

提取出ENSEMBL信息

```csharp
s2e=merge(g2e,g2s,by='gene_id')
```

整合两个数据，得到ENSEMBL和SYMBOL的对应关系

```bash
table(ids$ensembl_id %in% s2e$ensembl)
```

得到对应关系后进行ensembl_id转换，方法和上面的就是一样的了

```bash
ids=ids[ids$ensembl_id %in% s2e$ensembl,]
#取出在gencode数据库的gtf注释中能找到的ensembl_id
ids$symbol=s2e[match(ids$ensembl_id,s2e$ensembl),2]
#match返回其第二个参数中第一个参数匹配的位置
# 把s2e的ensembl按照ids$ensembl的顺序一个个取出来，从而得到ids$symbol这一列
length(unique(ids$symbol))
head(ids) 
ids=ids[order(ids$symbol,ids$median,decreasing = T),]#把ids$symbol按照ids$median排序
ids=ids[!duplicated(ids$symbol),]#取出不重复的ids$symbol
dim(ids) 
exprSet= exprSet[rownames(ids),]#取出表达矩阵中ids有的行
rownames(exprSet)=ids$symbol#把ids$symbol变为exprSet的行名
exprSet[1:4,1:4]  
dim(exprSet)
```



