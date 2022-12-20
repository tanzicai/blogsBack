---
title: 利用R包TCGAbiolinks进行各种数据下载
date: 2021-05-07 09:25:00
author: 谭自财
summary: R包TCGAbiolinks进行各种数据下载
categories: 医学统计
tags:
  - TCGA
  - 数据下载
---

TCGAbiolinks的优点在于具备一体化的下载整合，无需再使用复杂的方法对下载的单个数据重新进行整合，换句话说，就是TCGAbiolinks包下载的数据是合并了的，不需要整理（TCGAbiolinks数据下载）。
TCGAbiolinks的官方网站是：http://www.bioconductor.org/packages/devel/bioc/vignettes/TCGAbiolinks/inst/doc/index.html
代码参考：TCGA3.R包TCGAbiolinks下载数据

## 安装TCGAbiolinks

```R
> BiocManager::install("TCGAbiolinks")
> library(TCGAbiolinks)
```
## 选定要下载的cancer类型

```R
>TCGAbiolinks::getGDCprojects()$project_id
 [1] "TCGA-SARC"             "TARGET-CCSK"          
 [3] "TARGET-NBL"            "TARGET-AML"           
 [5] "TCGA-MESO"             "TCGA-ACC"             
 [7] "TCGA-READ"             "TCGA-LGG"             
 [9] "BEATAML1.0-CRENOLANIB" "TCGA-THCA"            
[11] "VAREPOP-APOLLO"        "HCMI-CMDC"            
[13] "TCGA-CHOL"             "TCGA-KIRC"            
[15] "ORGANOID-PANCREATIC"   "TCGA-BRCA"            
[17] "TCGA-OV"               "TCGA-GBM"             
[19] "TCGA-SKCM"             "GENIE-VICC"           
[21] "TCGA-DLBC"             "CGCI-BLGSP"           
[23] "OHSU-CNL"              "CPTAC-3"              
[25] "BEATAML1.0-COHORT"     "TCGA-KICH"            
[27] "TCGA-UVM"              "TCGA-THYM"            
[29] "TCGA-TGCT"             "TCGA-LUSC"            
[31] "TCGA-PRAD"             "FM-AD"                
[33] "TCGA-UCEC"             "TCGA-LAML"            
[35] "TARGET-ALL-P2"         "TCGA-STAD"            
[37] "TARGET-ALL-P3"         "GENIE-DFCI"           
[39] "GENIE-NKI"             "GENIE-MDA"            
[41] "GENIE-JHU"             "GENIE-MSK"            
[43] "TCGA-ESCA"             "TCGA-HNSC"            
[45] "TARGET-OS"             "TARGET-RT"            
[47] "TCGA-LIHC"             "CTSP-DLBCL1"          
[49] "TCGA-COAD"             "TCGA-LUAD"            
[51] "TCGA-CESC"             "TARGET-WT"            
[53] "NCICCR-DLBCL"          "TCGA-PAAD"            
[55] "MMRF-COMMPASS"         "TARGET-ALL-P1"        
[57] "CPTAC-2"               "TCGA-UCS"             
[59] "TCGA-KIRP"             "TCGA-PCPG"            
[61] "TCGA-BLCA"             "GENIE-UHN"            
[63] "GENIE-GRCC"

```

选择下载的癌症数据

```R
cancer_type="TCGA-HNSC"
```

## 临床数据下载

```R
clinical <- GDCquery_clinic(project= cancer_type,type = "clinical")
# 查看下载的部分数据：
clinical[1:4,1:4]
submitter_id year_of_diagnosis classification_of_tumor last_known_disease_status
1 TCGA-4P-AA8J              2013            not reported              not reported
2 TCGA-BA-4074              2003            not reported              not reported
3 TCGA-BA-4075              2004            not reported              not reported
4 TCGA-BA-4076              2003            not reported              not reported
dim(clinical)
[1] 528  78 #是个528行，78列的一个表
#可视化窗口查看数据
View(clinical)
```

可以看出这个表，一行是一个病例，列是根据这个病人的各项信息。

