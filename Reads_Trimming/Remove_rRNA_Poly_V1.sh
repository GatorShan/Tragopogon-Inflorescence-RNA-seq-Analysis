#!/bin/bash

#SBATCH --job-name=Remove_rRNA_Poly_V1
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=Remove_rRNA_Poly_V1_%j.out
#SBATCH --error=Remove_rRNA_Poly_V1_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=4gb
#SBATCH --time=10:00:00

date;hostname;pwd

DB=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/rRNA_Filter
OUT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/rRNA_Filter/Crop_clean
IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/TrimmomaticCrop

module purge
module load sortmerna/2.1

#indexdb_rna --ref Tdu_18S-26S_rRNA.fasta,Tdu_18S-26S_rRNA -v

ARRAY=("Tms_2604_24" "Tms_2604_43" "Tms_2604_48" "Tml_2605_9" "Tml_2605_24" "Tml_2605_42")

for STEM in "${ARRAY[@]}"; do

#for file in ${IN}/*_R1_trimmomatic-Uncrop_paired.fastq; do
#	STEM=$(basename ${file} _R1_trimmomatic-Uncrop_paired.fastq)
	
	merge-paired-reads.sh ${IN}/${STEM}_R1_trimmomatic-crop_paired.fastq ${IN}/${STEM}_R2_trimmomatic-crop_paired.fastq \
				${OUT}/${STEM}_crop_cat.fastq

	echo "${STEM}_R1_trimmomatic-crop_paired.fastq and ${STEM}_R2_trimmomatic-crop_paired.fastq have been mergered into ${STEM}_crop_cat.fastq"

	sortmerna --ref ${DB}/Tdu_18S-26S_rRNA.fasta,${DB}/Tdu_18S-26S_rRNA \
		--reads ${OUT}/${STEM}_crop_cat.fastq \
		--aligned ${OUT}/${STEM}_crop_rRNA_reads \
		--other ${OUT}/${STEM}_crop_clean_reads \
		--fastx \
		--paired_in \
		--log \
		--blast '1' \
		-a 4 \
		-m 4096 \
		-v

	echo "${STEM}_crop_cat.fastq has been filtered; filtered output is ${STEM}_crop_clean_reads.fastq"

	unmerge-paired-reads.sh ${OUT}/${STEM}_crop_clean_reads.fastq \
				${OUT}/${STEM}_R1_crop_clean.fastq ${OUT}/${STEM}_R2_crop_clean.fastq

	echo "${STEM}_crop_clean_reads.fastq has been splited into ${STEM}_R1_crop_clean.fastq and ${STEM}_R2_crop_clean.fastq"
done

#mkdir ${OUT}/LogFile
mv ${OUT}/*.log ${OUT}/LogFile

#mkdir ${OUT}/BlastResults
mv ${OUT}/*.blast ${OUT}/BlastResults

#mkdir ${OUT}/rRNA_reads
mv ${OUT}/*_rRNA_reads.fastq ${OUT}/rRNA_reads

#mkdir ${OUT}/CatFiles
mv ${OUT}/*_cat.fastq ${OUT}/CatFiles
mv ${OUT}/*clean_reads.fastq ${OUT}/CatFiles

date