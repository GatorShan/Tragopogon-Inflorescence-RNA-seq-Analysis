#!/bin/bash

#SBATCH --job-name=Trinotate_HMMER_Tdu_1.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=Trinotate_HMMER_Tdu_1.0_%j.out
#SBATCH --error=Trinotate_HMMER_Tdu_1.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=2gb
#SBATCH --time=10:00:00

date;hostname;pwd

IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Annotation/TransDecoder
DB=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Annotation/Database
OUT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Annotation/HMMER

module purge
module load hmmer/3.2.1

# prepare an HMM database for faster hmmscan searches
hmmpress \
	${DB}/Pfam-A.hmm

# search the database
hmmscan \
	--cpu 12 \
	--domtblout ${OUT}/Tdu_TrinotatePFAM.out \
	${DB}/Pfam-A.hmm \
	${IN}/SuperTranscript_Tdu.fasta.transdecoder.pep \
	> ${OUT}/Tdu_pfam.log

date
