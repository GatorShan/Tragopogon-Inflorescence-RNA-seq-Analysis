#!/bin/bash

#SBATCH --job-name=Trinotate_SignalP_Tpr_1.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=Trinotate_SignalP_Tpr_1.0_%j.out
#SBATCH --error=Trinotate_SignalP_Tpr_1.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=3gb
#SBATCH --time=10:00:00

date;hostname;pwd

IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Annotation/TransDecoder/Tpr
OUT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Annotation/SignalP

module purge
module load signalp/5.0b

cd ${OUT}

signalp \
	-fasta ${IN}/SuperTranscript_Tpr.fasta.transdecoder.pep

date
