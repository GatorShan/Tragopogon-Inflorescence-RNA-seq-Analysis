#!/bin/bash

module load sas/9.4

PROJ=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/sas_data_poly
LOGS=${PROJ}/sas_programs/logs
OUTPUT=${PROJ}/sas_programs/output
TMPDIR=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/sas_data_poly/sas_temp

## fix bed file coordinates
sas -log ${LOGS}/bayesian_make_sbys_reps_hybrid.log \
    -print ${OUTPUT}/bayesian_make_sbys_reps_hybrid.prt \
    -work ${TMPDIR} \
    -sysin ${PROJ}/sas_programs/bayesian_make_sbys_reps_hybrid.sas
