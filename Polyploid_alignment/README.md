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
Input (examples): (column no.4: mapped position of base 1 of a read on the reference)
  - `Tml_2605_24_reads_Tdu_ST_V1_uniq.sam`
    - ```
      NS500162:83:H2FF2AFXX:1:21204:25638:5752	163	Tdu_TRINITY_DN21974_c1_g1	100	42	136M	=	155	196	ACATAACTGATGAAAATCCCTAATTTCACATGATTCACGAAAAAAAAAACAAAAAAATGTTATAAAGAAAGTTCTGTACACACAAATTAAAATTAACACTGAATAATTCTGACACATGTATTGTTACACAAAATTG	FFFFFFFFFFFFFFFFFFFFF7FFFAA.FFFFFAFFFFFFFFAAFFFF7FFFFFFFFFFFF<FFAFFAFFAFF7<F7)F<FFFFAFFF.FFFFFF<AF<F7.AF7FFF).F.F7A)AAA<AAFA7)A<7AF<FFA7	AS:i:-7	XN:i:0	XM:i:2	XO:i:0	XG:i:0	NM:i:2	MD:Z:115T0A19	YS:i:-6	YT:Z:CP
      NS500162:83:H2FF2AFXX:1:21204:25638:5752	83	Tdu_TRINITY_DN21974_c1_g1	155	42	141M	=	100	-196	AATGTAATAAAGAAAGTTCTGTACACACAAATTAAAATAAACACTGAATAATTCTGACACTAGTATTGTTACACAAAATTGGACTATTGAAAATCAACACTAAATAGGGTCCGTAGCTTCCTCTACCACAGACTGCAACTC	<F<7A.<.7.7A.AF7F7F.F77<FA<A<AFF.<AFFF.FFFFFAF<F.FFFFFAFFFFF<FFFFFFFFAFFAF.AFFFF<FFFAFF<F<FFFFFFFFFF.FFF<FF<FAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAS:i:-6	XN:i:0	XM:i:2	XO:i:0	XG:i:0	NM:i:2	MD:Z:5T32T102	YS:i:-7	YT:Z:CP
      ...
      NS500162:83:H2FF2AFXX:1:11308:23543:15107	81	Tdu_TRINITY_DN21974_c1_g1	2156	42	136M	=	2166	146	CGGGCCAGTGGAGACCTTTGAACTAATTTTTGCTGTTGCTGGTGATTGTCCATTCTTACCGGAAACACAAGATAGGAAGAATAAGAACTCAATTTCGAGCGGAAAGAAGTGTGCGGGGATGCTAAGAACTGCGACT	<<.FFF<F.FFFAFFFFF.FFFF7FFAFFFFFF7F.7FFF<F7F.FFFFFFFFFFFF.FFF.FF7FFFFFFFFF)AFF7FFFFFFF7FFFFFFFFFFFFF<FFFFFFF<.F<FF<)FAF<FFFF<FFFFF7FFFFF	AS:i:-14	XN:i:0	XM:i:3	XO:i:0	XG:i:0	NM:i:3	MD:Z:0T13G11G109	YS:i:-10	YT:Z:DP
      NS500162:83:H2FF2AFXX:1:11308:23543:15107	161	Tdu_TRINITY_DN21974_c1_g1	2166	42	136M	=	2156	-146	GAGACCTTTGAACTAATTTTTGCTGTTGCTGGTGATTGTCCATTCTTACCGGAAACACAAGATAGGAAGAATAAGAACTCAATTTCGAGCGGAAAGAAGTGTGCGGGGATGCTAAGAACTGCGACTACTAACAAAT	FFFFFA7FFFFFFFAFFAFFFFAFF<FFFFFFFFFAFFFF7<FFFFFFF<FFF<FFF<FFFFFAFFAFFFAAFFFA.FAFFFFFF<FAA7FFFF7FFFFFF<AFFFFFFFFFAFFA.FFFFF<.F<FFFF.FAFF<	AS:i:-10	XN:i:0	XM:i:2	XO:i:0	XG:i:0	NM:i:2	MD:Z:4G11G119	YS:i:-14	YT:Z:DP
      ```
  - `Tms_2604_24_reads_Tpr_ST_V1_uniq.sam`
    - ```
      
      ```

