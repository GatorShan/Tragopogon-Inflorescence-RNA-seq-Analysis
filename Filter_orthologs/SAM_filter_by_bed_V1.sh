#!/bin/bash

#SBATCH --job-name=SAM_filter_by_bed_V1
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=SAM_filter_by_bed_V1_%j.out
#SBATCH --error=SAM_filter_by_bed_V1_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5gb
#SBATCH --time=2-00:00:00
#SBATCH --qos=soltis

date;hostname;pwd

module purge
module load perl/5.24.1

IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Filter_orthologs/Mapping_diploids_reads_2_Parents_ST
OUT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Filter_orthologs/Filter_SAM_by_bed

cd ${IN}

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

date
