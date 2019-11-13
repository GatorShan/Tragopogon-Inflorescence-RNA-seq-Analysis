#!/bin/bash

module load sas/9.4

PROJ=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/sas_data
LOGS=${PROJ}/sas_programs/logs
OUTPUT=${PROJ}/sas_programs/output
TMPDIR=${PROJ}/sas_temp

cd $SLURM_SUBMIT_DIR

## fix bed file coordinates
sas -log ${LOGS}/bayesian_export_flagged_dataset_parents.log \
    -print ${OUTPUT}/bayesian_export_flagged_dataset_parents.prt \
    -work ${TMPDIR} \
    -sysin ${PROJ}/sas_programs/bayesian_export_flagged_dataset_parents.V1.sas

