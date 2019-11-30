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
      NS500162:83:H2FF2AFXX:4:11407:2242:8661	145	Tpr_TRINITY_DN11295_c2_g2	1	8	3M14I120M	=	3	135	ATGGATTTCAGGAAGAAGTAGTTTGTGTGATCAACTATAAAGATATGGATAAGTATTTTAGAAAGAAAGTTTATGCAGAATGTTGGAAGTTTTGAAATATCAAAATATGATTGAAGATGATGAAGAAGCTAAAAACT	7A.<..F<)7F7<7<A.FF<F<FFFF7<7AF.AFF7F7FFFFFAFFF)FFFFFFFAFF.F<AFFFFFFFAF.FFFFFFFFFFFFF7FFF<FFFFFFFAF.FAFFF7FFFFFFFFFFF)7F<FF7FF.FFFFFFFFF.	AS:i:-59	XN:i:0	XM:i:3	XO:i:1	XG:i:14	NM:i:17	MD:Z:0G0A0A120	YS:i:-38	YT:Z:DP
      NS500162:83:H2FF2AFXX:4:11407:2242:8661	97	Tpr_TRINITY_DN11295_c2_g2	3	8	3M7I130M	=	1	-135	AGGAAGAAGTAGTTTGTGTGATCAACTATAAAGATATGGATAAGTATTTTAGAAAGAAAGTTTATGCAGAATGTTGGAAGTTTTGAAATATCAAAATATGATTGAAGATGATGAAGAAGCTAAAAACTCCAACATTTGGG	FFFFAFFFFFFFFFFFFFFFAFFFFFFAF<FFFFFAFFFFF.FFF<FFFF7FFFAFFFFFFFF<FFF<FA<FFFFFA7AFFFF<FFAAFFAF.AAFF<FA<FFFAFFFFFAFFFAA.FFAA.AF<FFAF7AFF<FA77.7	AS:i:-38	XN:i:0	XM:i:3	XO:i:1	XG:i:7	NM:i:10	MD:Z:2T128C0A0	YS:i:-59	YT:Z:DP
      NS500162:83:H2FF2AFXX:4:11503:19059:19129	163	Tpr_TRINITY_DN11295_c2_g2	3	42	141M	=	308	446	AGTAGTTTGTGTGATCAACTATAAAGATATGGATAAGTATTTTAGAAAGAAAGTTTATGCTGAATGTTGGAAGTTTTGAAATATCAAAATATGATTGAAGATGTTGAAGAAGCTAAAAACTCCAACATTTGCATCACTCGT	FFFFFFA)AFFFF.F7F.FFFFFAAFFFFFFFF<)FFF.AFFFAFFFAF<F<FFFFFF.F)FAFFFFFFF<.F7F<AFFAAF.AF.F<FA)F<)FFF7FFFFF)FF7.A7FFFFF.<F.FF.<F.F7F<A.FF<F.AFFA7	AS:i:-7	XN:i:0	XM:i:3	XO:i:0	XG:i:0	NM:i:3	MD:Z:60A42A31C5	YS:i:-5	YT:Z:CP
      ...
      NS500162:83:H2FF2AFXX:4:11601:5719:16634	161	Tpr_TRINITY_DN11295_c2_g2	2874	42	89M	=	2864	-99	CAAGTAAAGAGCAGCTGTGGTGTGTGGAGATTATCAACTCTCAGAACAGTTAATCTTCCCTTACCATCTCCCATACCAATCCAGTGAGG	FF<AF.FFFAFFAAFFFFFFFFFFFFFFFFFFFFFF<FFFFFFFFFFAFFF.FFFFFFFFFFFFFFAFFFFFF<FFF<FFFF<.FF<FF	AS:i:-4	XN:i:0	XM:i:1	XO:i:0	XG:i:0	NM:i:1	MD:Z:73G15	YS:i:-10	YT:Z:DP
      NS500162:83:H2FF2AFXX:1:21302:19888:14695	161	Tpr_TRINITY_DN11295_c2_g2	2874	42	89M	=	2864	-99	CAAGTAAAGAGCAGCTGTGGTGTGTGGAGATTATCAACTCTCAGAACAGTTAATCTTCCCTTACCATCTCCCATACCAATCCAGTGAGG	FFFFFFFFFAFFFFFFFFFFFFFFFFFFFFFFFFFFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFFFFFFFFFFFFFFFFFF<FFFF	AS:i:-5	XN:i:0	XM:i:1	XO:i:0	XG:i:0	NM:i:1	MD:Z:73G15	YS:i:-10	YT:Z:DP
      NS500162:83:H2FF2AFXX:3:11601:25368:10838	161	Tpr_TRINITY_DN11295_c2_g2	2881	3	83M12I4M	=	2871	-97	AGAGCAGCTGTGGAGTGTGGAGATTATCAACTCTCAGAACAGTTAATCTTCCCTTACCATCTCCCAGACCAATCCAGTGAGGGGAATCTTCTTCAACAG	AF.AFFFFF<FFF.FFFFFFFFFFFAF7<FF)FFFAFFFFFFAFAFFFAFFFFFFA<F<FFFFFAFF<F.7FFAFFFFFAFFAF.FFFFFFFF)F)7A<	AS:i:-54	XN:i:0	XM:i:4	XO:i:1	XG:i:12	NM:i:16	MD:Z:13T69G0A1T0	YS:i:-27	YT:Z:DP
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
  - `Tms_2604_24_uniq_2_TPR_filter_for_Poly.sam`; The CORE region of `Tpr_TRINITY_DN11295_c2_g2` is from 247 to 914.
    - ```
      NS500162:83:H2FF2AFXX:2:11305:2739:12279	81	Tpr_TRINITY_DN11295_c2_g2	228	0	6M1I14M4I101M	=	237	130	CAGCAACAGCTATTTGATAGAGGTTCCTCCCACACACTCTAACATCCAGTGCTTCTGGTTCTGGTACGCTCACTATCAAATGGGCATGCTCCCTTAATTTACCATCCACCACCGACACGCGCCAAC	F<<F.A<.AF.A.<7F7AFAAFFFFFFFF.FFA<F<FAF.FFAFAFFFF<AFA<FFFFAFF<FFFFFFFFFFF.F7F7FFFFFFFFFFFFFFFA.AFF<7FFFFAFFFFFFFFFF<FFFFFFFFFF	AS:i:-70	XN:i:0	XM:i:10	XO:i:2	XG:i:5	NM:i:15	MD:Z:0A2T0G3G0G3G0T1C0C0C102	YS:i:-45	YT:Z:DP
      NS500162:83:H2FF2AFXX:3:21411:20690:17652	99	Tpr_TRINITY_DN11295_c2_g2	232	3	6M2I10M4I118M	=	315	162	CAACAGCTATTTGAAAGAGGTTCCTCCCACACACTCTAACATCCAGTGCATCTGGTTCTGGTACGCTCACTATCAGATAGGCATGCTCCCTTAATTTACCATCCACCACCGACACGCGCCAACAACGAACACGCTGATCA	))FAFFFFF7<AFA.FFFAFFF)7FFFFFF)FFFAFFA77.AF7F.FFF).FAAA.FA7FFF.A<FFFAFF<F<<<FA)F.AFF.FAFFAFFF.7F..F.FAF7<7F)FFFF.FFF.FF<..F7.F.).FFF.FF.A<FF	AS:i:-71	XN:i:0	XM:i:11	XO:i:2	XG:i:6	NM:i:17	MD:Z:0G2G0G4G0T1C0C0C28T25A2G61	YS:i:-9	YT:Z:CP
      NS500162:83:H2FF2AFXX:1:21110:9764:18491	137	Tpr_TRINITY_DN11295_c2_g2	232	0	6M2I10M4I91M	=	232	0	CAACAGCTATTTGATAGAGGTTCCTCCCACACACTCTAACATCCAGTGCTTCTGGTTCTGGTACGCTCACTATCAAATGGGCATGCTCCCTTAATTTACCATCCACCACCGAC	FFAFFFFFAFAFFAF.F.FFFFFFFFFF)F<FFFFFFAFFFFF<FFF<FFFF7FFFFFF)FFAFFFFFFFF7FF7FA)F<<FFFA<F)AFFF..<F7<A..AF7AF<.7F<<F	AS:i:-66	XN:i:0	XM:i:8	XO:i:2	XG:i:6	NM:i:14	MD:Z:0G2G0G4G0T1C0C0C92	YT:Z:UP
      ...
      NS500162:83:H2FF2AFXX:3:21410:2633:16018	81	Tpr_TRINITY_DN11295_c2_g2	795	40	101M	=	804	111	CAGGACTGATGCTTTCCGCATAAATGTTTCAACAGCTTCACTCACATCCCAAAACCCGATACTTCCATCTGTAGACCCGCTAATCACGATAAACAGACTTT	AFF7FF<.7)FFAF<<AFA7F.<F.F.<FF.)7AFFF<FFFFA)F.FF.FF))FFF7F.AFF)FFFFAFFFFAF<AFAFFFFAFFAFF.AF)FF<FFFAFF	AS:i:-3	XN:i:0	XM:i:1	XO:i:0	XG:i:0	NM:i:1	MD:Z:24A76	YS:i:-26	YT:Z:DP
      NS500162:83:H2FF2AFXX:3:21410:2633:16018	161	Tpr_TRINITY_DN11295_c2_g2	804	40	102M	=	795	-111	TGCTTTCAGCATAAAAGTTTCAACAGCTTCACTCACAACCCAAAACCCGATACTTCCATCTGTAGACCCGCTAAACACGATAAACAGACTATTATCTTTTAA	<FFF7F.)FFFF7F<FFF7FFA.F<F<FFF<FF<<F.)<<AA.F<FFFF..FFFF))F<7)F.<<.A.7FF<F.)FFF<.7F7AAFFAF.)FFFF<F<FFF<	AS:i:-26	XN:i:0	XM:i:8	XO:i:0	XG:i:0	NM:i:8	MD:Z:7C29T36T15T6G0G0A1T0	YS:i:-3	YT:Z:DP
      NS500162:83:H2FF2AFXX:4:11501:12478:4818	73	Tpr_TRINITY_DN11295_c2_g2	833	24	91M3I4M	=	833	0	CACTCACATCCCAAAACCCGATACTTCCATCTGTAGACCCGCTAATCACGATAAACAGACTTTTATCTGGAATAAGACAAAGTAACCTTTTAAATAGT	F)FF7FFAFF7FFFFFFFF.AF<F<F)FFFFFFFFF.FFF)F)FFFF7FFFAFFFF...AFFAFFFFF77FAF7FFAFF.FF<7FF.<<<FF.FF.AF	AS:i:-18	XN:i:0	XM:i:1	XO:i:1	XG:i:3	NM:i:4	MD:Z:88A6	YT:Z:UP
      ```
