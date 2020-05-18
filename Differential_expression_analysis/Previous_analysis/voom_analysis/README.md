# Differential expression (DE) analysis
## 1. Description
This step is used to identify DE loci between two diploid parents.

Two rounds of comparison between Tdu and Tpr were performed:
  - Between Tdu (2613, Pullman) and Tpr (2608, Moscow)*, which are parents of long-liguled T. miscellus
  - Between Tdu (2886, Moscow) and Tpr (2608, Moscow), which are parents of short-liguled T. miscellus
  - *: Tpr from Pullman are not available (maybe extinct)

## 2. Generate files containing reads counts data

"Counts were taken from reads mapped to both of the COREs between orthologous pairs. Thus counts are taken from highly similar regions of the orthologs to account for differences in length between orthologous pairs resulting from incompletely reconstructed orthologs" -- Boatwright et al., 2018

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

## 3. Identify DE between T.dubius and T. pratensis at Moscow (parents of short-liguled T. miscellus)
The script is shown in a Jupyter notebook **`Tdu_Tpr_voom_Tms/voom_Tdu_Tpr_for_Tms_min10_3_rep.ipynb`.**
  - Use voom to transform count data to log2(counts per million reads) (a.k.a. logCPM)
  - Fit logCPM to a linear model using function lmFit
  - Empirical Bayes Statistics For Differential Expression (eBayes), given a linear model fit ==> overall_model
    - `fit=lmFit(voom, design)` and `overall_model <- eBayes(fit)`
    - output: `DE_overall_model_min10_3rep.txt`
  - contrast.fit: given a linear model fit to microarray data, compute estimated coefficients and standard errors for a given set of contrasts
    - `fit2 = contrasts.fit(fit, contrast.matrix)` and `fit2 = eBayes(fit2)`
    - output: **`DE_Tdu_Tpr_min10_3rep.txt`, which contains 8,021 orthologs**

Input:
```
both_counts_Tdu_4_2_Tdu_Tpr.csv   Tdu       Tdu_4
both_counts_Tdu_5_2_Tdu_Tpr.csv   Tdu       Tdu_5
both_counts_Tdu_6_2_Tdu_Tpr.csv   Tdu       Tdu_6
both_counts_Tpr_1_2_Tdu_Tpr.csv   Tpr       Tpr_1
both_counts_Tpr_2_2_Tdu_Tpr.csv   Tpr       Tpr_2
both_counts_Tpr_3_2_Tdu_Tpr.csv   Tpr       Tpr_3
```

Output:
  - `boxplot_log-CPM.pdf` in `voom_Tdu_Tpr_for_Tms_min10_3_rep.ipynb`
  - `voom_expression_values_min10_3rep.txt`
  - `residual_std_dev.pdf` in `voom_Tdu_Tpr_for_Tms_min10_3_rep.ipynb`
  - `DE_overall_model_min10_3rep.txt`
  - **`DE_Tdu_Tpr_min10_3rep.txt`, which contains 8,021 orthologs**
  
Different filtering methods have been compared

| Filtering methods | DE orthologs remained |
| -- | -- |
| keep <- rowSums(cpm(d) > cpm(10,mean(d$samples$lib.size))[1]) >= 3 | 8,021 |
| keep <- rowSums(cpm(d) > cpm(10,mean(d$samples$lib.size))[1]) >= 6 | 6,142 |
| keep <- rowSums(cpm(d) > cpm(5,mean(d$samples$lib.size))[1]) >= 6 | 7,366 |

**Script `ExpComp_DE_Tdu_Tpr.ipynb` was used to classify DE orthologs into differentially expressed and not differentially expressed**

Input: `DE_Tdu_Tpr_min10_3rep.txt`, which contains 8,021 loci

Output_1: **`Tdu_Tpr_voom_Tms/DE_Tdu_Tpr_not_sig_loci.txt`, which contains 6,938 loci**

Output_2: **`Tdu_Tpr_voom_Tms/DE_Tdu_Tpr_sig_loci.txt`, which contains 1,083 loci**

## 4. Taking parental diploids' expression level into consideration, re-analyze homeolog-specific expression in Tms (short-liguled T. miscellus)

### 4.1 Isolate DE orthologs showing unbiased mapping and compare Tdu and Tpr expression in those orthologs
Among the 8,021 orthologs with differential expression profiles, not all of them showed unbiased mapping; in addition, how many of them are equally expressed in two diploid parents? How many showed higher expression in Tdu? And how about higher expression in Tpr?

