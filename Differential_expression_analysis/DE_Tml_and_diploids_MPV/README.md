# Additive expression analysis in long-liguled T. miscellus (Tml)
## 1. Generate count matrix
Script `DESeq2_Tml_additive_count_matrix.ipynb` was used to generate the count matrix

## 2. DESeq2 analysis
Script `DESeq2_Tml_additive_analysis.ipynb` was used for DESeq2 analysis.

Based on PCA and clustering results, Tml_1 is a outlier (see notes in `DESeq2_Tml_additive_analysis.ipynb`), and is removed. Then, the PCA and clustering results showed samples from the same species were clustered together.

![PCA plot](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Differential_expression_analysis/DE_Tml_and_diploids_MPV/images/Tml_additive_PCA.png)

![Clustering](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Differential_expression_analysis/DE_Tml_and_diploids_MPV/images/Tml_additive_clustering.png)

For additive analysis, the expression value of Tml was compared with MPV (average of Tdu and Tpr) following the method described [here](https://support.bioconductor.org/p/69104/). If the expression of Tml is not significantly different from MPV in a locus, that locus is considered as additive; if the expression of Tml is significantly different (FDR 0.05) from MPV at a locus, that locus is considered as non-additive.

![MA plot](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Differential_expression_analysis/DE_Tml_and_diploids_MPV/images/Tml_additive_MA.png)

Output:
  - `DESeq2_Tml_nonAdditive_loci.txt`, contains 1,007 loci that showed non-additive expression
  - `DESeq2_Tml_Additive_loci.txt`, contains 7,949 loci showed additive expression

## 3. Classify additive and non-additive Tml loci based on parental expression profiles
Script `DESeq2_Tml_additive_loci_classification.ipynb` was used for this analysis.

Output:
  - `Tml_Additive_nonDE.txt`
  - `Tml_Additive_DE.txt`
  - `Tml_nonAdditive_nonDE.txt`
  - `Tml_nonAdditive_DE.txt`

| | Tml additive loci | Tml non-additive loci |
| -- | -- | -- |
| Tdu = Tpr | 6,403 | 737 |
| Tdu ≠ Tpr | 1,546 | 270 |


## 4. Expression-level dominant (ELD) and transgressive expression analysis
Scirpt `DESeq2_Tml_additive_analysis_v2.ipynb` was used, and generate the following output files:
  - `DESeq2_DE_loci_Tdu_higher.txt`, contains DE loci between Tdu and Tpr with higher expression in Tdu
  - `DESeq2_DE_loci_Tpr_higher.txt`, contains DE loci between Tdu and Tpr with higher expression in Tpr
  - `DESeq2_DE_loci_Tml_higher_than_Tdu.txt`, contains DE loci between Tml and Tdu with higher expression in Tml
  - `DESeq2_DE_loci_Tdu_higher_than_Tml.txt`, contains DE loci between Tml and Tdu with higher expression in Tdu
  - `DESeq2_noneDE_loci_Tml_Tdu.txt`, contains nonDE loci between Tml and Tdu
  - `DESeq2_DE_loci_Tml_higher_than_Tpr.txt`, contains DE loci between Tml and Tpr with higher expression in Tml
  - `DESeq2_DE_loci_Tpr_higher_than_Tml.txt`, contains DE loci between Tml and Tpr with higher expression in Tpr
  - `DESeq2_noneDE_loci_Tml_Tpr.txt`, contains nonDE loci between Tml and Tpr

Script `DESeq2_Tml_ELD_transgressiveExp.ipynb` was used to assess ELD and transgressive expression

Output:
  - `Tml_transgressive_higher.txt`
  - `Tml_transgressive_lower.txt`
  - `Tml_ELDofTdu_TduHigher.txt`
  - `Tml_ELDofTdu_TprHigher.txt`
  - `Tml_ELDofTpr_TduHigher.txt`
  - `Tml_ELDofTpr_TprHigher.txt`

| Type | Numuber of loci |
| -- | -- |
| Transgressive expression higher than both Tdu and Tpr | 180 |
| Transgressive expression lower than both Tdu and Tpr | 247 |
| ELD of Tdu; Tdu is higher than Tpr | 62 |
| ELD of Tdu; Tpr is higher than Tdu | 45 |
| ELD of Tpr; Tdu is higher than Tpr | 58 |
| ELD of Tpr; Tpr is higher than Tdu | 61 |
