#!/bin/bash

#SBATCH --job-name=Diploid_alignment_filter_V3.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=Diploid_alignment_filter_V3.0_%j.out
#SBATCH --error=Diploid_alignment_filter_V3.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=15gb
#SBATCH --time=2-00:00:00
#SBATCH --qos=soltis-b

date;hostname;pwd

module purge
module load samtools/1.9
module load sambamba/0.6.9

IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Filter_orthologs

cd ${IN}

for FILE in `ls *.sam`; do
	
	echo "$FILE is going to be processed"
	
	# Changing file format from SAM to BAM
	samtools view \
		-h \
		-S \
		-b \
		-o ${FILE%.*}_unsorted.bam \
		$FILE
	echo -e "\t$FILE has been formatted to BAM file"

	# Sorting BAM file by genomic coordinates
	sambamba sort \
		-t 10 \
		-o ${FILE%.*}_sorted.bam \
		${FILE%.*}_unsorted.bam
	echo -e "\t${FILE%.*}_unsorted.bam file has been sorted"

	# Filtering uniquely mapping reads
	sambamba view \
		-h \
		-t 10 \
		-f bam \
		-F "[XS] == null and not unmapped" \
		${FILE%.*}_sorted.bam > ${FILE%.*}_uniq.bam
	echo -e "\t${FILE%.*}_sorted.bam have been filtered"
	
	# Convert BAM file to SAM file
	samtools view \
		-h \
		-o ${FILE%.*}_uniq.sam \
		${FILE%.*}_uniq.bam
	echo -e "\t${FILE%.*}_uniq.sam has been generated"

done

date
