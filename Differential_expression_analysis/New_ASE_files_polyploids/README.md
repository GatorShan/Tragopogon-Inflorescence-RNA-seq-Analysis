# Generate new ASE files for polyploids
## 1. Description
These new ASE files include expression profiles for **all 11,863 identified orthologous pairs** in polyploids. These ASE files could be used for additive expression analysis as well as identifying DE loci between short- and long-liguled T. miscellus.

Previous ASE files include only 5,400 loci with none mapping-bias, which are used for homeolog-specific expression in polyploids.

## 2. Filter SAM files by bed files
In this step, SAM files will be filtered by bed files containing all 11,863 orthologous pairs.

The bed files containing 11,863 loci are generated from section **`Filter_orthologs`**.
  - `TDU-tpr_overlaps_orthologs.bed`
  - `TPR-tdu_overlaps_orthologs.bed`

Scripts `SAM_filter_by_bed_poly_newASE_V1.sh` and `sam-filter-by-bed.pl` were used.

```bash
IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Polyploid_alignment/Alignment
OUT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Polyploid_alignment/Filter_SAM_by_bed_newASE
CODE=/ufrc/soltis/shan158538/TragFL_NewAnalysis/SLURM

cd ${IN}

for FILE in `ls *_Tdu_ST_V1_uniq.sam`; do
	echo "${FILE} is going to be processed"
	# filter sam file of Tml/Tms reads aligned to TDU with TDU_tpr bed file
	perl ${CODE}/sam-filter-by-bed.pl \
		-b ${OUT}/TDU-tpr_overlaps_orthologs.bed \
		-s ${FILE} \
		> ${OUT}/${FILE%_reads_Tdu_ST_V1_uniq.*}_uniq_2_TDU_filter_for_Poly_newASE.sam		
	echo -e "\t${FILE} has been filtered based on the TDU_tpr bed file"
done

for FILE in `ls *_Tpr_ST_V1_uniq.sam`; do
	echo "${FILE} is going to be processed"
	# filter sam file of Tml/Tms reads aligned to TPR with TPR_tdu bed file
	perl ${CODE}/sam-filter-by-bed.pl \
		-b ${OUT}/TPR-tdu_overlaps_orthologs.bed \
		-s ${FILE} \
		> ${OUT}/${FILE%_reads_Tpr_ST_V1_uniq.*}_uniq_2_TPR_filter_for_Poly_newASE.sam		
	echo -e "\t${FILE} has been filtered based on the TPR_tdu bed file"
done
```

Input (`/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Polyploid_alignment/Alignment`), e.g.:
  - `Tml_2605_24_reads_Tdu_ST_V1_uniq.sam`
  - `Tms_2604_24_reads_Tdu_ST_V1_uniq.sam`

Output (`/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Polyploid_alignment/Filter_SAM_by_bed_newASE`), e.g.:
  - `Tml_2605_24_uniq_2_TDU_filter_for_Poly_newASE.sam`
  - `Tms_2604_24_uniq_2_TDU_filter_for_Poly_newASE.sam`
  
## 3. Add commonID to all SAM files
Scripts `submit_add_commonID_hybrid_newASE.bash` and `add_commonID_to_hybrid_sam_files_HPC_newASE.sas` were used.

