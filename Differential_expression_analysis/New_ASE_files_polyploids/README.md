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

