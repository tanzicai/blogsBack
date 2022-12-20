---
title: 基于TCGA数据库筛选与胃癌预后相关的差异基因
date: 2021-05-07 09:25:00
author: 谭自财
summary: TCGA 的差异基因分析的一些介绍
categories: 医学统计
tags:
  - TCGA
  - RNA-Seq
  - 肾癌
---

# 基于TCGA数据库筛选与胃癌预后相关的差异基因

[田如月](javascript:;) [郭水龙](javascript:;) [曹邦伟](javascript:;)

> 首都医科大学附属北京友谊医院肿瘤中心 首都医科大学附属北京友谊医院消化内科国家消化系统疾病临床医学研究中心首都医科大学消化病学系

**摘  要：**

**目的**: 通过对癌症基因组图谱(TCGA)数据库中胃腺癌转录组数据进行分析，找出预后相关的差异表达基因。

**方法** :从TCGA数据库中下载胃腺癌的转录组数据，利用R语言edgeR包筛选出差异基因后，对差异基因进行生存分析。

**结果** :

1. 共得到175个差异表达miRNA及201个差异表达mRNA/lncRNA
2. 进一部进行生存分析，以P <0. 05作为统计筛选标准，得到15个miRNA和9个mRNA、8个lncRNA与胃癌的生存时间相关。

**结论 ** :
通过对TCGA数据库中胃腺癌的表达数据进行分析研究，选出与该病预后密切相关的基因，为该病的早期诊断和靶向治疗提供分子层面的参考信息。

**关键词：**

胃癌、生物、标志物;

---

Screen differential genes related to prognosis of gastric cancer based on TCGA database

TIAN Ru-yue GUO Shui-long CAO Bang-wei

Oncology Center,Beijing Friendship Hospital,Capital Medical University Department of Gastroenterology,Beijing Friendship Hospital,Capital Medical University,National Clinical Research Center for Digestive Disease,Beijing Digestive Disease Center,Beijing Key Laboratory for Precancerous Lesion of Digestive Disease

**Abstract：**

Objective To analyze the differentially expressed genes related to prognosis by analyzing the transcriptome data of gastric adenocarcinoma in The Cancer Genome Atlas( TCGA) database. Methods The transcriptome data of gastric adenocarcinoma were downloaded from the TCGA database. After using the edgeR package based on the R language to screen out the differential genes,and analyze the differential genes for predicting survival. Results A total of 175 differentially expressed miRNAs and 201 differentially expressed mRNA/lncRNA were obtained after the survival analysis. For survival analysis,P < 0. 05 was used as the statistical screening standard. 15 miRNA,9 miRNA,and 8 lncRNA were associated with the survival time of gastric cancer. Conclusion By analyzing the expression data of gastric adenocarcinoma in TCGA database,the genes had significant influence on the prognosis of gastric cancer patients,and may provide molecular information for early diagnosis and targeted therapy.

---

胃癌是最常见的消化道肿瘤之一，其发病率在所有恶性肿瘤中排第5位，致死率排第3位。根据国际癌症研究机构统计的数据，2018年胃癌的新发诊断人数及致死人数相较于2012年均有所增加。2012年统计新发胃癌患者95万，因胃癌死亡者72万[[1](javascript:void(0);)]，而2018年新发病例及致死病例分别为103万和78万[[2](javascript:void(0);)]。尽管目前临床对于胃癌的诊治技术不断提高，但仍缺乏早期、可靠且有效的诊断及预后标志物。

随着现代医学的进展，癌症诊治在基因组学方面有着重大进展，从而使胃癌的诊治进入精准化、个体化阶段，目前已有针对胃癌主要分子信号通路ErbB受体家族，例如人表皮生长因子受体2(human epidermal growth factor receptor-2,HER2)和表皮生长因子受体(epidermal growth factor receptor,EGFR)以及针对血管内皮生长因子(vascular endothelial growth factor receptor,VEGF)家族的靶向药物:曲妥珠单抗、西妥昔单抗、贝伐单抗等[[3](javascript:void(0);)]。通过生物信息学对基因组学大数据库进行分析，可筛选出与胃癌发生、发展及预后相关的分子标志物，在分子水平上为精准医学提供可靠靶点。本研究通过对癌症基因组图谱(The Cancer Genome Atlas,TCGA)数据库，来筛选胃腺癌预后相关的差异表达基因，以期为胃腺癌的诊断和治疗提供分子依据。

