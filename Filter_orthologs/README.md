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

## 3. Filter SAM files by bed files
"In the previous step, we wanted to align to the entire transcriptome to prevent reads from mapping greedily to spurious locations in the transcriptome. Here, we isolate reads that map within our Common Orthologous REgions (COREs) so that we can make comparisons between reference mappings." -- Lucas

### 3.1 Filter CORE_bed files to inlcude those only inlcuded in shared orthologs
`Shared_reciprocated_blast_hits_SingleCopyOrthogroups_parser_FullDescription_filtered_2.0.txt` was used for downstream analysis. There are 11,863 shared orthologous pairs (P_VAL >= 1e-10 and Identity >= 0.8 and AlignmentLength >= 200), which is from section "Shared_COREs_wu-blast_OrthoFinder".
  - ```
    Tpr_TRINITY_DN14318_c0_g1       2973    Tdu_TRINITY_DN17012_c3_g3       2154    2798    0.      96.9    96.989966555184 598     2058    1465    401     997     -
    Tpr_TRINITY_DN13887_c2_g3       2065    Tdu_TRINITY_DN23158_c1_g4       2112    10072   0.      98.8    98.838334946757 2066    2065    1       35      2094    -
    Tpr_TRINITY_DN13936_c2_g4       2197    Tdu_TRINITY_DN24503_c1_g1       2378    4225    0.      93.7    93.7371663244353        974     1006    41      1385    2350    -
    Tpr_TRINITY_DN13936_c2_g3       2635    Tdu_TRINITY_DN22881_c5_g1       3487    2389    4.2e-291        95.3    95.3934740882918    521     521     1       2962    3482    -
    Tpr_TRINITY_DN13936_c2_g2       5116    Tdu_TRINITY_DN20656_c5_g1       5784    3220    0.      93.6    93.6742934051144        743     3695    4431    4376    5112    +
    ...
    ```

Input bed files are generated from script BLAST_COREs.py from section "WU-Blast_Analysis".
  - `Tdu_DB_Tpr_query_parser_single_hit_FullName.txt.filtered_Q.bed`
    - ```
      Tpr_TRINITY_DN31201_c0_g1       275     410     Tpr_TRINITY_DN31201_c0_g1,Tdu_TRINITY_DN10064_c0_g1     .       +
      Tpr_TRINITY_DN11072_c2_g4       676     1023    Tpr_TRINITY_DN11072_c2_g4,Tdu_TRINITY_DN7930_c0_g1      .       +
      Tpr_TRINITY_DN14318_c0_g1       1464    2057    Tpr_TRINITY_DN14318_c0_g1,Tdu_TRINITY_DN17012_c3_g3     .       +
      Tpr_TRINITY_DN13887_c2_g2       0       243     Tpr_TRINITY_DN13887_c2_g2,Tdu_TRINITY_DN23704_c6_g3     .       +
      Tpr_TRINITY_DN13887_c2_g3       0       2064    Tpr_TRINITY_DN13887_c2_g3,Tdu_TRINITY_DN23158_c1_g4     .       +
      ...
      ```
  - `Tdu_DB_Tpr_query_parser_single_hit_FullName.txt.filtered_S.bed`
    - ```
      Tdu_TRINITY_DN10064_c0_g1       75      210     Tpr_TRINITY_DN31201_c0_g1,Tdu_TRINITY_DN10064_c0_g1     .       +
      Tdu_TRINITY_DN7930_c0_g1        0       346     Tpr_TRINITY_DN11072_c2_g4,Tdu_TRINITY_DN7930_c0_g1      .       +
      Tdu_TRINITY_DN17012_c3_g3       400     996     Tpr_TRINITY_DN14318_c0_g1,Tdu_TRINITY_DN17012_c3_g3     .       +
      Tdu_TRINITY_DN23704_c6_g3       0       243     Tpr_TRINITY_DN13887_c2_g2,Tdu_TRINITY_DN23704_c6_g3     .       +
      Tdu_TRINITY_DN23158_c1_g4       34      2093    Tpr_TRINITY_DN13887_c2_g3,Tdu_TRINITY_DN23158_c1_g4     .       +
      ```

The following scripts were used to filter bed files to include only those shared orthologous pairs
  - `FilterBedFile_V1.py`
  - `FilterBedFile_V2.py`

Output:
  - `TDU-tpr_overlaps_orthologs.bed`
    - ```
      Tdu_TRINITY_DN17012_c3_g3	400	996	Tpr_TRINITY_DN14318_c0_g1,Tdu_TRINITY_DN17012_c3_g3	.	+
      Tdu_TRINITY_DN23158_c1_g4	34	2093	Tpr_TRINITY_DN13887_c2_g3,Tdu_TRINITY_DN23158_c1_g4	.	+
      Tdu_TRINITY_DN24503_c1_g1	1384	2349	Tpr_TRINITY_DN13936_c2_g4,Tdu_TRINITY_DN24503_c1_g1	.	+
      ```    
  - `TPR-tdu_overlaps_orthologs.bed`
    - ```
      Tpr_TRINITY_DN14318_c0_g1	1464	2057	Tpr_TRINITY_DN14318_c0_g1,Tdu_TRINITY_DN17012_c3_g3	.	+
      Tpr_TRINITY_DN13887_c2_g3	0	2064	Tpr_TRINITY_DN13887_c2_g3,Tdu_TRINITY_DN23158_c1_g4	.	+
      Tpr_TRINITY_DN13936_c2_g4	40	1005	Tpr_TRINITY_DN13936_c2_g4,Tdu_TRINITY_DN24503_c1_g1	.	+
      ```

