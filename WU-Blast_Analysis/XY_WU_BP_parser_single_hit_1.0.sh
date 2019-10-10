#!/bin/bash

#SBATCH --job-name=XY_WU_BP_parser_single_hit_1.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=XY_WU_BP_parser_single_hit_1.0_%j.out
#SBATCH --error=XY_WU_BP_parser_single_hit_1.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=100mb
#SBATCH --time=2-00:00:00

date;hostname;pwd

IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/wublast/parser_single_hit

module purge
module load perl/5.24.1

cd ${IN}

perl \
	XY_WU_BP.shan.v3.pl \
	../Tdu_DB_Tpr_query.txt > ./Tdu_DB_Tpr_query_parser_single_hit.txt
	
perl \
	XY_WU_BP.shan.v3.pl \
	../Tpr_DB_Tdu_query.txt > ./Tpr_DB_Tdu_query_parser_single_hit.txt

date
