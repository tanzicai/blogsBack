---
layout: pages
title: edgeR基本使用手册
date: 2021-09-19 20:59:06
top_img: https://gitee.com/tanzicai/drawingbed/raw/master/img/v2facfe9fc0e26126d4de52d729c25edc0_1440w.jpg
cover: https://gitee.com/tanzicai/drawingbed/raw/master/img/v2facfe9fc0e26126d4de52d729c25edc0_1440w.jpg
categories: 医学统计
tags:
   - TCGA
   - 基因差异分析
   - edgeR
---

# edgeR准备工作

edgeR包是由The Walterand Eliza Hall Institute of Medical Research, WEHI(澳大利亚沃尔特和伊丽莎·霍尔医学研究所)，Yunshun Chen等开发的，用来对**有生物学重复**的RNAseq数据进行差异表达分析。统计分析的方法是基于负二项分布，多种检验方法：

+ 贝叶斯估计

+ GLM(广义线性模型)

- exact test（fisher exact test）
- QLT (Qusi-likehood test)

## 安装edgeR

- R版本在3.5以上，可以这样安装

```R
if (!requireNamespace("BiocManager", quietly = TRUE))    
    install.packages("BiocManager")
BiocManager::install("edgeR")
```

- R版本3.5 以下，需要这样安装

```R
source("http://bioconductor.org/biocLite.R"）
       biocLite('edgeR')
```

## edgeR文档

```R
browseVignettes("edgeR")
```

### edgeR数据要求

这里我将以edgeR包中的示例数据为例，逐一讲述edgeR的使用过程。为保证结果的可靠性，使用edgeR有一些前提条件：

![image-20210919122332531](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210919122332.png)

- **样本有生物学重复**

- **数据为RNAseq counts值**

+ **特别说明：RPKM，FPKM是不能用edgeR进行分析的**

# edgeR原理说明

根据实验设计的不同，edgeR给出了多种分析数据分析方法。比如：

- **单因素两水平分析**

