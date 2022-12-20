---
title: pheatmap 相关性热图 基因表达量热图
date: 2021-05-07 09:25:00
author: 谭自财
summary: TCGA 的差异基因分析的一些介绍
categories: 医学统计
tags:
  - TCGA
  - RNA-Seq
---

> 作者：APExBIO
> 链接：https://www.jianshu.com/p/9a5f8eef02fb
> 来源：简书
> 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

# 热图

热图概念：热图是一个以颜色变化来显示数据的矩阵，可以简单地聚合大量数据，并使用一种渐进的色带直观地展现空间数据的相对大小。

热图在生物学中的应用：生物学中热图经常用于展示多个基因在不同样本中的表达水平。然后可以通过聚类等方式查看不同组（如疾病组和对照组）特有的形式。热图还可以用于展示其他物质的丰度比如微生物的相对丰度、代谢组不同物质的含量等等。当然，另一个热图的重要用处就是展现不同指标、不同样本等之间的相关性。

## 数据准备

1. 多个样本genes/transcripts read counts 文件

2. 多个样本genes/transcripts FPKM/TPM 文件
    如果得到单个样本all genes read counts, 需要先合并：
    数据格式如下：

   ![image-20210517133650091](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210517133650.png)

   image.png



```r
##相关性热图，使用数据gene_fpkm.csv
setwd("C:/Users/Desktop/Transcriptome/data/GSE101668_RAW")
fpkm<-read.csv("GSE101668_fpkm.csv",head=T,row.names=1)
head(fpkm)[,1:6]

#         GSM2711785 GSM2711786 GSM2711787 GSM2711788 GSM2711789 GSM2711790
#A1BG     0.09811600 0.05790660 0.05222180  0.0637481 0.04535840  0.0950140
#A1BG-AS1 0.27003800 0.23612600 0.31530100  0.2080520 0.24668500  0.2326070
#A1CF     0.02785390 0.02190900 0.00000000  0.0180425 0.04533540  0.0280336
#A2M      0.00438851 0.00000000 0.00000000  0.0000000 0.00000000  0.0000000
#A2M-AS1  0.07776420 0.10491300 0.12424300  0.1718890 0.07193070  0.1381680
#A2ML1    0.00000000 0.00366506 0.00463368  0.0000000 0.00670476  0.0000000
##求相关性
sample_cor<-cor(fpkm)
head(sample_cor)
 #          GSM2711785 GSM2711786 GSM2711787 GSM2711788 GSM2711789 GSM2711790
#GSM2711785  1.0000000  0.9981079  0.9856211  0.9964200  0.9539448  0.9555485
#GSM2711786  0.9981079  1.0000000  0.9855960  0.9965623  0.9541515  0.9556389
#GSM2711787  0.9856211  0.9855960  1.0000000  0.9886970  0.9414432  0.9429842
#GSM2711788  0.9964200  0.9965623  0.9886970  1.0000000  0.9520301  0.9537503
#GSM2711789  0.9539448  0.9541515  0.9414432  0.9520301  1.0000000  0.9992366
#GSM2711790  0.9555485  0.9556389  0.9429842  0.9537503  0.9992366  1.0000000
```

![image-20210517133803226](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210517133803.png)

cor.fpkm1.png

pheatmap画图



```r
#调整参数，换颜色
library(pheatmap)
library(ggplot2)
p1<-pheatmap(sample_cor,cluster_rows = F,
         scale="none",
         cluster_cols = F,
         fontsize_row = 10,
         fontsize_col = 10,
         color = colorRampPalette(c("navy", "white", "firebrick3"))(100),
         #color = colorRampPalette(c("green3", "white", "blue4"))(100),#换颜色
         angle_col = 45, #修改横轴坐标名倾斜度
         filename = 'cor.fpkm2.png',
)
```

![image-20210517133825930](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210517133826.png)

cor.fpkm2.png

基因fpkm表达量热图

1. 基因fpkm表达量准备



