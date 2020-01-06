# Raw reads were cleaned before performing downstream analysis
## 1. Description
This section includes the following steps:
  - change the name of the raw fastq files
  - Remove adaptor sequences, if present
  - Trim reads to get rid of low quality bases
  - Remove rRNA reads (only reads from mRNA is supposed to be remained)

## 2. Trimming reads from diploids
### 2.1 Rename fastq files
Script `NameChange.py` was used.

Example input:
  - `Sample1-2608-3-bc2-L03_S17_L003_R1_001.fastq`
  - `Sample4-2613-11-bc6-L03_S20_L003_R1_001.fastq`

Example output:
  - `Tpr_2608_3_R1.fastq`
  - `Tdu_2613_11_R1.fastq`

### 2.2 Remove adaptor sequences
Cutadapt/2.1 was used with scripts `AdaptorTrimming_R1_1.0.sh` and `AdaptorTrimming_R2_1.0.sh`. About **3%** reads have adapter(s) and about 99% of basepairs were left after filtering.

Example input:
  - `Tpr_2608_3_R1.fastq`
  - `Tdu_2613_11_R1.fastq`

Example output (`/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/AdapterTrim`):
  - `Tpr_2608_3_R1_adapter_trimmed.fastq`
  - `Tdu_2613_11_R1_adapter_trimmed.fastq `

### 2.3 Remove low quality bases by using Trimmomatic
Trimmomatic/0.36 was used with script `TrimmomaticCrop_1.0.sh`. **About 93%** read pairs have both R1 and R2 survived.

Example output (`/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/TrimmomaticCrop`):
  - `Tpr_2608_3_R1_trimmomatic-crop_paired.fastq`
  - `Tpr_2608_3_R1_trimmomatic-crop_unpaired.fastq`
  - `Tpr_2608_3_R2_trimmomatic-crop_paired.fastq`
  - `Tpr_2608_3_R2_trimmomatic-crop_unpaired.fastq`

### 2.4 Remove rRNA reads
sortmerna/2.1 was used with script `Remove_rRNA.2.1.sh`. **About 1%** reads are rRNA-originated, which have been filtered out.

Example output (`/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/rRNA_Filter/Crop_clean`):
  - `Tdu_2613_11_R1_crop_clean.fastq`
  - `Tdu_2613_11_R2_crop_clean.fastq`

## 3. Trimming reads from polyploids
### 3.1 Statistics of the raw reads

| Name from sequencer | Rename | Description | Index primer No. |
| -- | -- | -- | -- |
| T1 | Tml_2605_9 | Long-liguled T. miscellus from Pullman | 5 |
| T2 | Tms_2604_43 | Short-liguled T. miscellus from Moscow | 6 |
| T3 | Tms_2604_24 | Short-liguled T. miscellus from Moscow | 7 |
| T4 | Tml_2605_24 | Long-liguled T. miscellus from Pullman | 8 |
| T5 | Tms_2604_48 | Short-liguled T. miscellus from Moscow | 9 |
| T6 | Tml_2605_42 | Long-liguled T. miscellus from Pullman | 12 |

### 3.2 Remove adaptor sequence from reads
Read1 and Read2 were processed separately; scripts `AdaptorTrimming_R1_Poly_V1.sh` and `AdaptorTrimming_R2_Poly_V1.sh` were used to remove adaptors from R1 and R2 reads, respectively. The fastq file names were also changed at this step.

Cutadapt/2.1 was used.

```
cutadapt \
			--error-rate 0.1 \
			--times 1 \
			--overlap 5 \
			--minimum-length 0 \
			--adapter AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTA \
			--front GTGACTGGAGTTCAGACGTGTGCTCTTCCGATCT \
			--quality-base 33 \
			--output ${OUT}/Tml_2605_9_R2_adapter_trimmed.fastq \
			${OUT}/${SEQREP}_R2.fastq.gz
```

Output:
  - overall **about 0.5% reads with adapters**
  - e.g. `Tms_2604_24_R1_adapter_trimmed.fastq`
  - e.g. `Tms_2604_24_R2_adapter_trimmed.fastq`
  - Reads with adapters: `grep "Reads with adapters" AdaptorTrimming_R1_Poly_V1_44198131.out`
    ```
    Reads with adapters:                   217,924 (0.8%)
    Reads with adapters:                   197,689 (0.8%)
    Reads with adapters:                   129,024 (0.5%)
    Reads with adapters:                   134,401 (0.5%)
    Reads with adapters:                    77,902 (0.3%)
    Reads with adapters:                   116,780 (0.5%)
    ```
  - `grep "Reads with adapters" AdaptorTrimming_R2_Poly_V1_44199652.out`
    ```
    Reads with adapters:                   140,747 (0.5%)
    Reads with adapters:                   129,975 (0.5%)
    Reads with adapters:                   111,835 (0.4%)
    Reads with adapters:                   119,766 (0.4%)
    Reads with adapters:                    74,434 (0.3%)
    Reads with adapters:                    93,509 (0.4%)
    ```

