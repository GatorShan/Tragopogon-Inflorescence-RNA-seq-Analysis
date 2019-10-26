#!/bin/bash

#SBATCH --job-name=Samtools_Tdu-2613_1.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=Samtools_Tdu-2613_1.0_%j.out
#SBATCH --error=Samtools_Tdu-2613_1.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=2gb
#SBATCH --time=05:00:00
##SBATCH --qos=soltis-b

date;hostname;pwd

IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/HISAT2/Mapping_Tdu_2613_crop

module purge
module load samtools/1.9

# change the format from sam to bam
#samtools view -bS \
#	${IN}/Tdu_2613_crop.sam > ${IN}/Tdu_2613_crop.bam \
#	-@ 4

# sort the bam file by name
samtools sort \
	${IN}/Tdu_2613_crop.bam \
	-o ${IN}/Tdu_2613_crop.nameSorted.bam \
	-n \
	-@ 4

# Add ms and MC tags for markdup to use later; input of fixmate must be name-sorted
samtools fixmate \
	-m \
	${IN}/Tdu_2613_crop.nameSorted.bam \
	${IN}/Tdu_2613_crop.fixmate.bam \
	-@ 4

# Markdup needs position order
samtools sort \
	${IN}/Tdu_2613_crop.fixmate.bam \
	-o ${IN}/Tdu_2613_crop.positionSorted.bam \
	-@ 4

# mark duplicates
samtools markdup \
	-s \
	${IN}/Tdu_2613_crop.positionSorted.bam \
	${IN}/Tdu_2613_crop.markdup.bam \
	-@ 4

date