![img](https://gitee.com/tanzicai/drawingbed/raw/master/img/%E4%B8%8B%E8%BD%BD%E6%95%B0%E6%8D%AE%E8%A1%A8%E6%A0%BC%E7%A4%BA%E4%BE%8B.png)

## 实验相关的数据下载
好说~网上也能搜到各种数据类型的下载方法：

### 1.RNA-seq的counts数据

```R
library(dplyr)
library(DT)
library(SummarizedExperiment)
data_type <- "Gene Expression Quantification"#选择数据类型为“基因定量表达”
data_category <- "Transcriptome Profiling" #选择数据类别为转录组
workflow_type <- "HTSeq - Counts"
query_TranscriptomeCounts <- GDCquery(project = cancer_type, 
                                  data.category = data_category, 
                                  data.type =  data_type, 
                                  workflow.type = workflow_type)
# GDCquery函数参数详解官网网址：http://www.bioconductor.org/packages/release/bioc/vignettes/TCGAbiolinks/inst/doc/query.html#useful_information
#然后会弹出一大串下面这些
--------------------------------------
o GDCquery: Searching in GDC database
--------------------------------------
Genome of reference: hg38
--------------------------------------------
oo Accessing GDC. This might take a while...
--------------------------------------------
ooo Project: TCGA-HNSC
--------------------
oo Filtering results
--------------------
ooo By data.typeooo By workflow.type
----------------
oo Checking data
----------------
ooo Check if there are duplicated casesooo Check if there results for the query
-------------------
o Preparing output
-------------------
#将上一步搜索得到的数据下载下来，自动存储到所设置目录下的文件夹> GDCdownload(query_TranscriptomeCounts, method = "api")
#method：使用API (POST方法)或gdc客户端工具。选择“api”,“client”。API更快，但是下载过程中数据可能会损坏，可能需要重新执行。
Downloading data for project TCGA-HNSCGDC
download will download 546 files. A total of 136.906805 MB
Downloading as: Wed_Jan_08_16_55_43_2020.tar.gz
Downloading: 140 MB
```

GDCquery函数参数详解官网网址：

http://www.bioconductor.org/packages/release/bioc/vignettes/TCGAbiolinks/inst/doc/query.html#useful_information

```R
#将搜索得到的数据转换为适用于R语言的形式，返回值为a summarizedExperiment or a data.frame---类似矩阵的容器，行名为基因，列名为样本名 
> expdat <- GDCprepare(query = query_TranscriptomeCounts) 
 
|===================================================================================|100%                     
Completed after 1 m 
Starting to add information to samples
 => Add clinical information to samples
Add FFPE information. More information at: 
=> https://cancergenome.nih.gov/cancersselected/biospeccriteria 
=> http://gdac.broadinstitute.org/runs/sampleReports/latest/FPPP_FFPE_Cases.html
 => Adding subtype information to samples
hnsc subtype information from:doi:10.1038/nature14129
Accessing www.ensembl.org to get gene information
Downloading genome information (try:0) Using: Human genes (GRCh38.p13)
From the 60483 genes we couldn't map 3971

#转换
count_matrix=assay(expdat)
#可视化查看矩阵
View(count_matrix)
```

![img](https://gitee.com/tanzicai/drawingbed/raw/master/img/%E8%BD%AC%E6%8D%A2%E5%90%8E%E7%9F%A9%E9%98%B5.webp)

### 2.**下载RNA-seq的FPKM数据**

```R
> Expr_df <- GDCquery(project = cancer_type,
                     data.category = data_category,
                     data.type =  data_type,
                     workflow.type = "HTSeq - FPKM")
> GDCdownload(Expr_df, method = "api", files.per.chunk = 100)
#files.per.chunk：这将使API方法一次只下载n个(files.per.chunk)文件。当数据量过大时，可能会下载出错，可设置files.per.chunk参数减少下载问题。值为整数，即可将文件拆分为几个文件下载，如files.per.chunk = 6。
Downloading data for project TCGA-HNSC
GDCdownload will download 546 files. A total of 278.868796 MB
Downloading chunk 1 of 6 (100 files, size = 51.032322 MB) as Wed_Jan_08_19_22_27_2020_0.tar.gz
Downloading: 51 MB     Downloading chunk 2 of 6 (100 files, size = 51.063004 MB) as Wed_Jan_08_19_22_27_2020_1.tar.gz
Downloading: 51 MB     Downloading chunk 3 of 6 (100 files, size = 51.028334 MB) as Wed_Jan_08_19_22_27_2020_2.tar.gz
Downloading: 51 MB     Downloading chunk 4 of 6 (100 files, size = 51.08847 MB) as Wed_Jan_08_19_22_27_2020_3.tar.gz
Downloading: 51 MB     Downloading chunk 5 of 6 (100 files, size = 51.14113 MB) as Wed_Jan_08_19_22_27_2020_4.tar.gz
Downloading: 51 MB     Downloading chunk 6 of 6 (46 files, size = 23.515536 MB) as Wed_Jan_08_19_22_27_2020_5.tar.gz
Downloading: 24 MB
 
> expdat_2 <- GDCprepare(query = Expr_df)
> Expr_matrix=assay(expdat_2)
> write.csv(Expr_matrix,file = "TCGAbiolinks_HNSC_FPKM.csv")
```

### 3. 其他数据下载

```R
#下载miRNA数据
  query <- GDCquery(project = cancer_type, 
                    data.category = "Transcriptome Profiling", 
                    data.type = "miRNA Expression Quantification", 
                    workflow.type = "BCGSC miRNA Profiling")
  
  GDCdownload(query, method = "api", files.per.chunk = 50)
  expdat <- GDCprepare(query = query)
  count_matrix=assay(expdat)
  write.csv(count_matrix,file = paste(cancer_type,"miRNA.csv",sep = "-"))
  
#下载Copy Number Variation数据
  query <- GDCquery(project = cancer_type, 
                    data.category = "Copy Number Variation", 
                    data.type = "Copy Number Segment")
  
  GDCdownload(query, method = "api", files.per.chunk = 50)
  expdat <- GDCprepare(query = query)
  count_matrix=assay(expdat)
  write.csv(count_matrix,file = paste(cancer_type,"Copy-Number-Variation.csv",sep = "-"))
  
#下载甲基化数据
  query.met <- GDCquery(project =cancer_type,
                        legacy = TRUE,
                        data.category = "DNA methylation")
  GDCdownload(query.met, method = "api", files.per.chunk = 300)
  expdat <- GDCprepare(query = query)
  count_matrix=assay(expdat)
  write.csv(count_matrix,file = paste(cancer_type,"methylation.csv",sep = "-"))
```

## 保存下载表

```R
#保存数据
save(clinical,file="BRCA_clinical.Rdata")
#导出数据到文件
write.csv(clinical, file="TCGAbiolinks-BRCA-clinical.csv")
```