### 3.2 Filter SAM files by using bed files including only those shared orthologs
Script `SAM_filter_by_bed_V1.sh` was used
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

Output (examples):
  - `Tdu_2613_11_uniq_2_TDU_filter_for_Tms.sam`
  - `Tdu_2613_11_uniq_2_TPR_filter_for_Tms.sam`

## 4. Import BED files into SAS
### 4.1 Change BED files' delimiter from tab to ','

Input:
  - `TDU-tpr_overlaps_orthologs.bed`
  - `TPR-tdu_overlaps_orthologs.bed`

Using terminal window: `tr "," "|" < orthologs.bed > orthologs.pipe.bed`
  - the purpose is to change the comma in the 4th column to pipe "|"
  - Output: `TDU-tpr_overlaps_orthologs.pipe.bed` and `TPR-tdu_overlaps_orthologs.pipe.bed`
    - ```
      Tdu_TRINITY_DN17012_c3_g3       400     996     Tpr_TRINITY_DN14318_c0_g1|Tdu_TRINITY_DN17012_c3_g3     .       +
      Tdu_TRINITY_DN23158_c1_g4       34      2093    Tpr_TRINITY_DN13887_c2_g3|Tdu_TRINITY_DN23158_c1_g4     .       +
      Tdu_TRINITY_DN24503_c1_g1       1384    2349    Tpr_TRINITY_DN13936_c2_g4|Tdu_TRINITY_DN24503_c1_g1     .       +
      ```
    - ```
      Tpr_TRINITY_DN14318_c0_g1       1464    2057    Tpr_TRINITY_DN14318_c0_g1|Tdu_TRINITY_DN17012_c3_g3     .       +
      Tpr_TRINITY_DN13887_c2_g3       0       2064    Tpr_TRINITY_DN13887_c2_g3|Tdu_TRINITY_DN23158_c1_g4     .       +
      Tpr_TRINITY_DN13936_c2_g4       40      1005    Tpr_TRINITY_DN13936_c2_g4|Tdu_TRINITY_DN24503_c1_g1     .       +
      ```
      
Using terminal window: `tr '\t' ',' < orthologs.bed > orthologs.csv`
  - the purpose is to change tab to comma
  - Output: `TDU-tpr_overlaps_orthologs.csv` and `TPR-tdu_overlaps_orthologs.csv`
    - ```
      Tdu_TRINITY_DN17012_c3_g3,400,996,Tpr_TRINITY_DN14318_c0_g1|Tdu_TRINITY_DN17012_c3_g3,.,+
      Tdu_TRINITY_DN23158_c1_g4,34,2093,Tpr_TRINITY_DN13887_c2_g3|Tdu_TRINITY_DN23158_c1_g4,.,+
      Tdu_TRINITY_DN24503_c1_g1,1384,2349,Tpr_TRINITY_DN13936_c2_g4|Tdu_TRINITY_DN24503_c1_g1,.,+
      ```
    - ```
      Tpr_TRINITY_DN14318_c0_g1,1464,2057,Tpr_TRINITY_DN14318_c0_g1|Tdu_TRINITY_DN17012_c3_g3,.,+
      Tpr_TRINITY_DN13887_c2_g3,0,2064,Tpr_TRINITY_DN13887_c2_g3|Tdu_TRINITY_DN23158_c1_g4,.,+
      Tpr_TRINITY_DN13936_c2_g4,40,1005,Tpr_TRINITY_DN13936_c2_g4|Tdu_TRINITY_DN24503_c1_g1,.,+
      ```

### 4.2 Import BED files into SAS
The scripts `submit_sas_programs_4_sam_compare.bash` and `import_bed_fix_coord_for_sam_compare_HPC.sas` was used.

Output:
  - `TDU_tpr_bed_for_sam_compare.bed`
    - ```
      commonID	start	end
      Tpr_TRINITY_DN14318_c0_g1|Tdu_TRINITY_DN17012_c3_g3	0	596
      Tpr_TRINITY_DN13887_c2_g3|Tdu_TRINITY_DN23158_c1_g4	0	2059
      Tpr_TRINITY_DN13936_c2_g4|Tdu_TRINITY_DN24503_c1_g1	0	965
      ```
  - `TPR_tdu_bed_for_sam_compare.bed`
    - ```
      commonID	start	end
      Tpr_TRINITY_DN14318_c0_g1|Tdu_TRINITY_DN17012_c3_g3	0	593
      Tpr_TRINITY_DN13887_c2_g3|Tdu_TRINITY_DN23158_c1_g4	0	2064
      Tpr_TRINITY_DN13936_c2_g4|Tdu_TRINITY_DN24503_c1_g1	0	965
      ```
  - `import_bed_fix_coord_for_sam_compare_HPC.log`
  - `import_bed_fix_coord_for_sam_compare_HPC.prt`

## 5. Add commonID to all SAM files
### 











