#!/bin/bash

#SBATCH --job-name=blastn_TduCYC_TduSupertranscripts.V1
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=blastn_TduCYC_TduSupertranscripts.V1_%j.out
#SBATCH --error=blastn_TduCYC_TduSupertranscripts.V1_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1gb
#SBATCH --time=05:00:00

date;hostname;pwd

IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/CYC2_TB1

module purge
module load ncbi_blast/2.8.1

cd ${IN}

makeblastdb \
	-in SuperTranscript_Tdu_11863.fasta \
	-dbtype nucl \
	-parse_seqids

echo "The blast database has been created"

blastn \
	-db SuperTranscript_Tdu_11863.fasta \
	-query TduCYC.fasta \
	-outfmt 6 \
	-evalue 1e-10 \
	-perc_identity 85 \
	-qcov_hsp_perc 50 \
	-out blastn_TduCYC_TduSuperTranscripts_E10_I85_P50.txt

echo "blastn analysis is done"

date
