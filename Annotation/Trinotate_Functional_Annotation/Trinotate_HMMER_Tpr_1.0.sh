#!/bin/bash

#SBATCH --job-name=Trinotate_HMMER_Tpr_1.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=Trinotate_HMMER_Tpr_1.0_%j.out
#SBATCH --error=Trinotate_HMMER_Tpr_1.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=2gb
#SBATCH --time=14:00:00

date;hostname;pwd

IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Annotation/TransDecoder/Tpr
DB=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Annotation/Database
OUT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Annotation/HMMER

module purge
module load hmmer/3.2.1

# prepare an HMM database for faster hmmscan searches
#hmmpress \
#	${DB}/Pfam-A.hmm

# search the database
hmmscan \
	--cpu 12 \
	--domtblout ${OUT}/Tpr_TrinotatePFAM.out \
	${DB}/Pfam-A.hmm \
	${IN}/SuperTranscript_Tpr.fasta.transdecoder.pep \
	> ${OUT}/Tpr_pfam.log

date
