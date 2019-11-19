#!/bin/bash

#SBATCH --job-name=TrimmomaticCrop_Poly_1.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=TrimmomaticCrop_Poly_1.0_%j.out
#SBATCH --error=TrimmomaticCrop_Poly_1.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=5gb
#SBATCH --time=08:00:00

date;hostname;pwd

IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/AdapterTrim/Tetraploid
OUT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/TrimmomaticCrop

module purge
module load trimmomatic/0.36

for Pop in 2604 2605; do
	if [ $Pop == '2604' ]
	then
		for Rep in 24 43 48; do
			trimmomatic \
				PE \
				-threads 4 \
				-phred33 \
				${IN}/Tms_${Pop}_${Rep}_R1_adapter_trimmed.fastq ${IN}/Tms_${Pop}_${Rep}_R2_adapter_trimmed.fastq \
				${OUT}/Tms_${Pop}_${Rep}_R1_trimmomatic-crop_paired.fastq ${OUT}/Tms_${Pop}_${Rep}_R1_trimmomatic-crop_unpaired.fastq \
				${OUT}/Tms_${Pop}_${Rep}_R2_trimmomatic-crop_paired.fastq ${OUT}/Tms_${Pop}_${Rep}_R2_trimmomatic-crop_unpaired.fastq \
				HEADCROP:10 \
				LEADING:3 \
				TRAILING:3 \
				SLIDINGWINDOW:4:15 \
				MINLEN:60
			echo "Tms_${Pop}_${Rep} has beem trimmed"
		done
	elif [ $Pop == '2605' ]
	then
		for Rep in 9 24 42; do
			trimmomatic \
				PE \
				-threads 4 \
				-phred33 \
				${IN}/Tml_${Pop}_${Rep}_R1_adapter_trimmed.fastq ${IN}/Tml_${Pop}_${Rep}_R2_adapter_trimmed.fastq \
				${OUT}/Tml_${Pop}_${Rep}_R1_trimmomatic-crop_paired.fastq ${OUT}/Tml_${Pop}_${Rep}_R1_trimmomatic-crop_unpaired.fastq \
				${OUT}/Tml_${Pop}_${Rep}_R2_trimmomatic-crop_paired.fastq ${OUT}/Tml_${Pop}_${Rep}_R2_trimmomatic-crop_unpaired.fastq \
				HEADCROP:10 \
				LEADING:3 \
				TRAILING:3 \
				SLIDINGWINDOW:4:15 \
				MINLEN:60
			echo "Tml_${Pop}_${Rep} has beem trimmed"
		done
	fi
done

date
