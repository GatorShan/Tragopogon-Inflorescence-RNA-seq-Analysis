#!/bin/bash

#SBATCH --job-name=wublast_Tpr_db_Tdu_query_1.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=wublast_Tpr_db_Tdu_query_1.0_%j.out
#SBATCH --error=wublast_Tpr_db_Tdu_query_1.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem=1gb
#SBATCH --time=2-00:00:00

date;hostname;pwd

IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/wublast

module purge
module load wublast/2.0

cd ${IN}

xdformat \
	-n \
	-o Tpr_SuperTranscript_DB \
	SuperTranscript_Tpr.fasta

blastn \
	Tpr_SuperTranscript_DB \
	SuperTranscript_Tdu.fasta \
	O=Tpr_DB_Tdu_query.txt

date