### 3.3 Remove low quality bases by using Trimmomatic
trimmomatic/0.36 was used; script `TrimmomaticCrop_Poly_1.0.sh` was used.

```
trimmomatic \
    PE \
    -threads 4 \
    -phred33 \
    ${IN}/Tms_${Pop}_${Rep}_R1_adapter_trimmed.fastq ${IN}/Tms_${Pop}_${Rep}_R2_adapter_trimmed.fastq \
    ${OUT}/Tms_${Pop}_${Rep}_R1_trimmomatic-crop_paired.fastq ${OUT}/Tms_${Pop}_${Rep}_R1_trimmomatic-crop_unpaired.fastq \
    ${OUT}/Tms_${Pop}_${Rep}_R2_trimmomatic-crop_paired.fastq ${OUT}/Tms_${Pop}_${Rep}_R2_trimmomatic-crop_unpaired.fastq \
    HEADCROP:10 \
    LEADING:3 \
    TRAILING:3 \
    SLIDINGWINDOW:4:15 \
    MINLEN:60
```

Output: about 85% reads both survived. `grep "Both Surviving" TrimmomaticCrop_Poly_1.0_44222322.error`
  - e.g. `Tml_2605_24_R1_trimmomatic-crop_paired.fastq` and `Tml_2605_24_R2_trimmomatic-crop_paired.fastq`
  - e.g. `Tml_2605_24_R1_trimmomatic-crop_unpaired.fastq` and `Tml_2605_24_R2_trimmomatic-crop_unpaired.fastq`

```
Input Read Pairs: 25875630 Both Surviving: 22081317 (85.34%) Forward Only Surviving: 1909473 (7.38%) Reverse Only Surviving: 656407 (2.54%) Dropped: 1228433 (4.75%)
Input Read Pairs: 25583468 Both Surviving: 21956619 (85.82%) Forward Only Surviving: 1866951 (7.30%) Reverse Only Surviving: 668913 (2.61%) Dropped: 1090985 (4.26%)
Input Read Pairs: 27910493 Both Surviving: 23594224 (84.54%) Forward Only Surviving: 2320532 (8.31%) Reverse Only Surviving: 712613 (2.55%) Dropped: 1283124 (4.60%)
Input Read Pairs: 29023629 Both Surviving: 24456695 (84.26%) Forward Only Surviving: 2668389 (9.19%) Reverse Only Surviving: 689323 (2.38%) Dropped: 1209222 (4.17%)
Input Read Pairs: 27362115 Both Surviving: 22973097 (83.96%) Forward Only Surviving: 1970525 (7.20%) Reverse Only Surviving: 759902 (2.78%) Dropped: 1658591 (6.06%)
Input Read Pairs: 25286876 Both Surviving: 21403388 (84.64%) Forward Only Surviving: 2153523 (8.52%) Reverse Only Surviving: 620456 (2.45%) Dropped: 1109509 (4.39%)
```

### 3.4 Remove reads with rRNA sequences
Script `Remove_rRNA_Poly_V1.sh` was used; `sortmerna/2.1` was used.

Reference `Tdu_18S-26S_rRNA.fasta`
  - `>KT179662.1 Tragopogon dubius voucher Steele 1291 18S ribosomal RNA gene, partial sequence`
  - `>AF036493.1 Tragopogon dubius large subunit 26S ribosomal RNA gene, partial sequence`

Output:
  - e.g. `Tms_2604_24_R1_crop_clean.fastq` and `Tms_2604_24_R2_crop_clean.fastq`
  - e.g. `Tml_2605_9_R1_crop_clean.fastq` and `Tml_2605_9_R2_crop_clean.fastq`

About 2-4% reads are derived from rRNA
```
Tml_2605_24_crop_rRNA_reads.log:    Total reads passing E-value threshold = 2056752 (4.48%)
Tml_2605_42_crop_rRNA_reads.log:    Total reads passing E-value threshold = 1174748 (2.74%)
Tml_2605_9_crop_rRNA_reads.log:    Total reads passing E-value threshold = 2343401 (4.79%)
Tms_2604_24_crop_rRNA_reads.log:    Total reads passing E-value threshold = 1148765 (2.60%)
Tms_2604_43_crop_rRNA_reads.log:    Total reads passing E-value threshold = 1803479 (4.11%)
Tms_2604_48_crop_rRNA_reads.log:    Total reads passing E-value threshold = 2162065 (4.58%)
```









