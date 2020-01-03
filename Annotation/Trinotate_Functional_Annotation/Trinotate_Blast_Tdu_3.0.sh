#!/bin/bash

#SBATCH --job-name=Trinotate_Blast_Tdu_3.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=Trinotate_Blast_Tdu_3.0_%j.out
#SBATCH --error=Trinotate_Blast_Tdu_3.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=2gb
#SBATCH --time=5-00:00:00

date;hostname;pwd

IN1=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/SuperTranscript
IN2=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Annotation/TransDecoder
DB=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Annotation/Database
OUT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Annotation/Blast

# use the latest version of blast
module purge
module load ncbi_blast/2.9.0

cd ${DB}

#makeblastdb \
#	-in uniprot_sprot.pep \
#	-dbtype prot \
#	-parse_seqids

blastx \
	-query ${IN1}/SuperTranscript_Tdu.fasta \
	-db ${DB}/uniprot_sprot.pep \
	-num_threads 16 \
	-max_target_seqs 1 \
	-outfmt 6 \
	-evalue 1e-3 \
	> ${OUT}/Tdu_blastx.outfmt6

echo "Search Trinity transcripts"

blastp \
	-query ${IN2}/SuperTranscript_Tdu.fasta.transdecoder.pep \
	-db ${DB}/uniprot_sprot.pep \
	-num_threads 16 \
	-max_target_seqs 1 \
	-outfmt 6 \
	-evalue 1e-3 \
	> ${OUT}/Tdu_blastp.outfmt6

echo "Search Transdecoder-predicted proteins"

date