单因素两水平的实验设计(Tumor vs Normal）,可以使用qCML进行dispersion评估（**edgeR分析中提出一个dispersion概念，通过这个变量评估样本中基因表达均值与方差变化的关系，一般人源RNAseq数据dispersion在0.4以下**），在R中使用estimateDisp()函数完成；采用exact test对分析结果进行检测，在R中使用exactTest()函数完成，差异基因的表达分析。

- **单因素多水平分析**

当分析的变量大于2个因素时（比如A药物，B药物和C药物），可以使用GLM模型对RNAseq数据进行分析。对于dispersion的评估，采用Cox-Reid profile adjust likellihood 方法，检测CR methond。但同时需要提供一个design矩阵，在R中使用estimateDisp(y,design)函数完成；对于不同组的差异表达分析，作者推荐使用QL quasi-likelihood F-test检验，在R中可以通过glmQLFit()，以及glmQLFit()完成分析。

# edgeR使用步骤

## **读入示例数据**

```R
#读入数据
rawdata <- read.table("edgeR02_TableS1.txt",                      
					stringsAsFactors = FALSE,                        
					header = T)
head(rawdata)
```

![图片](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210919122820.webp)

## 数据预处理

### DEGlist对象

```R
library(edgeR)
y<-DGEList(counts = rawdata[,2:7],genes = rawdata[,1])
# 读入数据
y
```



注意：

**counts：不包含基因名的所有样本**

**genes：基因名的一列数据**

![image-20210919124249757](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210919124249.png)

edgeR中，对数据进行normalization，需要获取样本的library size以及normalization factor。

```R
dim(y$counts)
[1] 1881 1033
```

本次示例使用了1881个genes（基因），1033samples（样本）

### 数据的预处理（genes过滤）

因为表达矩阵中有重复基因，这里先对表达矩阵进行过滤，剔除重复基因（如果基因名称有重复，选择表达水平最高的那个转录本）

```R
o <- order(rowSums(y$counts), decreasing=TRUE)
y <- y[o,]
d <- duplicated(y$genes$genes)
y <- y[!d,]
nrow(y)
1881
```

剔除重复基因后，基因数目为1881个，所以本示例没有重复基因

### 数据的预处理（normalization）

计算library sizes，采用colSums重新计算，每个样本的library sizes.

```R
y$samples$lib.size <- colSums(y$counts)
```

计算1033组样本的normalization factor

```R
#重命名基因表达矩阵的行名
rownames(y$counts)=y$genes$genes
y<-calcNormFactors(y)
y$samples
```

norm.factors以及发生变化，不再是之前default值。

![image-20210919125222835](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210919125222.png)

### 数据的预处理（聚类结果）

以上对genes进行过滤，library size等进行了计算。接下来看下1033组样本是否有outlier 样本，可以使用PCA分析，这里使用edgeR自带的plotMDS函数，观察样本之间的聚类结果。

![PCA分析](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210919125659.png)

在图中，横轴可以区分tumor（癌症）和normal（正常组织），在纵轴上反应的是不同样本的数据。



# 数据处理

表达数据进行了预处理，下面开始构建design matrix。design matrix在DESeq2数据分析中也会用到，limma中也有类似处理。主要目的是为了对样本进行分组，然后才可以进行差异表达分析。

## 样本分组

查看表达矩阵中的样本

```R
colnames(y)
"X8N"  "X8T"  "X33N" "X33T" "X51N" "X51T"
```

一共有1033个样本，患者的tumor组织和normal组织。为了进行tumor vs normal的比较，需要这样来构建我们的design matix

```R

# 根据TCGA匹配level
group_list <- ifelse(as.numeric(substr(colnames(DATA),14,15))<10,"tumor","normal")
Samples <- factor(group_list,levels = c("normal","tumor"))

#构建design matrix
design=model.matrix(~Samples)

# 将样本与分组对应
rownames(design)=colnames(y)

#查看design
design
```

```R
design
                  (Intercept) Samplestumor
TCGA.SX.A7SN.01             1            1
TCGA.BQ.7061.11             1            0
TCGA.B0.5706.01             1            1
TCGA.A4.8517.01             1            1
TCGA.BP.4993.01             1            1
TCGA.AK.3461.01             1            1
TCGA.P4.A5E6.01             1            1
TCGA.A3.3378.01             1            1
TCGA.B0.4844.01             1            1
TCGA.BP.4763.01             1            1
TCGA.BP.4766.01             1            1
TCGA.CJ.4875.01             1            1
TCGA.BP.4971.01             1            1
TCGA.UZ.A9Q0.01             1            1
TCGA.Y8.A8RZ.01             1            1
TCGA.A3.3370.01             1            1
TCGA.A3.3346.01             1            1
TCGA.CZ.4865.01             1            1
TCGA.B0.5117.01             1            1
```



##  **Dispersion 计算**

在edgeR中，可以通过estimateDisp函数，对BCV（biological CV）进行可视化

**注意：estimateDisp()函数需要statmod包的支持，故在使用前记得先安装。**

```R
y1=estimateDisp(y,design,robust = T)
y1$common.dispersion
0.2139524
```

对结果进行可视化

```R
plotBCV(y1)
```

X轴为logCPM，y轴为variation，一般情况下，CPM值越高，variation越大。此外，当dispersion结果小于0.4时，认为数据可以使用基于负二项分布的统计检验分析方法，继续进行后续的差异分析。

> 左边为此示例BCV，右边为正常BCV

<img src="https://gitee.com/tanzicai/drawingbed/raw/master/img/20210919150859.png" alt="图片" style="zoom:67%;" /><img src="https://gitee.com/tanzicai/drawingbed/raw/master/img/20210919150912.webp" alt="图片" style="zoom: 50%;" />

## **差异表达分析**

在获得design matrix之后，我们就可以对表达矩阵进行差异表达分析.

```R
# GLM 拟合
fit<-glmFit(y1,design)

# 差异表达分析
et1=glmLRT(fit)

#查看前10组分析结果
topTags(et1)
```

```R
Coefficient:  Samplestumor 
                        genes     logFC     logCPM       LR        PValue           FDR
hsa-mir-508       hsa-mir-508 -3.246555  5.4039078 545.7512 1.057488e-120 1.989134e-117
hsa-mir-514a-1 hsa-mir-514a-1 -3.333287  3.5751599 541.8816 7.346884e-120 6.909744e-117
hsa-mir-514a-3 hsa-mir-514a-3 -3.337819  3.5733264 537.8194 5.620981e-119 3.524355e-116
hsa-mir-514a-2 hsa-mir-514a-2 -3.337954  3.5743685 530.2891 2.443780e-117 1.149187e-114
hsa-mir-106b     hsa-mir-106b  1.212604  8.2811253 469.2774 4.602722e-104 1.731544e-101
hsa-mir-506       hsa-mir-506 -4.227681  0.6067688 435.8532  8.648781e-97  2.711393e-94
hsa-mir-21         hsa-mir-21  2.616714 17.8219772 405.9373  2.808590e-90  7.547082e-88
hsa-mir-514b     hsa-mir-514b -4.830921  0.1271017 373.3704  3.454373e-83  8.122095e-81
hsa-mir-25         hsa-mir-25  1.074493 12.1895476 363.0142  6.212368e-81  1.298385e-78
hsa-mir-15a       hsa-mir-15a  1.059164  7.0132793 341.7897  2.600857e-76  4.892213e-74
```

## **Classic Analysis method**

edgeR中，这种单因素两水平的分析，还可以使用一种称之为classic analysis的分析方法进行分析。分析起来比较简单，一个R函数就可以搞定

```R
y1$samples$group=Samples
et=exactTest(y1)
topTags(et)
```

```R
Comparison of groups:  tumor-normal 
                        genes     logFC     logCPM        PValue           FDR
hsa-mir-508       hsa-mir-508 -3.246555  5.4039078 6.096154e-121 1.146687e-117
hsa-mir-514a-1 hsa-mir-514a-1 -3.333287  3.5751599 2.556674e-120 2.404552e-117
hsa-mir-514a-3 hsa-mir-514a-3 -3.337819  3.5733264 1.850444e-119 1.160229e-116
hsa-mir-514a-2 hsa-mir-514a-2 -3.337954  3.5743685 9.160521e-118 4.307735e-115
hsa-mir-106b     hsa-mir-106b  1.212604  8.2811253 3.072568e-104 1.155900e-101
hsa-mir-506       hsa-mir-506 -4.227681  0.6067688 4.093007e-100  1.283158e-97
hsa-mir-21         hsa-mir-21  2.616714 17.8219772  4.379912e-90  1.176945e-87
hsa-mir-514b     hsa-mir-514b -4.830921  0.1271017  1.242906e-85  2.922382e-83
hsa-mir-25         hsa-mir-25  1.074493 12.1895476  7.347694e-81  1.535668e-78
hsa-mir-15a       hsa-mir-15a  1.059164  7.0132793  1.330343e-76  2.502376e-74
```

这个是exactTest分析结果。可以看出和之前的分析结果几乎无差异。随便你选哪种分析方法，对于这种单因素两水平的数据。

# 差异结果可视化及富集分析

##  **查看分析结果**

Top10 genes，根据pvalue值，选择差异最为显著的genes，查看其normalization结果

```R
o <- order(et$table$PValue)
cpm(y)[o[1:10],]
```

```R
TCGA.SX.A7SN.01 TCGA.BQ.7061.11 TCGA.B0.5706.01 TCGA.A4.8517.01 TCGA.BP.4993.01 TCGA.AK.3461.01 TCGA.P4.A5E6.01 TCGA.A3.3378.01
               TCGA.B0.4844.01 TCGA.BP.4763.01 TCGA.BP.4766.01 TCGA.CJ.4875.01 TCGA.BP.4971.01 TCGA.UZ.A9Q0.01 TCGA.Y8.A8RZ.01 TCGA.A3.3370.01
       TCGA.A3.3346.01 TCGA.CZ.4865.01 TCGA.B0.5117.01 TCGA.CJ.4634.01 TCGA.B0.5098.01 TCGA.5P.A9JV.01 TCGA.B0.5099.01 TCGA.B4.5838.01
               TCGA.BP.4353.01 TCGA.BP.5178.01 TCGA.A3.3383.01 TCGA.UZ.A9PN.01 TCGA.BQ.7062.01 TCGA.A3.3319.01 TCGA.F9.A8NY.01 TCGA.B8.5550.01
               TCGA.B0.5084.01 TCGA.CZ.5463.01 TCGA.BQ.5887.01 TCGA.BQ.5894.11 TCGA.BP.4161.01 TCGA.BP.4982.01 TCGA.B0.5075.01 TCGA.Y8.A897.01
               TCGA.CJ.4894.01 TCGA.BP.5190.01 TCGA.DZ.6132.11 TCGA.A4.8518.01 TCGA.BP.4326.01 TCGA.B0.5095.01 TCGA.B8.5552.01 TCGA.B0.5690.11
               TCGA.2Z.A9JT.01 TCGA.KL.8335.01 TCGA.B4.5843.01 TCGA.B0.5701.01 TCGA.CW.5589.11 TCGA.BP.4768.01 TCGA.MM.A564.01 TCGA.CZ.5986.01
               TCGA.A4.A6HP.01 TCGA.BP.5174.01 TCGA.B8.5164.01 TCGA.CJ.6027.01 TCGA.AK.3451.01 TCGA.B8.5552.11 TCGA.BQ.5892.01 TCGA.AK.3444.01
               TCGA.B0.4697.01 TCGA.BP.4337.01 TCGA.BQ.7053.01 TCGA.AK.3465.01 TCGA.CW.5590.01 TCGA.CJ.5681.01 TCGA.CJ.6032.01 TCGA.A3.3313.01
               TCGA.CJ.4892.01 TCGA.B0.4852.01 TCGA.B2.5639.01 TCGA.B0.5693.01 TCGA.B0.4836.01 TCGA.DV.A4VZ.01 TCGA.B2.3923.01 TCGA.HE.A5NJ.01
               TCGA.IZ.A6M9.01 TCGA.KN.8432.01 TCGA.BP.5187.01 TCGA.B0.5709.01 TCGA.HE.7128.01 TCGA.B0.4688.01 TCGA.CJ.5678.01 TCGA.B0.5080.01
               TCGA.5P.A9K6.01 TCGA.Y8.A896.01 TCGA.CW.5581.01 TCGA.B0.4822.01 TCGA.A3.3320.01 TCGA.A3.3307.01 TCGA.B0.4818.01 TCGA.CJ.4637.01
               TCGA.CJ.4635.01 TCGA.B8.5549.01 TCGA.KN.8427.01 TCGA.5P.A9KH.01 TCGA.B0.5108.01 TCGA.KM.8639.01 TCGA.B8.A54H.01 TCGA.B0.4700.01
               TCGA.CJ.5686.01 TCGA.CZ.4861.01 TCGA.A4.7286.01 TCGA.UZ.A9PS.01 TCGA.B2.5635.01 TCGA.B8.A54F.01 TCGA.A4.8310.01 TCGA.BQ.7060.01
               TCGA.B8.5549.11 TCGA.B8.5163.01 TCGA.BQ.5885.01 TCGA.SX.A7SP.01 TCGA.B0.4706.01 TCGA.5P.A9JY.01 TCGA.KO.8411.01 TCGA.KO.8406.01
```

那么有多少个显著上调或下调的genes呢？

```R
summary(decideTests(et,p.value = 0.05))
```

```R
       tumor-normal
Down            209
NotSig         1175
Up              497
```

## **差异基因可视化**

采用火山图对差异表达基因进行可视化

```
plotMD(et)
abline(h=c(-1, 1), col="blue")
```

![volcano](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210919152422.png)

## **富集分析**

首先还要对geneSymbol进行转换

```R
library(org.Hs.eg.db)
#We add Entrez Gene IDs to the annotation
egREFSEQ <- toTable(org.Hs.egSYMBOL)
m<-match(et$genes$genes,egREFSEQ$symbol)
entrez_id=egREFSEQ$gene_id[m]
```

然后利用edgeR自带的包进行富集分析

```R
go <- goana(et,geneid = entrez_id,FDR=0.05)
topGO(go, ont="BP",n=20, truncate=30,sort ="Up")
```

前20个富集分析结果，可以改变ont参数，获取其他term的富集分析结果。还差了个可视化的效果，就留个你们了，可以尝试使用之前的代码对该部分结果进行可视化。

# 去批次化影响

在我们进行数据分析时，除了可控制的变量外，比如我们关注的处理条件（treated vs no-treated）；有时可能会不可避免地引入**额外变量**，比如不同批次处理实验样本。为了尽量得出可靠结论，我们需要对数据进行去批次化影响的处理。

现在介绍这么一组数据：由于某种原因，每次只能处理两个实验样本，分别是mock组合（control组）、hrcc组（experimental组）。一共做了3个生物学重复，bathch01：处理mock1和hrcc1样本；bathc02：处理mock2和hrcc2样本；batch03：处理mock3和hrcc3样本。

![图片](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210919160426.webp)

## **加载数据**

同样地，首先要加载示例数据。数据可以在粉丝群获取

```
#加载数据arab=readRDS("arab.rds")
head(arab)
```

![图片](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210919160511.webp)

```R
dim(arab)
26222     6
```

一共6个samples 26222个genes

## **获取分组信息**

从样本名上，提取factor信息。实验条件中有2个factors，一个是我们实验关注的处理因素treatment；另外一个是batch effect。

```
Treat <- factor(substring(colnames(arab),1,4))
#重新设置factor的levles，对照组为mock
Treat <- relevel(Treat, ref="mock")
Time <- factor(substring(colnames(arab),5,5))
```

## **构建DGElist对象**

在进行差异分析之前，都要将表达矩阵构建为DGElist对象。在R中很简单，使用DGElist函数即可

```
y <- DGEList(counts=arab, group=Treat)
y$samples
```

## **数据预处理**

### 数据过滤

对在所有样本中表达量为0的genes，从表达矩阵中去除

```R
keep <- filterByExpr(y)
table(keep)

keep
FALSE  TRUE 
12292 13930
#一共剔除12292个genes
y <- y[keep, , keep.lib.sizes=FALSE]
y$samples
```

### 数据normalization

以上对genes进行过滤，以及library size介绍，在进行normalization之前，还需要计算每个样本的normalization factor。

同样地，在R中可以这样操作

```
y <- calcNormFactors(y)
y$samples
```

### 样本间分析

以上主要是对不同样本中genes表达的预处理。同样地，可以观察下不同样本之间genes表达的关系，观察样本之间的聚类结果。

```R
plotMDS(y,col=rep(c('red','blue'), each=3))
```

![图片](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210919160859.webp)

从dim2上来看，实验组和对照组基本上可以分开；从dim1上看，mock2受到batch effect影响，不能与实验组很好的分开。