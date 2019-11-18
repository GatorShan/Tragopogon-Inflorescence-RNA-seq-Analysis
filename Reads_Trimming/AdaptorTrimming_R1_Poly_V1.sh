#!/bin/bash

#SBATCH --job-name=AdaptorTrimming_R1_Poly_V1
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=AdaptorTrimming_R1_Poly_V1_%j.out
#SBATCH --error=AdaptorTrimming_R1_Poly_V1_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5gb
#SBATCH --time=08:00:00

date;hostname;pwd

IN=/orange/soltis/SequenceBackup/Xiaoxian_TragFL.RNA_NextSeq_20150129/NS_PSoltis-103369_T1-T6Pool_1-26-2015-19819800
OUT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/AdapterTrim/Tetraploid

for SEQREP in T1 T2 T3 T4 T5 T6; do
	cd ${IN}/${SEQREP}*
	cat ${SEQREP}_*_L001_R1_* ${SEQREP}_*_L002_R1_* ${SEQREP}_*_L003_R1_* ${SEQREP}_*_L004_R1_* >> ${OUT}/${SEQREP}_R1.fastq.gz
	echo "${SEQREP} fastq.gz files have been combined"
done

module load cutadapt/2.1

for SEQREP in T1 T2 T3 T4 T5 T6; do
	if [ ${SEQREP} == 'T1' ]
	then
		cutadapt \
			--error-rate 0.1 \
			--times 1 \
			--overlap 5 \
			--minimum-length 0 \
			--adapter AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC \
			--front TACACTCTTTCCCTACACGACGCTCTTCCGATCT \
			--quality-base 33 \
			--output ${OUT}/Tml_2605_9_R1_adapter_trimmed.fastq \
			${OUT}/${SEQREP}_R1.fastq.gz
		echo "${SEQREP} has been trimmed"	
	elif [ ${SEQREP} == 'T2' ]
	then
		cutadapt \
			--error-rate 0.1 \
			--times 1 \
			--overlap 5 \
			--minimum-length 0 \
			--adapter AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC \
			--front TACACTCTTTCCCTACACGACGCTCTTCCGATCT \
			--quality-base 33 \
			--output ${OUT}/Tms_2604_43_R1_adapter_trimmed.fastq \
			${OUT}/${SEQREP}_R1.fastq.gz
		echo "${SEQREP} has been trimmed"
	elif [ ${SEQREP} == 'T3' ]
	then
		cutadapt \
			--error-rate 0.1 \
			--times 1 \
			--overlap 5 \
			--minimum-length 0 \
			--adapter AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC \
			--front TACACTCTTTCCCTACACGACGCTCTTCCGATCT \
			--quality-base 33 \
			--output ${OUT}/Tms_2604_24_R1_adapter_trimmed.fastq \
			${OUT}/${SEQREP}_R1.fastq.gz
		echo "${SEQREP} has been trimmed"
	elif [ ${SEQREP} == 'T4' ]
	then
		cutadapt \
			--error-rate 0.1 \
			--times 1 \
			--overlap 5 \
			--minimum-length 0 \
			--adapter AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC \
			--front TACACTCTTTCCCTACACGACGCTCTTCCGATCT \
			--quality-base 33 \
			--output ${OUT}/Tml_2605_24_R1_adapter_trimmed.fastq \
			${OUT}/${SEQREP}_R1.fastq.gz
		echo "${SEQREP} has been trimmed"
	elif [ ${SEQREP} == 'T5' ]
	then
		cutadapt \
			--error-rate 0.1 \
			--times 1 \
			--overlap 5 \
			--minimum-length 0 \
			--adapter AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC \
			--front TACACTCTTTCCCTACACGACGCTCTTCCGATCT \
			--quality-base 33 \
			--output ${OUT}/Tms_2604_48_R1_adapter_trimmed.fastq \
			${OUT}/${SEQREP}_R1.fastq.gz
		echo "${SEQREP} has been trimmed"
	elif [ ${SEQREP} == 'T6' ]
	then
		cutadapt \
			--error-rate 0.1 \
			--times 1 \
			--overlap 5 \
			--minimum-length 0 \
			--adapter AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC \
			--front TACACTCTTTCCCTACACGACGCTCTTCCGATCT \
			--quality-base 33 \
			--output ${OUT}/Tml_2605_42_R1_adapter_trimmed.fastq \
			${OUT}/${SEQREP}_R1.fastq.gz
		echo "${SEQREP} has been trimmed"
	fi
done

date
