# Align polyploids reads to diploid SuperTranscripts and identify homeolog expression bias
## 1. Description
Reads from both short-liguled *T. miscellus* (population 2604) and long-liguled *T. miscellus* (population 2605) were mapped to the diploid SuperTranscripts; homeolog expression bias is detected by using Bayesian Poisson-Gamma model (method as described from Boatwright et al., 2018)

## 2. Aligning clean reads from polyploids to diploid SuperTranscripts
### 2.1 Bowtie2 alignment
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
  
### 2.2 Identify unique mappings in SAM files
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

## 3. Filter SAM files by bed files
In this step, SAM files will be filed by bed files, which are derived from filtered unbiased orthologous pairs generated from section `Filter_orthologs`.
### 3.1 Filter CORE_bed files
Input files:
  - `Tdu_DB_Tpr_query_parser_single_hit_FullName.txt.filtered_Q.bed`, which is from section `WU-Blast_Analysis`; includes 42,595 orthologous pairs
  - `Tdu_DB_Tpr_query_parser_single_hit_FullName.txt.filtered_S.bed`, which is from section `WU-Blast_Analysis`; includes 42,595 orthologous pairs
  - `bayes_flag_sig_Filtered_Tdu-Tpr_overlap.V2.csv`, which contains 5,400 filtered unbiased orthologous pairs (from section `Filter_orthologs`)

Scripts:
  - `FilterBedFile_Poly_V1.py`

```bash
FilterBedFile_Poly_V1.py bayes_flag_sig_Filtered_Tdu-Tpr_overlap.V2.csv Tdu_DB_Tpr_query_parser_single_hit_FullName.txt.filtered_S.bed
```
  - `FilterBedFile_Poly_V2.py`

```bash
FilterBedFile_Poly_V2.py bayes_flag_sig_Filtered_Tdu-Tpr_overlap.V2.csv Tdu_DB_Tpr_query_parser_single_hit_FullName.txt.filtered_Q.bed
```

Output:
  - `Tdu-tpr_overlaps_orthologs_poly.bed`, which contains 5,400 orthologous pairs.
    - ```
      Tdu_TRINITY_DN25596_c4_g2	1275	1917	Tpr_TRINITY_DN11283_c3_g1,Tdu_TRINITY_DN25596_c4_g2	.	+
      Tdu_TRINITY_DN20652_c0_g3	232	2256	Tpr_TRINITY_DN11284_c2_g19,Tdu_TRINITY_DN20652_c0_g3	.	+
      Tdu_TRINITY_DN17239_c2_g3	12	2819	Tpr_TRINITY_DN11285_c1_g4,Tdu_TRINITY_DN17239_c2_g3	.	+
      Tdu_TRINITY_DN23322_c3_g3	3449	4111	Tpr_TRINITY_DN11295_c2_g2,Tdu_TRINITY_DN23322_c3_g3	.	+
      Tdu_TRINITY_DN12723_c0_g1	400	1613	Tpr_TRINITY_DN11295_c2_g3,Tdu_TRINITY_DN12723_c0_g1	.	+
      ...
      ```
  - `Tpr-tdu_overlaps_orthologs_poly.bed`, which contains 5,400 orthologous pairs.
    - ```
      Tpr_TRINITY_DN11283_c3_g1	0	639	Tpr_TRINITY_DN11283_c3_g1,Tdu_TRINITY_DN25596_c4_g2	.	+
      Tpr_TRINITY_DN11284_c2_g19	0	2022	Tpr_TRINITY_DN11284_c2_g19,Tdu_TRINITY_DN20652_c0_g3	.	+
      Tpr_TRINITY_DN11285_c1_g4	152	2957	Tpr_TRINITY_DN11285_c1_g4,Tdu_TRINITY_DN17239_c2_g3	.	+
      Tpr_TRINITY_DN11295_c2_g2	247	914	Tpr_TRINITY_DN11295_c2_g2,Tdu_TRINITY_DN23322_c3_g3	.	+
      Tpr_TRINITY_DN11295_c2_g3	139	1344	Tpr_TRINITY_DN11295_c2_g3,Tdu_TRINITY_DN12723_c0_g1	.	+
      ...
      ```