### NOTE: BED Files are NOT re-imported with SAS

## 4. Add commonID to all SAM files
Scripts `submit_add_commonID_hybrid.bash` and `add_commonID_to_hybrid_sam_files_HPC.sas` were used.

`add_commonID_to_hybrid_sam_files_HPC.sas` was changed as listed below:
  - `data Tms_ID_tdu_tpr` used tdu as ref, which is the second part of the commonID: `consensedID = scan(commonID,2,'|')`
  - `data Tms_ID_tpr_tdu` used tpr as ref, which is the first part of the commonID: `consensedID = scan(commonID,1,'|')`
  - For `s_VAR10` and `s_VAR11`, the value is 150, as the reads length is paired 150 bp

Input:
  - `tdu_tpr_bed_for_sam_compare.sas7bdat` from section Filter_orthologs
  - `tpr_tdu_bed_for_sam_compare.sas7bdat` from section Filter_orthologs
  - SAM files, e.g.
    - `Tml_2605_24_uniq_2_TDU_filter_for_Poly.sam`
      - ```
        NS500162:83:H2FF2AFXX:3:21604:21342:15517	163	Tdu_TRINITY_DN10011_c0_g1	3	23	8M1I130M	=	40	176	ATCTCAATCACCGGACCGCCATTAATCCTATTCTTCAAAATCACTCCACAGAAAATATAATAAAAATATATTCAATTCAATCCGCTTCTCACCTCCCAATTTTCCCCGACTTCAATCTTCTTCTCCTACAATCATCTAC	A<FFFF<.F.FAFFFFF<FF7AF<.FF.AF<F.)FFAFFFFFF.FFFFFAFA<FAF.F..<A.7FF7)FAF<)FFF)F7AAF.AA.FFFF7F.FFAF7.<7<..)FF.<FF7FF7.A.AAA7)<7<<7).F<A7A).<<	AS:i:-60	XN:i:0	XM:i:14	XO:i:1	XG:i:1	NM:i:15	MD:Z:1G0G1G1G0A0T0G32A18T22A11T29T5T1G3	YS:i:-14	YT:Z:CP
        NS500162:83:H2FF2AFXX:2:21211:7053:15851	99	Tdu_TRINITY_DN10011_c0_g1	12	24	119M	=	178	270	CCGGACCGCCAATAATCCTATTCTTCAGAATCAATCCACACAAAATATAATATAAATATAATCAATTCAATCCGCAACACACCTCCCTATTTACCACGACTTCAATCTTCTTCTCCTTC	FAF.FF.FF)F.7AAA.FFF.FFFFF<FFFFF<F7F.FFFFA.FFF.F.FFFFA<F.<<F..<FFFF<AAFF<AFF.<.F<F.F77<7.F77<7F..)FF<FFF<7FF.F7AAA.A7.<	AS:i:-34	XN:i:0	XM:i:9	XO:i:0	XG:i:0	NM:i:9	MD:Z:0G10T15A12G19T15T1T13T2C23	YS:i:-12	YT:Z:CP
        NS500162:83:H2FF2AFXX:1:21210:25029:19102	99	Tdu_TRINITY_DN10011_c0_g1	13	40	140M	=	31	158	CGGACCGCCATTAATCCTATTCTTCAGAATCAATCCACACGAAATATAATATAAATATATTCAATTCAATCCGCATCTCACCTCCCTATTTTCCCCGACTTCAATCTTCTTCTCCTTCAATCTTGTACAGAATAGGAACT	<AF.F.FFF.FFAFFFFFAFFAFFFFFFFFFAFFF))FFFFFFFF.F.FFAF<FFF.FA7AF7FFAF.FFFF7FFF<7F)F<FFFFF<FFA<F777..FFFFAFFFFFF.<<<7FAF<F<FA7<<A7.<FFF.FFF77)<	AS:i:-24	XN:i:0	XM:i:6	XO:i:0	XG:i:0	NM:i:6	MD:Z:26A12G0A91A5G0A0	YS:i:-25	YT:Z:CP
        ```
    - `Tml_2605_24_uniq_2_TPR_filter_for_Poly.sam`
      - ```
        NS500162:83:H2FF2AFXX:1:21305:26212:18295	145	Tpr_TRINITY_DN10010_c0_g1	209	0	64M11D51M	=	218	136	GCCAATACATATCAATCGTAATTTACCTTACCATATACAATATCCAAATGTACCAGTTTAACTCTGAAACCGCGTATAGAAGAAACCTCAACATAAACTGAACTTGAATATTACT	FFFAF<F7FFAF<FFFFFFFFA.<AFFAAFAFF<F7F<FF.<AF<FAA.FFFFFFFFF.F<F<FFFFFFFAFFAFFFFFFFFAFFFFFFFFFF<F<FFFFFFFFFFAFAFF<FFF	AS:i:-58	XN:i:0	XM:i:4	XO:i:1	XG:i:11	NM:i:15	MD:Z:0A0G0A61^TGAAACCGCCA38G12	YS:i:-43	YT:Z:DP
        NS500162:83:H2FF2AFXX:1:11106:16278:3249	145	Tpr_TRINITY_DN10010_c0_g1	209	0	64M11D51M	=	218	136	GCCAATACATATCAATCGTAATTTACCTTACCATATACAATATCCAAATGTACCAGTTTAACTCTGAAACCGCGTATAGAAGAAACCTCAACATAAACTGAACTTGAATATTACT	A7F7<..<<.F<A7F<AFFAFAF.AFFAAF.FF.F<FF<A.FFFF7AF7FFFFFFFFF7FFFFF<FFFFFFFFFFFFFFFFFFFFFFFFFFFF<FFFF<FFFFFFFFFAFFAFFF	AS:i:-57	XN:i:0	XM:i:4	XO:i:1	XG:i:11	NM:i:15	MD:Z:0A0G0A61^TGAAACCGCCA38G12	YS:i:-46	YT:Z:DP
        NS500162:83:H2FF2AFXX:2:11102:24074:19968	89	Tpr_TRINITY_DN10010_c0_g1	217	0	33M7I23M11D77M	=	217	0	ATATCAATCGTAATTTACCTTACCATATACAAAATCCAAAATCCAAATGTACCAGTTTAACTCTGAAACCGCGTATAGAAGAAACCTCAACATAAACTGAACTTCAATATTACTCCAATTAACAACTTTTCTCTATACTT	<.A.FAF<FF.<F.77F.F.AF.FA7F<AF<F)F<)F<FFFA<FFFF<.7A.F7FA..<FA.A).FFFAF..<.<FF<<FF7<FAFAAFFFFFF)FFA<AFFAF..<FAF<FFA<FFFFFF<F.F<F<AAFFFAFAFFFF	AS:i:-78	XN:i:0	XM:i:4	XO:i:2	XG:i:18	NM:i:22	MD:Z:32T23^TGAAACCGCCA38G2G22A12	YT:Z:UP
        ```
    - `Tms_2604_43_uniq_2_TDU_filter_for_Poly.sam`
    - `Tms_2604_43_uniq_2_TPR_filter_for_Poly.sam`

