# Raw reads were cleaned before used for downstream analysis
## 1. Description
This section includes the following steps:
  - change the name of the raw fastq files
  - Remove adaptor sequences, if present
  - Trim reads to get rid of low quality bases
  - Remove rRNA reads (only reads from mRNA is supposed to be remained)

## 2. Trimming reads from diploids

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







