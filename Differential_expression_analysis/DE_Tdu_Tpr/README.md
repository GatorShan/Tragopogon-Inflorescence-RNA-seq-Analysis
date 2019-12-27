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

## 2. DE analysis
The scripts could be found in Jupyter notebook `DESeq2_Tdu_Tpr_DEanalysis.ipynb`. When performing sample-level quality control, based on PCA and hierarchical clustering results:
  - Tdu samples and Tpr samples were well-separated
  - All six samples of Tdu were clustered together
  - All three samples of Tpr were clustered together

Bases on the above results, we performed **only one batch of DE analysis between Tdu and Tpr**.

![Tdu_Tpr_PCA | 100x100](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Differential_expression_analysis/DE_Tdu_Tpr/Images/Tdu_Tpr_PCA_DESeq2.png)

![Tdu_Tpr_correlation](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Differential_expression_analysis/DE_Tdu_Tpr/Images/Tdu_Tpr_correlation_DESeq2.png)


  