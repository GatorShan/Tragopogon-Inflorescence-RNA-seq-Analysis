# Orthologs of CYC/TB1 clade genes in supertranscript
We are using the 13 putative CYC/TB1 clade genes from Liu et al., (2020) as query to identify orthologs in Tdu supertranscripts; then we will assess those genes' expression files in polyploids and diploids.

## 1. Extract SuperTranscript fasta files (from Tdu) for those 11,863 orthologous pairs used in gene expression analysis
Script `Extract_fasta_seq_V1.ipynb` was used.

Output: `SuperTranscript_Tdu_11863.fasta`

## 2. Blastn analysis
Script `blastn_TduCYC_TduSupertranscripts.V1.sh` was used.
  - Query: 13 putative CYC/TB1 clade genes from Liu et al., (2020)
  - Database: `SuperTranscript_Tdu_11863.fasta`

Output: `blastn_TduCYC_TduSuperTranscripts_E10_I85_P50.txt`
```
TragDub01087    TRINITY_DN19548_c1_g2   97.888  947     0       1       852     1778    819     1765    0.0     1620
TragDub04045    TRINITY_DN18324_c0_g2   100.000 635     0       0       1       635     3276    2642    0.0     1173
TragDub04046    TRINITY_DN18324_c0_g4   99.881  842     1       0       1       842     1192    351     0.0     1550
TragDub04049    TRINITY_DN25185_c2_g1   100.000 950     0       0       1       950     264     1213    0.0     1755
TragDub06533    TRINITY_DN19040_c6_g3   99.220  641     1       1       7       647     220     856     0.0     1153
TragDub15759    TRINITY_DN9954_c0_g1    99.907  1072    1       0       70      1141    1       1072    0.0     1975
TragDub29017    TRINITY_DN18324_c0_g2   100.000 644     0       0       1       644     4129    3486    0.0     1190
```

Unique orthologs of CYC/TB1 clade genes (output `TduST_CYC_ortholog.txt`):
```
TRINITY_DN19548_c1_g2
TRINITY_DN18324_c0_g2
TRINITY_DN18324_c0_g4
TRINITY_DN25185_c2_g1
TRINITY_DN19040_c6_g3
TRINITY_DN9954_c0_g1
```