Output:
  - SAM files, e.g.
    - `Tml_2605_24_unq_2_TDU_commonID.sam`
      - ```
        NS500162:83:H2FF2AFXX:3:21604:21342:15517	163	Tpr_TRINITY_DN11857_c2_g6|Tdu_TRINITY_DN10011_c0_g1	3	23	8M1I130M	=	40	176	ATCTCAATCACCGGACCGCCATTAATCCTATTCTTCAAAATCACTCCACAGAAAATATAATAAAAATATATTCAATTCAATCCGCTTCTCACCTCCCAATTTTCCCCGACTTCAATCTTCTTCTCCTACAATCATCTAC	A<FFFF<.F.FAFFFFF<FF7AF<.FF.AF<F.)FFAFFFFFF.FFFFFAFA<FAF.F..<A.7FF7)FAF<)FFF)F7AAF.AA.FFFF7F.FFAF7.<7<..)FF.<FF7FF7.A.AAA7)<7<<7).F<A7A).<<	AS:i:-6	XN:i:0
        NS500162:83:H2FF2AFXX:2:21211:7053:15851	99	Tpr_TRINITY_DN11857_c2_g6|Tdu_TRINITY_DN10011_c0_g1	12	24	119M	=	178	270	CCGGACCGCCAATAATCCTATTCTTCAGAATCAATCCACACAAAATATAATATAAATATAATCAATTCAATCCGCAACACACCTCCCTATTTACCACGACTTCAATCTTCTTCTCCTTC	FAF.FF.FF)F.7AAA.FFF.FFFFF<FFFFF<F7F.FFFFA.FFF.F.FFFFA<F.<<F..<FFFF<AAFF<AFF.<.F<F.F77<7.F77<7F..)FF<FFF<7FF.F7AAA.A7.<	AS:i:-3	XN:i:0
        NS500162:83:H2FF2AFXX:1:21210:25029:19102	99	Tpr_TRINITY_DN11857_c2_g6|Tdu_TRINITY_DN10011_c0_g1	13	40	140M	=	31	158	CGGACCGCCATTAATCCTATTCTTCAGAATCAATCCACACGAAATATAATATAAATATATTCAATTCAATCCGCATCTCACCTCCCTATTTTCCCCGACTTCAATCTTCTTCTCCTTCAATCTTGTACAGAATAGGAACT	<AF.F.FFF.FFAFFFFFAFFAFFFFFFFFFAFFF))FFFFFFFF.F.FFAF<FFF.FA7AF7FFAF.FFFF7FFF<7F)F<FFFFF<FFA<F777..FFFFAFFFFFF.<<<7FAF<F<FA7<<A7.<FFF.FFF77)<	AS:i:-2	XN:i:0
        ```
    - `Tml_2605_24_unq_2_TPR_commonID.sam`
      - ```
        NS500162:83:H2FF2AFXX:1:21305:26212:18295	145	Tpr_TRINITY_DN10010_c0_g1|Tdu_TRINITY_DN19621_c0_g1	209	0	64M11D51	=218	136	GCCAATACATATCAATCGTAATTTACCTTACCATATACAATATCCAAATGTACCAGTTTAACTCTGAAACCGCGTATAGAAGAAACCTCAACATAAACTGAACTTGAATATTACT	FFFAF<F7FFAF<FFFFFFFFA.<AFFAAFAFF<F7F<FF.<AF<FAA.FFFFFFFFF.F<F<FFFFFFFAFFAFFFFFFFFAFFFFFFFFFF<F<FFFFFFFFFFAFAFF<FFF	AS:i:-5	XN:i:0
        NS500162:83:H2FF2AFXX:1:11106:16278:3249	145	Tpr_TRINITY_DN10010_c0_g1|Tdu_TRINITY_DN19621_c0_g1	209	0	64M11D51	=218	136	GCCAATACATATCAATCGTAATTTACCTTACCATATACAATATCCAAATGTACCAGTTTAACTCTGAAACCGCGTATAGAAGAAACCTCAACATAAACTGAACTTGAATATTACT	A7F7<..<<.F<A7F<AFFAFAF.AFFAAF.FF.F<FF<A.FFFF7AF7FFFFFFFFF7FFFFF<FFFFFFFFFFFFFFFFFFFFFFFFFFFF<FFFF<FFFFFFFFFAFFAFFF	AS:i:-5	XN:i:0
        NS500162:83:H2FF2AFXX:2:11102:24074:19968	89	Tpr_TRINITY_DN10010_c0_g1|Tdu_TRINITY_DN19621_c0_g1	217	0	33M7I23M	=217	0	ATATCAATCGTAATTTACCTTACCATATACAAAATCCAAAATCCAAATGTACCAGTTTAACTCTGAAACCGCGTATAGAAGAAACCTCAACATAAACTGAACTTCAATATTACTCCAATTAACAACTTTTCTCTATACTT	<.A.FAF<FF.<F.77F.F.AF.FA7F<AF<F)F<)F<FFFA<FFFF<.7A.F7FA..<FA.A).FFFAF..<.<FF<<FF7<FAFAAFFFFFF)FFA<AFFAF..<FAF<FFA<FFFFFF<F.F<F<AAFFFAFAFFFF	AS:i:-7	XN:i:0
        ```
    - `Tms_2604_43_unq_2_TDU_commonID.sam`
    - `Tms_2604_43_unq_2_TPR_commonID.sam`
  - SAS output, e.g.
    - `tml_2605_24_unq_2_tdu_commonid.sas7bdat`
    - `tml_2605_24_unq_2_tpr_commonid.sas7bdat`
    - `tms_2604_43_unq_2_tdu_commonid.sas7bdat`
    - `tms_2604_43_unq_2_tpr_commonid.sas7bdat`
  - SAS log file: `add_commonID_to_hybrid_sam_files_HPC.log`

