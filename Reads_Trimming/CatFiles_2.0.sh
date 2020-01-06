#!/bin/bash

#SBATCH --job-name=CatFiles_2.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=CatFiles_2.0_%j.out
#SBATCH --error=CatFiles_2.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2gb
#SBATCH --time=05:00:00

date;hostname;pwd

IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/rRNA_Filter/Crop_clean
OUT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/CatCleanReads/Crop

cat ${IN}/Tpr_2608_*_R1_crop_clean.fastq >> ${OUT}/Tpr_2608_R1_crop_clean_cat.fastq
echo "Tpr_2608_R1 files have been combined"

cat ${IN}/Tpr_2608_*_R2_crop_clean.fastq >> ${OUT}/Tpr_2608_R2_crop_clean_cat.fastq
echo "Tpr_2608_R2 files have been combined"

cat ${IN}/Tdu_2613_*_R1_crop_clean.fastq >> ${OUT}/Tdu_2613_R1_crop_clean_cat.fastq
echo "Tdu_2613_R1 files have been combined"

cat ${IN}/Tdu_2613_*_R2_crop_clean.fastq >> ${OUT}/Tdu_2613_R2_crop_clean_cat.fastq
echo "Tdu_2613_R2 files have been combined"

cat ${IN}/Tdu_2886_*_R1_crop_clean.fastq >> ${OUT}/Tdu_2886_R1_crop_clean_cat.fastq
echo "Tdu_2886_R1 files have been combined"

cat ${IN}/Tdu_2886_*_R2_crop_clean.fastq >> ${OUT}/Tdu_2886_R2_crop_clean_cat.fastq
echo "Tdu_2886_R2 files have been combined"

date
