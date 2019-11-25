# Filtering orthologous pairs with biased mapping
## 1. Description
Tdu and Tpr reads were mapping back to the supertranscripts. For example, if Tdu reads are biased mapping to a Tpr supertranscript, this Tpr supertranscript will be filtered out. The method below is adapted from [Locuas's method](https://htmlpreview.github.io/?https://github.com/BBarbazukLab/papers/blob/master/Boatwright_et_al.,2018/New_World_PG_pipeline_documentation.html#Filter), with the following changes:
  - SAM files were generated using **paired-end reads in current study**; Lucas used single-end reads for mapping
  - **Read length in current study is 150 bp**; in Lucas's study, read length is 100 bp
  - There are **6 and 3 replications for Tdu and Tpr**, respectively in this study; Lucas's study has 3 replications for both Tdu and Tpr

**All changed scripts to accommote above changes were shown in bold**

![Filtering orthologs](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Filter_orthologs/Images/Filter_orthologs_sample-1.png?raw=true)

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

## 3. Filter SAM files by bed files
"In the previous step, we wanted to align to the entire transcriptome to prevent reads from mapping greedily to spurious locations in the transcriptome. Here, we isolate reads that map within our Common Orthologous REgions (COREs) so that we can make comparisons between reference mappings." -- Lucas

### 3.1 Filter CORE_bed files to inlcude those only inlcuded in shared orthologs
`Shared_reciprocated_blast_hits_SingleCopyOrthogroups_parser_FullDescription_filtered_2.0.txt` was used for downstream analysis. There are 11,863 shared orthologous pairs (P_VAL >= 1e-10 and Identity >= 0.8 and AlignmentLength >= 200), which is from section "Shared_COREs_wu-blast_OrthoFinder".
  - There are 11,863 shared orthologs for downstream analysis
  - ```
    Tpr_TRINITY_DN14318_c0_g1       2973    Tdu_TRINITY_DN17012_c3_g3       2154    2798    0.      96.9    96.989966555184 598     2058    1465    401     997     -
    Tpr_TRINITY_DN13887_c2_g3       2065    Tdu_TRINITY_DN23158_c1_g4       2112    10072   0.      98.8    98.838334946757 2066    2065    1       35      2094    -
    Tpr_TRINITY_DN13936_c2_g4       2197    Tdu_TRINITY_DN24503_c1_g1       2378    4225    0.      93.7    93.7371663244353        974     1006    41      1385    2350    -
    Tpr_TRINITY_DN13936_c2_g3       2635    Tdu_TRINITY_DN22881_c5_g1       3487    2389    4.2e-291        95.3    95.3934740882918    521     521     1       2962    3482    -
    Tpr_TRINITY_DN13936_c2_g2       5116    Tdu_TRINITY_DN20656_c5_g1       5784    3220    0.      93.6    93.6742934051144        743     3695    4431    4376    5112    +
    ...
    ```

Input bed files are generated from script BLAST_COREs.py from section "WU-Blast_Analysis".
  - `Tdu_DB_Tpr_query_parser_single_hit_FullName.txt.filtered_Q.bed`, which includes 42,595 orthologous pairs.
    - ```
      Tpr_TRINITY_DN31201_c0_g1       275     410     Tpr_TRINITY_DN31201_c0_g1,Tdu_TRINITY_DN10064_c0_g1     .       +
      Tpr_TRINITY_DN11072_c2_g4       676     1023    Tpr_TRINITY_DN11072_c2_g4,Tdu_TRINITY_DN7930_c0_g1      .       +
      Tpr_TRINITY_DN14318_c0_g1       1464    2057    Tpr_TRINITY_DN14318_c0_g1,Tdu_TRINITY_DN17012_c3_g3     .       +
      Tpr_TRINITY_DN13887_c2_g2       0       243     Tpr_TRINITY_DN13887_c2_g2,Tdu_TRINITY_DN23704_c6_g3     .       +
      Tpr_TRINITY_DN13887_c2_g3       0       2064    Tpr_TRINITY_DN13887_c2_g3,Tdu_TRINITY_DN23158_c1_g4     .       +
      ...
      ```
  - `Tdu_DB_Tpr_query_parser_single_hit_FullName.txt.filtered_S.bed`, which includes 42,595 orthologous pairs.
    - ```
      Tdu_TRINITY_DN10064_c0_g1       75      210     Tpr_TRINITY_DN31201_c0_g1,Tdu_TRINITY_DN10064_c0_g1     .       +
      Tdu_TRINITY_DN7930_c0_g1        0       346     Tpr_TRINITY_DN11072_c2_g4,Tdu_TRINITY_DN7930_c0_g1      .       +
      Tdu_TRINITY_DN17012_c3_g3       400     996     Tpr_TRINITY_DN14318_c0_g1,Tdu_TRINITY_DN17012_c3_g3     .       +
      Tdu_TRINITY_DN23704_c6_g3       0       243     Tpr_TRINITY_DN13887_c2_g2,Tdu_TRINITY_DN23704_c6_g3     .       +
      Tdu_TRINITY_DN23158_c1_g4       34      2093    Tpr_TRINITY_DN13887_c2_g3,Tdu_TRINITY_DN23158_c1_g4     .       +
      ...
      ```

The following scripts were used to filter bed files to include only those shared orthologous pairs
  - `FilterBedFile_V1.py`
  - `FilterBedFile_V2.py`

Output:
  - `TDU-tpr_overlaps_orthologs.bed`, which includes those shared 11,863 orthologs.
    - ```
      Tdu_TRINITY_DN17012_c3_g3	400	996	Tpr_TRINITY_DN14318_c0_g1,Tdu_TRINITY_DN17012_c3_g3	.	+
      Tdu_TRINITY_DN23158_c1_g4	34	2093	Tpr_TRINITY_DN13887_c2_g3,Tdu_TRINITY_DN23158_c1_g4	.	+
      Tdu_TRINITY_DN24503_c1_g1	1384	2349	Tpr_TRINITY_DN13936_c2_g4,Tdu_TRINITY_DN24503_c1_g1	.	+
      ```    
  - `TPR-tdu_overlaps_orthologs.bed`, which includes those shared 11,863 orthologs.
    - ```
      Tpr_TRINITY_DN14318_c0_g1	1464	2057	Tpr_TRINITY_DN14318_c0_g1,Tdu_TRINITY_DN17012_c3_g3	.	+
      Tpr_TRINITY_DN13887_c2_g3	0	2064	Tpr_TRINITY_DN13887_c2_g3,Tdu_TRINITY_DN23158_c1_g4	.	+
      Tpr_TRINITY_DN13936_c2_g4	40	1005	Tpr_TRINITY_DN13936_c2_g4,Tdu_TRINITY_DN24503_c1_g1	.	+
      ```

### 3.2 Filter SAM files by using bed files including only those shared orthologs
Script `SAM_filter_by_bed_V1.sh` and `sam-filter-by-bed.pl` was used
```bash
for FILE in `ls *_Tdu_ST_V1_uniq.sam`; do
	echo "${FILE} is going to be processed"
	# filter sam file of TDU/TPR reads aligned to TDU with TDU_tpr bed file
	perl ${OUT}/sam-filter-by-bed.pl \
		-b ${OUT}/TDU-tpr_overlaps_orthologs.bed \
		-s ${FILE} \
		> ${OUT}/${FILE%_reads_Tdu_ST_V1_uniq.*}_uniq_2_TDU_filter_for_Tms.sam		
	echo -e "\t${FILE} has been filtered based on the TDU_tpr bed file"
done

for FILE in `ls *_Tpr_ST_V1_uniq.sam`; do
	echo "$FILE is going to be processed"
	# filter sam file of TDU/TPR reads aligned to TPR with TPR_tdu bed file
	perl ${OUT}/sam-filter-by-bed.pl \
		-b ${OUT}/TPR-tdu_overlaps_orthologs.bed \
		-s ${FILE} \
		> ${OUT}/${FILE%_reads_Tpr_ST_V1_uniq.*}_uniq_2_TPR_filter_for_Tms.sam		
	echo -e "\t$FILE has been filtered based on the TPR_tdu bed file"
done
```

Input (examples):
  - `Tdu_2613_11_reads_Tdu_ST_V1_uniq.sam`
    - e.g. reference `Tdu_TRINITY_DN17012_c3_g3`; column no.4: mapped position of base 1 of a read on the reference sequence
      - ```
        J00160:58:HG3KCBBXX:3:1106:16285:2914	99	Tdu_TRINITY_DN17012_c3_g3	24	42	141M	=	135	252	CGTATTTGCTACATCATGAGCATTCATTTTATAACAAATCCATATTATTTTTTTGAACATAAGTTTATTCTCTATCCTCAACAAACACATTTATCACGTTTAAATCTATTTTAACAAATTTAAATTTGTGAGCAATAAAAA	JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJFJJJJJJJJJJJJJJJJJJJJJJJFJJJ	AS:i:0	XN:i:0	XM:i:0	XO:i:0	XG:i:0	NM:i:0	MD:Z:141	YS:i:0	YT:Z:CP
        J00160:58:HG3KCBBXX:3:1214:29457:11073	145	Tdu_TRINITY_DN17012_c3_g3	37	40	141M	=	51	155	ATCTGAGCATTCATTTTATAACAAATCCATATTATTTTTTTGAACATAAGTTTATTCTCTATCCTCAACAAACACATTTATCACGTTTAAATCTATTTTAACAAATTTAAATTTGTGAGCAATAAAAATAATCGAGACACC	AJJJJJJFJJFAFJJJJJJFFF<JJJJJFJJFJJJJFJFFJJJJJJJJFFJJJJJJJFFJJJ<JJJJJJJJJJJFJJJJJJJJJJFJFJJJJJJFJJFJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJFJJ	AS:i:-17	XN:i:0	XM:i:3	XO:i:0	XG:i:0	NM:i:3	MD:Z:0T0C0A138	YS:i:-18	YT:Z:DP
        J00160:58:HG3KCBBXX:3:2224:4239:17702	99	Tdu_TRINITY_DN17012_c3_g3	39	42	141M	=	132	234	ATGAGCATTCATTTTATAACAAATCCATATTATTTTTTTGAACATAAGTTTATTCTCTATCCTCAACAAACACATTTATCACGTTTAAATCTATTTTAACAAATTTAAATTTGTGAGCAATAAAAATAATCGAGACACCTT	JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJFJJJJJJJJJJFJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJFJJAJJJJJJFFJJJJJJJJJFAJ<JJJAAFA	AS:i:0	XN:i:0	XM:i:0	XO:i:0	XG:i:0	NM:i:0	MD:Z:141	YS:i:-6	YT:Z:CP
        ......
        J00160:58:HG3KCBBXX:3:1115:17594:24173	97	Tdu_TRINITY_DN17012_c3_g3	2018	40	132M5I4M	=	2010	-144	GATAATTGAGGTAGGCGGAGATGATGCGCCTAAGAGATTTGACTTCTAGGGCTTCCTCGTACTCCCTCCGGCGAAGTTCCTCGTCGCTGTTCGACATATTGTTTTTCAGAGTTTGATGAACCACTGAAGCACGTTTAGCGG	JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ	AS:i:-38	XN:i:0	XM:i:3	XO:i:1	XG:i:5	NM:i:8	MD:Z:133T0T0T0	YS:i:0	YT:Z:DP
        J00160:58:HG3KCBBXX:3:1115:18111:24788	97	Tdu_TRINITY_DN17012_c3_g3	2018	40	132M5I4M	=	2010	-144	GATAATTGAGGTAGGCGGAGATGATGCGCCTAAGAGATTTGACTTCTAGGGCTTCCTCGTACTCCCTCCGGCGAAGTTCCTCGTCGCTGTTCGACATATTGTTTTTCAGAGTTTGATGAACCACTGAAGCACGTTTAGCGG	JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ<JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ	AS:i:-38	XN:i:0	XM:i:3	XO:i:1	XG:i:5	NM:i:8	MD:Z:133T0T0T0	YS:i:0	YT:Z:DP
        J00160:58:HG3KCBBXX:3:1118:27854:11917	147	Tdu_TRINITY_DN17012_c3_g3	2019	42	65M	=	1788	-296	ATAATTGAGTTAGGCGGAGATGATGCGCCTAAGAGATTTGACTTCTAGGGCTTCCTCGTACTCCC	AJA7J<777-777-A--7A<FJJ7JF<F<---<-AF-<-77F<-<AJ-7-<AJAFA7<FA-7<7A	AS:i:-3	XN:i:0	XM:i:1	XO:i:0	XG:i:0	NM:i:1	MD:Z:9G55	YS:i:0	YT:Z:CP
        ```
  - `Tdu_2613_11_reads_Tpr_ST_V1_uniq.sam`

Output (examples):
  - `Tdu_2613_11_uniq_2_TDU_filter_for_Tms.sam`
    - e.g. reference `Tdu_TRINITY_DN17012_c3_g3`; in `TDU-tpr_overlaps_orthologs.bed`, the CORE region is from 400 to 996
      - ```
        J00160:58:HG3KCBBXX:3:2126:6421:10405	99	Tdu_TRINITY_DN17012_c3_g3	262	42	141M	=	278	157	CCTGTTGCCAATGGTTTCTTTCGCATTGTCCAAAATGCTGAAAAATAGTGATTTTGCATCATTGCTCGGGGATTTGTAGTATACGTTGTTTCGATTGTCTTCTCGAGCTCCAGCTCAAATCCATAACTGATTGCAACCCTT	JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJFJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ	AS:i:0	XN:i:0	XM:i:0	XO:i:0	XG:i:0	NM:i:0	MD:Z:141	YS:i:0	YT:Z:CP
        J00160:58:HG3KCBBXX:3:2221:19319:18265	163	Tdu_TRINITY_DN17012_c3_g3	262	42	141M	=	464	343	CCTGTTGCCAATGGTTTCTTTCGCATTGTCCAAAATGCTGAAAAATAGTGATTTTGCATCATTGCTCGGGGATTTGTAGTATACGTTGTTTCGATTGTCTTCTCGAGCTCCAGCTCAAATCCATAACTGATTGCAACCCTT	JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJFJJJJJJJJJJJJJJJJJJJJJJJJFFJJAAJJFJJJJJJJJJJJJJJJJJJJJJFJ	AS:i:0	XN:i:0	XM:i:0	XO:i:0	XG:i:0	NM:i:0	MD:Z:141	YS:i:0	YT:Z:CP
        J00160:58:HG3KCBBXX:3:1205:23845:28709	163	Tdu_TRINITY_DN17012_c3_g3	262	42	141M	=	331	210	CCTGTTGCCAATGGTTTCTTTCGCATTGTCCAAAATGCTGAAAAATAGTGATTTTGCATCATTGCTCGGGGATTTGTAGTATACGTTGTTTCGATTGTCTTCTCGAGCTCCAGCTCAAATCCATAACTGATTGCAACCCTT	JJJJJJFJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJFJJJFJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJFJJFJJJJJJJJJJJFJJJJJJJJJJJJJJJJJFJJJJJ	AS:i:0	XN:i:0	XM:i:0	XO:i:0	XG:i:0	NM:i:0	MD:Z:141	YS:i:0	YT:Z:CP
        ......
        J00160:58:HG3KCBBXX:3:2125:2747:38820	161	Tdu_TRINITY_DN17012_c3_g3	895	40	103M2I3M3I5M	=	1470	716	GGAACTAGACAAGTAGGAGGGCTTTCTTTACTACGGTCAGGGAAATGGCGTGTAAGCTCTTCAAGAATAGGCCCATAACATTGGTCTCGTTCCTTCTGTCCCTCAGTGGCCCAGTC	FJJJJJJJJJJJJFJFJJJJJJAJJJJAFJJJJJJJ<JJAJJFJFAJJJJFJ<AJJJJJJFJJJJJJJJJJJJJJFJJJJAAAJ7<<FJF<JJFJJFFFJJJJJJJJFJJAJAA)<	AS:i:-37XN:i:0	XM:i:3	XO:i:2	XG:i:5	NM:i:8	MD:Z:107T0T0A1	YS:i:0	YT:Z:DP
        J00160:58:HG3KCBBXX:3:2212:15696:40860	147	Tdu_TRINITY_DN17012_c3_g3	911	23	85M14I5M	=	787	-214	GAGGGCTTGCTTTACTACGGTCAGGGAAATGGCGTGTAAGCTCTTCAAGAATAGGCCCATAACATTGGTCTCGTTCCTTCTGTCCCTCAGTGGCCCAGTCTCTG	A7AAJA-7-A<<7JJFA--F-77FFFAF7-77AJFJFJJF7-FAF7JJJ7J<JJA7<<<--77A--FFFA-7F<-F7JJFFFJJFFFFJJA<F7--JAJFJJJJ	AS:i:-56	XN:i:0	XM:i:2	XO:i:1	XG:i:14	NM:i:16	MD:Z:8T78G2	YS:i:-3	YT:Z:CP
        J00160:58:HG3KCBBXX:3:2227:8258:9649	73	Tdu_TRINITY_DN17012_c3_g3	923	8	75M2I2M1I5M	=	923	TACTACGGTCAGGGAAATGGCGTGTAAGCTCTTCAAGAATAGGCCCATAACATTGGTCTCGTTCCTTCTGTCCCTCAGTGGCCCA	JFJJAJAFAAJFFAJJAAFA<A-F<-FAA7AFFFJFAJFJ<JFFJ<-AFFF-JJJF-7JAJJFAJJJFJ<FJ<A--77F<FFAFJ	AS:i:-29	XN:i:0	XM:i:2	XO:i:2	XG:i:3	NM:i:5	MD:Z:79T0T1	YT:Z:UP
        ```
  - `Tdu_2613_11_uniq_2_TPR_filter_for_Tms.sam`

## 4. Import BED files into SAS
### 4.1 Reformat BED files for downstream analysis

Input:
  - `TDU-tpr_overlaps_orthologs.bed`
  - `TPR-tdu_overlaps_orthologs.bed`

Using terminal window: `tr "," "|" < orthologs.bed > orthologs.pipe.bed`
  - the purpose is to change the comma in the 4th column to pipe "|"
  - Output:
    - `TDU-tpr_overlaps_orthologs.pipe.bed`
      - ```
        Tdu_TRINITY_DN17012_c3_g3       400     996     Tpr_TRINITY_DN14318_c0_g1|Tdu_TRINITY_DN17012_c3_g3     .       +
        Tdu_TRINITY_DN23158_c1_g4       34      2093    Tpr_TRINITY_DN13887_c2_g3|Tdu_TRINITY_DN23158_c1_g4     .       +
        Tdu_TRINITY_DN24503_c1_g1       1384    2349    Tpr_TRINITY_DN13936_c2_g4|Tdu_TRINITY_DN24503_c1_g1     .       +
        ```
    - `TPR-tdu_overlaps_orthologs.pipe.bed`
      - ```
        Tpr_TRINITY_DN14318_c0_g1       1464    2057    Tpr_TRINITY_DN14318_c0_g1|Tdu_TRINITY_DN17012_c3_g3     .       +
        Tpr_TRINITY_DN13887_c2_g3       0       2064    Tpr_TRINITY_DN13887_c2_g3|Tdu_TRINITY_DN23158_c1_g4     .       +
        Tpr_TRINITY_DN13936_c2_g4       40      1005    Tpr_TRINITY_DN13936_c2_g4|Tdu_TRINITY_DN24503_c1_g1     .       +
        ```
      
Using terminal window: `tr '\t' ',' < orthologs.bed > orthologs.csv`
  - the purpose is to change tab to comma
  - Output:
    - `TDU-tpr_overlaps_orthologs.csv`, which includes those shared 11,863 orthologs.
      - ```
        Tdu_TRINITY_DN17012_c3_g3,400,996,Tpr_TRINITY_DN14318_c0_g1|Tdu_TRINITY_DN17012_c3_g3,.,+
        Tdu_TRINITY_DN23158_c1_g4,34,2093,Tpr_TRINITY_DN13887_c2_g3|Tdu_TRINITY_DN23158_c1_g4,.,+
        Tdu_TRINITY_DN24503_c1_g1,1384,2349,Tpr_TRINITY_DN13936_c2_g4|Tdu_TRINITY_DN24503_c1_g1,.,+
        ```
    - `TPR-tdu_overlaps_orthologs.csv`, which includes those shared 11,863 orthologs.
      - ```
        Tpr_TRINITY_DN14318_c0_g1,1464,2057,Tpr_TRINITY_DN14318_c0_g1|Tdu_TRINITY_DN17012_c3_g3,.,+
        Tpr_TRINITY_DN13887_c2_g3,0,2064,Tpr_TRINITY_DN13887_c2_g3|Tdu_TRINITY_DN23158_c1_g4,.,+
        Tpr_TRINITY_DN13936_c2_g4,40,1005,Tpr_TRINITY_DN13936_c2_g4|Tdu_TRINITY_DN24503_c1_g1,.,+
        ```

### 4.2 Import BED files into SAS
The scripts `submit_sas_programs_4_sam_compare.bash` and `import_bed_fix_coord_for_sam_compare_HPC.sas` was used. **The purpose of this step is to fix bed file coordinates**.

Input:
  - `TDU-tpr_overlaps_orthologs.csv`
    - ```
      Tdu_TRINITY_DN17012_c3_g3,400,996,Tpr_TRINITY_DN14318_c0_g1|Tdu_TRINITY_DN17012_c3_g3,.,+
      Tdu_TRINITY_DN23158_c1_g4,34,2093,Tpr_TRINITY_DN13887_c2_g3|Tdu_TRINITY_DN23158_c1_g4,.,+
      Tdu_TRINITY_DN24503_c1_g1,1384,2349,Tpr_TRINITY_DN13936_c2_g4|Tdu_TRINITY_DN24503_c1_g1,.,+
      ```
  - `TPR-tdu_overlaps_orthologs.csv`
    - ```
      Tpr_TRINITY_DN14318_c0_g1,1464,2057,Tpr_TRINITY_DN14318_c0_g1|Tdu_TRINITY_DN17012_c3_g3,.,+
      Tpr_TRINITY_DN13887_c2_g3,0,2064,Tpr_TRINITY_DN13887_c2_g3|Tdu_TRINITY_DN23158_c1_g4,.,+
      Tpr_TRINITY_DN13936_c2_g4,40,1005,Tpr_TRINITY_DN13936_c2_g4|Tdu_TRINITY_DN24503_c1_g1,.,+
      ```

Output:
  - `TDU_tpr_bed_for_sam_compare.bed`, which includes those shared 11,863 orthologs.
    - ```
      commonID	start	end
      Tpr_TRINITY_DN14318_c0_g1|Tdu_TRINITY_DN17012_c3_g3	0	596
      Tpr_TRINITY_DN13887_c2_g3|Tdu_TRINITY_DN23158_c1_g4	0	2059
      Tpr_TRINITY_DN13936_c2_g4|Tdu_TRINITY_DN24503_c1_g1	0	965
      ```
  - `TPR_tdu_bed_for_sam_compare.bed`, which includes those shared 11,863 orthologs.
    - ```
      commonID	start	end
      Tpr_TRINITY_DN14318_c0_g1|Tdu_TRINITY_DN17012_c3_g3	0	593
      Tpr_TRINITY_DN13887_c2_g3|Tdu_TRINITY_DN23158_c1_g4	0	2064
      Tpr_TRINITY_DN13936_c2_g4|Tdu_TRINITY_DN24503_c1_g1	0	965
      ```
Output in SAS format:
  - `tdu_tpr_bed_for_sam_compare.sas7bdat`
  - `tpr_tdu_bed_for_sam_compare.sas7bdat`

## 5. Add commonID to all SAM files
We have to rename putatively orthologous pairs so that SAM compare is comparing the correct sequence pairs.

Scripts `submit_sas_program_add_commonID_parent_V2.sbatch` and `add_commonID_to_parent_sam_files_HPC.V2.sas` were used during this step.

**`add_commonID_to_parent_sam_files_HPC.V2.sas` was changed [here](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/894d236acb59e87d671a99d1149c434f3cb8d9b0/Filter_orthologs/add_commonID_to_parent_sam_files_HPC.V2.sas#L15-L33) and [there](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/894d236acb59e87d671a99d1149c434f3cb8d9b0/Filter_orthologs/add_commonID_to_parent_sam_files_HPC.V2.sas#L64-L78) to fit our own dataset.**
  - **data `TDU_ID_tdu_tpr` uses tdu as reference, which is the second part of the commonID `consensedID = scan(commonID,2,'|')`**
  - **data `TDU_ID_tpr_tdu` uses tpr as reference, which is the first part of the commonID `consensedID = scan(commonID,1,'|')`**
  - **For `s_VAR10` and `s_VAR11`, this is changed from 100 to 150, as the reads length in the current study is paired 150 bp**

Input (examples):
  - `Tdu_2613_11_uniq_2_TDU_filter_for_Tms.sam`
    - ```
      J00160:58:HG3KCBBXX:3:2126:6421:10405	99	Tdu_TRINITY_DN17012_c3_g3	262	42	141M	=	278	157	CCTGTTGCCAATGGTTTCTTTCGCATTGTCCAAAATGCTGAAAAATAGTGATTTTGCATCATTGCTCGGGGATTTGTAGTATACGTTGTTTCGATTGTCTTCTCGAGCTCCAGCTCAAATCCATAACTGATTGCAACCCTT	JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJFJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ	AS:i:0	XN:i:0	XM:i:0	XO:i:0	XG:i:0	NM:i:0	MD:Z:141	YS:i:0	YT:Z:CP
      J00160:58:HG3KCBBXX:3:2221:19319:18265	163	Tdu_TRINITY_DN17012_c3_g3	262	42	141M	=	464	343	CCTGTTGCCAATGGTTTCTTTCGCATTGTCCAAAATGCTGAAAAATAGTGATTTTGCATCATTGCTCGGGGATTTGTAGTATACGTTGTTTCGATTGTCTTCTCGAGCTCCAGCTCAAATCCATAACTGATTGCAACCCTT	JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJFJJJJJJJJJJJJJJJJJJJJJJJJFFJJAAJJFJJJJJJJJJJJJJJJJJJJJJFJ	AS:i:0	XN:i:0	XM:i:0	XO:i:0	XG:i:0	NM:i:0	MD:Z:141	YS:i:0	YT:Z:CP
      J00160:58:HG3KCBBXX:3:1205:23845:28709	163	Tdu_TRINITY_DN17012_c3_g3	262	42	141M	=	331	210	CCTGTTGCCAATGGTTTCTTTCGCATTGTCCAAAATGCTGAAAAATAGTGATTTTGCATCATTGCTCGGGGATTTGTAGTATACGTTGTTTCGATTGTCTTCTCGAGCTCCAGCTCAAATCCATAACTGATTGCAACCCTT	JJJJJJFJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJFJJJFJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJFJJFJJJJJJJJJJJFJJJJJJJJJJJJJJJJJFJJJJJ	AS:i:0	XN:i:0	XM:i:0	XO:i:0	XG:i:0	NM:i:0	MD:Z:141	YS:i:0	YT:Z:CP
      ```
  - `Tdu_2613_11_uniq_2_TPR_filter_for_Tms.sam`

Output (examples):
  - `Tdu_2613_11_unq_2_TDU_4_Tms_commonID.sam`
    - ```
      J00160:58:HG3KCBBXX:3:2126:6421:10405	99	Tpr_TRINITY_DN14318_c0_g1|Tdu_TRINITY_DN17012_c3_g3	262	42	141M	=	278	157	CCTGTTGCCAATGGTTTCTTTCGCATTGTCCAAAATGCTGAAAAATAGTGATTTTGCATCATTGCTCGGGGATTTGTAGTATACGTTGTTTCGATTGTCTTCTCGAGCTCCAGCTCAAATCCATAACTGATTGCAACCCTT	JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJFJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ	AS:i:0	XN:i:0
      J00160:58:HG3KCBBXX:3:2221:19319:18265	163	Tpr_TRINITY_DN14318_c0_g1|Tdu_TRINITY_DN17012_c3_g3	262	42	141M	=	464	343	CCTGTTGCCAATGGTTTCTTTCGCATTGTCCAAAATGCTGAAAAATAGTGATTTTGCATCATTGCTCGGGGATTTGTAGTATACGTTGTTTCGATTGTCTTCTCGAGCTCCAGCTCAAATCCATAACTGATTGCAACCCTT	JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJFJJJJJJJJJJJJJJJJJJJJJJJJFFJJAAJJFJJJJJJJJJJJJJJJJJJJJJFJ	AS:i:0	XN:i:0
      J00160:58:HG3KCBBXX:3:1205:23845:28709	163	Tpr_TRINITY_DN14318_c0_g1|Tdu_TRINITY_DN17012_c3_g3	262	42	141M	=	331	210	CCTGTTGCCAATGGTTTCTTTCGCATTGTCCAAAATGCTGAAAAATAGTGATTTTGCATCATTGCTCGGGGATTTGTAGTATACGTTGTTTCGATTGTCTTCTCGAGCTCCAGCTCAAATCCATAACTGATTGCAACCCTT	JJJJJJFJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJFJJJFJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJFJJFJJJJJJJJJJJFJJJJJJJJJJJJJJJJJFJJJJJ	AS:i:0	XN:i:0
      ...
      ```
  - `Tdu_2613_11_unq_2_TPR_4_Tms_commonID.sam`

Output sas files, e.g.:
  - `tdu_2613_11_unq_2_tdu_4_tms_id.sas7bdat`
  - `tdu_2613_11_unq_2_tpr_4_tms_id.sas7bdat`
  
## 6. SAM compare
This step performs SAM compare to obtain couts for each reference. Scripts `sam_compare_parental_reads_V3.sbatch` and `sam_compare.shan.py` were used for analysis.

**For script `sam_compare_parental_reads_V3.sbatch`, it has been changed [here](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/9a66594bd121024c244b072490be783b1cf3f86d/Filter_orthologs/sam_compare_parental_reads_V3.sbatch#L40-L41) and [here](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/9a66594bd121024c244b072490be783b1cf3f86d/Filter_orthologs/sam_compare_parental_reads_V3.sbatch#L46) to fit our own dataset.**
  - DO NOT REPLACE SAPCE WITH UNDERSCORE!!! DIFFERENT FROM LUCAS'S METHOD; I USED PAIRED READS FOR MAPPING
  - The read length is 150, instead of 100 in Lucas's analysis

**For script `sam_compare.shan.py`, it has been changed [here](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/9a66594bd121024c244b072490be783b1cf3f86d/Filter_orthologs/sam_compare.shan.py#L93-L98) to fit our own dataset.**
  - CUT -D' '; THIS WILL ONLY OUTPUT THE READS HEADER BEFORE THE WHITE SPACE
  
Output:
  - In csv format, e.g.:
    - `ase_counts_Tdu_2613_11_2_Tdu_Tpr.csv`
    - `ase_totals_Tdu_2613_11_2_Tdu_Tpr.csv`
      - ```
        Count totals:
        1:	a_single_exact	192257
        2:	a_single_inexact	95045
        3:	a_multi_exact	227820
        4:	a_multi_inexact	2343
        5:	b_single_exact	199146
        6:	b_single_inexact	78072
        7:	b_multi_exact	189100
        8:	b_multi_inexact	3328
        9:	both_single_exact_same	0
        10:	both_single_exact_diff	641939
        11:	both_single_inexact_same	0
        12:	both_single_inexact_diff	212797
        13:	both_inexact_diff_equal	93359
        14:	both_inexact_diff_a_better	61361
        15:	both_inexact_diff_b_better	58077
        16:	both_multi_exact	4717109
        17:	both_multi_inexact	7463
        18:	a_single_exact_b_single_inexact	77688
        19:	a_single_inexact_b_single_exact	43801
        20:	a_single_exact_b_multi_exact	202545
        21:	a_multi_exact_b_single_exact	454175
        22:	a_single_exact_b_multi_inexact	896
        23:	a_multi_inexact_b_single_exact	355
        24:	a_single_inexact_b_multi_exact	61303
        25:	a_multi_exact_b_single_inexact	208417
        26:	a_single_inexact_b_multi_inexact	2280
        27:	a_multi_inexact_b_single_inexact	3499
        28:	a_multi_exact_b_multi_inexact	25465
        29:	a_multi_inexact_b_multi_exact	1916
        30:	total_count	7648759
        ```

## 7. Import ASE counts into SAS
### 7.1 Rename ase_counts*.csv files to fit the downstream analysis
Script `Replicate_rename.sh` was used to rename csv files.

| Original csv files | Renamed csv files |
| -- | -- |
| ase_counts_Tdu_2613_11_2_Tdu_Tpr.csv | ase_counts_Tdu_1_2_Tdu_Tpr.csv |
| ase_counts_Tdu_2613_12_2_Tdu_Tpr.csv | ase_counts_Tdu_2_2_Tdu_Tpr.csv |
| ase_counts_Tdu_2613_41_2_Tdu_Tpr.csv | ase_counts_Tdu_3_2_Tdu_Tpr.csv |
| ase_counts_Tdu_2886_3_2_Tdu_Tpr.csv | ase_counts_Tdu_4_2_Tdu_Tpr.csv |
| ase_counts_Tdu_2886_5_2_Tdu_Tpr.csv | ase_counts_Tdu_5_2_Tdu_Tpr.csv |
| ase_counts_Tdu_2886_7_2_Tdu_Tpr.csv | ase_counts_Tdu_6_2_Tdu_Tpr.csv |
| ase_counts_Tpr_2608_3_2_Tdu_Tpr.csv | ase_counts_Tpr_1_2_Tdu_Tpr.csv |
| ase_counts_Tpr_2608_21_2_Tdu_Tpr.csv | ase_counts_Tpr_2_2_Tdu_Tpr.csv |
| ase_counts_Tpr_2608_31_2_Tdu_Tpr.csv | ase_counts_Tpr_3_2_Tdu_Tpr.csv |

### 7.2 Import ASE counts into SAS
Scripts `submit_import_ase_counts_parents.bash` and `import_ase_counts_parents.V3.sas` were used.

Output in SAS format:
  - `ase_4_bayes_tpr_reads_tdu_tpr.sas7bdat`
  - `ase_4_bayes_tdu_reads_tdu_tpr.sas7bdat`

Output log file: `import_ase_counts_parents.log`

## 8. Prep for Bayesian analysis
Scripts `submit_bayesian_make_sbys_reps_parents.bash` and `bayesian_make_sbys_reps_parents.sas` were used in this step.

Output:
  - sorted `ase_4_bayes_tdu_reads_tdu_tpr.sas7bdat`
  - sorted `ase_4_bayes_tpr_reads_tdu_tpr.sas7bdat`
  - `ase_bayes_tdu_rds_tdu_tpr_sbys.sas7bdat`
  - `ase_bayes_tpr_rds_tdu_tpr_sbys.sas7bdat`
  - `bayesian_make_sbys_reps_parents.log`

## 9. Bayesian Flag Analyze
"This step flags each feature (putative orthologous pair) for analysis (1) or not (0). Each feature MUST have at least one read and all reps should be present. This check for presence is important when running different rep counts." -- Lucas

Scripts `submit_bayesian_flag_analyze_parents.bash` and **`bayesian_flag_analyze_parents.sas`, which have been changed [here](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/17dd721720212ace4c6b1816a74e543dd53ba387/Filter_orthologs/bayesian_flag_analyze_parents.sas#L17-L22) to fit the 6 replications for Tdu**, were used.

Output:
  - `bayesian_flag_analyze_parents.log`
  - `bayes_flag_tdu_reads_tdu_tpr.sas7bdat`
  - `bayes_flag_tpr_reads_tdu_tpr.sas7bdat`

## 10. Export Bayesian Flag Data
"Export those data which were flagged for analysis (1) so that we can run the PG analysis (Empirical Bayesian Machine)." -- Lucas

Scripts `submit_bayesian_export_flagged_dataset_parents.bash` and **`bayesian_export_flagged_dataset_parents.V1.sas`, which has been changed [here](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/b391fe52e2b5ef5833f3d181434b7964e60617d9/Filter_orthologs/bayesian_export_flagged_dataset_parents.V1.sas#L30-L51) to fit the 6 replications for Tdu reads**, were used.

Output:
  - `bayesian_export_flagged_dataset_parents.log`
  - `ase_bayes_tdu_tdu_tpr_flag.sas7bdat`
  - `ase_bayes_tpr_tdu_tpr_flag.sas7bdat`
  - **`ase_bayes_tdu_tdu_tpr_flag.csv`**
  
```
commonID,LINE_TOTAL_1,LINE_TOTAL_2,LINE_TOTAL_3,LINE_TOTAL_4,LINE_TOTAL_5,LINE_TOTAL_6,TESTER_TOTAL_1,TESTER_TOTAL_2,TESTER_TOTAL_3,TESTER_TOTAL_4,TESTER_TOTAL_5,TESTER_TOTAL_6,flag_analyze
Tpr_TRINITY_DN10005_c0_g2|Tdu_TRINITY_DN21586_c5_g2,6,9,13,7,4,9,1,12,0,5,2,0,1
Tpr_TRINITY_DN10006_c0_g1|Tdu_TRINITY_DN18006_c3_g3,17,23,28,16,14,9,80,117,152,53,131,108,1
Tpr_TRINITY_DN10008_c0_g2|Tdu_TRINITY_DN16267_c0_g1,0,15,14,0,0,0,0,0,0,0,0,0,1
Tpr_TRINITY_DN10008_c0_g5|Tdu_TRINITY_DN16267_c0_g4,0,5,3,0,0,0,0,0,0,0,0,0,1
Tpr_TRINITY_DN10010_c0_g1|Tdu_TRINITY_DN19621_c0_g1,70,226,222,183,281,184,126,352,381,265,361,232,1
Tpr_TRINITY_DN10012_c0_g1|Tdu_TRINITY_DN21718_c1_g1,4,2,5,0,2,4,53,70,96,57,59,58,1
Tpr_TRINITY_DN10017_c0_g1|Tdu_TRINITY_DN15873_c0_g1,14,7,16,7,7,4,2,0,3,0,0,0,1
Tpr_TRINITY_DN10018_c0_g1|Tdu_TRINITY_DN3659_c0_g1,2,0,3,2,12,1,0,0,0,0,0,1,1
Tpr_TRINITY_DN10022_c0_g1|Tdu_TRINITY_DN24419_c1_g5,6,11,14,4,17,5,0,2,2,2,2,0,1
Tpr_TRINITY_DN10030_c0_g1|Tdu_TRINITY_DN13817_c0_g1,2,0,1,1,2,2,0,1,2,0,2,2,1
...
```
  - **`ase_bayes_tpr_tdu_tpr_flag.csv`**

```
commonID,LINE_TOTAL_1,LINE_TOTAL_2,LINE_TOTAL_3,TESTER_TOTAL_1,TESTER_TOTAL_2,TESTER_TOTAL_3,flag_analyze
Tpr_TRINITY_DN10005_c0_g2|Tdu_TRINITY_DN21586_c5_g2,4,11,3,0,0,1,1
Tpr_TRINITY_DN10006_c0_g1|Tdu_TRINITY_DN18006_c3_g3,3,2,4,48,127,56,1
Tpr_TRINITY_DN10008_c0_g2|Tdu_TRINITY_DN16267_c0_g1,38,0,0,0,0,0,1
Tpr_TRINITY_DN10008_c0_g5|Tdu_TRINITY_DN16267_c0_g4,8,0,0,0,0,0,1
Tpr_TRINITY_DN10010_c0_g1|Tdu_TRINITY_DN19621_c0_g1,21,102,67,44,201,121,1
Tpr_TRINITY_DN10012_c0_g1|Tdu_TRINITY_DN21718_c1_g1,1,5,1,34,111,40,1
Tpr_TRINITY_DN10017_c0_g1|Tdu_TRINITY_DN15873_c0_g1,3,23,12,9,16,13,1
Tpr_TRINITY_DN10018_c0_g1|Tdu_TRINITY_DN3659_c0_g1,0,0,4,14,22,11,1
Tpr_TRINITY_DN10022_c0_g1|Tdu_TRINITY_DN24419_c1_g5,8,13,6,0,1,1,1
Tpr_TRINITY_DN10030_c0_g1|Tdu_TRINITY_DN13817_c0_g1,2,1,1,1,5,2,1
...
```

## 11. Split ASE Table
"This step is performed to speed up the analysis by separating the process into reasonably sized chunks" -- Lucas

Scripts `split_emp_bayesian_ase_table.bash` and `splitTable.py` were used to splite the original csv files into 500 small files.

Input:
  - `ase_bayes_tdu_tdu_tpr_flag.csv`
  - `ase_bayes_tpr_tdu_tpr_flag.csv`

Output:
  - `split_tdu_ur/split_(1-500).csv`
  - `split_tpr_ur/split_(1-500).csv`

## 12. Run Bayesian Possion-Gamma
"Execute the Bayesian PG machine to identify expression bias between the orthologous pairs. For the parents, parental reads were mapped back to both references to identify loci that exhibit a mapping bias toward the wrong parental reference." -- Lucas

Script: **`run_emp_bayesian_machine_parents.sbatch`, which has been changed [here](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/6dce32b31000024165ef544ddfecd0e3a53ebddd/Filter_orthologs/run_emp_bayesian_machine_parents.sbatch#L22-L28)**; dependencies include:
  - `PG_model_empirical_q456_3reps.r` for Tpr reads
  - **`PG_model_empirical_q456_6reps.r` for Tdu reads, which has been changed [here](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/6dce32b31000024165ef544ddfecd0e3a53ebddd/Filter_orthologs/PG_model_empirical_q456_6reps.r#L36-L40)**
  - `Subroutines_model2_experimental.R`
  - `AI_poissongamma_functions.R`

Output:
  - `empirical_bayesian_parents_output/split_tdu_ur/split_(1-500).csv`
  - `empirical_bayesian_parents_output/split_tpr_ur/split_(1-500).csv`

## 13. Combine Bayesian Possion-Gamma Output
"After each of the split runs of the Emp_Bayes_Machine finishes, all of the output is subsequently merged back into one file." -- Lucas

Scripts `combine_emp_bayesian_ase_table_parents.bash` and `catTable.py` were used.

Output:
  - `empirical_bayesian_parents_output/PG_emp_bayesian_results_tdu_parents_UR.csv`
    - ```
      commonID,q4_mean_theta,q4_q025,q4_q975,q5_mean_theta,q5_q025,q5_q975,q6_mean_theta,q6_q025,q6_q975
      Tpr_TRINITY_DN11281_c1_g9|Tdu_TRINITY_DN15992_c0_g1,0.56,0.363,0.74,0.475,0.286,0.664,0.393,0.223,0.587
      Tpr_TRINITY_DN11282_c5_g4|Tdu_TRINITY_DN21715_c2_g2,0.033,0.018,0.052,0.022,0.012,0.034,0.015,0.008,0.024
      Tpr_TRINITY_DN11283_c3_g1|Tdu_TRINITY_DN25596_c4_g2,0.33,0.228,0.439,0.253,0.17,0.344,0.186,0.119,0.264
      Tpr_TRINITY_DN11283_c4_g1|Tdu_TRINITY_DN18533_c6_g7,0.946,0.929,0.961,0.928,0.903,0.948,0.903,0.87,0.93
      Tpr_TRINITY_DN11283_c4_g3|Tdu_TRINITY_DN19916_c2_g2,0.05,0.004,0.157,0.035,0.002,0.111,0.024,0.002,0.072
      Tpr_TRINITY_DN11283_c4_g5|Tdu_TRINITY_DN23960_c3_g1,0.029,0.009,0.06,0.02,0.006,0.041,0.013,0.004,0.028
      Tpr_TRINITY_DN11283_c4_g7|Tdu_TRINITY_DN21302_c2_g2,0.498,0.425,0.573,0.401,0.331,0.471,0.312,0.254,0.377
      Tpr_TRINITY_DN11284_c2_g11|Tdu_TRINITY_DN24630_c2_g7,0.92,0.868,0.953,0.905,0.845,0.949,0.891,0.811,0.943
      Tpr_TRINITY_DN11284_c2_g17|Tdu_TRINITY_DN18038_c1_g1,0.082,0,0.369,0.067,0,0.301,0.043,0,0.2
      Tpr_TRINITY_DN11284_c2_g18|Tdu_TRINITY_DN18953_c5_g5,0.906,0.879,0.93,0.873,0.836,0.905,0.827,0.779,0.872
      ...
      ```
  - `empirical_bayesian_parents_output/PG_emp_bayesian_results_tpr_parents_UR.csv`
    - ```
      commonID,q4_mean_theta,q4_q025,q4_q975,q5_mean_theta,q5_q025,q5_q975,q6_mean_theta,q6_q025,q6_q975
      Tpr_TRINITY_DN11281_c1_g9|Tdu_TRINITY_DN15992_c0_g1,0.754,0.527,0.903,0.724,0.473,0.892,0.683,0.378,0.883
      Tpr_TRINITY_DN11282_c5_g4|Tdu_TRINITY_DN21715_c2_g2,0.088,0.057,0.125,0.06,0.039,0.084,0.041,0.027,0.06
      Tpr_TRINITY_DN11283_c3_g1|Tdu_TRINITY_DN25596_c4_g2,0.832,0.726,0.907,0.79,0.668,0.89,0.742,0.591,0.859
      Tpr_TRINITY_DN11283_c4_g1|Tdu_TRINITY_DN18533_c6_g7,0.93,0.902,0.951,0.907,0.87,0.937,0.877,0.828,0.916
      Tpr_TRINITY_DN11283_c4_g3|Tdu_TRINITY_DN19916_c2_g2,0.364,0.236,0.499,0.281,0.181,0.39,0.209,0.132,0.306
      Tpr_TRINITY_DN11283_c4_g5|Tdu_TRINITY_DN23960_c3_g1,0.099,0.043,0.172,0.07,0.032,0.125,0.048,0.02,0.084
      Tpr_TRINITY_DN11283_c4_g7|Tdu_TRINITY_DN21302_c2_g2,0.393,0.285,0.507,0.304,0.208,0.404,0.228,0.141,0.318
      Tpr_TRINITY_DN11284_c2_g11|Tdu_TRINITY_DN24630_c2_g7,0.902,0.83,0.947,0.888,0.801,0.942,0.87,0.766,0.938
      Tpr_TRINITY_DN11284_c2_g18|Tdu_TRINITY_DN18953_c5_g5,0.94,0.912,0.961,0.926,0.886,0.956,0.909,0.854,0.948
      Tpr_TRINITY_DN11284_c2_g19|Tdu_TRINITY_DN20652_c0_g3,0.821,0.665,0.921,0.791,0.613,0.909,0.757,0.54,0.892
      ...
      ```

## 14. Import Bayesian Poisson-Gamma Results to SAS
Scripts `execute_import_bayesian_flag_results.bash` and `import_bayesian_results.sas` will be used.

Input:
  - `PG_emp_bayesian_results_tdu_parents_UR.csv`
  - `PG_emp_bayesian_results_tpr_parents_UR.csv`

Output:
  - `emp_tdu_for_tdu_tpr.sas7bdat`
  - `emp_tpr_for_tdu_tpr.sas7bdat`
  - `import_bayesian_results.log`

## 15. Flag Significant Bayesian Poisson-Gamma Output
"Flag those putative orthologous pairs that exhibit mapping bias. Flag significant if the credible interval [similar to 95% Highest posterior density interval (HPDI)] does not overlap 0.5 for each prior (q4,q5,q6). Then, flag significant for all three if q4 = q5 = q6 = 1" -- Lucas

Scripts `execute_bayesian_flag_sig_results_parents.bash` and `bayesian_flag_sig_results_parents_pdf.sas` were used.

Output:
  - `SGPlot.png` and `SGPlot1.png`
  - `bayes_flag_sig_tdu_for_tdu_tpr.pdf` and `bayes_flag_sig_tpr_for_tdu_tpr.pdf`
  - `bayes_flag_sig_tdu_for_tdu_tpr.sas7bdat` and `bayes_flag_sig_tpr_for_tdu_tpr.sas7bdat`
  - `bayesian_flag_sig_parents.log`

Images:

![bayes_flag_sig_tdu_for_tdu_tpr](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Filter_orthologs/Images/SGPlot.png?raw=true)
![bayes_flag_sig_tdu_for_tdu_tpr](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Filter_orthologs/Images/SGPlot1.png?raw=true)

## 16. Generate CSVs of Flagged Significant Bayesian Possion-Gamma Output
"Export the flagged EBM results into a CSV for filtering." -- Lucas

Scripts `execute_output_ase_bayesian_flagged_CSVs.bash` and `output_ase_bayesian_flagged_CSVs.sas` were used.

Input:
  - `bayes_flag_sig_tdu_for_tdu_tpr.sas7bdat`
  - `bayes_flag_sig_tpr_for_tdu_tpr.sas7bdat`

Output:
  - `empirical_bayesian_parents_output/bayes_flag_sig_TDU_for_UR.csv`
  
```
commonID,q4_mean_theta,q4_q025,q4_q975,q5_mean_theta,q5_q025,q5_q975,q6_mean_theta,q6_q025,q6_q975,flag_q4_sig,flag_q5_sig,flag_q6_sig,flag_sig_tdu_tdu_tpr
Tpr_TRINITY_DN11281_c1_g9|Tdu_TRINITY_DN15992_c0_g1,0.56,0.363,0.74,0.475,0.286,0.664,0.393,0.223,0.587,0,0,0,0
Tpr_TRINITY_DN11282_c5_g4|Tdu_TRINITY_DN21715_c2_g2,0.033,0.018,0.052,0.022,0.012,0.034,0.015,0.008,0.024,1,1,1,1
Tpr_TRINITY_DN11283_c3_g1|Tdu_TRINITY_DN25596_c4_g2,0.33,0.228,0.439,0.253,0.17,0.344,0.186,0.119,0.264,1,1,1,1
Tpr_TRINITY_DN11283_c4_g1|Tdu_TRINITY_DN18533_c6_g7,0.946,0.929,0.961,0.928,0.903,0.948,0.903,0.87,0.93,1,1,1,1
Tpr_TRINITY_DN11283_c4_g3|Tdu_TRINITY_DN19916_c2_g2,0.05,0.004,0.157,0.035,0.002,0.111,0.024,0.002,0.072,1,1,1,1
Tpr_TRINITY_DN11283_c4_g5|Tdu_TRINITY_DN23960_c3_g1,0.029,0.009,0.06,0.02,0.006,0.041,0.013,0.004,0.028,1,1,1,1
Tpr_TRINITY_DN11283_c4_g7|Tdu_TRINITY_DN21302_c2_g2,0.498,0.425,0.573,0.401,0.331,0.471,0.312,0.254,0.377,0,1,1,0
Tpr_TRINITY_DN11284_c2_g11|Tdu_TRINITY_DN24630_c2_g7,0.92,0.868,0.953,0.905,0.845,0.949,0.891,0.811,0.943,1,1,1,1
Tpr_TRINITY_DN11284_c2_g17|Tdu_TRINITY_DN18038_c1_g1,0.082,0,0.369,0.067,0,0.301,0.043,0,0.2,1,1,1,1
Tpr_TRINITY_DN11284_c2_g18|Tdu_TRINITY_DN18953_c5_g5,0.906,0.879,0.93,0.873,0.836,0.905,0.827,0.779,0.872,1,1,1,1
...
```
  - `empirical_bayesian_parents_output/bayes_flag_sig_TPR_for_UR.csv`

```
commonID,q4_mean_theta,q4_q025,q4_q975,q5_mean_theta,q5_q025,q5_q975,q6_mean_theta,q6_q025,q6_q975,flag_q4_sig,flag_q5_sig,flag_q6_sig,flag_sig_tpr_tdu_tpr
Tpr_TRINITY_DN11281_c1_g9|Tdu_TRINITY_DN15992_c0_g1,0.754,0.527,0.903,0.724,0.473,0.892,0.683,0.378,0.883,1,0,0,0
Tpr_TRINITY_DN11282_c5_g4|Tdu_TRINITY_DN21715_c2_g2,0.088,0.057,0.125,0.06,0.039,0.084,0.041,0.027,0.06,1,1,1,1
Tpr_TRINITY_DN11283_c3_g1|Tdu_TRINITY_DN25596_c4_g2,0.832,0.726,0.907,0.79,0.668,0.89,0.742,0.591,0.859,1,1,1,1
Tpr_TRINITY_DN11283_c4_g1|Tdu_TRINITY_DN18533_c6_g7,0.93,0.902,0.951,0.907,0.87,0.937,0.877,0.828,0.916,1,1,1,1
Tpr_TRINITY_DN11283_c4_g3|Tdu_TRINITY_DN19916_c2_g2,0.364,0.236,0.499,0.281,0.181,0.39,0.209,0.132,0.306,1,1,1,1
Tpr_TRINITY_DN11283_c4_g5|Tdu_TRINITY_DN23960_c3_g1,0.099,0.043,0.172,0.07,0.032,0.125,0.048,0.02,0.084,1,1,1,1
Tpr_TRINITY_DN11283_c4_g7|Tdu_TRINITY_DN21302_c2_g2,0.393,0.285,0.507,0.304,0.208,0.404,0.228,0.141,0.318,0,1,1,0
Tpr_TRINITY_DN11284_c2_g11|Tdu_TRINITY_DN24630_c2_g7,0.902,0.83,0.947,0.888,0.801,0.942,0.87,0.766,0.938,1,1,1,1
Tpr_TRINITY_DN11284_c2_g18|Tdu_TRINITY_DN18953_c5_g5,0.94,0.912,0.961,0.926,0.886,0.956,0.909,0.854,0.948,1,1,1,1
Tpr_TRINITY_DN11284_c2_g19|Tdu_TRINITY_DN20652_c0_g3,0.821,0.665,0.921,0.791,0.613,0.909,0.757,0.54,0.892,1,1,1,1
...
```
  - `output_ase_bayesian_flagged_CSVs.log`



  


  

  
  