Input:
  - `tdu_tpr_bed_for_sam_compare.sas7bdat` from section Filter_orthologs, which includes 11,863 orthologs
  - `tpr_tdu_bed_for_sam_compare.sas7bdat` from section Filter_orthologs, which includes 11,863 orthologs
  - SAM files, e.g.
    - `Tms_2604_24_uniq_2_TDU_filter_for_Poly_newASE.sam`
      - ```
        NS500162:83:H2FF2AFXX:2:21206:9969:13145	163	Tdu_TRINITY_DN10011_c0_g1	95	42	139M	=	151	197	TCCCTATTTTCCCCGACATCAATCTTCTTCTCCTTCAATCTTGTACAGAAAAGGAAGAGATTGAACATTGTTGGGGACATGGAAACCGTTGGAGACAACCCCTTGAAGAAGAACCAACTTAAAACCACATCCATCCGCC	AFFFF..AF<.F)F<FF.FF<AFFF7FFFFFFFAAAAF.FFF)F<FAFAFA7<F7<<<F.A<<AFFFF<7F<77<.FA<FA7<..FFF7FF)<.7F.A7FFAFF<F.77FF.A<F7.F7.A..)AA.F..A<.AAA<.7	AS:i:-14	XN:i:0	XM:i:5	XO:i:0	XG:i:0	NM:i:5	MD:Z:17T78C26T4T3T6	YS:i:0	YT:Z:CP
        NS500162:83:H2FF2AFXX:2:11112:26023:7418	81	Tdu_TRINITY_DN10011_c0_g1	108	42	74M	=	117	84	CGACTTCAATCTTCTTCTCCTTCAATCTTGTACAGAAAAGGAAGAGATTGAACATTGTTGGGGACATGGAAACC	7FFFFFFAFFFFFFAAA7FF.FFAF<FFFFF7FFFFFFFFFFFFFFFFA<FFFFAFFFFFF<7FFFFFFFFFFF	AS:i:0	XN:i:0	XM:i:0	XO:i:0	XG:i:0	NM:i:0	MD:Z:74	YS:i:0	YT:Z:DP
        NS500162:83:H2FF2AFXX:1:11206:8033:20270	145	Tdu_TRINITY_DN10011_c0_g1	109	42	114M	=	118	124	GACTGCAATCTTCTTCTCCTTCATTCTTGTACAGAAAAGGAAGAGATTGAACATTGTTGGGGACATGGAAACCGTTGGAGACCACCCCTTGAAGAAGAACCAACTTAAATCCAC	FA<7)AF.A<.F...A<A.AFFF)F.A.<AFFFF.FFFFFFFF7<7FFFAAF7FFF7FF.FF<F.FFFFF<F<FFFA7FFFF))FFFFAAAFFFF<7FFF).A7F<<AF<<FFF	AS:i:-4	XN:i:0	XM:i:2	XO:i:0	XG:i:0	NM:i:2	MD:Z:4T18A90	YS:i:-14	YT:Z:DP
        ```

Output:
  - SAM files, e.g.
    - `Tms_2604_24_unq_2_TDU_commonID_newASE.sam`
      - ```
        NS500162:83:H2FF2AFXX:2:21206:9969:13145	163	Tpr_TRINITY_DN11857_c2_g6|Tdu_TRINITY_DN10011_c0_g1	95	42	139M	=	151	197	TCCCTATTTTCCCCGACATCAATCTTCTTCTCCTTCAATCTTGTACAGAAAAGGAAGAGATTGAACATTGTTGGGGACATGGAAACCGTTGGAGACAACCCCTTGAAGAAGAACCAACTTAAAACCACATCCATCCGCC	AFFFF..AF<.F)F<FF.FF<AFFF7FFFFFFFAAAAF.FFF)F<FAFAFA7<F7<<<F.A<<AFFFF<7F<77<.FA<FA7<..FFF7FF)<.7F.A7FFAFF<F.77FF.A<F7.F7.A..)AA.F..A<.AAA<.7	AS:i:-1	XN:i:0
        NS500162:83:H2FF2AFXX:2:11112:26023:7418	81	Tpr_TRINITY_DN11857_c2_g6|Tdu_TRINITY_DN10011_c0_g1	108	42	74M	=	117	84	CGACTTCAATCTTCTTCTCCTTCAATCTTGTACAGAAAAGGAAGAGATTGAACATTGTTGGGGACATGGAAACC	7FFFFFFAFFFFFFAAA7FF.FFAF<FFFFF7FFFFFFFFFFFFFFFFA<FFFFAFFFFFF<7FFFFFFFFFFF	AS:i:0	XN:i:0
        NS500162:83:H2FF2AFXX:1:11206:8033:20270	145	Tpr_TRINITY_DN11857_c2_g6|Tdu_TRINITY_DN10011_c0_g1	109	42	114M	=	118	124	GACTGCAATCTTCTTCTCCTTCATTCTTGTACAGAAAAGGAAGAGATTGAACATTGTTGGGGACATGGAAACCGTTGGAGACCACCCCTTGAAGAAGAACCAACTTAAATCCAC	FA<7)AF.A<.F...A<A.AFFF)F.A.<AFFFF.FFFFFFFF7<7FFFAAF7FFF7FF.FF<F.FFFFF<F<FFFA7FFFF))FFFFAAAFFFF<7FFF).A7F<<AF<<FFF	AS:i:-4	XN:i:0
        ```
  - SAS log file: `add_commonID_to_hybrid_sam_files_HPC_newASE.log`

## 4. SAM Compare
Scripts `sam_compare_hybrid_reads_newASE.sh` and `sam_compare.shan.py` (from Filter orthologs section) were used.

