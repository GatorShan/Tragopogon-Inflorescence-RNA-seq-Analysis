#!/bin/bash

#SBATCH --job-name=submit_add_commonID_hybrid_newASE
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=submit_add_commonID_hybrid_newASE_%j.out
#SBATCH --error=submit_add_commonID_hybrid_newASE_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5gb
#SBATCH --time=2-00:00:00
#SBATCH --qos=soltis-b

date;hostname;pwd

module load sas/9.4

PROJ=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/sas_data_poly_newASE
LOGS=${PROJ}/sas_programs/logs
OUTPUT=${PROJ}/sas_programs/output
TMPDIR=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/sas_data_poly_newASE/sas_temp

## add commonID to polyploid sam files
sas -log ${LOGS}/add_commonID_to_hybrid_sam_files_HPC_newASE.log \
    -print ${OUTPUT}/add_commonID_to_hybrid_sam_files_HPC_newASE.prt \
    -work ${TMPDIR} \
    -sysin ${PROJ}/sas_programs/add_commonID_to_hybrid_sam_files_HPC_newASE.sas

date