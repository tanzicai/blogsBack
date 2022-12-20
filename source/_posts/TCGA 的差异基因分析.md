---
title: TCGA 差异基因分析
date: 2021-05-07 09:25:00
author: 谭自财
summary: TCGA 的差异基因分析介绍及实践
categories: 医学统计
tags:
  - TCGA
  - RNA-Seq
---

# TCGA数据库

## 数据库简介

肿瘤被认为是人类最复杂疾病之一, 目前为止人类已经发现了超过200种肿瘤亚型。肿瘤病人基因中发生的变化如体细胞突变、拷贝数变异、基因表达量差异和表观修饰变化与其特定的肿瘤亚型是相对应的。

**目的: **为了更好地发现、诊断和治疗肿瘤, 对其基因变化进行深入研究和建立相应数据库是目前所急需的。TCGA计划旨在通过大规模基因测序和综合性、多维度的分析手段来寻找由肿瘤发生发展造成的基因变化, 构建肿瘤基因相关的全方位“地图集”。

**时间、组织:**2006年, 美国国立癌症研究院 (National Cancer Institute, NCI) 和美国国立人类基因组研究院 (National Human Genome Research Institute, NHGRI) 合作开展了The Cancer Genome Atlas (TCGA) 数据库计划, 

**TCGA计划分为两个部分:**

**第一部分**从2006～2008年选择了具有严重不良预后且危害公共健康的3种常见肿瘤 (脑癌、肺癌和卵巢癌) 进行数据采集和分析, 从而对其数据库整体框架的构建进行基本测试;

**第二阶段**从2009年开始, 扩大肿瘤类型至33种并扩大样本量进行6种数据类型的记录和分析 (图1, A和B) , 这一过程虽然耗资巨大但成果显著。近年来科研人员已经依据TCGA数据库在多种肿瘤中发现了潜在的临床标志物和治疗靶点。

## 1. TCGA数据类型

TCGA使用基于芯片技术的高通量测序方法和二代测序技术来精确记录肿瘤基因组的全方位信息, 除此之外, TCGA还记录并追踪了病人的临床信息包括性别、年龄、肿瘤分期、复发和预后情况等, 从而有利于对其开展多因素综合性的分析。以下为TCGA数据库中较为常见的数据类型。

### 1.1 RNA测序数据

RNA测序 (**RNA-seq**) 是一种针对**转录组**进行测序的高通量技术, 其特点是**可以在大量样本中快速识别和量化不同表达水平的转录组,** 检测异构体变化、找到新的转录组、筛选融合基因和非编码RNA (ncRNA) 。

TCGA数据库中提供了RNA序列、基因表达量、外显子序列和突变点等信息的记录, 这一数据库为肿瘤转录组研究人员提供了大量数据和样本信息支持。

### 1.2 MicroRNA测序数据

MicroRNA是**一种长度约20nt的非编码小RNA分子**, 通过**与mRNA相互作用影响目标mRNA的稳定性及转录翻译等过程**, 最终**调控基因表达、诱导靶基因沉默、影响细胞生长、发育等生物**过程, 近年来也有研究以miRNA作为靶点的抗肿瘤药物[[19](javascript:void(0);)]。

TCGA数据库提供了肿瘤样本的miRNA表达、异构体情况, 可以用于分析肿瘤相关基因的互作网络关系和探索未被发现的miRNA[[20](javascript:void(0);),[21](javascript:void(0);)]。

### 1.3 DNA测序数据

DNA测序 (DNA-seq) **是一种高通量手段来测定DNA序列**从而找到DNA的变化如插入、缺失、点突变、多态性、拷贝数改变、突变频率和病毒基因组侵入。

TCGA数据库以Sanger测序技术为基础构建了DNA测序数据集, 构建该数据集是为了探究在不同肿瘤类型中基因组的多样性, 从而进一步找到具有诊断和治疗意义的新靶点。

### 1.4 单核苷酸多态性检测数据

