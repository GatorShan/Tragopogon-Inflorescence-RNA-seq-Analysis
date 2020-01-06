#!/bin/bash

#SBATCH --job-name=Remove_rRNA.2.1
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=Remove_rRNA.2.1_%j.out
#SBATCH --error=Remove_rRNA.2.1_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=4gb
#SBATCH --time=10:00:00

date;hostname;pwd

DB=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/rRNA_Filter
OUT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/rRNA_Filter/Uncrop_clean
IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/TrimmomaticUnCrop

module load sortmerna/2.1

#indexdb_rna --ref Tdu_18S-26S_rRNA.fasta,Tdu_18S-26S_rRNA -v

for file in ${IN}/*_R1_trimmomatic-Uncrop_paired.fastq; do
	STEM=$(basename ${file} _R1_trimmomatic-Uncrop_paired.fastq)
	
	merge-paired-reads.sh ${IN}/${STEM}_R1_trimmomatic-Uncrop_paired.fastq ${IN}/${STEM}_R2_trimmomatic-Uncrop_paired.fastq \
				${OUT}/${STEM}_Uncrop_cat.fastq

	echo "${STEM}_R1_trimmomatic-Uncrop_paired.fastq and ${STEM}_R2_trimmomatic-Uncrop_paired.fastq have been mergered into ${STEM}_Uncrop_cat.fastq"

	sortmerna --ref ${DB}/Tdu_18S-26S_rRNA.fasta,${DB}/Tdu_18S-26S_rRNA \
		--reads ${OUT}/${STEM}_Uncrop_cat.fastq \
		--aligned ${OUT}/${STEM}_Uncrop_rRNA_reads \
		--other ${OUT}/${STEM}_Uncrop_clean_reads \
		--fastx \
		--paired_in \
		--log \
		--blast '1' \
		-a 4 \
		-m 4096 \
		-v

	echo "${STEM}_Uncrop_cat.fastq has been filtered; filtered output is ${STEM}_Uncrop_clean_reads.fastq"

	unmerge-paired-reads.sh ${OUT}/${STEM}_Uncrop_clean_reads.fastq \
				${OUT}/${STEM}_R1_Uncrop_clean.fastq ${OUT}/${STEM}_R2_Uncrop_clean.fastq

	echo "${STEM}_Uncrop_clean_reads.fastq has been splited into ${STEM}_R1_Uncrop_clean.fastq and ${STEM}_R2_Uncrop_clean.fastq"
done

mkdir ${OUT}/LogFile
mv ${OUT}/*.log ${OUT}/LogFile

mkdir ${OUT}/BlastResults
mv ${OUT}/*.blast ${OUT}/BlastResults

mkdir ${OUT}/rRNA_reads
mv ${OUT}/*_rRNA_reads.fastq ${OUT}/rRNA_reads

mkdir ${OUT}/CatFiles
mv ${OUT}/*_cat.fastq ${OUT}/CatFiles

date
