#!/bin/bash

#SBATCH --job-name=ReadRepresent_Tdu_norm_concat_denovo_1.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=ReadRepresent_Tdu_norm_concat_denovo_1.0_%j.out
#SBATCH --error=ReadRepresent_Tdu_norm_concat_denovo_1.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=3gb
#SBATCH --time=1-00:00:00
#SBATCH --qos=soltis-b

date;hostname;pwd

IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Trinity/Tdu_trinity_norm_concat_denovo
OUT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/AssemblyAssessment/ReadRepresent/Tdu_trinity_norm_concat_denovo
READ=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/CatCleanReads/Crop

cd ${OUT}

module load bowtie2/2.3.5.1
module load samtools/1.9

#bowtie2-build \
#	${IN}/Tdu_trinity_norm_concat_denovo.Trinity.fasta \
#	${OUT}/Tdu_trinity_norm_concat_denovo.Trinity.fasta

#echo "The transcriptome has been indexed"

bowtie2 -p 10 -q --no-unal -k 20 -x ${OUT}/Tdu_trinity_norm_concat_denovo.Trinity.fasta \
	-1 ${READ}/Tdu_R1_clean_concatenated.fastq \
	-2 ${READ}/Tdu_R2_clean_concatenated.fastq \
	2>align_stats.txt| samtools view -@10 -Sb -o bowtie2.bam

echo "The reads have been mapped to the transcriptome"

cat 2>&1 align_stats.txt

date