Scripts are in Jupyter notebook **`Tdu_Tpr_voom_Tms/filter_DE_Tdu_Tpr_for_Tms.ipynb`**.

Input: `DE_Tdu_Tpr_min10_3rep.txt`, which contains 8,021 orthologs. Among these, **3,704 orthologs showed unbiased mapping and have homeolog-specific expression profiles**.

Output:
  - `DE_Tdu_Tpr_filtered.txt`, contains 3,704 unbiased mapping othologs and have homeolog-specific expression profiles
  - `DE_Tdu_Tpr_filtered_not_sig_loci.txt`, contains **3,185 orthologs that showed no expression difference betweeen Tdu and Tpr**
  - `DE_Tdu_Tpr_filtered_sig_loci_Tdu_higher.txt`, contains **242 orthologs with higher expression in Tdu**
  - `DE_Tdu_Tpr_filtered_sig_loci_Tpr_higher.txt`, contains **277 orthologs with higher expression in Tpr**

### 4.2 Classify DE orthologs into different homeolog-specific expression categories

Script **`Tdu_Tpr_voom_Tms/DE_Tdu_Tpr_for_Tms_homeolog-bias_exp.ipynb`** was used.

Input1: `DE_Tdu_Tpr_filtered_not_sig_loci.txt`

Output1:
  - `DE_Tdu_Tpr_filtered_not_sig_loci_unbias.txt`, contains 2,506 orthologs
  - `DE_Tdu_Tpr_filtered_not_sig_loci_biasTdu.txt`, contains 304 orthologs
  - `DE_Tdu_Tpr_filtered_not_sig_loci_biasTpr.txt`, contains 375 orthologs

Input2: `DE_Tdu_Tpr_filtered_sig_loci_Tdu_higher.txt`

Output2:
  - `DE_Tdu_Tpr_filtered_sig_loci_Tdu_higher_unbias.txt`, contains 182 orthologs
  - `DE_Tdu_Tpr_filtered_sig_loci_Tdu_higher_biasTdu.txt`, contains 31 orthologs
  - `DE_Tdu_Tpr_filtered_sig_loci_Tdu_higher_biasTpr.txt`, contains 29 orthologs
  
Input3: `DE_Tdu_Tpr_filtered_sig_loci_Tpr_higher.txt`

Output3:
  - `DE_Tdu_Tpr_filtered_sig_loci_Tpr_higher_unbias.txt`, contains 189 orthologs
  - `DE_Tdu_Tpr_filtered_sig_loci_Tpr_higher_biasTdu.txt`, contains 25 orthologs
  - `DE_Tdu_Tpr_filtered_sig_loci_Tpr_higher_biasTpr.txt`, contains 63 orthologs


|    | No homeolog expression bias | Homeolog expression bias to Tdu | Homeolog expression bias to Tpr | Sum |
| -- | -- | -- | -- | -- |
| Tdu = Tpr | 2506 | 304 | 375 | 3,185 |
| Tdu > Tpr | 182 | 31 | 29 | 242 |
| Tdu < Tpr | 189| 25 | 63 | 277 |

## 5. Identify DE between T.dubius (Pullman) and T. pratensis (Moscow) (parents of long-liguled T. miscellus)
The script is shown in a Jupyter notebook **`Tdu_Tpr_voom_Tml/voom_Tdu_Tpr_for_Tml_min10_3_rep.ipynb`.**

Input:
```
both_counts_Tdu_1_2_Tdu_Tpr.csv   Tdu       Tdu_1
both_counts_Tdu_2_2_Tdu_Tpr.csv   Tdu       Tdu_2
both_counts_Tdu_3_2_Tdu_Tpr.csv   Tdu       Tdu_3
both_counts_Tpr_1_2_Tdu_Tpr.csv   Tpr       Tpr_1
both_counts_Tpr_2_2_Tdu_Tpr.csv   Tpr       Tpr_2
both_counts_Tpr_3_2_Tdu_Tpr.csv   Tpr       Tpr_3
```

