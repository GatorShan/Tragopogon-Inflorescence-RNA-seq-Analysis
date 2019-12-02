#!/bin/bash

#SBATCH --job-name=SuperTranscript_Tpr_1.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=SuperTranscript_Tpr_1.0_%j.out
#SBATCH --error=SuperTranscript_Tpr_1.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4gb
#SBATCH --time=05:00:00

date;hostname;pwd

IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Trinity/Tpr_trinity_crop_separately_norm_1
OUT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/SuperTranscript

module purge
module load gcc/5.2.0
module load trinity/r20180213-2.6.5

cd ${OUT}

$TRINITY_HOME/Analysis/SuperTranscripts/Trinity_gene_splice_modeler.py \
	--trinity_fasta ${IN}/Tpr_trinity_crop_separately_norm_1.Trinity.fasta \
	--out_prefix SuperTranscript_Tpr \
	--incl_malign

date