单核苷酸多态性检测 (single nucleotide polymorphisms, SNPs) 是指由**单一核苷酸的改变所引起的序列多态性**

TCGA选择了Illumina平台的分子量阵列技术来检测多种肿瘤基因组中SNP水平的变化, 此外还能记录拷贝数变异 (copy number variation, CNV) 和杂合性缺失 (loss of heterozygosity, LOH) [[24](javascript:void(0);)]。

### 1.5 DNA甲基化测序数据

DNA甲基化测序可以检测**全基因组的表观遗传学改变**, 在CpG位点上的甲基化和去甲基化修饰是最早和最常见的肿瘤相关表观遗传变异, 这些表观遗传变异具有成为特异性肿瘤标志物的可能。

TCGA数据库中的甲基化数据是基于lllumina测序平台获得的, 保证了单碱基对的分辨率, 高测量精度和低样品DNA需要量, 不仅记录了信号强度、探查可信度还收载了用于进一步确定DNA甲基化水平的的计算β值等[[25](javascript:void(0);),[26](javascript:void(0);),[27](javascript:void(0);)]。

### 1.6 反向蛋白质阵列表达数据

反向蛋白质阵列 (reverse-phase protein array, RPPA) 是一种**高通量、高灵敏度、可重复的蛋白检测技术**, 可同时用500个抗体对超过1000个样本进行检测, 可以用于分子标志物筛选、分子靶标识别、肿瘤细胞亚型分析和药效学评价。

TCGA数据库收录了RPPA分析的原始图片, 原始信号强度, 相对蛋白表达量以及标准化后的蛋白信号。

### 1.7总述

| 名称               | 英文     | 测序技术                                                     | 格式 |
| ------------------ | -------- | ------------------------------------------------------------ | ---- |
| RNA测序数据        | RNA-seq  | 对**转录组**进行测序的高通量技术                             | gz   |
| MicroRNA()测序数据 | MicroRNA | 对MicroRNA测序(一种长度约20 nt的非编码小RNA分子)             |      |
| DNA测序数据        | DNA-seq  | 对DNA进行测序的高通量技术                                    |      |
| 单核苷酸多态性检测 | SNPs     | 检测单一核苷酸的改变所引起的序列多态性                       |      |
| DNA甲基化测序      |          | 精确评估单个 C 碱基的甲基化水平，构建精细全基因组DNA甲基化图谱 |      |
| 反向蛋白质阵列     | RPPA     | 一种高通量、高灵敏度、可重复的蛋白检测技术                   |      |

# R语言分析TCGA差异基因方法

TCGA下载的count文件，打开是这样的：

![image-20210604004024587](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210604004024.png)

[^]: 列是样品名称，格式举例：TCGA.BA.A4IF.01A.11R.A266.07，这里面包含分组信息，比如说这个样品是肿瘤样品还是正常组织。分组信息是在这个id的第14-15位，01-09是tumor，10-29是normal。比如第一个样品，是01A，说明这个样品是个肿瘤样品。

OK,知道了哪里是分组信息，就可以开始进行操作了。

##### （一）准备R包



```php
if(!require(stringr))install.packages('stringr')
if(!require(ggplotify))install.packages("ggplotify")
if(!require(patchwork))install.packages("patchwork")
if(!require(cowplot))install.packages("cowplot")
if(!require(DESeq2))BiocManager::install('DESeq2')
if(!require(edgeR))BiocManager::install('edgeR')
if(!require(limma))BiocManager::install('limma')
```

##### （二）载入数据

