#!/bin/bash

#SBATCH --job-name=Trinity_Tpr_crop_separately_norm_2.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=Trinity_Tpr_crop_separately_norm_2.0_%j.out
#SBATCH --error=Trinity_Tpr_crop_separately_norm_2.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem-per-cpu=16gb
#SBATCH --time=3-00:00:00
#SBATCH --qos=soltis-b
##SBATCH --partition=bigmem

date;hostname;pwd

IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Trinity_normalization/Tpr_crop_1
OUT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Trinity/Tpr_trinity_crop_separately_norm_1

module purge
module load gcc/5.2.0
module load trinity/r20180213-2.6.5

Trinity --seqType fq \
	--max_memory 75G \
	--left ${IN}/Tpr_2608_R1_crop_clean_cat.fastq.normalized_K25_maxC50_minC2_pctSD10000.fq \
	--right ${IN}/Tpr_2608_R2_crop_clean_cat.fastq.normalized_K25_maxC50_minC2_pctSD10000.fq \
	--CPU 5 \
	--min_contig_length 200 \
	--full_cleanup \
	--output ${OUT} \
	--no_normalize_reads

date
