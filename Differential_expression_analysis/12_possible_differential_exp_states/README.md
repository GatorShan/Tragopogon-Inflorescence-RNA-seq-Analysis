# Parsing genes into the 12 possible differential expression states
This analysis has been performed in Rapp et al. (2009), Yoo et al. (2013, 2014), and many others -- a conventional approach to assess nonadditive expression in hybrid/polyploid.
![12 categories](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Differential_expression_analysis/12_possible_differential_exp_states/images/12_categories.png)
## 1. Analysis in short-liguled T. miscellus (Tms)
### 1.1 Input files
Script `DESeq2_Tms_additive_analysis_v3.ipynb` was used to compare the expression levels among Tdu, Tpr, and Tms.

  - 1178 `DESeq2_DE_loci_Tdu_higher_than_Tms.txt`
  - 952 `DESeq2_DE_loci_Tdu_higher.txt`: Tdu > Tpr
  - 952 `DESeq2_DE_loci_Tms_higher_than_Tdu.txt`
  - 785 `DESeq2_DE_loci_Tms_higher_than_Tpr.txt`
  - 942 `DESeq2_DE_loci_Tpr_higher_than_Tms.txt`
  - 990 `DESeq2_DE_loci_Tpr_higher.txt`: Tpr > Tdu
  - 9072 `DESeq2_noneDE_loci_Tdu_Tpr.txt`
  - 8430 `DESeq2_noneDE_loci_Tms_Tdu.txt`
  - 8153 `DESeq2_noneDE_loci_Tms_Tpr.txt`
  
