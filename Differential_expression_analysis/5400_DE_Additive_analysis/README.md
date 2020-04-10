# Perform additive gene expression analysis using the 5,400 loci without mapping bias
These analyses were performed to answer Pam's question during my PhD defense

## 1. DE analysis of 5,400 loci between Tdu and Tpr
### 1.1 Generate DESeq2 count matrix for the 5,400 loci
Script `ExtractInfo_V4.0.py` was used:
```
ExtractInfo_V4.0.py bayes_flag_sig_Filtered_Tdu-Tpr_overlap.V2.csv DESeq2_count_matrix_Tdu_Tpr.csv
```

Output: `DESeq2_count_matrix_Tdu_Tpr_5400.csv`

### 1.2 DE analysis
Script `DESeq2_Tdu_Tpr_DEanalysis_5400.r` was used.

![PCA](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Differential_expression_analysis/5400_DE_Additive_analysis/images/Pic_3_PCA_Tdu_Tpr.png)
![Tree](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Differential_expression_analysis/5400_DE_Additive_analysis/images/Pic_4_Tree_Tdu_Tpr.png)
![DE](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Differential_expression_analysis/5400_DE_Additive_analysis/images/Pic_6_DE_analysis_Tdu_Tpr.png)

Results:

| Expression pattern | No. of loci |
| -- | -- |
| DE | 960 |
| non-DE | 4,095 |
| Total | 5,055 |

## 2. Additive expression analysis in Tms (short-liguled T. miscellus)
Script `DESeq2_Tms_additive_analysis_5400.r` was used.

![DE](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Differential_expression_analysis/5400_DE_Additive_analysis/images/Pic_4_DE_Tms_MPV.png)

Results:

| Expression pattern | No. of loci |
| -- | -- |
| Additive | 4,122 (84.9%) |
| non-Additive | 731 (15.1%) |
| Total | 4,853 |

## 3. Additive expression analysis in Tml (long-liguled T. miscellus)
Script `DESeq2_Tml_additive_analysis_5400.r` was used.

![DE](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Differential_expression_analysis/5400_DE_Additive_analysis/images/Pic_6_DE_Tml_MPV.png)

Results:

| Expression pattern | No. of loci |
| -- | -- |
| Additive | 4,062 (91.6%) |
| non-Additive | 372 (8.4%) |
| Total | 4,434 |
