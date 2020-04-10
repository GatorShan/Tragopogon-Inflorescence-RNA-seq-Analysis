# Perform additive gene expression analysis for filtered 5,400 loci
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

Results:

| Expression pattern | No. of loci |
| -- | -- |
| DE | 960 |
| non-DE | 4,095 |
| Total | 5,055 |
