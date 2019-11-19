#!/bin/bash

#SBATCH --job-name=Bowtie2_two_polyploids_reads_parents_ST_V1.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=Bowtie2_two_polyploids_reads_parents_ST_V1.0_%j.out
#SBATCH --error=Bowtie2_two_polyploids_reads_parents_ST_V1.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=2gb
#SBATCH --time=2-00:00:00

date;hostname;pwd

REF=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/SuperTranscript
READ=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/rRNA_Filter/Crop_clean
OUT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Polyploid_alignment

module purge
module load bowtie2/2.3.5.1

#bowtie2-build \
#	${REF}/SuperTranscript_Tdu_FullName.fasta \
#	${REF}/SuperTranscript_Tdu_FullName

#echo "The supertranscript reference has been indexed"

for PARENT in Tdu Tpr; do
	echo "${PARENT} is used as reference"
	for POP in Tms_2604 Tml_2605; do
		if [ ${POP} == Tms_2604 ]; then
			echo -e "\tPopulation ${POP} is being process"
			for REP in 24 43 48; do
				bowtie2 \
					-p 10 \
					-q \
					--no-unal \
					-x ${REF}/SuperTranscript_${PARENT}_FullName \
					-1 ${READ}/${POP}_${REP}_R1_crop_clean.fastq \
					-2 ${READ}/${POP}_${REP}_R2_crop_clean.fastq \
					-S ${OUT}/${POP}_${REP}_reads_${PARENT}_ST_V1.sam
				echo -e "\t\tReplicate ${REP} has been mapped to reference ${PARENT}"
			done
		fi
		# processing a different population 		
		if [ ${POP} == Tml_2605 ]; then
			echo -e "\tPopulation ${POP} is being process"
			for REP in 9 24 42; do
				bowtie2 \
					-p 10 \
					-q \
					--no-unal \
					-x ${REF}/SuperTranscript_${PARENT}_FullName \
					-1 ${READ}/${POP}_${REP}_R1_crop_clean.fastq \
					-2 ${READ}/${POP}_${REP}_R2_crop_clean.fastq \
					-S ${OUT}/${POP}_${REP}_reads_${PARENT}_ST_V1.sam
				echo -e "\t\tReplicate ${REP} has been mapped to reference ${PARENT}"
			done
		fi
	done
done

date
