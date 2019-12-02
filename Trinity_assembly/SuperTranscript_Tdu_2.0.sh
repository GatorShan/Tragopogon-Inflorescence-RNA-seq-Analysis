#!/bin/bash

#SBATCH --job-name=SuperTranscript_Tdu_2.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=SuperTranscript_Tdu_2.0_%j.out
#SBATCH --error=SuperTranscript_Tdu_2.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4gb
#SBATCH --time=05:00:00

date;hostname;pwd

IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Trinity/Tdu_trinity_norm_concat_denovo
OUT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/SuperTranscript

module purge
module load gcc/5.2.0
module load trinity/r20180213-2.6.5

cd ${OUT}

$TRINITY_HOME/Analysis/SuperTranscripts/Trinity_gene_splice_modeler.py \
	--trinity_fasta ${IN}/Tdu_trinity_norm_concat_denovo.Trinity.fasta \
	--out_prefix SuperTranscript_Tdu \
	--incl_malign

date
