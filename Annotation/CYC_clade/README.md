# Homologs of CYC/TB1 clade genes in supertranscript
We are using the 13 putative CYC/TB1 clade genes from Liu et al., (2020) as query to identify homologs in Tdu supertranscripts; then we will assess those genes' expression profiles in polyploids and diploids.

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

Unique homologs of CYC/TB1 clade genes (output `TduST_CYC_ortholog.txt`):
```
TRINITY_DN19548_c1_g2
TRINITY_DN18324_c0_g2
TRINITY_DN18324_c0_g4
TRINITY_DN25185_c2_g1
TRINITY_DN19040_c6_g3
TRINITY_DN9954_c0_g1
```

## 3. Expression profiles of those SuperTranscript orthologs
### 3.1 DE analysis between Tdu and Tpr

**Expression profiles of those CYC2 homologs ** extracted from file `DESeq2_count_matrix_Tdu_Tpr.csv`.
```
FUSION_ID,Tdu_1,Tdu_2,Tdu_3,Tdu_4,Tdu_5,Tdu_6,Tpr_1,Tpr_2,Tpr_3

Tpr_TRINITY_DN30478_c0_g1|Tdu_TRINITY_DN19548_c1_g2,3,1,2,1,10,3,2,6,1
Tpr_TRINITY_DN10225_c1_g2|Tdu_TRINITY_DN18324_c0_g2,8,9,17,4,7,3,4,5,5
Tpr_TRINITY_DN10615_c2_g5|Tdu_TRINITY_DN18324_c0_g4,12,32,46,18,43,24,62,100,45
Tpr_TRINITY_DN10418_c1_g5|Tdu_TRINITY_DN25185_c2_g1,15,19,22,32,36,20,43,73,60
Tpr_TRINITY_DN10615_c2_g2|Tdu_TRINITY_DN19040_c6_g3,2,6,2,2,4,0,2,2,9
Tpr_TRINITY_DN8293_c0_g1|Tdu_TRINITY_DN9954_c0_g1,0,0,0,1,0,0,4,1,0
```


**Two supertranscripts were highly expressed in Tpr**; from file `DESeq2_DE_higher_Tpr.txt`
```
Tpr_TRINITY_DN10615_c2_g5|Tdu_TRINITY_DN18324_c0_g4	41.3422228500312	-1.37404748450446	0.29782163086959	-4.61407803773289	3.94844061798986e-06	7.56326967574314e-05
Tpr_TRINITY_DN10418_c1_g5|Tdu_TRINITY_DN25185_c2_g1	36.6950878553297	-1.39883165529803	0.33153835151915	-4.22133195580499	2.42862973711084e-05	0.000371238337908864
```

**Three supertranscripts were equally expressed between Tdu and Tpr**; from file `DESeq2_none-DE_Tdu_Tpr.txt`
```
Tpr_TRINITY_DN10225_c1_g2|Tdu_TRINITY_DN18324_c0_g2	6.4327432085505	0.391271667732685	0.519798138044234	0.751176433179099	0.452546481271371	0.6749111835721
Tpr_TRINITY_DN30478_c0_g1|Tdu_TRINITY_DN19548_c1_g2	2.9605415514574	0.0574434272204818	0.630552472559964	0.0904415143991211	0.92793636812809	0.970566888446998
Tpr_TRINITY_DN10615_c2_g2|Tdu_TRINITY_DN19040_c6_g3	3.46816116463934	-0.745088881589372	0.630472326698205	-1.1853396394098	0.235883186749713	0.463739613028251
```

**No supertranscript was highly expressed in Tdu**
