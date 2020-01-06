#!/bin/bash

#SBATCH --job-name=TrimmomaticCrop_1.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=TrimmomaticCrop_1.0_%j.out
#SBATCH --error=TrimmomaticCrop_1.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=5gb
#SBATCH --time=08:00:00

date;hostname;pwd

cd /ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/AdapterTrim/

module load trimmomatic/0.36

for Pop in 2608 2613 2886; do
	if [ $Pop == '2608' ]
	then
		for Rep in 3 21 31; do
			trimmomatic \
			PE \
			-threads 4 \
			-phred33 \
			./Tpr_${Pop}_${Rep}_R1_adapter_trimmed.fastq ./Tpr_${Pop}_${Rep}_R2_adapter_trimmed.fastq \
			../TrimmomaticCrop/Tpr_${Pop}_${Rep}_R1_trimmomatic-crop_paired.fastq ../TrimmomaticCrop/Tpr_${Pop}_${Rep}_R1_trimmomatic-crop_unpaired.fastq \
			../TrimmomaticCrop/Tpr_${Pop}_${Rep}_R2_trimmomatic-crop_paired.fastq ../TrimmomaticCrop/Tpr_${Pop}_${Rep}_R2_trimmomatic-crop_unpaired.fastq \
			HEADCROP:10 \
			LEADING:3 \
			TRAILING:3 \
			SLIDINGWINDOW:4:15 \
			MINLEN:60
		done
	elif [ $Pop == '2613' ]
	then
		for Rep in 11 12 41; do
			trimmomatic \
			PE \
			-threads 4 \
			-phred33 \
			./Tdu_${Pop}_${Rep}_R1_adapter_trimmed.fastq ./Tdu_${Pop}_${Rep}_R2_adapter_trimmed.fastq \
			../TrimmomaticCrop/Tdu_${Pop}_${Rep}_R1_trimmomatic-crop_paired.fastq ../TrimmomaticCrop/Tdu_${Pop}_${Rep}_R1_trimmomatic-crop_unpaired.fastq \
			../TrimmomaticCrop/Tdu_${Pop}_${Rep}_R2_trimmomatic-crop_paired.fastq ../TrimmomaticCrop/Tdu_${Pop}_${Rep}_R2_trimmomatic-crop_unpaired.fastq \
			HEADCROP:10 \
			LEADING:3 \
			TRAILING:3 \
			SLIDINGWINDOW:4:15 \
			MINLEN:60
		done
	elif [ $Pop == '2886' ]
	then
		for Rep in 3 5 7; do
			trimmomatic \
			PE \
			-threads 4 \
			-phred33 \
			./Tdu_${Pop}_${Rep}_R1_adapter_trimmed.fastq ./Tdu_${Pop}_${Rep}_R2_adapter_trimmed.fastq \
			../TrimmomaticCrop/Tdu_${Pop}_${Rep}_R1_trimmomatic-crop_paired.fastq ../TrimmomaticCrop/Tdu_${Pop}_${Rep}_R1_trimmomatic-crop_unpaired.fastq \
			../TrimmomaticCrop/Tdu_${Pop}_${Rep}_R2_trimmomatic-crop_paired.fastq ../TrimmomaticCrop/Tdu_${Pop}_${Rep}_R2_trimmomatic-crop_unpaired.fastq \
			HEADCROP:10 \
			LEADING:3 \
			TRAILING:3 \
			SLIDINGWINDOW:4:15 \
			MINLEN:60
		done
	fi
done

date
