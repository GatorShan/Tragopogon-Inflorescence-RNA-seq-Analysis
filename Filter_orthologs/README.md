# Filtering orthologous pairs with biased mapping
## 1. Description
Tdu and Tpr reads were mapping back to the supertranscripts. For example, if Tdu reads are biased mapping to a Tpr supertranscript, this Tpr supertranscript will be filtered out.

![Filtering orthologs](https://cdn1.imggmi.com/uploads/2019/11/1/a7814143cb5ebd1c8868877ba7a0d737-full.png)

## 2. Mapping diploid reads to Tdu and Tpr supertranscripts
### 2.1 Using Bowtie2 for reads mapping
Method: Bowtie2; each replicate will be mapped to the reference separately

Script:
  - `Bowtie2_two_diploids_reads_parents_ST_V1.0.sh`

Output (e.g.):
  - `Tdu_2613_11_reads_Tdu_ST_V1.sam`
  - `Tdu_2613_12_reads_Tdu_ST_V1.sam`
  - `Tdu_2613_41_reads_Tdu_ST_V1.sam`

### 2.2 Identify unique mappings, which will be used for downstream analysis
Method is based on the description [here](https://hbctraining.github.io/Intro-to-ChIPseq/lessons/03_align_and_filtering.html)

Script `Diploid_alignment_filter_V4.sh` was used.

Output (e.g.):
  - `Tdu_2613_11_reads_Tdu_ST_V1_uniq.sam`
  - `Tdu_2613_12_reads_Tdu_ST_V1_uniq.sam`
  - `Tdu_2613_41_reads_Tdu_ST_V1_uniq.sam`







