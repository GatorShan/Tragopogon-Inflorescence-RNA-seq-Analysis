# Identify DE genes between diploid T. dubius (Tdu) and T. pratensis (Tpr)

## 1. Introduction
Tdu are from two populations (Pullman and Moscow) with six replications in total; Tpr samples are from Moscow with three replications. DESeq2 was used for DE analysis. Based on PCA analysis, since there is not many difference between the six samples of Tdu, Tdu samples from 2 populations were combined for DE analysis.

```
sample	species	population
Tdu_1	Tdu	Tdu_pullman
Tdu_2	Tdu	Tdu_pullman
Tdu_3	Tdu	Tdu_pullman
Tdu_4	Tdu	Tdu_moscow
Tdu_5	Tdu	Tdu_moscow
Tdu_6	Tdu	Tdu_moscow
Tpr_1	Tpr	Tpr_moscow
Tpr_2	Tpr	Tpr_moscow
Tpr_3	Tpr	Tpr_moscow
```

## 2. Generate count matrix
Script `DESeq2_Tdu_Tpr_count_matrix.ipynb` was used to generate count matrix of Tdu and Tpr, which is the input for DESeq2 analysis.

## 3. DE analysis
The scripts could be found in Jupyter notebook `DESeq2_Tdu_Tpr_DEanalysis.ipynb`. When performing sample-level quality control, based on PCA and hierarchical clustering results:
  - Tdu samples and Tpr samples were well-separated
  - All six samples of Tdu were clustered together
  - All three samples of Tpr were clustered together

Bases on the above results, we performed **only one batch of DE analysis between Tdu and Tpr**.

![Tdu_Tpr_PCA](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Differential_expression_analysis/DE_Tdu_Tpr/Images/Tdu_Tpr_PCA_DESeq2.png)

![Tdu_Tpr_correlation](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Differential_expression_analysis/DE_Tdu_Tpr/Images/Tdu_Tpr_correlation_DESeq2.png)

Here is the **results of DE analysis (padj < 0.05) between Tdu and Tpr**:

| Classes | Number |
| -- | -- |
| Total loci | 11,864 (11,863 loci + one called "commonID") |
| Nonzero total read count | 11,661 |
| DE loci with LFC > 0 (Tdu > Tpr) | 987 |
| DE loci with LFC < 0 (Tdu < Tpr) | 1,030 |
| Outliers | 11 |
| Low counts | 904 |
| Total number of loci with results | 10,746 (=11,661 - 11 - 904) |

![MA_plot_Tdu_Tpr](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Differential_expression_analysis/DE_Tdu_Tpr/Images/Tdu_Tpr_MAplot.png)

**OUTPUT**

1) **`DESeq2_DE_Tdu_Tpr.txt`** contains 2,017 DE loci between Tdu and Tpr

2) **`DESeq2_DE_higher_Tdu.txt`** contains 987 DE loci with higher expression in Tdu

3) **`DESeq2_DE_higher_Tpr.txt`** contains 1,030 DE loci with higher expression in Tpr

4) **`DESeq2_none-DE_Tdu_Tpr.txt`** contains 8,729 DE loci with none-DE expression between Tdu and Tpr

## 4. DE analysis between the two populations of Tdu: Pullman vs. Moscow
Script `DESeq2_Tdu_count_matrix.ipynb` was used to construct the count matrix, and `DESeq2_Tdu_DEanalysis.ipynb` was used to perform the DE analysis.

There is only **one DE gene** between Tdu_pullman and Tdu_moscow. This gene is **not differentially expressed** between Tdu (combining data from two populations) and Tpr.

Here is the **results of DE analysis (padj < 0.05) between Tdu_pullman and Tdu_moscow**:

| Classes | Number |
| -- | -- |
| Nonzero total read count | 11,502 |
| DE loci with LFC > 0 (Tdu_pullman > Tdu_moscow) | 0 |
| DE loci with LFC < 0 (Tdu_pullman < Tdu_moscow) | 1 |
| Outliers | 3 |
| Low counts | 0 |
| Total number of loci with results | 11,499 (=11,502 - 3 - 0) |

![DE_Tdu_two_pop](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Differential_expression_analysis/DE_Tdu_Tpr/Images/DE_Tdu_two_pop.png)
