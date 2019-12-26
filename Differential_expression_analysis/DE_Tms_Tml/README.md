# Identify DE genes between long-liguled T. miscellus (Tml) and short-liguled T. miscellus (Tms)

## 1. Description
Limma-voom was used to identify DE loci between Tms and Tml. However, no DE locus was identified! After disccusing with Lucas, we decided to use DESeq2 for DE analysis. Using PCA analsis, Tml_1 was found as a outlier. 2 and 41 DE loci were identified between two forms of T. miscellus with and without Tml_1, respectively.

Finally, we used those 41 DE loci for downstream analysis.

The methods we used are from this [tutorial](https://github.com/hbctraining/DGE_workshop/tree/master/lessons)

Difference between different DE analyzing softwares:
  - __DESeq2 and EdgeR__: Both these tools use the **negative binomial model**, employ similar methods, and typically, yield similar results. They are pretty stringent, and have a good balance between sensitivity and specificity (reducing both false positives and false negatives).
  - __Limma-Voom__ is another set of tools often used together for DE analysis, but **this method may be less sensitive for small sample sizes**. This method is recommended when the number of biological replicates per group grows large (> 20).

## 2. Quality control
There are two levels of quality control (QC): sample-level and gene-level. As DESeq2 will perform gene-level quality control by default, here we performed sample-level QC.

The purpose of sample-level QC is **assess overall similarity between samples**.

The scripts is in `DESeq2_Tml_Tms_Part1.ipynb`. Based on PCA and hierarchical clustering analysis, we think Tml_1 is the outlier. Therefore, Tml_1 was removed for DE analysis.

![PCA analysis](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Differential_expression_analysis/DE_Tms_Tml/Images/Tms_Tml_PCA_DESeq2.png?raw=true)

![Hierarchical clustering](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Differential_expression_analysis/DE_Tms_Tml/Images/Tms_Tml_correlation_DESeq2.png?raw=true)





