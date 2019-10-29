#!/bin/bash

#SBATCH --job-name=CatFiles_4.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=CatFiles_4.0_%j.out
#SBATCH --error=CatFiles_4.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1gb
#SBATCH --time=02:00:00

date;hostname;pwd

R1_IN1=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Trinity_normalization/Tdu_2613/Tdu_2613_R1_crop_clean_cat.fastq.normalized_K25_maxC50_minC2_pctSD10000.fq
R1_IN2=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Trinity_normalization/Tdu_2886/Tdu_2886_R1_crop_clean_cat.fastq.normalized_K25_maxC50_minC2_pctSD10000.fq

R2_IN1=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Trinity_normalization/Tdu_2613/Tdu_2613_R2_crop_clean_cat.fastq.normalized_K25_maxC50_minC2_pctSD10000.fq
R2_IN2=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Trinity_normalization/Tdu_2886/Tdu_2886_R2_crop_clean_cat.fastq.normalized_K25_maxC50_minC2_pctSD10000.fq

R1_OUT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Trinity_normalization/Tdu_norm_concatenated/Tdu_R1_clean_K25_maxC50_minC2_pctSD10000_concatenated.fq
R2_OUT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Trinity_normalization/Tdu_norm_concatenated/Tdu_R2_clean_K25_maxC50_minC2_pctSD10000_concatenated.fq

cat ${R1_IN1} ${R1_IN2} >> ${R1_OUT}

echo "Tdu_R1 norm. files have been combined"

cat ${R2_IN1} ${R2_IN2} >> ${R2_OUT}

echo "Tdu_R2 norm. files have been combined"

date
