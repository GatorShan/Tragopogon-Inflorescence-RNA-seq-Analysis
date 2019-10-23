#!/bin/bash

#SBATCH --job-name=HISAT2_indexing_Tdu_ref_1.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=HISAT2_indexing_Tdu_ref_1.0_%j.out
#SBATCH --error=HISAT2_indexing_Tdu_ref_1.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2gb
#SBATCH --time=05:00:00
#SBATCH --qos=soltis-b

date;hostname;pwd

cd /ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/HISAT2/Ref_index

REF=/orange/soltis/Tdub_Genome_V1

module purge
module load gcc/5.2.0
module load hisat2/2.1.0

hisat2-build \
	-f \
	${REF}/Tdub.V1.fasta \
	Tdu_ref_v1
	
date