### 3.2 Filter SAM files by using BED files including only those filtered, unbiased orthologous pairs
Scripts `SAM_filter_by_bed_poly_V1.sh` and `sam-filter-by-bed.pl` were used.

```bash
for FILE in `ls *_Tdu_ST_V1_uniq.sam`; do
	echo "${FILE} is going to be processed"
	# filter sam file of Tml/Tms reads aligned to TDU with TDU_tpr bed file
	perl ${CODE}/sam-filter-by-bed.pl \
		-b ${OUT}/Tdu-tpr_overlaps_orthologs_poly.bed \
		-s ${FILE} \
		> ${OUT}/${FILE%_reads_Tdu_ST_V1_uniq.*}_uniq_2_TDU_filter_for_Poly.sam		
	echo -e "\t${FILE} has been filtered based on the TDU_tpr bed file"
done

for FILE in `ls *_Tpr_ST_V1_uniq.sam`; do
	echo "${FILE} is going to be processed"
	# filter sam file of Tml/Tms reads aligned to TPR with TPR_tdu bed file
	perl ${CODE}/sam-filter-by-bed.pl \
		-b ${OUT}/Tpr-tdu_overlaps_orthologs_poly.bed \
		-s ${FILE} \
		> ${OUT}/${FILE%_reads_Tpr_ST_V1_uniq.*}_uniq_2_TPR_filter_for_Poly.sam		
	echo -e "\t${FILE} has been filtered based on the TPR_tdu bed file"
done
```
Input (examples):
  - `Tms_2604_24_reads_Tdu_ST_V1_uniq.sam`
    - ```
      NS500162:83:H2FF2AFXX:2:11212:16127:16981       81      Tdu_TRINITY_DN31201_c0_g1       1       0       4M14I122M       Tdu_TRINITY_DN22508_c5_g1       2204    0       TTGTGAAATATGTCAAGAACGATGTCAACCTTCAAGCCGACGACCTTCCAACCTGTGGTTGGAGACTCCGAGTTTAATTTTAACCTGAGGAGGGAATAGAAGTGAGTGACGAACTGGAGTGAGGGAGATGGTTGAGCAGG    F.F.FFA<F<<<.A)F.A.FFF7F.FAFFFA<F<FF<FF<AF)FFF<FF<FFF.F<FA)7FF<FAFFF7<FF<7F).F.AF)FFFFF.FFFF)AFAFFFF7FFFFFFFFF.FFF<F)FF.FFFFFFFFFFF<.F7FFFFF    AS:i:-82        XN:i:0  XM:i:9  XO:i:1  XG:i:14 NM:i:23 MD:Z:0A0A1A8G10T15A38A29T8A8    YS:i:-54        YT:Z:DP
      NS500162:83:H2FF2AFXX:2:21207:4108:1933 99      Tdu_TRINITY_DN31201_c0_g1       2       8       2M3I136M        =       18      155     TCAAGAACGATGTCGACCTTCAAGCCGACGCCATTCCAACCAGTGGTTGGAGACTCCGAGTTTAATTTTAACCTGAGGAGGGAATAGAAGAGAGTGACGAACTGGAGTGAGGGAGATGGTTGAGCAGGTAACTAAAATCAC   FF7FFFAFF.F)FFAAFFFFF.FFAFFFFF.F.7FF<F7F)FFFFFFF<FFFFFFFFFFFFA.7FFFFFA.FF<FFF.FFAF<FFFFA<F.A..<FFF.F<.FFF.FFFFF.F)7F.AFFFAFA<FFFFFAF.7A.FF))<   AS:i:-63        XN:i:0  XM:i:12 XO:i:1  XG:i:3  NM:i:15 MD:Z:0A0G20T4A1C47A9T19T8A9T2A6G1 YS:i:-32        YT:Z:CP
      NS500162:83:H2FF2AFXX:2:21207:4108:1933 147     Tdu_TRINITY_DN31201_c0_g1       18      8       139M    =       2       -155    TCATGCCGACGACCTTCCAACCAGTGGTTGGAGACTCCGAGTTTAATTTTAACCTGAGGAGGGAATAGAAGTGAGTGACGAACTGGAGTGAGGGAGTTGGTTGAGCAGGTAACAAATATCGCTCAGAAGGCAGCAGTCG     <A.)<..FAFF.FFFFAFF)A)<A).F.7.A<AAF)<FF.AF.FF.AFF.<F7AFF7F7FFFFAFAFF<.FAFAF.F7.7FFF<FFAF.F.F7F.F.FFF7.FAFFFFFFF.FFFF.FAFF<)FAFF7F.FFFFFF.FF     AS:i:-32        XN:i:0  XM:i:9  XO:i:0  XG:i:0  NM:i:9  MD:Z:3A2T54A29T4A3A9T5A5A16     YS:i:-63  YT:Z:CP
      ```
  - `Tms_2604_24_reads_Tpr_ST_V1_uniq.sam`
    - ```
      NS500162:83:H2FF2AFXX:4:11505:25715:19864       99      Tpr_TRINITY_DN31201_c0_g1       1       24      4M2I135M        =       102     177     AGAACTCAACATCAGGCATAGATTCTATCGTCCCGAAGGATCCCATGTTGCATAGAGTTTCAAAAAGACATCTTCTTACCAAAATCAGAGGCAAACCTAATTATGGCGATGGGTTGTTTCTTCTATACAGACGCCGCATAT   )F77F<<<<F.AFFFFFFFAF.F7F<F7FF<AFF)7.A<AFFF7..F)F<FF.FFFA.FAFFAFFFF.F<<F7FF<7)FFA.AFFF77.7A7<F.AFA<F)AAFFA.FF.)AF.)<..<.A)AA<)AFFF.<..FAFFA<A   AS:i:-37        XN:i:0  XM:i:7  XO:i:1  XG:i:2  NM:i:9  MD:Z:1A0C0T75T42T5T1T8  YS:i:-4 YT:Z:CP
      NS500162:83:H2FF2AFXX:4:11505:25715:19864       147     Tpr_TRINITY_DN31201_c0_g1       102     24      76M     =       1       -177    TGGCGATGGGTTGTTTCTTCTTTACAGTCTCCGCATTTGACATGTTCGGAGTTGCTTTGCCGGCATGCTCGTCGAA    <FFFF<.FFF.FFFFA.FFAFFAAFFFF<.FFFAFF7FF.77AF<FAFFFFA<FF<FAFFAFFAFAFF<FF.AFFF    AS:i:-4 XN:i:0  XM:i:1  XO:i:0  XG:i:0  NM:i:1  MD:Z:36A39      YS:i:-37        YT:Z:CP
      NS500162:83:H2FF2AFXX:4:21609:5860:6172 99      Tpr_TRINITY_DN11072_c2_g4       391     40      6M1D134M        =       409     159     TTGTTCGGTATTTTATTGTTTAGTTATTTTTATTTAATATCGCGTAAAATAAAGTTTGGCTAGTCACTTTGTTTTGAGTTAATAGTTTAGAGTTGTTTGAGGACAAGCAATGTTCAAGTGTGTGAATGTTTGATATTTGC    FFFFFFFFFFFFFAAFFFFFF.FFF<FFFAF7FAFFFF<FFAFFF<AAAF.FFFFFFF<FA.F<F7FAFAFFFF<F7FFF.AA.FFF<<F.F<FFFF7A<AA.FAFFA.<AFA7F..F<<.AA7.7<AA.77.AA<.<.7    AS:i:-48        XN:i:0  XM:i:8  XO:i:1  XG:i:1  NM:i:9  MD:Z:0A2C0A1^A1A0A1A0A1A126     YS:i:0  YT:Z:CP
      ```

Output (examples):
  - sth
  
  