#!/bin/bash

#SBATCH --job-name=wublast_Tdu_db_Tpr_query_1.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=wublast_Tdu_db_Tpr_query_1.0_%j.out
#SBATCH --error=wublast_Tdu_db_Tpr_query_1.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem=4gb
#SBATCH --time=2-00:00:00

date;hostname;pwd

IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/wublast

module purge
module load wublast/2.0

xdformat \
	-n \
	-o Tdu_SuperTranscript_DB \
	SuperTranscript_Tdu.fasta

blastn \
	${IN}/Tdu_SuperTranscript_DB \
	${IN}/SuperTranscript_Tpr.fasta \
	O=${IN}/Tdu_DB_Tpr_query.txt

date
