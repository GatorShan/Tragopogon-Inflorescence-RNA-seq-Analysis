#!/bin/bash

#SBATCH --job-name=blastn_DE_Tms_Tml_single_copy_gene.V1
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=blastn_DE_Tms_Tml_single_copy_gene.V1_%j.out
#SBATCH --error=blastn_DE_Tms_Tml_single_copy_gene.V1_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=200mb
#SBATCH --time=01:00:00
#SBATCH --qos=soltis-b

date;hostname;pwd

IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/DE_analysis/DE_Tms_Tml/DESeq2_DE_Tms_Tml_single_copy_gene

module purge
module load ncbi_blast/2.8.1

cd ${IN}

makeblastdb \
	-in 959_single_copy_gene_At.fasta \
	-dbtype nucl \
	-parse_seqids

echo "The blast database has been created"

blastn \
	-db 959_single_copy_gene_At.fasta \
	-query DESeq2_Tms_Tml.fasta \
	-outfmt 6 \
	-evalue 1e-10 \
	-perc_identity 85 \
	-out blastn_DE_Tms_Tml_single_copy_gene_E10_I85.txt

echo "blastn analysis is done"

date
