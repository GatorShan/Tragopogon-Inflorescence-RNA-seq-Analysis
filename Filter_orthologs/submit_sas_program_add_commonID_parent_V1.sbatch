#!/bin/bash

#SBATCH --job-name=submit_sas_program_add_commonID_parent_V1
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=submit_sas_program_add_commonID_parent_V1_%j.out
#SBATCH --error=submit_sas_program_add_commonID_parent_V1_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5gb
#SBATCH --time=2-00:00:00
#SBATCH --qos=soltis

date;hostname;pwd

module load sas/9.4

PROJ=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/sas_data
LOGS=${PROJ}/sas_programs/logs
OUTPUT=${PROJ}/sas_programs/output
TMPDIR=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/sas_data/sas_temp


## add commonID to parent sam files
sas -log ${LOGS}/add_commonID_to_parent_sam_files_HPC.V1.log \
	-print ${OUTPUT}/add_commonID_to_parent_sam_files_HPC.V1.prt \
	-work $TMPDIR \
	-sysin ${PROJ}/sas_programs/add_commonID_to_parent_sam_files_HPC.V1.sas

date