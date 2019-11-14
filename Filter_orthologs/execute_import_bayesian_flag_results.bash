#!/bin/bash

module load sas/9.4

PROJ=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/sas_data
LOGS=${PROJ}/sas_programs/logs
OUTPUT=${PROJ}/sas_programs/output
TMPDIR=${PROJ}/sas_temp

## fix bed file coordinates
sas -log ${LOGS}/import_bayesian_results.log \
    -print ${OUTPUT}/import_bayesian_results.prt \
    -work ${TMPDIR} \
    -sysin ${PROJ}/sas_programs/import_bayesian_results.sas

