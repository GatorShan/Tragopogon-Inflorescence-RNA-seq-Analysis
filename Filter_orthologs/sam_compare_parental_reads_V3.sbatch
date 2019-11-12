#!/bin/bash

#SBATCH --job-name=sam_compare_parental_reads_V3
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=sam_compare_parental_reads_V3_%j.out
#SBATCH --error=sam_compare_parental_reads_V3_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=30gb
#SBATCH --time=2-00:00:00
#SBATCH --qos=soltis-b

date;hostname;pwd

# python version has been changed from 2.7.3 to 2.7.10
module purge
module load gcc/5.2.0
module load python/2.7.10

#### Set Directories
IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Filter_orthologs/Filter_SAM_by_bed
SCRIPTS=/ufrc/soltis/shan158538/TragFL_NewAnalysis/SLURM
READ=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/rRNA_Filter/Crop_clean
OUT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Filter_orthologs/Compare_SAM
TMPDIR=${OUT}/temp_dir
LOGS=${OUT}/logs


## TDU reads to TDU and TPR for Tms
for i in 2613_11 2613_12 2613_41 2886_3 2886_5 2886_7
do

## Doing Tdu -- TDU and TPR alignments for comparing
SAMA=${IN}/Tdu_${i}_unq_2_TDU_4_Tms_commonID.sam
SAMB=${IN}/Tdu_${i}_unq_2_TPR_4_Tms_commonID.sam

### Concatenate reads for use in sam-compare; sed 's/ /_/g': replace all (g, global) space with _
# DO NOT REPLACE SAPCE WITH UNDERSCORE!!! DIFFERENT FROM LUCAS'S METHOD; I USED PAIRED READS FOR MAPPING
cat ${READ}/Tdu_${i}_*.fastq > ${TMPDIR}/Tdu_${i}.fastq

# LENGTH OF READS (-L) CHANGED TO 150
python ${SCRIPTS}/sam_compare.shan.py \
	-d \
	-l 150 \
	-f ${IN}/TDU_tpr_bed_for_sam_compare.bed \
	-q ${TMPDIR}/Tdu_${i}.fastq \
	-A $SAMA \
	-B $SAMB \
	-c ${OUT}/ase_counts_Tdu_${i}_2_Tdu_Tpr.csv \
	-t ${OUT}/ase_totals_Tdu_${i}_2_Tdu_Tpr.csv \
	-g ${LOGS}/ase_counts_Tdu_${i}_2_Tdu_Tpr.log
done


## TPR reads to TDU and TPR for Tms
for i in 2608_3 2608_21 2608_31
do

## Doing Tpr -- TDU and TPR alignments for comparing
SAMA=${IN}/Tpr_${i}_unq_2_TDU_4_Tms_commonID.sam
SAMB=${IN}/Tpr_${i}_unq_2_TPR_4_Tms_commonID.sam

### Concatenate reads for use in sam-compare
# DO NOT REPLACE SAPCE WITH UNDERSCORE!!! DIFFERENT FROM LUCAS'S METHOD; I USED PAIRED READS FOR MAPPING
cat ${READ}/Tpr_${i}_*.fastq > ${TMPDIR}/Tpr_${i}.fastq

# LENGTH OF READS (-L) CHANGED TO 150
python ${SCRIPTS}/sam_compare.shan.py \
	-d \
	-l 150 \
	-f ${IN}/TPR_tdu_bed_for_sam_compare.bed \
	-q ${TMPDIR}/Tpr_${i}.fastq \
	-A $SAMA \
	-B $SAMB \
	-c ${OUT}/ase_counts_Tpr_${i}_2_Tdu_Tpr.csv \
	-t ${OUT}/ase_totals_Tpr_${i}_2_Tdu_Tpr.csv \
	-g ${LOGS}/ase_counts_Tpr_${i}_2_Tdu_Tpr.log
done

date