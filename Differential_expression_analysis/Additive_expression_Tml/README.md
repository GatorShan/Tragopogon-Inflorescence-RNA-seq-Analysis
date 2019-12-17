# Additive expression analysis in long-liguled T. miscellus (Tml)

## 1. Description
The expression level between Tdu (1,2,3), Tpr (1,2,3), and Tml (1,2,3) is compared.

For additivity analysis, the mean of Tdu and Tpr is campared to Tml.

## 2. Voom additive expression analysis
Scripts could be found in `voom_additivity_Tml.ipynb`. **After removing low counts orthologs, there are 8,376 loci left**.

Input:
  - `both_counts_Tdu_1_2_Tdu_Tpr.csv`
  - `both_counts_Tdu_2_2_Tdu_Tpr.csv`
  - `both_counts_Tdu_3_2_Tdu_Tpr.csv`
  - `both_counts_Tpr_1_2_Tdu_Tpr.csv`
  - `both_counts_Tpr_2_2_Tdu_Tpr.csv`
  - `both_counts_Tpr_3_2_Tdu_Tpr.csv`
  - `both_counts_new_Tml_1_2_tdu_tpr.csv`
  - `both_counts_new_Tml_2_2_tdu_tpr.csv`
  - `both_counts_new_Tml_3_2_tdu_tpr.csv`

Output:
  - `all_samples.csv`
  - `additive_boxplot_log-CPM.pdf` in Jupyter notebook
  - `additive_voom_plot.pdf` in Jupyter notebook
  - `additive_residual_std_dev.pdf` in Jupyter notebook
  - `additive_DE_overall_model.txt`
  - `DE_Tdu_Tpr.txt`, in which expression level between Tdu and Tpr is compared; results are relative to Tdu
  - `DE_additive_Tdu_Tpr-Tml.txt`, in which expression level between (Tdu+Tpr)/2 and Tml is compared; results are relative to Tml
  - `additive_MDS_plot.pdf` in Jupyter notebook
  
## 3. Filter DE files
In this step, significantly different and not significantly different (FDR 0.05) loci were isolated.

Scripts could be found in `filter_DE_additive_Tml.ipynb`.

Input:
  - `additive_DE_overall_model.txt`
  - `DE_Tdu_Tpr.txt`
  - `DE_additive_Tdu_Tpr-Tml.txt`

Output:
  - `additive_DE_overall_model_sig_loci.txt`
  - `additive_DE_overall_model_not_sig_loci.txt`, which contains ??? loci
  - `DE_Tdu_Tpr_sig_loci.txt`, which contains ??? loci
  - `DE_Tdu_Tpr_not_sig_loci.txt`, which contains ??? loci
  - `DE_additive_Tdu_Tpr-Tml_sig_loci.txt`, which contains ??? loci
  - `DE_additive_Tdu_Tpr-Tml_not_sig_loci.txt`, which contains ??? loci

## 4. Test for additivity in Tml based on parental expression level
In this step, loci will be classified into two catogories: have same expression between parents or differentially expressed; then, additivity in Tml is assessed separately in each catogory.

Scripts could be found in `Assess_additivity_Tml.ipynb`.

Output:
  - `Tml_not_sig_parents_same.csv`, which contains ??? loci
  - `Tml_not_sig_parents_diff.csv`, which contains ??? loci
  - `Tml_sig_loci_parents_same.csv`, which contains ??? loci
  - `Tml_sig_loci_parents_diff.csv`, which contains ??? loci

|    | Additive exp in Tml | Non-additive exp in Tml |
| -- | -- | -- |
| Tdu = Tpr |  |  |
| Tdu ≠ Tpr |  |  |


