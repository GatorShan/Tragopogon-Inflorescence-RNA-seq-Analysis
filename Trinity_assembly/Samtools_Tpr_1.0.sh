#!/bin/bash

#SBATCH --job-name=Samtools_Tpr_1.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=Samtools_Tpr_1.0_%j.out
#SBATCH --error=Samtools_Tpr_1.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=2gb
#SBATCH --time=05:00:00
#SBATCH --qos=soltis-b

date;hostname;pwd

IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/HISAT2/Mapping_Tpr_2608_crop

module purge
module load samtools/1.9

# change the format from sam to bam
samtools view -bS \
	${IN}/Tpr_2608_crop.sam > ${IN}/Tpr_2608_crop.bam \
	-@ 4

# sort the bam file by name
samtools sort \
	${IN}/Tpr_2608_crop.bam \
	-o ${IN}/Tpr_2608_crop.nameSorted.bam \
	-n \
	-@ 4

# Add ms and MC tags for markdup to use later; input of fixmate must be name-sorted
samtools fixmate \
	-m \
	${IN}/Tpr_2608_crop.nameSorted.bam \
	${IN}/Tpr_2608_crop.fixmate.bam \
	-@ 4

# Markdup needs position order
samtools sort \
	${IN}/Tpr_2608_crop.fixmate.bam \
	-o ${IN}/Tpr_2608_crop.positionSorted.bam \
	-@ 4

# mark duplicates
samtools markdup \
	-s \
	${IN}/Tpr_2608_crop.positionSorted.bam \
	${IN}/Tpr_2608_crop.markdup.bam \
	-@ 4

date
