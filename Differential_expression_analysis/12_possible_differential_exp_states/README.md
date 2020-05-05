# Parsing genes into 12 possible differential expression states
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
### 1.2 Parse genes
Script `DESeq2_Tms_12_categories_v1.ipynb` was used to parse genes into the 12 categories.

Output:
```
6243 Tdu_equal_Tpr_AND_Tms_equal_Tdu_AND_Tms_equal_Tpr.txt
 260 Tdu_equal_Tpr_AND_Tms_high_Tdu_AND_Tms_high_Tpr.txt
 433 Tdu_equal_Tpr_AND_Tms_low_Tdu_AND_Tms_low_Tpr.txt
 261 Tdu_high_Tpr_AND_Tms_equal_Tdu_AND_Tms_high_Tpr.txt
   7 Tdu_high_Tpr_AND_Tms_high_Tdu_AND_Tms_high_Tpr.txt
 297 Tdu_high_Tpr_AND_Tms_low_Tdu_AND_Tms_equal_Tpr.txt
  50 Tdu_high_Tpr_AND_Tms_low_Tdu_AND_Tms_high_Tpr.txt
  14 Tdu_high_Tpr_AND_Tms_low_Tdu_AND_Tms_low_Tpr.txt
 293 Tpr_high_Tdu_AND_Tms_equal_Tpr_AND_Tms_high_Tdu.txt
   6 Tpr_high_Tdu_AND_Tms_high_Tpr_AND_Tms_high_Tdu.txt
 245 Tpr_high_Tdu_AND_Tms_low_Tpr_AND_Tms_equal_Tdu.txt
  43 Tpr_high_Tdu_AND_Tms_low_Tpr_AND_Tms_high_Tdu.txt
  33 Tpr_high_Tdu_AND_Tms_low_Tpr_AND_Tms_low_Tdu.txt
8185 total
```

## 2. Analysis in long-liguled T. miscellus (Tml)
### 2.1 Input files
Script `DESeq2_Tml_additive_analysis_v3.ipynb` was used to compare the expression levels among Tdu, Tpr, and Tml.

  - 765 `DESeq2_DE_loci_Tdu_higher_than_Tml.txt`
  - 960 `DESeq2_DE_loci_Tdu_higher.txt`: Tdu > Tpr
  - 718 `DESeq2_DE_loci_Tml_higher_than_Tdu.txt`
  - 537 `DESeq2_DE_loci_Tml_higher_than_Tpr.txt`
  - 568 `DESeq2_DE_loci_Tpr_higher_than_Tml.txt`
  - 986 `DESeq2_DE_loci_Tpr_higher.txt`: Tdu < Tpr
  - 8822 `DESeq2_noneDE_loci_Tdu_Tpr.txt`
  - 8380 `DESeq2_noneDE_loci_Tml_Tdu.txt`
  - 8758 `DESeq2_noneDE_loci_Tml_Tpr.txt`

### 2.2 Parse genes
Script `DESeq2_Tml_12_categories_v1.ipynb` was used.

Output:
```
  6883 Tdu_equal_Tpr_AND_Tml_equal_Tdu_AND_Tml_equal_Tpr.txt
   173 Tdu_equal_Tpr_AND_Tml_high_Tdu_AND_Tml_high_Tpr.txt
   219 Tdu_equal_Tpr_AND_Tml_low_Tdu_AND_Tml_low_Tpr.txt
   203 Tdu_high_Tpr_AND_Tml_equal_Tdu_AND_Tml_high_Tpr.txt
     7 Tdu_high_Tpr_AND_Tml_high_Tdu_AND_Tml_high_Tpr.txt
   252 Tdu_high_Tpr_AND_Tml_low_Tdu_AND_Tml_equal_Tpr.txt
    32 Tdu_high_Tpr_AND_Tml_low_Tdu_AND_Tml_high_Tpr.txt
     6 Tdu_high_Tpr_AND_Tml_low_Tdu_AND_Tml_low_Tpr.txt
   267 Tpr_high_Tdu_AND_Tml_equal_Tpr_AND_Tml_high_Tdu.txt
     4 Tpr_high_Tdu_AND_Tml_high_Tpr_AND_Tml_high_Tdu.txt
   191 Tpr_high_Tdu_AND_Tml_low_Tpr_AND_Tml_equal_Tdu.txt
    29 Tpr_high_Tdu_AND_Tml_low_Tpr_AND_Tml_high_Tdu.txt
    22 Tpr_high_Tdu_AND_Tml_low_Tpr_AND_Tml_low_Tdu.txt
  8288 total
```
![Comparison](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Differential_expression_analysis/12_possible_differential_exp_states/images/Picture1.png)

## 3. Identify common loci between Tms and Tml
Script `Compare_Tms_Tml_12_categories.ipynb` was used to compare the loci within each category between Tms and Tml.

The results are shown below:
![common_loci]()
