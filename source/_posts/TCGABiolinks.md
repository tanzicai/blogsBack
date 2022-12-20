---
title: TCGAbiolinks使用手册
date: 2021-09-25 09:25:00
author: 谭自财
summary: TCGAbiolinks使用介绍
categories: 医学统计
top_img: https://gitee.com/tanzicai/drawingbed/raw/master/img/20210926173535.png
cover: https://gitee.com/tanzicai/drawingbed/raw/master/img/20210926173535.png
tags:
  - TCGA
  - RNA-Seq
  - 肾癌
  - TCGAbiolinks
---

## 介绍

下载TCGA数据的方法有很多，之前介绍了如何用gdc-client批量下载数据、网页下载等。基于网上有很多用TCGAbiolinks包下载数据的教程，所以也想学习一下这个方法。

TCGAbiolinks的优点在于具备一体化的下载整合，无需再使用复杂的方法对下载的单个数据重新进行整合，换句话说，就是TCGAbiolinks包下载的数据是合并了的。不需要在进行读取合并等等操作。

[TCGA数据库中含有的癌症名称、简写、中文名称对照表 | 小谭的部落阁 (gitee.io)](https://tanzicai.gitee.io/2021/05/07/TCGA数据库中含有的癌症名称、简写、中文名称对照表/))

# 数据下载

## 疾病缩写查看

```R
TCGAbiolinks:::getGDCprojects()$project_id
```

可以查看所有支持的癌症种类的缩写

```R
 [1] "CPTAC-3"               "GENIE-MSK"            
 [3] "GENIE-VICC"            "GENIE-UHN"            
 [5] "CPTAC-2"               "CMI-ASC"              
 [7] "BEATAML1.0-COHORT"     "CGCI-BLGSP"           
 [9] "BEATAML1.0-CRENOLANIB" "CMI-MPC"              
[11] "CMI-MBC"               "GENIE-GRCC"           
[13] "GENIE-MDA"             "GENIE-JHU"            
[15] "GENIE-NKI"             "FM-AD"                
[17] "TCGA-BRCA"             "TCGA-MESO"            
[19] "VAREPOP-APOLLO"        "WCDT-MCRPC"           
[21] "GENIE-DFCI"            "TARGET-ALL-P3"        
[23] "TARGET-ALL-P2"         "OHSU-CNL"             
[25] "TARGET-ALL-P1"         "MMRF-COMMPASS"        
[27] "TARGET-CCSK"           "ORGANOID-PANCREATIC"  
[29] "NCICCR-DLBCL"          "TARGET-NBL"           
[31] "TCGA-CESC"             "TCGA-BLCA"            
[33] "TARGET-OS"             "TCGA-CHOL"            
[35] "TARGET-RT"             "TARGET-WT"            
[37] "TCGA-ACC"              "TCGA-DLBC"            
[39] "TCGA-HNSC"             "TCGA-COAD"            
[41] "TCGA-ESCA"             "TCGA-LAML"            
[43] "TCGA-KIRP"             "TCGA-KIRC"            
[45] "TCGA-GBM"              "TCGA-KICH"            
[47] "TCGA-READ"             "TCGA-PAAD"            
[49] "TCGA-LUAD"             "TCGA-OV"              
[51] "TCGA-LIHC"             "TCGA-LUSC"            
[53] "TCGA-LGG"              "TCGA-UCEC"            
[55] "TCGA-PRAD"             "TCGA-STAD"            
[57] "TCGA-THCA"             "TCGA-THYM"            
[59] "TCGA-UCS"              "TCGA-UVM"             
[61] "TCGA-PCPG"             "TCGA-SARC"            
[63] "CGCI-HTMCP-CC"         "TCGA-SKCM"            
[65] "TARGET-AML"            "CTSP-DLBCL1"          
[67] "HCMI-CMDC"             "TRIO-CRU"             
[69] "REBC-THYR"             "TCGA-TGCT"  
```

查看癌症种类的缩写中英文对照表参考博客[TCGA数据库中含有的癌症名称、简写、中文名称对照表]([TCGA数据库中含有的癌症名称、简写、中文名称对照表 | 小谭的部落阁 (gitee.io)](https://tanzicai.gitee.io/2021/05/07/TCGA数据库中含有的癌症名称、简写、中文名称对照表/))

## 癌症选择下载

请求时我们将`GDCquery`函数，使用发现=`GDCquery`函数一共有11个参数：

```R
project、data.category、data.type、workflow.type、legacy = FALSE、access、platform、file.type、barcode、experimental.strategy、sample.type
```

具体这些参数代表什么意思，请查看[基于TCGA数据库筛选和肾癌（KIRC亚型）差异基因（实现）]([基于TCGA数据库筛选和肾癌（KIRC亚型）差异基因（实现） | 小谭的部落阁 (gitee.io)](https://tanzicai.gitee.io/2021/06/07/基于TCGA数据库的肾癌自噬相关基因预后模型的建立与应用（实现）/))网页下载部分的信息，这些参数与网页选择是一一对应的。
```R
cancer_type="TCGA-KIRC"
  
clinical <- GDCquery_clinic(project = cancer_type, type = "clinical")
  
clinical[1:4,1:4]
```
设置癌症简写，请求数据结果如下

```R
submitter_id synchronous_malignancy ajcc_pathologic_stage days_to_diagnosis
1 TCGA-KM-A7QD                     No               Stage I                 0
2 TCGA-KL-8328                     No              Stage II                 0
3 TCGA-UW-A72P                     No               Stage I                 0
4 TCGA-KO-8407                     No              Stage II                 0
```

![image-20210924122547733](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210924122925.png)

我们打开可视化列表即可发现，收到的表的每一行是一个病例，里面详细记录了病例的编号、是否同步恶性、观察时间等等信息。

```R
dim(clinical)
[1] 113  71
```

列表共117个病例，每个病例有71项记录参数。

接下来我们将下载我们需要的数据，参数要求与网页下载对照即可明白

```R
 query <- GDCquery(project = cancer_type, 
                   
                   data.category = "Transcriptome Profiling", 
                   
                   data.type = "miRNA Expression Quantification", 
                   
                   workflow.type = "BCGSC miRNA Profiling",
                 
                   data.format = "txt")
```

请求到的数据如下图所示，我们需要把他们全都下载下来

![image-20210924123947469](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210924123947.png)

```R
GDCdownload(query, method = "api", files.per.chunk = 50)
```

方法一般选择`api`，` files.per.chunk`指切片数量，在网络不好的情况下啊，切片数量尽量小。

```R
Downloading data for project TCGA-KICH
GDCdownload will download 91 files. A total of 4.570954 MB
Downloading chunk 1 of 2 (50 files, size = 2.511206 MB) as Fri_Sep_24_12_42_01_2021_0.tar.gz
Downloading: 410 kB     Downloading chunk 2 of 2 (41 files, size = 2.059748 MB) as Fri_Sep_24_12_42_01_2021_1.tar.gz
```

这里介绍了下载信息，可以观察我们下载的数据

![image-20210924124442526](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210924124442.png)

在这步执行完后，我们可以发现，在工作路径里多了GDCData的文件夹，其中就是我们下载解压好的文件。

接下来自然是把所有的数据合并到一个表中，所以有

```R
expdat <- GDCprepare(query = query)
```

温馨提示，这一步生成的表格打开和写入的话，非常消耗性能，谨慎操作

![image-20210924125216494](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210924125216.png)

接下来进行一般的数据处理，我们简单写写就行

```R
  library(tibble)
  
  #重命名行名
  
  rownames(expdat) <- NULL

  expdat <- column_to_rownames(expdat,var = "miRNA_ID")
  
  expdat[1:3,1:3]

  #行列置换

  exp = t(expdat[,seq(1,ncol(expdat),3)])
  
  exp[1:4,1:4]
  
  expr=exp
  
  #行名分割替换

  rowName <- str_split(rownames(exp),'_',simplify = T)[,3]
  
  expr<- apply(expr,2,as.numeric) 
  
  expr<- na.omit(expr)
  
  dim(expr)
  
  expr <- expr[,apply(expr, 2,function(x){sum(x>1)>10})]
  
  rownames(expr) <- rowName
  
  dim(expr)
  
  expr[1:4,1:4]
  
  #保存数据

  save(expr,clinical,file = "tcga-kirc-download.Rdata")
```

我们得到了如下的表格，列明为miRNA编号，行名为病例的编号，接下来就是数据分析了

![image-20210924131444792](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210924131444.png)

# 数据分析

## 病例随身参数筛选

`clinical`存着病例随身参数，是病例的详细参数，而我们不需要所有，我们筛选一下，只要其中的几项存入meta中即可。

```R
  meta <- clinical
  
  colnames(meta)
  
  meta <- meta[,c("submitter_id","vital_status",
                  
                  "days_to_death","days_to_last_follow_up",
                  
                  "race",
                  
                  "age_at_diagnosis",
                  
                  "gender" ,
                  
                  "ajcc_pathologic_stage")]
```

![image-20210924131939456](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210924131939.png)

## 根据meta匹配样本癌症信息

```R
  #转置样本  
  expr=t(expr)

  expr[1:4,1:4]
  
  #分出tumor组和normal组

  group_list <- ifelse(as.numeric(str_sub(colnames(expr),14,15))<10,"tumor","normal")
  
  group_list <- factor(group_list,levels = c("normal","tumor"))
  
  table(group_list)
```

```R
> table(group_list)

group_list

normal  tumor 

    25     66 
```

我们就得到了normal样本25个，tumor样本66个

保存数据

```R
save(expr,group_list,file = "tcga-kirc-raw.Rdata")
```

## 使用DESeq2进行差异分析

### 创建tumor、normal对照表，以及创建`DESeqDataSetFromMatrix`

```R
library(DESeq2)
 
colData <- data.frame(row.names =colnames(expr), condition=group_list)
  
 dds <- DESeqDataSetFromMatrix(
   	 countData = expr,
    
     colData = colData,
    
    design = ~ condition)

dds <- DESeq(dds)
```

### 计算所有参数

```R
 # 两两比较/
  
 res <- results(dds, contrast = c("condition",rev(levels(group_list))))
  
resOrdered <- res[order(res$pvalue),] # 按照P值排序
 
  DEG <- as.data.frame(resOrdered)
  
  head(DEG)
```

### 去除NA

```R
 DEG <- na.omit(DEG)
```

### 添加上下调标记

```R
#logFC_cutoff <- with(DEG,mean(abs(log2FoldChange)) + 2*sd(abs(log2FoldChange)) )
logFC_cutoff <- 1
  
DEG$change = as.factor(ifelse(DEG$pvalue < 0.05 & abs(DEG$log2FoldChange) > logFC_cutoff,ifelse(DEG$log2FoldChange > logFC_cutoff ,'UP','DOWN'),'NOT'))

head(DEG)
  
DESeq2_DEG <- DEG
```

```R
DOWN  NOT   UP 
 137  384  131
```



## 使用edgeR方法

```R
library(edgeR)

dge <- DGEList(counts=expr,group=group_list)
  
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
  
  DEG=topTags(fit2, n=nrow(expr))
  
  DEG=as.data.frame(DEG)
  
  logFC_cutoff <- with(DEG,mean(abs(logFC)) + 2*sd(abs(logFC)) )
  
  logFC_cutoff <- 1
  
  DEG$change = as.factor(
  
      ifelse(DEG$PValue < 0.05 & abs(DEG$logFC) > logFC_cutoff,
    
                    ifelse(DEG$logFC > logFC_cutoff ,'UP','DOWN'),'NOT')
  
      )
  
  head(DEG)
  
  table(DEG$change)
  
  edgeR_DEG <- DEG
```

```R
DOWN  NOT   UP 
 108  413  13
```

## limma方法

```R
library(limma)
  
  
  design <- model.matrix(~0+group_list)
  
  colnames(design)=levels(group_list)
  
  rownames(design)=colnames(expr)
  
  
  dge <- DGEList(counts=expr)
  
  dge <- calcNormFactors(dge)
  
  logCPM <- cpm(dge, log=TRUE, prior.count=3)
  
  
  v <- voom(dge,design, normalize="quantile")
  
  fit <- lmFit(v, design)
  
  
  constrasts = paste(rev(levels(group_list)),collapse = "-")
  
  cont.matrix <- makeContrasts(contrasts=constrasts,levels = design) 
  
  fit2=contrasts.fit(fit,cont.matrix)
  
  fit2=eBayes(fit2)
  
  DEG = topTable(fit2, coef=constrasts, n=Inf)
  
  DEG = na.omit(DEG)
  #logFC_cutoff <- with(DEG,mean(abs(logFC)) + 2*sd(abs(logFC)) )
  
  logFC_cutoff <- 1
  
  DEG$change = as.factor(
  
      ifelse(DEG$P.Value < 0.05 & abs(DEG$logFC) > logFC_cutoff,
    
                    ifelse(DEG$logFC > logFC_cutoff ,'UP','DOWN'),'NOT')
  )
  
  
  head(DEG)
  
  limma_voom_DEG <- DEG
  
  save(DESeq2_DEG,edgeR_DEG,limma_voom_DEG,group_list,file = "DEG.Rdata")
```

```R
DOWN  NOT   UP 
 123  435   94
```

#  差异分析结果的可视化

```R
draw_pca<-function(dat,group_list,path){
## 下面是画PCA的必须操作，需要看说明书。
dat=t(dat)#画PCA图时要求是行名时样本名，列名时探针名，因此此时需要转换
dat=as.data.frame(dat)#将matrix转换为data.frame
dat=cbind(dat,group_list) #cbind横向追加，即将分组信息追加到最后一列
library("FactoMineR")#画主成分分析图需要加载这两个包
library("factoextra") 
# The variable group_list (index = 54676) is removed
# before PCA analysis
dat.pca <- PCA(dat[,-ncol(dat)], graph = FALSE)#现在dat最后一列是group_list，需要重新赋值给一个dat.pca,这个矩阵是不含有分组信息的
fviz_pca_ind(dat.pca,
             geom.ind = "point", # show points only (nbut not "text")
             col.ind = dat$group_list, # color by groups
             #palette = c("#00AFBB", "#E7B800"),
             addEllipses = TRUE, # Concentration ellipses
             legend.title = "Groups"
)
ggsave('path')
}
}

```

```R
draw_heatmap<-function(dat,group_list){
cg=names(tail(sort(apply(dat,1,sd)),1000))#apply按行（'1'是按行取，'2'是按列取）取每一行的方差，从小到大排序，取最大的1000个
library(pheatmap)
pheatmap(dat[cg,],show_colnames =F,show_rownames = F) #对那些提取出来的1000个基因所在的每一行取出，组合起来为一个新的表达矩阵
n=t(scale(t(dat[cg,]))) # 'scale'可以对log-ratio数值进行归一化
n[n>2]=2 
n[n< -2]= -2
n[1:4,1:4]
pheatmap(n,show_colnames =F,show_rownames = F)
ac=data.frame(g=group_list)
rownames(ac)=colnames(n) #把ac的行名给到n的列名，即对每一个探针标记上分组信息
pheatmap(n,show_colnames =F,show_rownames = F,
         annotation_col=ac,filename = 'heatmap_top1000_sd.png')
}
```

```R
  cg1 = rownames(DESeq2_DEG)[DESeq2_DEG$change !="NOT"]
  
  cg2 = rownames(edgeR_DEG)[edgeR_DEG$change !="NOT"]
  
  cg3 = rownames(limma_voom_DEG)[limma_voom_DEG$change !="NOT"]
  
  #下面三个图会相互覆盖，注意保存
  
  h1 = draw_heatmap(expr[cg1,],group_list)
  
  h2 = draw_heatmap(expr[cg2,],group_list)
  
  h3 = draw_heatmap(expr[cg3,],group_list)
  
  #下面三个图会相互覆盖，注意保存

  v1 = draw_volcano(DESeq2_DEG[,c(2,5,7)])
  
  v2 = draw_volcano(edgeR_DEG[,c(1,4,6)])
  
  v3 = draw_volcano(limma_voom_DEG[,c(1,4,7)]) 
  
```

火山图##有错误

```r
if (!requireNamespace('BiocManager', quietly = TRUE))
    install.packages('BiocManager')

  BiocManager::install('EnhancedVolcano')
```

```R
EnhancedVolcano(data,
                title = 'limma',
                lab = rownames(data),
                x = 'logFC',
                y = 'P.Value',
                FCcutoff = 1,
                pCutoff=0.01,
                xlim=c(-8,8),    #x轴范围，为了完整显示右边miRNA的名字，设置大一点
                ylim=c(-1,1)
)
```

+ tips:BiocManager安装的包报错，建议使用github安装

+ ```
  devtools::install_github('kevinblighe/EnhancedVolcano')
  ```

```R
 draw_volcano <- function(data,p = NULL,x,y){
     if(!is.null(p)){
         FCcutoff = p
     }else{
         FCcutoff = 1
     }
     rownames(data,"logFC","pvalue")
     EnhancedVolcano(data,
                     lab = rownames(data),
                     x = 'logFC',
                     y = 'pvalue',
                     xlim = c(-6,7),
                    xlab = bquote(~Log[2]~ 'fold change'),
                     pCutoff = 10e-14,
                     FCcutoff = FCcutoff
     )
 }
```