## 5. SAM Compare
Scripts `sam_compare_hybrid_reads.sbatch` and `sam_compare.shan.py` (from Filter orthologs section) were used.

`sam_compare_hybrid_reads.sbatch` has been changed as listed below:
  - DO NOT REPLACE SAPCE WITH UNDERSCORE!!! DIFFERENT FROM LUCAS'S METHOD; I USED PAIRED READS FOR MAPPING
  - The read length is 150, instead of 100 in Lucas's analysis

```bash
## Tms (short-liguled) reads to TDU and TPR
for i in 2604_24 2604_43 2604_48
do

SAMA=${IN}/Tms_${i}_unq_2_TDU_commonID.sam
SAMB=${IN}/Tms_${i}_unq_2_TPR_commonID.sam

### Concatenate reads for use in sam-compare; sed 's/ /_/g': replace all (g, global) space with _
# DO NOT REPLACE SAPCE WITH UNDERSCORE!!! DIFFERENT FROM LUCAS'S METHOD; I USED PAIRED READS FOR MAPPING
cat ${READ}/Tms_${i}_*.fastq > ${TMPDIR}/Tms_${i}.fastq

# LENGTH OF READS (-L) CHANGED TO 150
python ${SCRIPTS}/sam_compare.shan.py \
	-d \
	-l 150 \
	-f ${IN}/TDU_tpr_bed_for_sam_compare.bed \
	-q ${TMPDIR}/Tms_${i}.fastq \
	-A $SAMA \
	-B $SAMB \
	-c ${OUT}/ase_counts_Tms_${i}_2_tdu_tpr.csv \
	-t ${OUT}/ase_totals_Tms_${i}_2_tdu_tpr.csv \
	-g ${LOGS}/ase_counts_Tms_${i}_2_tdu_tpr.log
done
```

