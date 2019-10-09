#!/bin/bash

#SBATCH --job-name=OrthoFinder_1.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=OrthoFinder_1.0_%j.out
#SBATCH --error=OrthoFinder_1.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=5gb
#SBATCH --time=3-00:00:00
#SBATCH --qos=soltis-b

date;hostname;pwd

IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/OrthoFinder

module purge
module load orthofinder/2.3.3

cd ${IN}

orthofinder \
	-f ./fasta_files \
	-t 10 \
	-S blast

date
