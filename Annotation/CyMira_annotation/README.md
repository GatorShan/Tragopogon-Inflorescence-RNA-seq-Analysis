## Identify orthologous pairs that are organelle-targeted and have direct cytonuclear interactions

[CyMIRA](http://cymira.colostate.edu/) is a detailed classification of genes involved in cytonuclear interactions in Arabidopsis thaliana. The AGI identifier of certain groups of genes (either organelle-targeting or showing direct cytonuclear interaction) are download from the [here](http://cymira.colostate.edu/). The associated fasta files are obtained through bulk download on [TAIR](https://www.arabidopsis.org/tools/bulk/sequences/index.jsp) (Dataset: Araport 11 transcripts; get one sequence per locus).

### 1. Extract SuperTranscript fasta files (from Tdu) for those 4,957 orthologous pairs used in homeolog-specific expression comparison between Tms and Tml

The information of those orthologous pairs can be found [here](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/tree/master/Polyploid_alignment/Homeolog-specific-expression_Tms-Tml_Compare)

Script `Extract_fasta_seq_V2.ipynb` was used. Output: `SuperTranscript_Tdu_4957.fasta`.

### 2. Blastn analysis
#### 2.1 Mitochondria interaction

  - Query: 534* At mito-interaction genes from Forsythe et al. (2019). * for unknown reason there is only 534, instead of 535, genes
  - DB: `SuperTranscript_Tdu_4957.fasta`

Script `blastn_mito-interaction_Tdu_4957.V1.sh`. Output: `blastn_Mito-interaction_TduSuperTranscripts_E10_I85_P50.txt`. **No output**

Script `blastn_mito-interaction_Tdu_4957.V2.sh`. Output: `blastn_Mito-interaction_TduSuperTranscripts_E10_I85_P30.txt`. **No output**

Script `blastn_mito-interaction_Tdu_4957.V3.sh`. Output: `blastn_Mito-interaction_TduSuperTranscripts_E10_I85.txt`. **No output**

Script `blastn_mito-interaction_Tdu_4957.V4.sh`. Output: `blastn_Mito-interaction_TduSuperTranscripts_E5_I80.txt`. 4 hits but short alignment length.
```
AT2G04860.1     TRINITY_DN20841_c3_g1   100.000 28      0       0       379     406     671     644     3.29e-06        52.8
AT2G04860.1     TRINITY_DN20878_c1_g10  100.000 28      0       0       380     407     33      60      3.29e-06        52.8
AT2G17210.1     TRINITY_DN23916_c7_g1   100.000 33      0       0       598     630     983     951     5.65e-09        62.1
AT2G41080.1     TRINITY_DN25045_c0_g4   84.615  52      8       0       392     443     1687    1636    3.00e-06        52.8
```

#### 2.2 Plastid interaction

  - Query: 293 At plastid-interaction genes from Forsythe et al. (2019).
  - DB: `SuperTranscript_Tdu_4957.fasta`

Script `blastn_plastid-interaction_Tdu_4957.V1.sh`. Output: `blastn_Plastid-interaction_TduSuperTranscripts_E10_I85_P50.txt`. **No output**

Script `blastn_plastid-interaction_Tdu_4957.V2.sh`. Output: `blastn_Plastid-interaction_TduSuperTranscripts_E10_I85_P30.txt`. **No output**

Script `blastn_plastid-interaction_Tdu_4957.V3.sh`. Output: `blastn_Plastid-interaction_TduSuperTranscripts_E10_I85.txt`. **No output**

#### 2.3 Organelle-targeting

  - Query: 4,267* At organelle-targeting genes from Forsythe et al. (2019). * for unknown reason there is only 4,267, instead of 4,268, genes
  - DB: `SuperTranscript_Tdu_4957.fasta`

Script `blastn_organelle-targeting_Tdu_4957.V1.sh`. Output: `blastn_organelle-targeting_TduSuperTranscripts_E10_I85_P50.txt`. **No output**

Script `blastn_organelle-targeting_Tdu_4957.V2.sh`. Output: `blastn_organelle-targeting_TduSuperTranscripts_E5_I80_P30.txt`. 2 hits
```
AT3G25860.1     TRINITY_DN10960_c0_g1   81.947  637     113     2       980     1615    1077    442     2.00e-152       538
AT2G07696.1     TRINITY_DN25553_c4_g2   81.746  504     89      3       400     901     1723    1221    1.54e-116       418
```
  
  
  
  
  
  

