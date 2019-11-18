#!/bin/bash

#SBATCH --job-name=AdaptorTrimming_R1_1.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=AdaptorTrimming_R1_1.0_%j.out
#SBATCH --error=AdaptorTrimming_R1_1.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=5gb
#SBATCH --time=08:00:00

date;hostname;pwd

cd /ufrc/soltis/shan158538/TragFL_NewAnalysis/RawData

module load cutadapt/2.1

for Pop in 2608 2613 2886; do
	if [ $Pop == '2608' ]
	then
		for Rep in 3 21 31; do
			cutadapt \
			--error-rate 0.1 \
			--times 1 \
			--overlap 5 \
			--minimum-length 0 \
			--adapter AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC \
			--front TACACTCTTTCCCTACACGACGCTCTTCCGATCT \
			--quality-base 33 \
			--output ../OutPut/AdapterTrim/Tpr_${Pop}_${Rep}_R1_adapter_trimmed.fastq \
			Tpr_${Pop}_${Rep}_R1.fastq
		done
	elif [ $Pop == '2613' ]
	then
		for Rep in 11 12 41; do
			cutadapt \
			--error-rate 0.1 \
			--times 1 \
			--overlap 5 \
			--minimum-length 0 \
			--adapter AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC \
			--front TACACTCTTTCCCTACACGACGCTCTTCCGATCT \
			--quality-base 33 \
			--output ../OutPut/AdapterTrim/Tdu_${Pop}_${Rep}_R1_adapter_trimmed.fastq \
			Tdu_${Pop}_${Rep}_R1.fastq
		done
	elif [ $Pop == '2886' ]
	then
		for Rep in 3 5 7; do
			cutadapt \
			--error-rate 0.1 \
			--times 1 \
			--overlap 5 \
			--minimum-length 0 \
			--adapter AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC \
			--front TACACTCTTTCCCTACACGACGCTCTTCCGATCT \
			--quality-base 33 \
			--output ../OutPut/AdapterTrim/Tdu_${Pop}_${Rep}_R1_adapter_trimmed.fastq \
			Tdu_${Pop}_${Rep}_R1.fastq
		done
	fi
done

date