### 1 材料与方法

#### 1.1 数据来源

本研究于2019年7月3日于北京从TCGA数据库下载并整理胃腺癌转录组的miRNA及mRNA/lncRNA表达谱数据及临床数据。

其中mRNA表达芯片数据的样本:共407例，包括375例胃癌样本及32例癌旁样本;

mRNA/lncRNA表达芯片数据样本:共491例，其中胃癌标本446例，癌旁标本45例。

#### 1.2 胃腺癌mRNA / lncRNA 及 miRNA 差异表达分析

利用R语言edgeR包对癌旁和癌组织的miRNA及基因进行表达差异对比分析，由于miRNA检测数目较少，其筛选阈值设置为:
$$
差异倍数 Log2FC(fold change,FC)>1.5 且P<0.01
$$

$$
mRNA/lncRNA的筛选阈值为:Log2FC>5且P<0.01
$$

并将表达数据进行标准化处理。分别使用R语言**heatmap.2**包和**plot**包进行热图和火山图的绘制。

#### 1.3 差异表达miRNA和mRNA/lncRNA的生存分析

从临床数据中提取生存信息，包括生存状态和总体生存时间，并与表达谱进行整合匹配。利用R语言Survival包、survminer包及parallel包，以P<0.05作为筛选标准，对所得到的差异基因进行生存分析，分析其与胃癌患者预后的相关性。

### 2 结果

#### 2.1 差异表达的miRNA 与 mRNA/lncRNA

对TCGA胃腺癌数据库进行分析后，
$$
以Log2FC>1.5且P<0.01为标准
$$
对共491例miRNA芯片数据样本进行分析，共筛选出175个差异表达miRNA，上调的基因127个、下调基因48个。


$$
以Log2FC>5且P<0.01为标准
$$
对407例mRNA/lncRNA芯片数据的样本进行分析，共筛选出201个差异表达mRNA/lncRNA，其中表达上调基因127个、下调基因48个。



使用R语言heatmap.2包和plot包对差异表达的基因进行热图和火山图的绘制(图1、2)。

> 热图概念：热图是一个以颜色变化来显示数据的矩阵，可以简单地聚合大量数据，并使用一种渐进的色带直观地展现空间数据的相对大小。

> 热图在生物学中的应用：生物学中热图经常用于展示多个基因在不同样本中的表达水平。然后可以通过聚类等方式查看不同组（如疾病组和对照组）特有的形式。热图还可以用于展示其他物质的丰度比如微生物的相对丰度、代谢组不同物质的含量等等。当然，另一个热图的重要用处就是展现不同指标、不同样本等之间的相关性。

![SYLC202005001_01300](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210517134218.jpg)

[^图1]: 胃腺癌差异基因热图 注:A:差异表达miRNA热图;B:差异表达mRNA和lncRNA热图;红色:高表达差异基因，蓝色:低表达差异基因，白色:无差异表达基因

![SYLC202005001_01400](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210517134227.jpg)


[^图2]: 胃腺癌差异基因的火山图 注:A:差异表达miRNA火山 图;B:差异表达mRNA和lncRNA火山图;红点表示上调差异基因，绿点表示下调差异基因，黑点表示无差异基因



#### 2.2 生存分析

为筛选与胃癌预后相关的标记物，对175个差异表达miRNA及201个差异表达mRNA/lncRNA进行生存分析，以$$P<0.05$$作为统计筛选标准，得到15个miRNA和9个mRNA,8个lncRNA与胃癌的生存时间相关(表1～3)。按与胃癌预后的相关性P值从小到大排序，选取$$P<0.01$$的差异基因绘制生存曲线(图3～5)。

![SYLC202005001_01700](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210517134327.jpg)


[^图3]: 胃癌生存相关的3个miRNA(P<0.01)的生存曲线 


![SYLC202005001_01800](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210517134346.jpg)

[^图4]: 胃癌生存相关的2个mRNA(P<0.01)的生存曲线


![SYLC202005001_01900](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210517134359.jpg)

[^图5]: 胃癌生存相关的4个lncRNA(P<0.01)的生存曲线

---



[^表1]: 生存分析后筛选的差异miRNA

