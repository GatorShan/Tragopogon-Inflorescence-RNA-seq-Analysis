#!/bin/bash

#SBATCH --job-name=HISAT2_mapping_Tpr_crop_1.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=HISAT2_mapping_Tpr_crop_1.0_%j.out
#SBATCH --error=HISAT2_mapping_Tpr_crop_1.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=2gb
#SBATCH --time=2:00:00
#SBATCH --qos=soltis-b

date;hostname;pwd

INDEX=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/HISAT2/Ref_index
IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/CatCleanReads/Crop
OUT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/HISAT2/Mapping_Tpr_2608_crop

module purge
module load gcc/5.2.0
module load hisat2/2.1.0

hisat2 \
	-x ${INDEX}/Tdu_ref_v1 \
	-1 ${IN}/Tpr_2608_R1_crop_clean_cat.fastq \
	-2 ${IN}/Tpr_2608_R2_crop_clean_cat.fastq \
	-S ${OUT}/Tpr_2608_crop.sam \
	--phred33 \
	-p 8 \
	--summary-file ${OUT}/AlignmentSummary_Tpr_2608_crop.txt

echo "Tpr_2608_crop has been mapped to Tdu_ref_v1"

date