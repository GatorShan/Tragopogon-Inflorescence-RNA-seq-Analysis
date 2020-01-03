#!/bin/bash

#SBATCH --job-name=TransDecoder_Tpr_1.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=TransDecoder_Tpr_1.0_%j.out
#SBATCH --error=TransDecoder_Tpr_1.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=1gb
#SBATCH --time=02:00:00

date;hostname;pwd

IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/SuperTranscript
OUT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Annotation/TransDecoder/Tpr

module purge
module load transdecoder/5.5.0

TransDecoder.LongOrfs \
	-t ${IN}/SuperTranscript_Tpr.fasta \
	-O ${OUT}

TransDecoder.Predict \
	-t ${IN}/SuperTranscript_Tpr.fasta \
	-O ${OUT}

date
