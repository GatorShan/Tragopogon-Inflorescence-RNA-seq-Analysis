# Additive expression analysis in short-liguled T. miscellus (Tms)
## 1. Generate count matrix
Script `DESeq2_Tms_additive_count_matrix.ipynb` was used to generate the count matrix

## 2. DESeq2 analysis
Script `*` was used for DESeq2 analysis.

For additive analysis, the expression value of Tms was compared with MPV (average of Tdu and Tpr) following the method described [here](https://support.bioconductor.org/p/69104/). If the expression of Tms is not significantly different from MPV in a locus, that locus is considered as additive; if the expression of Tms is significantly different (FDR 0.05) from MPV at a locus, that locus is considered as non-additive.

Output:
  - `DESeq2_Tms_nonAdditive_loci.txt`, contains 1,768 loci that showed non-additive expression
  - `DESeq2_Tms_Additive_loci.txt`, contains 8,336 loci showed additive expression
  

## 3. Compare non-additive loci identified by DESeq2 and Limma
Script `Tms_additive_analysis_methods_compare.ipynb` was used for the comparison analysis. The majority (77.2%) of non-additive loci identified by Limma were also identified by DESeq2.
  - DESeq2 identified 1,768 non-additive loci
  - Limma identified 1,312 non-additive loci
  - 1,013 loci were identified by both methods