Output, example:
  - `ase_counts_Tml_2605_9_2_tdu_tpr.csv`, which contains 11,864 orthologs; but only those orthologs from SAM files have expression level displayed.
  - `ase_totals_Tml_2605_9_2_tdu_tpr.csv`
    - ```
      Count totals:
      1:	a_single_exact	22456
      2:	a_single_inexact	16362
      3:	a_multi_exact	51346
      4:	a_multi_inexact	1090
      5:	b_single_exact	20947
      6:	b_single_inexact	15873
      7:	b_multi_exact	56179
      8:	b_multi_inexact	576
      9:	both_single_exact_same	0
      10:	both_single_exact_diff	158508
      11:	both_single_inexact_same	0
      12:	both_single_inexact_diff	60968
      13:	both_inexact_diff_equal	28749
      14:	both_inexact_diff_a_better	16128
      15:	both_inexact_diff_b_better	16091
      16:	both_multi_exact	1655741
      17:	both_multi_inexact	4922
      18:	a_single_exact_b_single_inexact	13966
      19:	a_single_inexact_b_single_exact	14069
      20:	a_single_exact_b_multi_exact	74196
      21:	a_multi_exact_b_single_exact	66710
      22:	a_single_exact_b_multi_inexact	255
      23:	a_multi_inexact_b_single_exact	363
      24:	a_single_inexact_b_multi_exact	46549
      25:	a_multi_exact_b_single_inexact	41664
      26:	a_single_inexact_b_multi_inexact	1279
      27:	a_multi_inexact_b_single_inexact	1513
      28:	a_multi_exact_b_multi_inexact	11791
      29:	a_multi_inexact_b_multi_exact	14237
      30:	total_count	2351560
      ```

