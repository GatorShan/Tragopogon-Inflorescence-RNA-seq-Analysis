#!/bin/bash

#SBATCH --job-name=Trinotate_RNAmmer_Tdu_1.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=Trinotate_RNAmmer_Tdu_1.0_%j.out
#SBATCH --error=Trinotate_RNAmmer_Tdu_1.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10gb
#SBATCH --time=10:00:00

date;hostname;pwd

IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/SuperTranscript
OUT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Annotation/RNAmmer

module purge
module load trinotate/3.0.1
module load rnammer/1.2

cd ${OUT}

/apps/trinotate/3.0.1/util/rnammer_support/RnammerTranscriptome.pl \
	--transcriptome ${IN}/SuperTranscript_Tdu.fasta \
	--path_to_rnammer /apps/rnammer/1.2/bin/rnammer

date
