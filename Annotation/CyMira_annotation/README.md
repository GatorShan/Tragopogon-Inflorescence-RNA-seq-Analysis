## Identify orthologous pairs that are organelle-targeted and have direct cytonuclear interactions


### 1. Extract SuperTranscript fasta files (from Tdu) for those 4,957 orthologous pairs used in homeolog-specific expression comparison between Tms and Tml

The information of those orthologous pairs can be found [here](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/tree/master/Polyploid_alignment/Homeolog-specific-expression_Tms-Tml_Compare)

Script `Extract_fasta_seq_V2.ipynb` was used. Output: `SuperTranscript_Tdu_4957.fasta`.

### 2. Blastn analysis
#### 2.1 Mitochondria interaction

Script `blastn_mito-interaction_Tdu_4957.V1.sh` was used.
  - Query: 534* At mito-interaction genes from Forsythe et al. (2019). * for unknown reason there is only 534, instead of 535, genes
  - DB: `SuperTranscript_Tdu_4957.fasta`

Output: `blastn_Mito-interaction_TduSuperTranscripts_E10_I85_P50.txt`.

