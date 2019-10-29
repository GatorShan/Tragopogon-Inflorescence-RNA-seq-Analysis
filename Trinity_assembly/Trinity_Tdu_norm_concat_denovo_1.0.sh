#!/bin/bash

#SBATCH --job-name=Trinity_Tdu_norm_concat_denovo_1.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=Trinity_Tdu_norm_concat_denovo_1.0_%j.out
#SBATCH --error=Trinity_Tdu_norm_concat_denovo_1.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem-per-cpu=16gb
#SBATCH --time=4-00:00:00
#SBATCH --qos=soltis-b

date;hostname;pwd

cd /ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Trinity/Tdu_trinity_norm_concat_denovo

IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Trinity_normalization/Tdu_norm_concatenated
OUT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Trinity/Tdu_trinity_norm_concat_denovo

module purge
module load gcc/5.2.0
module load trinity/r20180213-2.6.5

Trinity --seqType fq \
	--max_memory 75G \
	--left ${IN}/Tdu_R1_clean_K25_maxC50_minC2_pctSD10000_concatenated.fq \
	--right ${IN}/Tdu_R2_clean_K25_maxC50_minC2_pctSD10000_concatenated.fq \
	--CPU 5 \
	--min_contig_length 200 \
	--full_cleanup \
	--output ${OUT} \
	--no_normalize_reads

date
