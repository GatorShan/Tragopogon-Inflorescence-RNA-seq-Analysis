#!/bin/bash

#SBATCH --job-name=ReadRepresent_Tpr_crop_trinity_separately_norm_1.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=ReadRepresent_Tpr_crop_trinity_separately_norm_1.0_%j.out
#SBATCH --error=ReadRepresent_Tpr_crop_trinity_separately_norm_1.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=500mb
#SBATCH --time=1-00:00:00
##SBATCH --qos=soltis-b

date;hostname;pwd

cd /ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/AssemblyAssessment/ReadRepresent/Tpr_crop_trinity_separately_norm

IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Trinity/Tpr_trinity_crop_separately_norm_1
OUT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/AssemblyAssessment/ReadRepresent/Tpr_crop_trinity_separately_norm
READ=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/CatCleanReads/Crop

module load bowtie2/2.3.5.1
module load samtools/1.9

bowtie2-build \
	${IN}/Tpr_trinity_crop_separately_norm_1.Trinity.fasta \
	${OUT}/Tpr_trinity_crop_separately_norm_1.Trinity.fasta

echo "The transcriptome has been indexed"

bowtie2 -p 10 -q --no-unal -k 20 -x ${OUT}/Tpr_trinity_crop_separately_norm_1.Trinity.fasta \
	-1 ${READ}/Tpr_2608_R1_crop_clean_cat.fastq \
	-2 ${READ}/Tpr_2608_R2_crop_clean_cat.fastq \
	2>align_stats.txt| samtools view -@10 -Sb -o bowtie2.bam
 
echo "The reads have been mapped to the transcriptome"

cat 2>&1 align_stats.txt

date