```r
#过滤标准:保留基因在大于floor(ncol(exprSet)/10)个样本中表达量大于1
fpkm_filter=fpkm[apply(fpkm,1,function(x) sum(x>1) > floor(ncol(fpkm)/10)),]
dim(fpkm)
dim(fpkm_filter)
> dim(fpkm)
[1] 26228    12
> dim(fpkm_filter)
[1] 11670    12
#用log2(fpkm_filter+1)标准化
data=log2(fpkm_filter+1)
#选取每个基因表达量的变异系数最大的1000个
genes=names(head(sort(apply(data,1,function(x) 100*sd(x)/mean(x)),decreasing=T),1000))#apply按行（'1'是按行取，'2'是按列取）取每一行的方差，从小到大排序，取最大的1000个
dat=t(scale(t(data[genes,]))) # 'scale'可以对log(fpkm+1)数值进行归一化
#处理数据
dat[dat>2]=2 
dat[dat<-2]= -2
```

1. 样本分组信息准备



```r
df_info=data.frame(read.table("samplename.txt"),stringsAsFactors = F)                                          
head(df_info)
 #           CellType GroupList
#GSM2711785        WT        WT
#GSM2711786        WT        WT
#GSM2711787 PRDM1-KO2        KO
#GSM2711788 PRDM1-KO2        KO
#GSM2711789 PRDM1-KO5        KO
#GSM2711790 PRDM1-KO5        KO

df1 = df_info[,-1,drop=FALSE]
head(df1)
# GroupList
#GSM2711785        WT
#GSM2711786        WT
#GSM2711787        KO
#GSM2711788        KO
#GSM2711789        KO
#GSM2711790        KO
```

情况1：一类分组：KO,OE,WT



```r
#####分组KO,OE,WT
p2<-pheatmap(
  mat=dat,
  cluster_rows = T,
  cluster_columns = F,
  border_color      = NA,
  show_colnames     = FALSE,
  show_rownames     = FALSE,
  fontsize          = 14,
  annotation_col    = df1,
  drop_levels       = TRUE,
  main              = "Default Heatmap1",   
  filename = 'heatmap_top1000_1.png'
)
```

![image-20210517133848490](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210517133848.png)

heatmap_top1000_1.png



```r
#如果要调色
library(RColorBrewer)
library(viridis)
mat_colors <- list(GroupList = brewer.pal(3, "Set1"))
names(mat_colors$GroupList) <- unique(df1[,1])
p3<-pheatmap(
  mat=dat,
  cluster_rows = T,
  cluster_columns = F,
  border_color      = NA,
  show_colnames     = FALSE,
  show_rownames     = FALSE,
  fontsize          = 14,
  annotation_col    = df1,
  annotation_colors = mat_colors,
  drop_levels       = TRUE,
  main              = "Default Heatmap2",   
  color = colorRampPalette(c("navy", "white", "firebrick3"))(100),
  #filename = 'heatmap_top1000_2.png'
)
```

情况2：两类分组



```r
#两类分组1.Celltype；2. GroupList
p4<-pheatmap(
  mat=dat,
  cluster_rows = T,
  cluster_columns = F,
  border_color      = NA,
  show_colnames     = FALSE,
  show_rownames     = FALSE,
  fontsize          = 14,
  annotation_col    = df_info,
  drop_levels       = TRUE,
  main              = "Default Heatmap",
  filename = 'heatmap_top1000_rtg.png'
)
```

两类分组自定义颜色



```php
#两组分类CellType/GroupList，自己设定颜色
mat_colors <- list(CellType = brewer.pal(6, "Set1"),GroupList = brewer.pal(3, "Set1"))
names(mat_colors$CellType) <- unique(df_info[,1])
names(mat_colors$GroupList) <- unique(df_info[,2])

p5<-pheatmap(
  mat=dat,
  cluster_rows = T,
  cluster_columns = F,
  border_color      = NA,
  show_colnames     = FALSE,
  show_rownames     = FALSE,
  fontsize          = 14,
  annotation_col    = df_info,
  annotation_colors = mat_colors,
  drop_levels       = TRUE,
  main              = "Default Heatmap",
  color = colorRampPalette(c("navy", "white", "firebrick3"))(100),  ##调颜色
  #color             = inferno(10),
  #color             = rainbow(10),
  filename = "heatmap_top1000_tg.png"
)
```

![image-20210517133919683](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210517133920.png)

heatmap_top1000_tg.png

鲜艳的热图就这样完成啦！