```bash
## Tms (short-liguled) reads to TDU and TPR
for i in 2604_24 2604_43 2604_48
do

SAMA=${IN}/Tms_${i}_unq_2_TDU_commonID_newASE.sam
SAMB=${IN}/Tms_${i}_unq_2_TPR_commonID_newASE.sam

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
	-c ${OUT}/ase_counts_new_Tms_${i}_2_tdu_tpr.csv \
	-t ${OUT}/ase_totals_new_Tms_${i}_2_tdu_tpr.csv \
	-g ${LOGS}/ase_counts_new_Tms_${i}_2_tdu_tpr.log
done
```

Output, examples:
  - `ase_counts_new_Tml_2605_9_2_tdu_tpr.csv`, which contains 11,863 orthologs
  - `ase_totals_new_Tml_2605_9_2_tdu_tpr.csv`
    - ```
      Count totals:
      1:	a_single_exact	90966
      2:	a_single_inexact	45304
      3:	a_multi_exact	177619
      4:	a_multi_inexact	2970
      5:	b_single_exact	99843
      6:	b_single_inexact	47224
      7:	b_multi_exact	192140
      8:	b_multi_inexact	2266
      9:	both_single_exact_same	0
      10:	both_single_exact_diff	301669
      11:	both_single_inexact_same	0
      12:	both_single_inexact_diff	117506
      13:	both_inexact_diff_equal	52503
      14:	both_inexact_diff_a_better	32060
      15:	both_inexact_diff_b_better	32943
      16:	both_multi_exact	3090872
      17:	both_multi_inexact	9166
      18:	a_single_exact_b_single_inexact	28849
      19:	a_single_inexact_b_single_exact	27504
      20:	a_single_exact_b_multi_exact	162607
      21:	a_multi_exact_b_single_exact	144975
      22:	a_single_exact_b_multi_inexact	677
      23:	a_multi_inexact_b_single_exact	609
      24:	a_single_inexact_b_multi_exact	88748
      25:	a_multi_exact_b_single_inexact	82537
      26:	a_single_inexact_b_multi_inexact	2479
      27:	a_multi_inexact_b_single_inexact	2919
      28:	a_multi_exact_b_multi_inexact	18853
      29:	a_multi_inexact_b_multi_exact	20012
      30:	total_count	4758314
      ```

## 5. Rename new ase files

Following script is used:

```bash
IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Polyploid_alignment/Compare_SAM_newASE
OUT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Polyploid_alignment/Compare_SAM_newASE/ase_counts_new_rename

cp ${IN}/ase_counts_new_Tms_2604_24_2_tdu_tpr.csv ${OUT}/ase_counts_new_Tms_1_2_tdu_tpr.csv
cp ${IN}/ase_counts_new_Tms_2604_43_2_tdu_tpr.csv ${OUT}/ase_counts_new_Tms_2_2_tdu_tpr.csv
cp ${IN}/ase_counts_new_Tms_2604_48_2_tdu_tpr.csv ${OUT}/ase_counts_new_Tms_3_2_tdu_tpr.csv

cp ${IN}/ase_counts_new_Tml_2605_9_2_tdu_tpr.csv ${OUT}/ase_counts_new_Tml_1_2_tdu_tpr.csv
cp ${IN}/ase_counts_new_Tml_2605_24_2_tdu_tpr.csv ${OUT}/ase_counts_new_Tml_2_2_tdu_tpr.csv
cp ${IN}/ase_counts_new_Tml_2605_42_2_tdu_tpr.csv ${OUT}/ase_counts_new_Tml_3_2_tdu_tpr.csv
```

## 6. Count reads in polyploids for additive expression analysis

"Counts were taken from reads mapped to both of the COREs between orthologous pairs. Thus counts are taken from hihgly similar regions of the orthologs to account for differences in length between orthologous pairs resulting from incompletely reconstructed orthologs" -- Boatwright et al., 2018

Jupyther Notebook `count_reads_both_poly.ipynb` was used.

Output, example:
  - `both_counts_new_Tms_1_2_tdu_tpr.csv`
  - `both_counts_new_Tms_2_2_tdu_tpr.csv`
  - `both_counts_new_Tms_3_2_tdu_tpr.csv`
  - `both_counts_new_Tml_1_2_tdu_tpr.csv`
  - `both_counts_new_Tml_2_2_tdu_tpr.csv`
  - `both_counts_new_Tml_3_2_tdu_tpr.csv`