#!/bin/bash

#SBATCH --job-name=Bowtie2_Tdu_reads_Tdu_ST_V1.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=Bowtie2_Tdu_reads_Tdu_ST_V1.0_%j.out
#SBATCH --error=Bowtie2_Tdu_reads_Tdu_ST_V1.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=4gb
#SBATCH --time=3-00:00:00

date;hostname;pwd

REF=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/SuperTranscript
READ=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/CatCleanReads/Crop
OUT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Filter_orthologs

module purge
module load bowtie2/2.3.5.1

bowtie2-build \
	${REF}/SuperTranscript_Tdu_FullName.fasta \
	${REF}/SuperTranscript_Tdu_FullName

echo "The supertranscript reference has been indexed"

bowtie2 \
	-p 10 \
	-q \
	--no-unal \
	-x ${REF}/SuperTranscript_Tdu_FullName \
	-1 ${READ}/Tdu_R1_clean_concatenated.fastq \
	-2 ${READ}/Tdu_R2_clean_concatenated.fastq \
	-S ${OUT}/Tdu_reads_Tdu_ST_V1.sam

echo "Tdu reads have been mapped to Tdu supertranscripts"

date
