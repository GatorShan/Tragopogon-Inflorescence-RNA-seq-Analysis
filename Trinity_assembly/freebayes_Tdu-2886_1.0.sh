#!/bin/bash

#SBATCH --job-name=freebayes_Tdu-2886_1.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=freebayes_Tdu-2886_1.0_%j.out
#SBATCH --error=freebayes_Tdu-2886_1.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=15gb
#SBATCH --time=2-00:00:00
##SBATCH --qos=soltis-b

date;hostname;pwd

IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/HISAT2/Mapping_Tdu_2886_crop/Tdu_2886_crop.markdup.bam
REF=/orange/soltis/Tdub_Genome_V1/Tdub.V1.fasta
OUT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/freebayes/Tdu_2886_var.vcf

module purge
module load freebayes/1.2.0-20180409

freebayes \
	-f ${REF} \
	${IN} \
	> ${OUT}

date
