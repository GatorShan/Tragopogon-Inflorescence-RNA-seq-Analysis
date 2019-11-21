# Align polyploids reads to diploid SuperTranscripts and identify homeolog expression bias
## 1. Description
Reads from both short-liguled *T. miscellus* (population 2604) and long-liguled *T. miscellus* (population 2605) were mapped to the diploid SuperTranscripts; homeolog expression bias is detected by using Bayesian Poisson-Gamma model (method as described from Boatwright et al., 2018)

## 2. Aligning clean reads from polyploids to diploid SuperTranscripts
Input:
  - trimmed reads from section `Reads_Trimming` was used
  - e.g. `Tms_2604_24_R1_crop_clean.fastq` and `Tms_2604_24_R2_crop_clean.fastq`
  - e.g. `Tml_2605_9_R1_crop_clean.fastq` and `Tml_2605_9_R2_crop_clean.fastq`

Script:
  - `bowtie2/2.3.5.1` was used for mapping
  - script is `Bowtie2_two_polyploids_reads_parents_ST_V1.0.sh`

Output:
  - e.g. `Tml_2605_24_reads_Tdu_ST_V1.sam` and `Tml_2605_24_reads_Tpr_ST_V1.sam`
  - e.g. `Tms_2604_24_reads_Tdu_ST_V1.sam` and `Tms_2604_24_reads_Tpr_ST_V1.sam`
  - **overall alignment rate is ~77%**
  ```
  76.48% overall alignment rate
  76.75% overall alignment rate
  76.55% overall alignment rate
  76.24% overall alignment rate
  77.06% overall alignment rate
  76.93% overall alignment rate
  77.61% overall alignment rate
  78.17% overall alignment rate
  76.90% overall alignment rate
  77.54% overall alignment rate
  77.47% overall alignment rate
  77.92% overall alignment rate
  ```

## 3. Filter the sam files
Script `Polyploid_alignment_filter_V1.sh` was used. The process comprises:
  - changing file format from SAM to BAM
  - Sorting BAM file by genomic coordinates
  - Filtering uniquely mapping reads
  - Convert BAM file to SAM file

Input:
  - e.g. `Tml_2605_24_reads_Tdu_ST_V1.sam` and `Tml_2605_24_reads_Tpr_ST_V1.sam`
  - e.g. `Tms_2604_24_reads_Tdu_ST_V1.sam` and `Tms_2604_24_reads_Tpr_ST_V1.sam`

Output:
  - e.g. `Tml_2605_24_reads_Tdu_ST_V1_uniq.sam` and `Tml_2605_24_reads_Tpr_ST_V1_uniq.sam`
  - e.g. `Tms_2604_24_reads_Tdu_ST_V1_uniq.sam` and `Tms_2604_24_reads_Tpr_ST_V1_uniq.sam`

```
14G Nov 19 11:43 Tml_2605_24_reads_Tdu_ST_V1.sam
13G Nov 19 14:39 Tml_2605_24_reads_Tdu_ST_V1_uniq.sam
14G Nov 19 13:51 Tml_2605_24_reads_Tpr_ST_V1.sam
14G Nov 19 14:48 Tml_2605_24_reads_Tpr_ST_V1_uniq.sam
13G Nov 19 12:03 Tml_2605_42_reads_Tdu_ST_V1.sam
13G Nov 19 14:58 Tml_2605_42_reads_Tdu_ST_V1_uniq.sam
14G Nov 19 14:12 Tml_2605_42_reads_Tpr_ST_V1.sam
13G Nov 19 15:07 Tml_2605_42_reads_Tpr_ST_V1_uniq.sam
15G Nov 19 11:22 Tml_2605_9_reads_Tdu_ST_V1.sam
14G Nov 19 15:18 Tml_2605_9_reads_Tdu_ST_V1_uniq.sam
15G Nov 19 13:30 Tml_2605_9_reads_Tpr_ST_V1.sam
14G Nov 19 15:29 Tml_2605_9_reads_Tpr_ST_V1_uniq.sam
14G Nov 19 10:19 Tms_2604_24_reads_Tdu_ST_V1.sam
13G Nov 19 15:38 Tms_2604_24_reads_Tdu_ST_V1_uniq.sam
14G Nov 19 12:25 Tms_2604_24_reads_Tpr_ST_V1.sam
13G Nov 19 15:48 Tms_2604_24_reads_Tpr_ST_V1_uniq.sam
13G Nov 19 10:39 Tms_2604_43_reads_Tdu_ST_V1.sam
13G Nov 19 15:58 Tms_2604_43_reads_Tdu_ST_V1_uniq.sam
13G Nov 19 12:45 Tms_2604_43_reads_Tpr_ST_V1.sam
13G Nov 19 16:08 Tms_2604_43_reads_Tpr_ST_V1_uniq.sam
15G Nov 19 11:00 Tms_2604_48_reads_Tdu_ST_V1.sam
14G Nov 19 16:19 Tms_2604_48_reads_Tdu_ST_V1_uniq.sam
15G Nov 19 13:07 Tms_2604_48_reads_Tpr_ST_V1.sam
14G Nov 19 16:30 Tms_2604_48_reads_Tpr_ST_V1_uniq.sam
```