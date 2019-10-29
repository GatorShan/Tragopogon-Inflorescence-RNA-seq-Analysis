#!/bin/bash

#SBATCH --job-name=BUSCO_Tpr_crop_trinity_separatly_norm_1.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=BUSCO_Tpr_crop_trinity_separatly_norm_1.0_%j.out
#SBATCH --error=BUSCO_Tpr_crop_trinity_separatly_norm_1.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=1gb
#SBATCH --time=1-00:00:00
##SBATCH --qos=soltis-b

date;hostname;pwd

cd /ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/AssemblyAssessment/BUSCO

IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Trinity/Tpr_trinity_crop_separately_norm_1
LINEAGE=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/AssemblyAssessment/BUSCO

module purge
module load gcc/5.2.0
module load busco/3.02

export BUSCO_CONFIG_FILE=/home/shan158538/busco/config.ini

run_BUSCO.py \
	-i ${IN}/Tpr_trinity_crop_separately_norm_1.Trinity.fasta \
	-o Tpr_crop_trinity_separately_norm \
	-l ${LINEAGE}/embryophyta_odb10 \
	-m tran \
	-c 4 \
	-sp Lactuca_sativa

date
