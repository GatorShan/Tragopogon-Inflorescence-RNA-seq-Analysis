#!/bin/bash

#SBATCH --job-name=Trinity_normalization_Tpr_crop_2.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=Trinity_normalization_Tpr_crop_2.0_%j.out
#SBATCH --error=Trinity_normalization_Tpr_crop_2.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem-per-cpu=32gb
#SBATCH --time=08:00:00
#SBATCH --qos=soltis-b
#SBATCH --partition=bigmem

date;hostname;pwd

IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/CatCleanReads/Crop
OUT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Trinity_normalization/Tpr_crop_1

module purge
module load gcc/5.2.0
module load trinity/r20180213-2.6.5

insilico_read_normalization.pl \
	--seqType fq \
	--JM 155G \
	--max_cov 50 \
	--left ${IN}/Tpr_2608_R1_crop_clean_cat.fastq \
	--right $IN/Tpr_2608_R2_crop_clean_cat.fastq \
	--CPU 5 \
	--output ${OUT} \
	--pairs_together \
	--PARALLEL_STATS \
	--min_cov 2

date
