#!/bin/bash

#SBATCH --job-name=blastn_mito-interaction_Tdu_4957.V2
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=blastn_mito-interaction_Tdu_4957.V2_%j.out
#SBATCH --error=blastn_mito-interaction_Tdu_4957.V2_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1gb
#SBATCH --time=05:00:00
#SBATCH --qos=soltis-b

date;hostname;pwd

IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Annotation/CyMira_annotation

module purge
module load ncbi_blast/2.8.1

cd ${IN}

#makeblastdb \
#	-in SuperTranscript_Tdu_4957.fasta \
#	-dbtype nucl \
#	-parse_seqids

#echo "The blast database has been created"

blastn \
	-db SuperTranscript_Tdu_4957.fasta \
	-query Mito_interaction.fasta \
	-outfmt 6 \
	-evalue 1e-10 \
	-perc_identity 85 \
	-qcov_hsp_perc 30 \
	-out blastn_Mito-interaction_TduSuperTranscripts_E10_I85_P30.txt

echo "blastn analysis is done"

date