Output:
  - `boxplot_log-CPM.pdf` in `voom_Tdu_Tpr_for_Tml_min10_3_rep.ipynb`
  - `voom_expression_values_min10_3rep.txt`
  - `residual_std_dev.pdf` in `voom_Tdu_Tpr_for_Tml_min10_3_rep.ipynb`
  - `DE_overall_model_min10_3rep.txt`
  - **`DE_Tdu_Tpr_min10_3rep.txt`, which contains 8,248 orthologs**
  
**Script `ExpComp_DE_Tdu_Tpr.ipynb` was used to classify DE orthologs into differentially expressed and not differentially expressed**

Input: `DE_Tdu_Tpr_min10_3rep.txt`, which contains 8,248 loci

Output_1: **`Tdu_Tpr_voom_Tml/DE_Tdu_Tpr_not_sig_loci.txt`, which contains 6,886 loci**

Output_2: **`Tdu_Tpr_voom_Tml/DE_Tdu_Tpr_sig_loci.txt`, which contains 1,362 loci**

## 6. Taking parental diploids' expression level into consideration, re-analyze homeolog-specific expression in Tml (long-liguled T. miscellus)

### 6.1 Isolate DE orthologs showing unbiased mapping and compare Tdu and Tpr expression in those orthologs
Among the 8,248 orthologs with differential expression profiles, not all of them showed unbiased mapping; in addition, how many of them are equally expressed in two diploid parents? How many showed higher expression in Tdu? And how about higher expression in Tpr?

Scripts are in Jupyter notebook **`Tdu_Tpr_voom_Tml/filter_DE_Tdu_Tpr_for_Tml.ipynb`**.

Input: `DE_Tdu_Tpr_min10_3rep.txt`, which contains 8,248 orthologs. Among these, **3,817 orthologs showed unbiased mapping and have homeolog-specific expression profiles**.

Output:
  - `DE_Tdu_Tpr_filtered.txt`, contains 3,817 unbiased mapping othologs and have homeolog-specific expression profiles
  - `DE_Tdu_Tpr_filtered_not_sig_loci.txt`, contains **3,162 orthologs that showed no expression difference betweeen Tdu and Tpr**
  - `DE_Tdu_Tpr_filtered_sig_loci_Tdu_higher.txt`, contains **278 orthologs with higher expression in Tdu**
  - `DE_Tdu_Tpr_filtered_sig_loci_Tpr_higher.txt`, contains **377 orthologs with higher expression in Tpr**

### 6.2 Classify DE orthologs into different homeolog-specific expression categories

Script **`Tdu_Tpr_voom_Tml/DE_Tdu_Tpr_for_Tml_homeolog-bias_exp.ipynb`** was used.

Input1: `DE_Tdu_Tpr_filtered_not_sig_loci.txt`

Output1:
  - `DE_Tdu_Tpr_filtered_not_sig_loci_unbias.txt`, contains 2,531 orthologs
  - `DE_Tdu_Tpr_filtered_not_sig_loci_biasTdu.txt`, contains 281 orthologs
  - `DE_Tdu_Tpr_filtered_not_sig_loci_biasTpr.txt`, contains 350 orthologs

Input2: `DE_Tdu_Tpr_filtered_sig_loci_Tdu_higher.txt`

Output2:
  - `DE_Tdu_Tpr_filtered_sig_loci_Tdu_higher_unbias.txt`, contains 214 orthologs
  - `DE_Tdu_Tpr_filtered_sig_loci_Tdu_higher_biasTdu.txt`, contains 33 orthologs
  - `DE_Tdu_Tpr_filtered_sig_loci_Tdu_higher_biasTpr.txt`, contains 31 orthologs
  
Input3: `DE_Tdu_Tpr_filtered_sig_loci_Tpr_higher.txt`

Output3:
  - `DE_Tdu_Tpr_filtered_sig_loci_Tpr_higher_unbias.txt`, contains 274 orthologs
  - `DE_Tdu_Tpr_filtered_sig_loci_Tpr_higher_biasTdu.txt`, contains 27 orthologs
  - `DE_Tdu_Tpr_filtered_sig_loci_Tpr_higher_biasTpr.txt`, contains 76 orthologs


|    | No homeolog expression bias | Homeolog expression bias to Tdu | Homeolog expression bias to Tpr | Sum |
| -- | -- | -- | -- | -- |
| Tdu = Tpr | 2,531 | 281 | 350 | 3,162 |
| Tdu > Tpr | 214 | 33 | 31 | 278 |
| Tdu < Tpr | 274 | 27 | 76 | 377 |
