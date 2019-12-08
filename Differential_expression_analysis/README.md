# Differential expression (DE) analysis
## 1. Description
"Counts were taken from reads mapped to both of the COREs between orthologous pairs" -- Boatwright et al., 2018

## 2. Identify DE loci between diploid parents
### 2.1 Count reads

Input:
  - `ase_counts_Tdu_(1-6)_2_Tdu_Tpr.csv`
  - `ase_counts_Tpr_(1-3)_2_Tdu_Tpr.csv`

| Original csv files | Renamed csv files |
| -- | -- |
| ase_counts_Tdu_2613_11_2_Tdu_Tpr.csv | ase_counts_Tdu_1_2_Tdu_Tpr.csv |
| ase_counts_Tdu_2613_12_2_Tdu_Tpr.csv | ase_counts_Tdu_2_2_Tdu_Tpr.csv |
| ase_counts_Tdu_2613_41_2_Tdu_Tpr.csv | ase_counts_Tdu_3_2_Tdu_Tpr.csv |
| ase_counts_Tdu_2886_3_2_Tdu_Tpr.csv | ase_counts_Tdu_4_2_Tdu_Tpr.csv |
| ase_counts_Tdu_2886_5_2_Tdu_Tpr.csv | ase_counts_Tdu_5_2_Tdu_Tpr.csv |
| ase_counts_Tdu_2886_7_2_Tdu_Tpr.csv | ase_counts_Tdu_6_2_Tdu_Tpr.csv |
| ase_counts_Tpr_2608_3_2_Tdu_Tpr.csv | ase_counts_Tpr_1_2_Tdu_Tpr.csv |
| ase_counts_Tpr_2608_21_2_Tdu_Tpr.csv | ase_counts_Tpr_2_2_Tdu_Tpr.csv |
| ase_counts_Tpr_2608_31_2_Tdu_Tpr.csv | ase_counts_Tpr_3_2_Tdu_Tpr.csv |

Scripts are shown in `count_reads_both.ipynb`

Output:
  - `both_counts_Tdu_1_2_Tdu_Tpr.csv`
  - `both_counts_Tdu_2_2_Tdu_Tpr.csv`
  - `both_counts_Tdu_3_2_Tdu_Tpr.csv`
  - `both_counts_Tdu_4_2_Tdu_Tpr.csv`
  - `both_counts_Tdu_5_2_Tdu_Tpr.csv`
  - `both_counts_Tdu_6_2_Tdu_Tpr.csv`
  - `both_counts_Tpr_1_2_Tdu_Tpr.csv`
  - `both_counts_Tpr_2_2_Tdu_Tpr.csv`
  - `both_counts_Tpr_3_2_Tdu_Tpr.csv`

### 2.2 Merge "both_counts" files
The process of the analysis is shown in Jupyter notebook `merge_both_files.ipynb`.

Output:
  - `both_count_Tdu_Tpr_all_reps_for_Tms.csv`, which will be used for short-liguled T. miscellus analysis
    - ```
      FUSION_ID,Tdu_4,Tdu_5,Tdu_6,Tpr_1,Tpr_2,Tpr_3
      Tpr_TRINITY_DN11257_c2_g1|Tdu_TRINITY_DN16696_c0_g1,106,116,121,103,173,78
      Tpr_TRINITY_DN10844_c2_g7|Tdu_TRINITY_DN25328_c2_g5,177,169,238,204,402,205
      Tpr_TRINITY_DN15383_c4_g16|Tdu_TRINITY_DN14160_c0_g1,43,36,47,21,25,18
      Tpr_TRINITY_DN1451_c0_g1|Tdu_TRINITY_DN16990_c3_g1,80,126,108,141,200,119
      Tpr_TRINITY_DN10853_c1_g4|Tdu_TRINITY_DN21860_c3_g3,809,1113,918,751,1281,700
      Tpr_TRINITY_DN12798_c2_g2|Tdu_TRINITY_DN24179_c2_g3,28,48,39,35,118,55
      Tpr_TRINITY_DN21120_c0_g1|Tdu_TRINITY_DN19044_c2_g2,0,7,2,0,0,0
      Tpr_TRINITY_DN15495_c0_g2|Tdu_TRINITY_DN17403_c2_g1,19,64,44,52,62,33
      Tpr_TRINITY_DN38363_c0_g1|Tdu_TRINITY_DN14954_c0_g1,0,0,0,0,0,0
      ```
  - `both_count_Tdu_Tpr_all_reps_for_Tml.csv`, which will be used for long-liguled T. miscellus analysis
    - ```
      FUSION_ID,Tdu_1,Tdu_2,Tdu_3,Tpr_1,Tpr_2,Tpr_3
      Tpr_TRINITY_DN11257_c2_g1|Tdu_TRINITY_DN16696_c0_g1,92,109,123,103,173,78
      Tpr_TRINITY_DN10844_c2_g7|Tdu_TRINITY_DN25328_c2_g5,157,218,281,204,402,205
      Tpr_TRINITY_DN15383_c4_g16|Tdu_TRINITY_DN14160_c0_g1,36,64,58,21,25,18
      Tpr_TRINITY_DN1451_c0_g1|Tdu_TRINITY_DN16990_c3_g1,96,140,142,141,200,119
      Tpr_TRINITY_DN10853_c1_g4|Tdu_TRINITY_DN21860_c3_g3,773,1099,976,751,1281,700
      Tpr_TRINITY_DN12798_c2_g2|Tdu_TRINITY_DN24179_c2_g3,50,46,72,35,118,55
      Tpr_TRINITY_DN21120_c0_g1|Tdu_TRINITY_DN19044_c2_g2,0,0,9,0,0,0
      Tpr_TRINITY_DN15495_c0_g2|Tdu_TRINITY_DN17403_c2_g1,62,68,114,52,62,33
      Tpr_TRINITY_DN38363_c0_g1|Tdu_TRINITY_DN14954_c0_g1,2,1,1,0,0,0
      ```