## 6. Import ASE counts into SAS
Script `Replicate_rename_poly.sh` was used to rename csv files, which is erquired for downstream analysis.
```bash
cp ${IN}/ase_counts_Tms_2604_24_2_tdu_tpr.csv ${OUT}/ase_counts_Tms_1_2_tdu_tpr.csv
cp ${IN}/ase_counts_Tms_2604_43_2_tdu_tpr.csv ${OUT}/ase_counts_Tms_2_2_tdu_tpr.csv
cp ${IN}/ase_counts_Tms_2604_48_2_tdu_tpr.csv ${OUT}/ase_counts_Tms_3_2_tdu_tpr.csv

cp ${IN}/ase_counts_Tml_2605_9_2_tdu_tpr.csv ${OUT}/ase_counts_Tml_1_2_tdu_tpr.csv
cp ${IN}/ase_counts_Tml_2605_24_2_tdu_tpr.csv ${OUT}/ase_counts_Tml_2_2_tdu_tpr.csv
cp ${IN}/ase_counts_Tml_2605_42_2_tdu_tpr.csv ${OUT}/ase_counts_Tml_3_2_tdu_tpr.csv
```

Scripts `submit_import_ase_counts_hybrid.bash` and `import_ase_counts_hybrid.sas` were used to import ASE counts into SAS.

Output:
  - `ase_4_bayes_tms_reads_tdu_tpr.sas7bdat`
  - `ase_4_bayes_tml_reads_tdu_tpr.sas7bdat`
  - `import_ase_counts_hybrid.log`

## 7. Prep for Bayesian Analysis
Scripts `submit_bayesian_make_sbys_reps_hybrid.bash` and `bayesian_make_sbys_reps_hybrid.sas` were used in this step.

Output:
  - sorted `ase_4_bayes_tms_reads_tdu_tpr.sas7bdat`
  - sorted `ase_4_bayes_tml_reads_tdu_tpr.sas7bdat`
  - `ase_bayes_tms_rds_tdu_tpr_sbys.sas7bdat`
  - `ase_bayes_tml_rds_tdu_tpr_sbys.sas7bdat`
  - `bayesian_make_sbys_reps_hybrid.log`

## 8. Bayesian Flag Analyze
"This step flags each feature for analysis (1) or not (0).Each feature must have at least one read and all reps should be present. This check for presence is important when running different rep cunts" --Lucas

Scripts `submit_bayesian_flag_analyze_hybrid.bash` and `bayesian_flag_analyze_hybrids.sas` were usded in this step. There are 3 replicates for each polyploid species.

Output:
  - `bayes_flag_tms_reads_tdu_tpr.sas7bdat`
  - `bayes_flag_tml_reads_tdu_tpr.sas7bdat`
  - `bayesian_flag_analyze_hybrids.log`

## 9. Export Bayesian Flag Data
"Export those data which were flagged for analysis (1) so that we can run the PG analysis" -- Lucas

