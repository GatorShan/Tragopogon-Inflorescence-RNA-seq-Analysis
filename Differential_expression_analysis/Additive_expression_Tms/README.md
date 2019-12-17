# Additive expression analysis in short-liguled T. miscellus (Tms)

## 1. Description
The expression level between Tdu (4,5,6), Tpr (1,2,3), and Tms (1,2,3) is compared.

For additivity analysis, the mean of Tdu and Tpr is campared to Tms.

## 2. Voom additive expression analysis
Scripts could be found in `voom_additivity_Tms.ipynb`. **After removing low counts orthologs, there are 8,327 loci left**.

Input:
  - `both_counts_Tdu_4_2_Tdu_Tpr.csv`
  - `both_counts_Tdu_5_2_Tdu_Tpr.csv`
  - `both_counts_Tdu_6_2_Tdu_Tpr.csv`
  - `both_counts_Tpr_1_2_Tdu_Tpr.csv`
  - `both_counts_Tpr_2_2_Tdu_Tpr.csv`
  - `both_counts_Tpr_3_2_Tdu_Tpr.csv`
  - `both_counts_new_Tms_1_2_tdu_tpr.csv`
  - `both_counts_new_Tms_2_2_tdu_tpr.csv`
  - `both_counts_new_Tms_3_2_tdu_tpr.csv`

Output:
  - `all_samples.csv`
  - `additive_boxplot_log-CPM.pdf` in Jupyter notebook
  - `additive_voom_plot.pdf` in Jupyter notebook
  - `additive_residual_std_dev.pdf` in Jupyter notebook
  - `additive_DE_overall_model.txt`
  - `DE_Tdu_Tpr.txt`, in which expression level between Tdu and Tpr is compared; results are relative to Tdu
  - `DE_additive_Tdu_Tpr-Tms.txt`, in which expression level between (Tdu+Tpr)/2 and Tms is compared; results are relative to Tms
  - `additive_MDS_plot.pdf` in Jupyter notebook
  
## 3. Filter DE files
In this step, significantly different and not significantly different (FDR 0.05) loci were isolated.

Scripts could be found in `filter_DE_additive_Tms.ipynb`.

Input:
  - `additive_DE_overall_model.txt`
  - `DE_Tdu_Tpr.txt`
  - `DE_additive_Tdu_Tpr-Tms.txt`

Output:
  - `additive_DE_overall_model_sig_loci.txt`
  - `additive_DE_overall_model_not_sig_loci.txt`, which contains 110 loci
  - `DE_Tdu_Tpr_sig_loci.txt`, which contains 1,024 loci
  - `DE_Tdu_Tpr_not_sig_loci.txt`, which contains 7,303 loci
  - `DE_additive_Tdu_Tpr-Tms_sig_loci.txt`, which contains 1,312 loci
  - `DE_additive_Tdu_Tpr-Tms_not_sig_loci.txt`, which contains 7,015 loci

## 4. Test for additivity in Tms based on parental expression level
In this step, loci will be classified into two catogories: have same expression between parents or differentially expressed; then, additivity in Tms is assessed separately in each catogory.

Scripts could be found in `Assess_additivity_Tms.ipynb`.

Output:
  - `Tms_not_sig_parents_same.csv`, which contains 6,107 loci
  - `Tms_not_sig_parents_diff.csv`, which contains 825 loci
  - `Tms_sig_loci_parents_same.csv`, which contains 1,092 loci
  - `Tms_sig_loci_parents_diff.csv`, which contains 193 loci

|    | Additive exp in Tms | Non-additive exp in Tms |
| -- | -- | -- |
| Tdu = Tpr | 6,107 | 1,092 |
| Tdu ≠ Tpr | 825 | 193 |






  