这里的数据是我上一篇文章下载好的count文件，不知道怎么下的请移步：[利用R包TCGAbiolinks进行各种数据下载](https://www.jianshu.com/p/3b4c07f7e5f3)



```csharp
#加载数据
> rm(list = ls())
> a= read.csv("TCGAbiolinks_HNSC_counts.csv")
> dim(a)
[1] 56512   547
#另外要关注一下，你的这个表达矩阵的第一列是样品还是基因名，如果第一列是基因名，要把第一列设置成为行名，不然只有的差异分析会出错
#将第一列换成行名
> row.names(a) <- a[, 1]
> a <- a[, -1]
```

NOTE：如果你没有check你的矩阵，导致了你的矩阵第一列是基因名，后面DESeq2运行会显示：“Error in DESeqDataSet(se, design = design, ignoreRank) : some values in assay are negative”这样的报错。

##### （三）将样品分组



```swift
> group_list <- ifelse(as.numeric(str_sub(colnames(a),14,15))<10,"tumor","normal")
> group_list <- factor(group_list,levels = c("normal","tumor"))
> table(group_list)
group_list
normal  tumor 
    44    502 
```

##### （四）差异分析

参考文章：[TCGA-6.（转录组）差异分析三大R包及其结果对比](https://www.jianshu.com/p/9aeaf8d2c2d5)

**DESeq2方法做差异分析**



```xml
> library(DESeq2)
> colData <- data.frame(row.names =colnames(a), 
                       condition=group_list) #condition是你的分组信息
> dds <- DESeqDataSetFromMatrix(
   countData = a,
   colData = colData,
   design = ~ condition)
> dds <- DESeq(dds)
estimating size factors
estimating dispersions
gene-wise dispersion estimates
mean-dispersion relationship
final dispersion estimates
fitting model and testing
-- replacing outliers and refitting for 3594 genes
-- DESeq argument 'minReplicatesForReplace' = 7 
-- original counts are preserved in counts(dds)
estimating dispersions
fitting model and testing

# 两两比较
> res <- results(dds, contrast = c("condition",rev(levels(group_list))))
> resOrdered <- res[order(res$pvalue),] # 按照P值排序
> DEG <- as.data.frame(resOrdered)
> head(DEG)
                 baseMean log2FoldChange     lfcSE      stat        pvalue          padj
ENSG00000231887  233.5976      -7.414328 0.3208937 -23.10525 4.100424e-118 1.594778e-113
ENSG00000107159 1962.6861       5.849713 0.2969441  19.69971  2.168630e-86  4.217225e-82
ENSG00000106351 1273.1916      -2.371015 0.1206022 -19.65980  4.765762e-86  6.178493e-82
ENSG00000070081 2922.2020      -2.145545 0.1094426 -19.60430  1.420977e-85  1.381652e-81
ENSG00000102547  434.7033      -2.210238 0.1154164 -19.15013  9.655057e-82  7.510283e-78
ENSG00000151882  882.7880      -4.178352 0.2216513 -18.85102  2.882343e-79  1.868383e-75
```

去除NA值:



```css
> DEG <- na.omit(DEG)
```

在DEG里添加一列名为change列，标记基因上调下调:



```bash
> logFC_cutoff <- with(DEG,mean(abs(log2FoldChange)) + 2*sd(abs(log2FoldChange)) )
> logFC_cutoff
[1] 2.610411
> DEG$change = as.factor(
+   ifelse(DEG$pvalue < 0.05 & abs(DEG$log2FoldChange) > logFC_cutoff,
+          ifelse(DEG$log2FoldChange > logFC_cutoff ,'UP','DOWN'),'NOT')
+ )
> head(DEG)
                 baseMean log2FoldChange     lfcSE      stat        pvalue          padj change
ENSG00000231887  233.5976      -7.414328 0.3208937 -23.10525 4.100424e-118 1.594778e-113   DOWN
ENSG00000107159 1962.6861       5.849713 0.2969441  19.69971  2.168630e-86  4.217225e-82     UP
ENSG00000106351 1273.1916      -2.371015 0.1206022 -19.65980  4.765762e-86  6.178493e-82    NOT
ENSG00000070081 2922.2020      -2.145545 0.1094426 -19.60430  1.420977e-85  1.381652e-81    NOT
ENSG00000102547  434.7033      -2.210238 0.1154164 -19.15013  9.655057e-82  7.510283e-78    NOT
ENSG00000151882  882.7880      -4.178352 0.2216513 -18.85102  2.882343e-79  1.868383e-75   DOWN
> View(DEG)
> DESeq2_DEG <- DEG
```

最后看一下用这个方法做差异分析，上调和下调的基因有多少：



```bash
> table(DEG$change)
 DOWN   NOT    UP 
  929 36955  1009
```

**edgeR方法做差异分析**



```xml
> library(edgeR)
> dge <- DGEList(counts=a,group=group_list)
> dge$samples$lib.size <- colSums(dge$counts)
> dge <- calcNormFactors(dge)
> design <- model.matrix(~0+group_list)
> rownames(design)<-colnames(dge)
> colnames(design)<-levels(group_list)
> dge <- estimateGLMCommonDisp(dge,design)
> dge <- estimateGLMTrendedDisp(dge, design)
> dge <- estimateGLMTagwiseDisp(dge, design)
> fit <- glmFit(dge, design)
> fit2 <- glmLRT(fit, contrast=c(-1,1)) 
> DEG2=topTags(fit2, n=nrow(a))
> DEG2=as.data.frame(DEG2)
> logFC_cutoff2 <- with(DEG2,mean(abs(logFC)) + 2*sd(abs(logFC)) )
> DEG2$change = as.factor(
+   ifelse(DEG2$PValue < 0.05 & abs(DEG2$logFC) > logFC_cutoff2,
+          ifelse(DEG2$logFC > logFC_cutoff2 ,'UP','DOWN'),'NOT')
+ )
> head(DEG2)
                     logFC     logCPM       LR        PValue           FDR change
ENSG00000170369  -9.842798  4.4837048 1227.908 5.248913e-269 2.966266e-264   DOWN
ENSG00000162877  -6.470581 -0.1480235 1215.091 3.203213e-266 9.050998e-262   DOWN
ENSG00000231887  -9.129113  4.9924958 1140.670 4.781111e-250 9.006338e-246   DOWN
ENSG00000131686  -9.939181  4.2888099 1135.359 6.822362e-249 9.638633e-245   DOWN
ENSG00000101441 -10.903794  5.4644612 1059.704 1.893018e-232 2.139565e-228   DOWN
ENSG00000160349 -10.982631  6.4426001 1030.047 5.287725e-226 4.980332e-222   DOWN
```

看一下用edgeR方法，上调和下调基因的数量：



```bash
> table(DEG2$change)
 DOWN   NOT    UP 
 1188 53914  1410 
> edgeR_DEG <- DEG2
```

**limma-voom方法做差异分析**



```xml
> library(limma)
> design <- model.matrix(~0+group_list)
> colnames(design)=levels(group_list)
> rownames(design)=colnames(a)
> dge <- DGEList(counts=a)
> dge <- calcNormFactors(dge)
> logCPM <- cpm(dge, log=TRUE, prior.count=3)
> v <- voom(dge,design, normalize="quantile")
> fit <- lmFit(v, design)
> constrasts = paste(rev(levels(group_list)),collapse = "-")
> cont.matrix <- makeContrasts(contrasts=constrasts,levels = design) 
> fit3=contrasts.fit(fit,cont.matrix)
> fit3=eBayes(fit3)
> DEG3 = topTable(fit3, coef=constrasts, n=Inf)
> DEG3 = na.omit(DEG3)
> logFC_cutoff3 <- with(DEG3,mean(abs(logFC)) + 2*sd(abs(logFC)) )
> DEG3$change = as.factor(
+   ifelse(DEG3$P.Value < 0.05 & abs(DEG3$logFC) > logFC_cutoff3,
+          ifelse(DEG3$logFC > logFC_cutoff3 ,'UP','DOWN'),'NOT')
+ )
> head(DEG3)
                    logFC   AveExpr         t       P.Value     adj.P.Val        B change
ENSG00000203740  3.394627 -3.404611  28.73533 3.090631e-111 1.746578e-106 243.1880     UP
ENSG00000096006 -8.588036 -1.083975 -27.14114 2.835110e-103  8.010887e-99 224.8165   DOWN
ENSG00000260976  3.045123 -3.341040  27.00751 1.329154e-102  2.503772e-98 223.4002     UP
ENSG00000181092 -7.489810 -4.776791 -24.73134  4.130357e-91  5.835368e-87 196.2190   DOWN
ENSG00000198478 -4.043231  3.231204 -24.35482  3.353473e-89  3.790229e-85 192.7091   DOWN
ENSG00000181355  4.163352 -2.440333  24.29635  6.639596e-89  6.253614e-85 191.7566     UP
> limma_voom_DEG <- DEG3
```



```bash
> table(DEG3$change)

 DOWN   NOT    UP 
 1593 53742  1177 
```

##### （五）保存三种方法得到的矩阵



```bash
> save(DESeq2_DEG,edgeR_DEG,limma_voom_DEG,group_list,file = "DEG.Rdata")
```

##### （六）热图

下面得到了三个方法得来了矩阵，就可以可视化了。教程里用的包draw_heatmap在我的R版本上安装不了，所以我用的是pheatmap画的热图。



```bash
#这一步是定义后面画的热图是三个矩阵里change那一列上调和下调的基因，不包括没变化的基因
> cg1 = rownames(DESeq2_DEG)[DESeq2_DEG$change !="NOT"]
> cg2 = rownames(edgeR_DEG)[edgeR_DEG$change !="NOT"]
> cg3 = rownames(limma_voom_DEG)[limma_voom_DEG$change !="NOT"]
```



```xml
> library(pheatmap)
> library(RColorBrewer)
#定义热图的颜色
> color<- colorRampPalette(c('#436eee','white','#EE0000'))(100) 
#下面画第一个DESeq2矩阵的热图
> mat=a[cg1,]
> n=t(scale(t(mat)))
> n[n>1]=1
> n[n< -1]= -1
> ac=data.frame(group=group_list)
> rownames(ac)=colnames(mat)
> ht1 <- pheatmap(n,show_rownames = F,show_colnames = F, 
         cluster_rows = F,cluster_cols = T,
         annotation_col = ac,color=color)

#下面画edgeR矩阵的热图
> mat2=a[cg2,]
> n2=t(scale(t(mat2)))
> n2[n2 > 1]=1
> n2[n2< -1]= -1
> ht2 <- pheatmap(n2,show_rownames = F,show_colnames = F, 
         cluster_rows = F,cluster_cols = T,
         annotation_col = ac,color=color)

#下面画limma矩阵的热图
> mat3=a[cg3,]
> n3=t(scale(t(mat3)))
> n3[n3 > 1]=1
> n3[n3< -1]= -1
> ht3 <- pheatmap(n3,show_rownames = F,show_colnames = F, 
         cluster_rows = F,cluster_cols = T,
         annotation_col = ac,color=color)
```

![img](https://upload-images.jianshu.io/upload_images/18922188-0c9a5a35ac1ad2e2.png?imageMogr2/auto-orient/strip|imageView2/2/w/772/format/webp)

DESeq2矩阵热图

![img](https://upload-images.jianshu.io/upload_images/18922188-215829c1d28527b4.png?imageMogr2/auto-orient/strip|imageView2/2/w/703/format/webp)

edgeR矩阵热图

![img](https://upload-images.jianshu.io/upload_images/18922188-6b7297638e9c4d04.png?imageMogr2/auto-orient/strip|imageView2/2/w/684/format/webp)

limma矩阵热图

##### （七）火山图



```dart
> library(EnhancedVolcano)
> library(airway)

> v1=EnhancedVolcano(DESeq2_DEG,
                lab = rownames(DESeq2_DEG),
                x = 'log2FoldChange',
                y = 'pvalue',
                xlim = c(-8, 8),
                title = 'DESeq2_DEG',
                pCutoff = 10e-17,
                FCcutoff = 2.5,
                transcriptPointSize = 1.0,
                transcriptLabSize = 3.0,
                col=c('black', 'blue', 'green', 'red1'),
                colAlpha = 1,
                legend=c('NS','Log2 fold-change','P value',
                         'P value & Log2 fold-change'),
                legendPosition = 'right',
                legendLabSize = 10,
                legendIconSize = 3.0,
)

> v2=EnhancedVolcano(edgeR_DEG,
                lab = rownames(edgeR_DEG),
                x = 'logFC',
                y = 'PValue',
                xlim = c(-8, 8),
                title = 'edgeR_DEG',
                pCutoff = 10e-17,
                FCcutoff = 2.5,
                transcriptPointSize = 1.0,
                transcriptLabSize = 3.0,
                col=c('black', 'blue', 'green', 'red1'),
                colAlpha = 1,
                legend=c('NS','LogFC','P value',
                         'P value & LogFC'),
                legendPosition = 'right',
                legendLabSize = 10,
                legendIconSize = 3.0,
)

> v3=EnhancedVolcano(limma_voom_DEG,
                lab = rownames(limma_voom_DEG),
                x = 'logFC',
                y = 'P.Value',
                xlim = c(-8, 8),
                title = 'limma_voom_DEG',
                pCutoff = 10e-17,
                FCcutoff = 2.5,
                transcriptPointSize = 1.0,
                transcriptLabSize = 3.0,
                col=c('black', 'blue', 'green', 'red1'),
                colAlpha = 1,
                legend=c('NS','LogFC','P value',
                         'P value & LogFC'),
                legendPosition = 'right',
                legendLabSize = 10,
                legendIconSize = 3.0,
)
```

把三个火山图组合起来：



```php
#multiplot function
> multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  require(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}
```



```undefined
> multiplot(v1,v2,v3,cols=3)
```

![img](https://upload-images.jianshu.io/upload_images/18922188-45e514687bac832e.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

##### （八）三个不同方法得到的矩阵的交集可视化

上面的可视化是用三个矩阵分别画出的热图和火山图，下面要把这三个矩阵里上调和下调的基因的交集提出来，然后再进行可视化：



```php
> UP=function(df){
  rownames(df)[df$change=="UP"]
}
> DOWN=function(df){
  rownames(df)[df$change=="DOWN"]
}

> up = intersect(intersect(UP(DESeq2_DEG),UP(edgeR_DEG)),UP(limma_voom_DEG))
> down = intersect(intersect(DOWN(DESeq2_DEG),DOWN(edgeR_DEG)),DOWN(limma_voom_DEG))

> mat_total=a[c(up,down),]
> n4=t(scale(t(mat_total)))
> n4[n4 >1]=1
> n4[n4< -1]= -1
> ac=data.frame(group=group_list)
> rownames(ac)=colnames(mat_total)
> ht_combine <- pheatmap(n4,show_rownames = F,show_colnames = F, 
                cluster_rows = F,cluster_cols = T,
                annotation_col = ac,color=color)
```

![img](https://upload-images.jianshu.io/upload_images/18922188-3adcec4af13bfafb.png?imageMogr2/auto-orient/strip|imageView2/2/w/692/format/webp)

三个矩阵的交集画韦恩图：



```php
#上调、下调基因分别画维恩图
> up.plot <- venn(list(UP(DESeq2_DEG),UP(edgeR_DEG),UP(limma_voom_DEG)))
> down.plot <- venn(list(DOWN(DESeq2_DEG),DOWN(edgeR_DEG),DOWN(limma_voom_DEG)))
```

![img](https://upload-images.jianshu.io/upload_images/18922188-491c608bd57709e4.png?imageMogr2/auto-orient/strip|imageView2/2/w/540/format/webp)

三个矩阵里上调基因的交集，一共533个

![img](https://upload-images.jianshu.io/upload_images/18922188-6f73f51b6e4663c1.png?imageMogr2/auto-orient/strip|imageView2/2/w/540/format/webp)

三个矩阵里下调基因的交集，一共630个