Scripts `submit_bayesian_export_flagged_dataset_hybrid.bash` and `bayesian_export_flagged_dataset_hybrid.sas`, which has been modified [here](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/694e44098e567b8cab26bc523d6411874bb2b9ad/Polyploid_alignment/bayesian_export_flagged_dataset_hybrid.sas#L31-L34), were used in this step. There are 3 replicates for each species.

Output:
  - **`ase_bayes_Tms_tdu_tpr_flag.csv`**; the two csv files have truncated commonID for 3 orthologs; but all commonIDs are uniq even after truncation.
    - ```
      commonID,LINE_TOTAL_1,LINE_TOTAL_2,LINE_TOTAL_3,TESTER_TOTAL_1,TESTER_TOTAL_2,TESTER_TOTAL_3,flag_analyze
      Tpr_TRINITY_DN10005_c0_g2|Tdu_TRINITY_DN21586_c5_g2,0,0,0,0,0,0,0
      Tpr_TRINITY_DN10006_c0_g1|Tdu_TRINITY_DN18006_c3_g3,0,0,0,0,0,0,0
      Tpr_TRINITY_DN10008_c0_g2|Tdu_TRINITY_DN16267_c0_g1,0,0,0,0,0,0,0
      Tpr_TRINITY_DN10008_c0_g5|Tdu_TRINITY_DN16267_c0_g4,0,0,0,0,0,0,0
      Tpr_TRINITY_DN10010_c0_g1|Tdu_TRINITY_DN19621_c0_g1,21,28,22,45,35,49,1
      Tpr_TRINITY_DN10012_c0_g1|Tdu_TRINITY_DN21718_c1_g1,0,0,0,0,0,0,0
      Tpr_TRINITY_DN10017_c0_g1|Tdu_TRINITY_DN15873_c0_g1,5,5,6,1,2,3,1
      Tpr_TRINITY_DN10018_c0_g1|Tdu_TRINITY_DN3659_c0_g1,1,2,0,1,2,1,1
      ```
  - **`ase_bayes_Tml_tdu_tpr_flag.csv`**
    - ```
      commonID,LINE_TOTAL_1,LINE_TOTAL_2,LINE_TOTAL_3,TESTER_TOTAL_1,TESTER_TOTAL_2,TESTER_TOTAL_3,flag_analyze
      Tpr_TRINITY_DN10005_c0_g2|Tdu_TRINITY_DN21586_c5_g2,0,0,0,0,0,0,0
      Tpr_TRINITY_DN10006_c0_g1|Tdu_TRINITY_DN18006_c3_g3,0,0,0,0,0,0,0
      Tpr_TRINITY_DN10008_c0_g2|Tdu_TRINITY_DN16267_c0_g1,0,0,0,0,0,0,0
      Tpr_TRINITY_DN10008_c0_g5|Tdu_TRINITY_DN16267_c0_g4,0,0,0,0,0,0,0
      Tpr_TRINITY_DN10010_c0_g1|Tdu_TRINITY_DN19621_c0_g1,185,7,24,220,15,43,1
      Tpr_TRINITY_DN10012_c0_g1|Tdu_TRINITY_DN21718_c1_g1,0,0,0,0,0,0,0
      Tpr_TRINITY_DN10017_c0_g1|Tdu_TRINITY_DN15873_c0_g1,2,3,4,2,5,1,1
      ```
  - `ase_bayes_tms_tdu_tpr_flag.sas7bdat`
  - `ase_bayes_tml_tdu_tpr_flag.sas7bdat`
  - `bayesian_export_flagged_dataset_hybrid.log`

## 10. Split ASE Table
"This step is performed to speed up the analysis by separating the process into reasonably sized chunks" -- Lucas

Script `split_emp_bayesian_ase_table_hybrids.bash` was used.

Input:
  - `ase_bayes_Tms_tdu_tpr_flag.csv`
  - `ase_bayes_Tml_tdu_tpr_flag.csv`

Output:
  - `split_Tms_tdu_tpr/split_(1-500).csv`
  - `split_Tml_tdu_tpr/split_(1-500).csv`

## 11. Run Bayesian Possion-Gamma
"Execute the Bayesian PG machine to identify expression bias between the orthologous pairs. For the hybrid, reads were mapped back to both references to identify loci that exhibit an expression bias toward each parental reference. This was done using all loci and is later filtered (keeping loci that do not exhibit mapping bias -- derived from the parent PG pipe)." -- Lucas

Script `run_emp_bayesian_machine_hybrids.sbatch` was used.

## 12. Combine Bayesian Poisson-Gamma Output
Scripts `combine_emp_bayesian_ase_table_hybrid.bash` and `catTable.py` were used in this step.

Output:
  - `PG_emp_bayesian_results_Tms_tdu_tpr_hybrid.csv`, which contains 5,118 orthologous pairs.
    - ```
      commonID,q4_mean_theta,q4_q025,q4_q975,q5_mean_theta,q5_q025,q5_q975,q6_mean_theta,q6_q025,q6_q975
      Tpr_TRINITY_DN11281_c1_g9|Tdu_TRINITY_DN15992_c0_g1,0.712,0.406,0.896,0.669,0.304,0.893,0.645,0.271,0.879
      Tpr_TRINITY_DN11283_c3_g1|Tdu_TRINITY_DN25596_c4_g2,0.608,0.418,0.786,0.529,0.333,0.708,0.446,0.259,0.637
      Tpr_TRINITY_DN11283_c4_g7|Tdu_TRINITY_DN21302_c2_g2,0.297,0.122,0.491,0.229,0.092,0.406,0.168,0.06,0.317
      Tpr_TRINITY_DN11284_c2_g19|Tdu_TRINITY_DN20652_c0_g3,0.527,0.284,0.758,0.447,0.202,0.699,0.384,0.169,0.62
      Tpr_TRINITY_DN11285_c1_g4|Tdu_TRINITY_DN17239_c2_g3,0.187,0.093,0.299,0.136,0.065,0.224,0.096,0.048,0.169
      ...
      ```
  - `PG_emp_bayesian_results_Tml_tdu_tpr_hybrid.csv`, which contains 5,137 orthologous pairs.
    - ```
      commonID,q4_mean_theta,q4_q025,q4_q975,q5_mean_theta,q5_q025,q5_q975,q6_mean_theta,q6_q025,q6_q975
      Tpr_TRINITY_DN11281_c1_g9|Tdu_TRINITY_DN15992_c0_g1,0.734,0.519,0.878,0.686,0.445,0.861,0.637,0.377,0.828
      Tpr_TRINITY_DN11283_c3_g1|Tdu_TRINITY_DN25596_c4_g2,0.603,0.36,0.796,0.524,0.298,0.746,0.452,0.231,0.691
      Tpr_TRINITY_DN11283_c4_g7|Tdu_TRINITY_DN21302_c2_g2,0.573,0.411,0.724,0.484,0.31,0.64,0.398,0.248,0.545
      Tpr_TRINITY_DN11284_c2_g19|Tdu_TRINITY_DN20652_c0_g3,0.527,0.266,0.749,0.462,0.231,0.703,0.379,0.142,0.638
      Tpr_TRINITY_DN11285_c1_g4|Tdu_TRINITY_DN17239_c2_g3,0.163,0.055,0.3,0.121,0.037,0.238,0.086,0.025,0.171
      ...
      ```

## 13. Import Bayesian Poisson-Gamma Results to SAS
Scripts `import_bayesian_results_hybrid.sas` and `execute_import_bayesian_flag_results_hybrid.bash` were used in this step.

Input:
  - `PG_emp_bayesian_results_Tms_tdu_tpr_hybrid.csv`
  - `PG_emp_bayesian_results_Tml_tdu_tpr_hybrid.csv`

Output:
  - `emp_tms_tdu_tpr.sas7bdat`
  - `emp_tml_tdu_tpr.sas7bdat`
  - `import_bayesian_results_hybrid.log`

## 14. Flag Significant Bayesian Poisson-Gamma Output
Flag those putative orthologous pairs that exhibit mapping bias?

Scripts `execute_bayesian_flag_sig_results_hybrid.bash` and `bayesian_flag_sig_results_hybrid_pdf.sas` were used in this step.

Output:
  - `bayes_flag_sig_tms_tdu_tpr.sas7bdat`
  - `bayes_flag_sig_tml_tdu_tpr.sas7bdat`
  - `bayes_flag_sig_Tms_tdu_tpr.pdf`
  - `bayes_flag_sig_Tml_tdu_tpr.pdf`
  - `bayesian_flag_sig_hybrid.log`

![tms_tdu_tpr](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Polyploid_alignment/images/emp_tms_tdu_tpr.png)

![tms_tdu_tpr_sig](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Polyploid_alignment/images/emp_tms_tdu_tpr_sig.png)

![tml_tdu_tpr](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Polyploid_alignment/images/emp_tml_tdu_tpr.png)

![tml_tdu_tpr_sig](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Polyploid_alignment/images/emp_tml_tdu_tpr_sig.png)

## 15. Generate CSVs of Flagged Significant Bayesian Possion-Gamma Output
Scripts `execute_output_ase_bayesian_flagged_CSVs.bash` and `output_ase_bayesian_flagged_hybrids_CSVs.sas` have been used in this step.

Output:
  - `bayes_flag_sig_Tms_for_UR.csv`

```
commonID,q4_mean_theta,q4_q025,q4_q975,q5_mean_theta,q5_q025,q5_q975,q6_mean_theta,q6_q025,q6_q975,flag_q4_sig,flag_q5_sig,flag_q6_sig,flag_sig_Tms_tdu_tpr
Tpr_TRINITY_DN11281_c1_g9|Tdu_TRINITY_DN15992_c0_g1,0.712,0.406,0.896,0.669,0.304,0.893,0.645,0.271,0.879,0,0,0,0
Tpr_TRINITY_DN11283_c3_g1|Tdu_TRINITY_DN25596_c4_g2,0.608,0.418,0.786,0.529,0.333,0.708,0.446,0.259,0.637,0,0,0,0
Tpr_TRINITY_DN11283_c4_g7|Tdu_TRINITY_DN21302_c2_g2,0.297,0.122,0.491,0.229,0.092,0.406,0.168,0.06,0.317,1,1,1,1
Tpr_TRINITY_DN11284_c2_g19|Tdu_TRINITY_DN20652_c0_g3,0.527,0.284,0.758,0.447,0.202,0.699,0.384,0.169,0.62,0,0,0,0
Tpr_TRINITY_DN11285_c1_g4|Tdu_TRINITY_DN17239_c2_g3,0.187,0.093,0.299,0.136,0.065,0.224,0.096,0.048,0.169,1,1,1,1    
```
  - `bayes_flag_sig_Tml_for_UR.csv`
  
```
commonID,q4_mean_theta,q4_q025,q4_q975,q5_mean_theta,q5_q025,q5_q975,q6_mean_theta,q6_q025,q6_q975,flag_q4_sig,flag_q5_sig,flag_q6_sig,flag_sig_Tml_tdu_tpr
Tpr_TRINITY_DN11281_c1_g9|Tdu_TRINITY_DN15992_c0_g1,0.734,0.519,0.878,0.686,0.445,0.861,0.637,0.377,0.828,1,0,0,0
Tpr_TRINITY_DN11283_c3_g1|Tdu_TRINITY_DN25596_c4_g2,0.603,0.36,0.796,0.524,0.298,0.746,0.452,0.231,0.691,0,0,0,0
Tpr_TRINITY_DN11283_c4_g7|Tdu_TRINITY_DN21302_c2_g2,0.573,0.411,0.724,0.484,0.31,0.64,0.398,0.248,0.545,0,0,0,0
Tpr_TRINITY_DN11284_c2_g19|Tdu_TRINITY_DN20652_c0_g3,0.527,0.266,0.749,0.462,0.231,0.703,0.379,0.142,0.638,0,0,0,0
Tpr_TRINITY_DN11285_c1_g4|Tdu_TRINITY_DN17239_c2_g3,0.163,0.055,0.3,0.121,0.037,0.238,0.086,0.025,0.171,1,1,1,1
```
  - `output_ase_bayesian_flagged_CSVs.log`


  
  
  