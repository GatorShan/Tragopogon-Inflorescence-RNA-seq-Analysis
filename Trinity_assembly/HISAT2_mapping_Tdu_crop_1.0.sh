#!/bin/bash

#SBATCH --job-name=HISAT2_mapping_Tdu_crop_1.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=HISAT2_mapping_Tdu_crop_1.0_%j.out
#SBATCH --error=HISAT2_mapping_Tdu_crop_1.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=2gb
#SBATCH --time=10:00:00
#SBATCH --qos=soltis-b

date;hostname;pwd

INDEX=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/HISAT2/Ref_index
IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/CatCleanReads/Crop
OUT1=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/HISAT2/Mapping_Tdu_2613_crop
OUT2=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/HISAT2/Mapping_Tdu_2886_crop

module purge
module load gcc/5.2.0
module load hisat2/2.1.0

hisat2 \
	-x ${INDEX}/Tdu_ref_v1 \
	-1 ${IN}/Tdu_2613_R1_crop_clean_cat.fastq \
	-2 ${IN}/Tdu_2613_R2_crop_clean_cat.fastq \
	-S ${OUT1}/Tdu_2613_crop.sam \
	--phred33 \
	-p 8 \
	--summary-file ${OUT1}/AlignmentSummary_Tdu_2613_crop.txt

echo "Tdu_2613_crop has been mapped to Tdu_ref_v1"

hisat2 \
	-x ${INDEX}/Tdu_ref_v1 \
	-1 ${IN}/Tdu_2886_R1_crop_clean_cat.fastq \
	-2 ${IN}/Tdu_2886_R2_crop_clean_cat.fastq \
	-S ${OUT2}/Tdu_2886_crop.sam \
	--phred33 \
	-p 8 \
	--summary-file ${OUT2}/AlignmentSummary_Tdu_2886_crop.txt

echo "Tdu_2886_crop has been mapped to Tdu_ref_v1"

date