# Additive expression analysis in short-liguled T. miscellus (Tms)
## 1. Generate count matrix
Script `DESeq2_Tms_additive_count_matrix.ipynb` was used to generate the count matrix

## 2. DESeq2 analysis
Script `DESeq2_Tms_additive_analysis.ipynb` was used for DESeq2 analysis.

For additive analysis, the expression value of Tms was compared with MPV (average of Tdu and Tpr) following the method described [here](https://support.bioconductor.org/p/69104/).
```r
## Contrast MPV and polyploid; cutoff of adjusted p-value (FDR) is set as 0.05; MPV is the baseline for logFC
## contrast: a list of 2 character vectors: the names of the fold changes for the numerator, and the names of the fold changes for the denominator; these names should be elements of resultNames(object)
## listvalues: a numeric of length two: the log2 fold changes in the list are multiplied by these values (only used if a list is provided to contrast)
res_additive_analysis <- results(dds, contrast=list("speciesTms", c("speciesTdu","speciesTpr")), listValues=c(1, -1/2), alpha = 0.05)
```

If the expression of Tms is not significantly different from MPV in a locus, that locus is considered as additive; if the expression of Tms is significantly different (FDR 0.05) from MPV at a locus, that locus is considered as non-additive.

![PCA plot](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Differential_expression_analysis/Additive_exp_Tms/images/Tms_additive_PCA.png)

![Clustering](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Differential_expression_analysis/Additive_exp_Tms/images/Tms_additive_clustering.png)

![MA plot](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Differential_expression_analysis/Additive_exp_Tms/images/Tms_additive_MA.png)

Output:
  - `DESeq2_Tms_nonAdditive_loci.txt`, contains 1,768 loci that showed non-additive expression
  - `DESeq2_Tms_Additive_loci.txt`, contains 8,336 loci showed additive expression
  

## 3. Compare non-additive loci identified by DESeq2 and Limma
Script `Tms_additive_analysis_methods_compare.ipynb` was used for the comparison analysis. The majority (77.2%) of non-additive loci identified by Limma were also identified by DESeq2.
  - DESeq2 identified 1,768 non-additive loci
  - Limma identified 1,312 non-additive loci
  - 1,013 loci were identified by both methods

## 4. Classify additive and non-additive Tms loci based on parental expression profiles
Script `DESeq2_Tms_additive_loci_classification.ipynb` was used for this analysis.

Output:
  - `Tms_Additive_nonDE.txt`
  - `Tms_Additive_DE.txt`
  - `Tms_nonAdditive_nonDE.txt`
  - `Tms_nonAdditive_DE.txt`

| | Tms additive loci | Tms non-additive loci |
| -- | -- | -- |
| Tdu = Tpr | 6,823 | 1,364 |
| Tdu ≠ Tpr | 1,513 | 404 |

## 5. Expression-level dominant (ELD) and transgressive expression analysis
Scirpt `DESeq2_Tms_additive_analysis_v2.ipynb` was used, and generate the following output files:
  - `DESeq2_DE_loci_Tdu_higher.txt`, contains DE loci between Tdu and Tpr with higher expression in Tdu
  - `DESeq2_DE_loci_Tpr_higher.txt`, contains DE loci between Tdu and Tpr with higher expression in Tpr
  - `DESeq2_DE_loci_Tms_higher_than_Tdu.txt`, contains DE loci between Tms and Tdu with higher expression in Tms
  - `DESeq2_DE_loci_Tdu_higher_than_Tms.txt`, contains DE loci between Tms and Tdu with higher expression in Tdu
  - `DESeq2_noneDE_loci_Tms_Tdu.txt`, contains nonDE loci between Tms and Tdu
  - `DESeq2_DE_loci_Tms_higher_than_Tpr.txt`, contains DE loci between Tms and Tpr with higher expression in Tms
  - `DESeq2_DE_loci_Tpr_higher_than_Tms.txt`, contains DE loci between Tms and Tpr with higher expression in Tpr
  - `DESeq2_noneDE_loci_Tms_Tpr.txt`, contains nonDE loci between Tms and Tpr

Script `DESeq2_Tms_ELD_transgressiveExp.ipynb` was used to assess ELD and transgressive expression

Output:
  - `Tms_transgressive_higher.txt`
  - `Tms_transgressive_lower.txt`
  - `Tms_ELDofTdu_TduHigher.txt`
  - `Tms_ELDofTdu_TprHigher.txt`
  - `Tms_ELDofTpr_TduHigher.txt`
  - `Tms_ELDofTpr_TprHigher.txt`

| Type | Numuber of loci |
| -- | -- |
| Transgressive expression higher than both Tdu and Tpr | 273 |
| Transgressive expression lower than both Tdu and Tpr | 480 |
| ELD of Tdu; Tdu is higher than Tpr | 88 |
| ELD of Tdu; Tpr is higher than Tdu | 92 |
| ELD of Tpr; Tdu is higher than Tpr | 72 |
| ELD of Tpr; Tpr is higher than Tdu | 85 |