![SYLC202005001_02000](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210517134412.jpg)

[^表2]: 生存分析后筛选的差异mRNA

![SYLC202005001_02100](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210517134531.jpeg)



[^表3]: ** 生存分析后筛选的差异lncRNA**

![SYLC202005001_02200](https://gitee.com/tanzicai/drawingbed/raw/master/img/20210517134444.jpeg)

---



### 3 讨论

尽管胃癌的患病率在发达国家呈下降趋势，但它仍然是世界许多地区的最常见疾病，其中在东亚、东欧和南美洲地区的发病率最高，而全球有42%的病例报告发生在中国[[2](javascript:void(0);)]。在癌症研究领域，TCGA是一个功能强大且组织良好的分子数据类型的存储库，其数据集是癌症领域最大和最常用的公共资源，提供数千个肿瘤样本的体细胞突变、基因表达、基因甲基化和拷贝数变异等数据集[[4](javascript:void(0);)]。利用TCGA数据库筛选影响胃癌发生、发展的有效生物标志物，可为胃癌的治疗及预后提供新的思路和机遇。

越来越多的研究证明lncRNA可与miRNA相互作用，作为潜在的癌基因或抑癌基因，通过改变其靶向mRNA的水平或翻译来改变细胞周期进程、迁移和侵袭。因此lncRNA、miRNA和mRNA共同参与癌症信号通路调节，其异常表达与肿瘤发生、进展和对治疗的反应相关，表明它们可用作诊断、预后和预测性生物标志物[[5](javascript:void(0);),[6](javascript:void(0);),[7](javascript:void(0);),[8](javascript:void(0);)]。本研究对TCGA数据库中胃腺癌miRNA和mRNA/LncRNA芯片表达谱进行分析，初步筛选出差异表达基因(包括175个差异表达miRNA及201个差异表达mRNA/LncRNA)后，进一步分析得出15个miRNA和17个mRNA/LncRNA(其中mRNA 9个，lncRNA 8个)与胃癌的生存时间相关(P<0.05)。

在15个与胃癌的生存相关的miRNA中，其中P<0.01的miRNA有3个。其中miR-183在胃癌组织中表达升高，与相关文献报道[[9](javascript:void(0);)]一致，miR183可促进胃癌细胞的增殖和侵袭，但仍有其他研究表明miR183可抑制胃癌细胞的侵袭[[10](javascript:void(0);)]，因此miR183在胃癌中的具体作用仍存在争议。而0.01<P<0.05的miRNA有10个，其中miR139在胃癌组织中异常下调，有研究表明，miR139通过靶向ROCK1抑制胃癌细胞增殖、迁移和侵袭，另一研究表明，HER2通过HER2/CD44-miR139-CXCR4轴促进胃肿瘤进展和转移，为miR139在胃癌中的抗癌活性提供了明确的证明[[11](javascript:void(0);),[12](javascript:void(0);)]。miR217在胃癌组织中表达上调，且其低表达预示着较好的预后。Li等[[13](javascript:void(0);)]研究发现，miR217过表达后靶向降低外泌体CDH1影响微环境而发挥促癌作用，为我们的研究提供了证据支持。但更多的研究表明，miR217通过靶向其他分子(PTPN14、GCP5)在胃癌中发挥抑癌作用[[14](javascript:void(0);),[15](javascript:void(0);),[16](javascript:void(0);)]。Guo等[[17](javascript:void(0);)]证实miR365受PTEN-Akt-p53轴调控并靶向cyclin D1/cdc25A促进胃细胞增殖，且miR365低表达与胃癌组织低分化，深度浸润和晚期阶段相关。我们发现miR145在胃癌中表达下调，有相关研究表明其在胃癌中发挥抑癌作用，通过靶向CD44、MYO6等分子抑制胃癌细胞的增殖、迁移和转移，增强化疗敏感性[[18](javascript:void(0);),[19](javascript:void(0);)]。而其他9个miRNA未见文献报道，其中在胃癌组织中上调的有:miR508、miR96、miR1911、miR549a和miR877，下调的有:miR-605、miR137、miR5680、miR6510，其在胃癌发生、发展中的作用需进一步的探索和实验验证。

经初步筛选和深入分析获得17个与胃癌的生存相关的mRNA/lncRNA，其中P<0.01的mRNA有2个，lncRNA有4个。2个与胃腺癌密切相关的mRNA(CGB5和FGL1)在胃癌组织中的表达均上调，进一步探索2个基因与胃癌预后的关系，发现2个基因在胃癌中的高表达均提示较差的预后。Yang等[[20](javascript:void(0);)]在ICGC和TCGA 2个数据库中进行分析，表明CGB5在胃癌组织中可作为独立预后因子，其表达与胃癌患者较差的生存相关，本研究与其分析结果相一致，进一步证明了结果的可靠性。本研究显示，在胃癌组织中FGL1表达上调，具有高FGL1表达水平的胃癌患者的总存活时间明显短于具有低FGL1表达水平的胃癌患者，这与Zhang等[[21](javascript:void(0);)]对于FGL1的研究结果相一致，且他们的研究表明FGL1促进上皮间充质转化(epithelial-mesenchymal transition,EMT)，并表明FGL1有可能成为胃癌患者的预测因子。而关于4个lncRNA(OVAAL、LINC00973、RP11-962G15.1、CTD-2591A6.2)的文献报道较少，在胃癌中的具体作用尚不清楚。但我们的研究表明4个lncRNA均在胃癌组织中高表达，且其高表达预示着较差的预后。

### 4 结论

本研究以TCGA数据库为基础，采用生物信息学方法，对胃腺癌数据进行分析研究，初步筛选出多个与胃癌预后相关的差异表达基因，为该疾病的早期诊断治疗和靶向药物的开发提供了重要分子依据。由于胃癌的发生、发展涉及多方面因素影响，其复杂性和多样性需要更多的研究来验证这些基因表达在胃癌发生、发展和治疗反应中的潜在机制，以为进一步的诊断和精准靶向治疗提供可靠依据。

但是，我们的研究仍然存在一些局限性。首先，我们依赖于TCGA数据库，该数据库提供的有关患者治疗方案的信息较少，因此我们无法探究治疗方案对基因表达的影响。其次，在我们的研究中确定的预后基因仍有待大量基础实验以进行体外和体内验证。

### 参考文献

[**[1\]** Bray F,Ferlay J,Soerjomataram I,et al. Global cancer statistics 2018:GLOBOCAN estimates of incidence and mortality worldwide for 36 cancers in 185 countries[J]. CA Cancer J Clin,2018,68(6):394-424.](https://kns.cnki.net/kcms/detail/detail.aspx?dbcode=SJWD&filename=SJWDD72DD4502879DD556EBFEC6ABBE160F5&v=MDI4MjFGcG1hQnVIWWZPR1FsZkJyYlV3NTk1aHg3eSt4SzA9TmlmY2FzZS9IS1c0cTRwRlp1TUlCUWhOeWhNVm4wMExQUXprM1dCSERMT1NSY3lhQ09OdkZTaVdXcjdKSQ==&uid=WEEvREcwSlJHSldSdmVqMDh6a1dpNnd2cGtMOTRyN1g0WlVhbThqTnJOWT0=$9A4hF_YAuvQ5obgVAqNKPCYcEjKensW4IQMovwHtwkF4VYPoHbKxJw!!)

[**[2\]** Torre LA,Bray F,Siegel RL,et al. Global cancer statistics,2012[J].CA Cancer J Clin,2015,65(2):87-108.](https://kns.cnki.net/kcms/detail/detail.aspx?dbcode=SJWD&filename=SJWD15030900000061&v=MjY4MjVIL2lyUmRHZXJxUVRNbndaZVp0RnluaFU3bklJMW9WYmhjPU5pZmNhcks5SHRMTXBvOUZaT3NQREhvNG9CTVQ2VDRQUQ==&uid=WEEvREcwSlJHSldSdmVqMDh6a1dpNnd2cGtMOTRyN1g0WlVhbThqTnJOWT0=$9A4hF_YAuvQ5obgVAqNKPCYcEjKensW4IQMovwHtwkF4VYPoHbKxJw!!)

[**[3\]**刘瑾，高源，徐农．胃癌靶向治疗的现状和研究进展[J]．肿瘤学杂志，2018,24(12):1147-1152.](https://kns.cnki.net/kcms/detail/detail.aspx?dbcode=DKFX&filename=XHON201812002&v=MjA2MTR6cXFCdEdGckNVUjd1Zll1ZG9GeXZoVXJ2TlBTWEVZTEc0SDluTnJZOUZab1FLREg4NHZSNFQ2ajU0TzM=&uid=WEEvREcwSlJHSldSdmVqMDh6a1dpNnd2cGtMOTRyN1g0WlVhbThqTnJOWT0=$9A4hF_YAuvQ5obgVAqNKPCYcEjKensW4IQMovwHtwkF4VYPoHbKxJw!!)

[**[4\]** Deng M,Brgelmann J,Schultze JL,et al. Web-TCGA:an online platform for integrated analysis of molecular cancer data sets[J]. BMC Bioinformatics,2016,17(1):72.](http://scholar.cnki.net/result.aspx?q=Web-TCGA:an online platform for integrated analysis of molecular cancer data sets)

[**[5\]** Zhao Y,Wang H,Wu C,et al. Construction and investigation of lncRNA-associated ceRNA regulatory network in papillary thyroid cancer[J]. Oncol Rep,2018,39(3):1197-1206.](https://kns.cnki.net/kcms/detail/detail.aspx?dbcode=SJSD&filename=SJSDE6EADFF1CF985890305365F96F2F5A93&v=MjMyNjY1aHg3eSt4SzA9TmlmWWFzYSthNkM0MmZsRUY1MEdCSGt4eGhZUTZqcCtUbnFVcFJSRGU4U1JOTE9jQ09OdkZTaVdXcjdKSUZwbWFCdUhZZk9HUWxmQnJiVXc1OQ==&uid=WEEvREcwSlJHSldSdmVqMDh6a1dpNnd2cGtMOTRyN1g0WlVhbThqTnJOWT0=$9A4hF_YAuvQ5obgVAqNKPCYcEjKensW4IQMovwHtwkF4VYPoHbKxJw!!)

[**[6\]** Zhao Y,Liu Y,Lin L,et al. The lncRNA MACC1-AS1 promotes gastric cancer cell metabolic plasticity via AMPK/Lin28 mediated mRNA stability of MACC1[J]. Mol Cancer,2018,17(1):69.](http://scholar.cnki.net/result.aspx?q=The lncRNA MACC1-AS1 promotes gastric cancer cell metabolic plasticity via AMPK/Lin28mediated mRNA stability of MACC1)

[**[7\]** Iorio MV,Croce CM. MicroRNA dysregulation in cancer:diagnostics,monitoring and therapeutics. A comprehensive review[J]. EMBO Mol Med,2012,4(3):143-159.](https://kns.cnki.net/kcms/detail/detail.aspx?dbcode=SJWD&filename=SJWD120427005862&v=MjY4ODVySzZIdFhPcUk5RlllTUpEaE04enhVU21EZDlTSDduM3hFOWZidm5LcmlmWmVkdkV5ampVN3pNSVZvUk5pZmNh&uid=WEEvREcwSlJHSldSdmVqMDh6a1dpNnd2cGtMOTRyN1g0WlVhbThqTnJOWT0=$9A4hF_YAuvQ5obgVAqNKPCYcEjKensW4IQMovwHtwkF4VYPoHbKxJw!!)

[**[8\]** Jiang C,Chen X,Alattar M,et al. MicroRNAs in tumorigenesis,metastasis,diagnosis and prognosis of gastric cancer[J]. Cancer Gene Ther,2015,22(6):291-301.](http://scholar.cnki.net/result.aspx?q=MicroRNAs in tumorigenesis,metastasis,diagnosis and prognosis of gastric cancer)

[**[9\]** Gu W,Gao T,Shen J,et al. MicroRNA-183 inhibits apoptosis and promotes proliferation and invasion of gastric cancer cells by targeting PDCD4[J]. Int J Clin Exp Med,2014,7(9):2519-2529.](http://scholar.cnki.net/result.aspx?q=microRNA-183 inhibits apoptosis and promotes proliferation and invasion of gastric cancer cells by targeting PDCD4)

[**[10\]** Cao LL,Xie JW,Lin Y,et al. miR-183 inhibits invasion of gastric cancer by targeting Ezrin[J]. Int J Clin Exp Pathol,2014,7(9):5582-5594.](http://scholar.cnki.net/result.aspx?q=mi R-183 inhibits invasion of gastric cancer by targeting Ezrin)

[**[11\]** Yu X,Ma C,Fu L,et al. MicroRNA-139 inhibits the proliferation,migration and invasion of gastric cancer cells by directly targetingρ-associated protein kinase 1[J]. Oncol Lett,2018,15(4):5977-5982.](https://kns.cnki.net/kcms/detail/detail.aspx?dbcode=SJSD&filename=SJSDB84523867C3FFE7176D89360BE803BC4&v=MDg0OTNFdDFRWHprckdCQWNiS1hOOG1iQ09OdkZTaVdXcjdKSUZwbWFCdUhZZk9HUWxmQnJiVXc1OTVoeDd5K3hLMD1OaWZZYXNHd0d0VE9ySWREWTVnTWVncE15QmNVNw==&uid=WEEvREcwSlJHSldSdmVqMDh6a1dpNnd2cGtMOTRyN1g0WlVhbThqTnJOWT0=$9A4hF_YAuvQ5obgVAqNKPCYcEjKensW4IQMovwHtwkF4VYPoHbKxJw!!)

[**[12\]** Bao W,Fu HJ,Xie QS,et al. HER2 interacts with CD44 to up-regulate CXCR4 via epigenetic silencing of microRNA-139 in gastric cancer cells[J]. Gastroenterology,2011,141(6):2076-2087. e6.](https://kns.cnki.net/kcms/detail/detail.aspx?dbcode=SJES&filename=SJES13011601503935&v=MjExMDI4OG9CTVQ2VDRQUUgvaXJSZEdlcnFRVE1ud1plWnRGeW5oVTduSUkxb1ZiaGM9TmlmT2ZiSzdIdEROcVk5RVllc01CWA==&uid=WEEvREcwSlJHSldSdmVqMDh6a1dpNnd2cGtMOTRyN1g0WlVhbThqTnJOWT0=$9A4hF_YAuvQ5obgVAqNKPCYcEjKensW4IQMovwHtwkF4VYPoHbKxJw!!)

[**[13\]** Li W,Gao YQ. MiR-217 is involved in the carcinogenesis of gastric cancer by down-regulating CDH1 expression[J]. Kaohsiung J Med Sci,2018,34(7):377-384.](https://kns.cnki.net/kcms/detail/detail.aspx?dbcode=SJES&filename=SJESA460566691C79C36222E8E1B05841E18&v=Mjc5NDhRbGZCcmJVdzU5NWh4N3kreEswPU5pZk9mY0s4R05ISnFZbERiZXA4QzNWS3pCQVI2RDBJUUFyajNoSXdjYmFWTUx1WENPTnZGU2lXV3I3SklGcG1hQnVIWWZPRw==&uid=WEEvREcwSlJHSldSdmVqMDh6a1dpNnd2cGtMOTRyN1g0WlVhbThqTnJOWT0=$9A4hF_YAuvQ5obgVAqNKPCYcEjKensW4IQMovwHtwkF4VYPoHbKxJw!!)

[**[14\]** Liu YP,Sun XH,Cao XL,et al. MicroRNA-217 suppressed epithelial-to-mesenchymal transition in gastric cancer metastasis through targeting PTPN14[J]. Eur Rev Med Pharmacol Sci,2017,21(8):1759-1767.](http://scholar.cnki.net/result.aspx?q=MicroRNA-217 suppressed epithelial-to-mesenchymal transition in gastric cancer metastasis through targeting PTPN14)

[**[15\]** Wang H,Dong X,Gu X,et al. The MicroRNA-217 Functions as a Potential Tumor Suppressor in Gastric Cancer by Targeting GPC5[J].PLo S One,2015,10(6):e0125474.](http://scholar.cnki.net/result.aspx?q=The Micro RNA-217 Functions as a Potential Tumor Suppressor in Gastric Cancer by Targeting GPC5)

[**[16\]** Dong X,He X,Guan A,et al. Long non-coding RNA Hotair promotes gastric cancer progression via miR-217-GPC5 axis[J]. Life Sci,2019,217:271-282.](https://kns.cnki.net/kcms/detail/detail.aspx?dbcode=SJES&filename=SJESB9CF7B472DCF51B45608BE083D6CF235&v=MDc3ODNXV3I3SklGcG1hQnVIWWZPR1FsZkJyYlV3NTk1aHg3eSt4SzA9TmlmT2ZjR3hiYWZMM1l0Q1pwOThlbms0dlJJVzdEOTFPZ3JpcEJGQmY4SGlSN21hQ09OdkZTaQ==&uid=WEEvREcwSlJHSldSdmVqMDh6a1dpNnd2cGtMOTRyN1g0WlVhbThqTnJOWT0=$9A4hF_YAuvQ5obgVAqNKPCYcEjKensW4IQMovwHtwkF4VYPoHbKxJw!!)

[**[17\]** Guo SL,Ye H,Teng Y,et al. Akt-p53-miR-365-cyclin D1/cdc25A axis contributes to gastric tumorigenesis induced by PTEN deficiency[J]. Nat Commun,2013,4:2544.](http://scholar.cnki.net/result.aspx?q=Akt-p53-miR-365-cyclin D1/cdc25A axis contributes to gastric tumorigenesis induced by PTEN deficiency)

[**[18\]** Zeng JF,Ma XQ,Wang LP,et al. MicroRNA-145 exerts tumorsuppressive and chemo-resistance lowering effects by targeting CD44 in gastric cancer[J]. World J Gastroenterol,2017,23(13):2337-2345.](https://kns.cnki.net/kcms/detail/detail.aspx?dbcode=CJFD&filename=ZXXY201713009&v=MDgwNzJPM3pxcUJ0R0ZyQ1VSN3VmWXVkb0Z5dmhVcnZOUHpYVGQ3RzRIOWJOckk5RmJZUUtESDg0dlI0VDZqNTQ=&uid=WEEvREcwSlJHSldSdmVqMDh6a1dpNnd2cGtMOTRyN1g0WlVhbThqTnJOWT0=$9A4hF_YAuvQ5obgVAqNKPCYcEjKensW4IQMovwHtwkF4VYPoHbKxJw!!)

[**[19\]** Lei C,Du F,Sun L,et al. miR-143 and miR-145 inhibit gastric cancer cell migration and metastasis by suppressing MYO6[J]. Cell Death Dis,2017,8(10):e3101.](http://scholar.cnki.net/result.aspx?q=miR-143and miR-145 inhibit gastric cancer cell migration and metastasis by suppressing MYO6)

[**[20\]** Yang Y,Shi Y,Hou Y,et al. CGB5 expression is independently associated with poor overall survival and recurrence-free survival in patients with advanced gastric cancer[J]. Cancer Med,2018,7(3):716-725.](https://kns.cnki.net/kcms/detail/detail.aspx?dbcode=SJWD&filename=SJWDC5B3EF7F77D70BC67605239D05F71256&v=MjEwMjE3K1pDT052RlNpV1dyN0pJRnBtYUJ1SFlmT0dRbGZCcmJVdzU5NWh4N3kreEswPU5pZmNhc0M5Yk5LNTJZZ3pZK3g3QzN4THZCQVU3RDk0U256cjJCSXdEN1dWUg==&uid=WEEvREcwSlJHSldSdmVqMDh6a1dpNnd2cGtMOTRyN1g0WlVhbThqTnJOWT0=$9A4hF_YAuvQ5obgVAqNKPCYcEjKensW4IQMovwHtwkF4VYPoHbKxJw!!)

[**[21\]** Zhang Y,Qiao HX,Zhou YT,et al. Fibrinogen-like-protein 1 promotes the invasion and metastasis of gastric cancer and is associated with poor prognosis[J]. Mol Med Rep,2018,18(2):1465-1472.](https://kns.cnki.net/kcms/detail/detail.aspx?dbcode=SJSD&filename=SJSD86B240486ADAC7AD4A8E33C07F9B18CF&v=MzE1MjRJRnBtYUJ1SFlmT0dRbGZCcmJVdzU5NWh4N3kreEswPU5pZllhcnUrYk5QSXI0dE5ZcHA3ZlE4K3ZtSVhtemNJUzN5UnJCVkRjTUNWVGNucENPTnZGU2lXV3I3Sg==&uid=WEEvREcwSlJHSldSdmVqMDh6a1dpNnd2cGtMOTRyN1g0WlVhbThqTnJOWT0=$9A4hF_YAuvQ5obgVAqNKPCYcEjKensW4IQMovwHtwkF4VYPoHbKxJw!!)