Output (examples):
  - `Tml_2605_24_uniq_2_TDU_filter_for_Poly.sam`; the CORE regions of `Tdu_TRINITY_DN21974_c1_g1` is from 1098 to 2033.
    - ```
      NS500162:83:H2FF2AFXX:4:11411:9832:13861        137     Tdu_TRINITY_DN21974_c1_g1       1130    0       94M     =       1130    0       TAGTTCATTATGTGCGGGGATATCGAATGATTGAGGAACCCCGCAATTGGAATCAAACAAGTTCTTAATTTCCCATCACTAAACATGACTTTCA  FAFFFFFFF<FFFFFFFFFFFFFFFAFFFFFFFFFFF.FFFFFFFFFFFFFFFFFFFF<FFFFFFFFFAFFFFF.FFFFF<<FFFFF.FFFFF7  AS:i:-55        XN:i:0  XM:i:11 XO:i:0  XG:i:0  NM:i:11 MD:Z:3C1A1A3A0A0T0T0T1A0C3C71   YT:Z:UP
      NS500162:83:H2FF2AFXX:1:21302:10963:3047        163     Tdu_TRINITY_DN21974_c1_g1       1139    24      7M3I130M        =       1151    152     ATTATGTGCGGGGATATCGAATGATTGAGGAACCCCGCAATTGGAATCAAACAAGTTCTTAATTTCCCATCACTAAACATGACTTTCATGCTATTTGAGTACCATAACTCACAAGCCCATAAGAACTCATCCCATGTGTA    AFF<AFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFFF.FAFFFFFFFAFFFFF<FFFFFFF.FFFF<.FFFFFFFFFF<7F<<7FFFFF7<F7FF)7<FF<FFFFAF<F<A7<AF.FA.<.AAFAA7    AS:i:-44        XN:i:0  XM:i:6  XO:i:1  XG:i:3  NM:i:9  MD:Z:2A2T2A0C3C90T32    YS:i:-13        YT:Z:CP
      NS500162:83:H2FF2AFXX:1:21302:10963:3047        83      Tdu_TRINITY_DN21974_c1_g1       1151    24      140M    =       1139    -152    ATCGTATGATTGAGGAACCCCGCAATTGGAATCAAACAAGTTCTTAATTTCCCATCACTAAACATGACTTTCATGCTATTTGAGTACCATAACTCACAAGCCCATAAGAACTCATCCCATGTGTAAATCTCTTGAGGAAA    <AF..A<AF<<A<<FFFFF.AFF7A7F<FFF<FFFF.F7FFFFA.FF.<AFFFFFFFF<FFFFFFFFFFF<FFFFF<F<FFFFFF<FFFAFFFFFFFFFFAFAFAFFFFFFFFFFFFFFFFAFFFFFFFFFFFFFFFFAF    AS:i:-13        XN:i:0  XM:i:3  XO:i:0  XG:i:0  NM:i:3  MD:Z:1C2A87T47  YS:i:-44        YT:Z:CP
      ...
      NS500162:83:H2FF2AFXX:2:11106:15793:11327       147     Tdu_TRINITY_DN21974_c1_g1       1996    24      141M    =       1874    -263    AAGCATCTCTTCCAGAACAGAATTCAGCAACTCAATGCTAGAAGTGCTCTTGATTTTGACTTTTCCTTTGGGGTCAAAACCCTTGACTTCTAATAATCTCTTCTTTTTCTCGAAGAGAATATCTTTTTCAGAGAGCTCCAT   A<FFFFFAA<<7F<AAAA<A<AFAFAF<<FFF<FFFFFFFFFFFFFAAF<FFFFFFAFFFFFFFFF<FFF<AFAFFFFFFFFFAAFFFFF<FAAFFFAFAFFFFFFFFFFFFFFFFFFFAFAFFFFFFFFFFFFFFFFFFF   AS:i:-25        XN:i:0  XM:i:5  XO:i:0  XG:i:0  NM:i:5  MD:Z:14A25C13G28C27A29  YS:i:-35        YT:Z:CP
      NS500162:83:H2FF2AFXX:4:21503:11768:5748        99      Tdu_TRINITY_DN21974_c1_g1       2016    24      141M    =       2144    247     AATTCAGCAACTCAATGCTAGAAGTGCTCTTGATTTTGACTTTTCCTTTGGGGTCAAAACCCTTGCCTTCTAATAATCTCTTCTTTTTCTCGAAGAGAATATCTTATTCAGAGCGCTCCGTCACCAATTCAAGTTCATCAT   FFAFF))FF.FFA<FFAFFAFFFFFFFFFF.FF<FF<F.<FF7<FAFAFF<FFFAF...FAFAAA.FF<FF<<F7F.F<F.<FFF<<F.FAF<FA.<FFFFFFFF.FFA.A<..AFFA<..<)A7A<FFAAF<F.<.AA<<   AS:i:-36        XN:i:0  XM:i:9  XO:i:0  XG:i:0  NM:i:9  MD:Z:20C13G28C1A25A13T7A5A4T16  YS:i:-20        YT:Z:CP
      NS500162:83:H2FF2AFXX:1:11302:4669:16518        163     Tdu_TRINITY_DN21974_c1_g1       2016    40      141M    =       2123    247     AATTCAGCAACTCAATGCTAGAAGTGCTCTTGATTTTGACTTTTCCTTTGGGGTCAAAACCCTTGACTTCTAATAATCTCTTCTTTTTCTCGAAGAGAATATCTTTTTCAGAGAGCTCCATCACCAATTCAAGTTCATCAT   FFFFFFFFF.FFFFFFFFF<FFFFFFFFFFFFFFFFFF.FFFFFFFFFFFFAFFFFAFAFAFAFF.<FFFAFFF<FFFFAAAFFA<FAFAAFFFFFFFFFFFF77FF7FFAFF<FAA<FFFF<FAF.AF<A.77.FAFF<A   AS:i:-25        XN:i:0  XM:i:5  XO:i:0  XG:i:0  NM:i:5  MD:Z:20C13G28C27A32T16  YS:i:-20        YT:Z:CP
      ```
  
  
  