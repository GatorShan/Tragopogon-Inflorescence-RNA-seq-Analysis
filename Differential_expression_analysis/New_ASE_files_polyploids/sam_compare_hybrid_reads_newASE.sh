#!/bin/bash

#SBATCH --job-name=sam_compare_hybrid_reads_newASE
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=sam_compare_hybrid_reads_newASE_%j.out
#SBATCH --error=sam_compare_hybrid_reads_newASE_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=30gb
#SBATCH --time=1-00:00:00
#SBATCH --qos=soltis-b

date;hostname;pwd

# python version has been changed from 2.7.3 to 2.7.10
module purge
module load gcc/5.2.0
module load python/2.7.10

#### Set Directories
IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Polyploid_alignment/Filter_SAM_by_bed_newASE
SCRIPTS=/ufrc/soltis/shan158538/TragFL_NewAnalysis/SLURM
READ=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/rRNA_Filter/Crop_clean
OUT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Polyploid_alignment/Compare_SAM_newASE
TMPDIR=${OUT}/temp_dir
LOGS=${OUT}/logs

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

## Tml (long-liguled) reads to TDU and TPR
for i in 2605_9 2605_24 2605_42
do

SAMA=${IN}/Tml_${i}_unq_2_TDU_commonID_newASE.sam
SAMB=${IN}/Tml_${i}_unq_2_TPR_commonID_newASE.sam

### Concatenate reads for use in sam-compare; sed 's/ /_/g': replace all (g, global) space with _
# DO NOT REPLACE SAPCE WITH UNDERSCORE!!! DIFFERENT FROM LUCAS'S METHOD; I USED PAIRED READS FOR MAPPING
cat ${READ}/Tml_${i}_*.fastq > ${TMPDIR}/Tml_${i}.fastq

# LENGTH OF READS (-L) CHANGED TO 150
python ${SCRIPTS}/sam_compare.shan.py \
	-d \
	-l 150 \
	-f ${IN}/TDU_tpr_bed_for_sam_compare.bed \
	-q ${TMPDIR}/Tml_${i}.fastq \
	-A $SAMA \
	-B $SAMB \
	-c ${OUT}/ase_counts_new_Tml_${i}_2_tdu_tpr.csv \
	-t ${OUT}/ase_totals_new_Tml_${i}_2_tdu_tpr.csv \
	-g ${LOGS}/ase_counts_new_Tml_${i}_2_tdu_tpr.log
done

date