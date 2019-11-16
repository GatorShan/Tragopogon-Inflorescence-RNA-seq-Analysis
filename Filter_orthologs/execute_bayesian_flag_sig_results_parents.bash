#!/bin/bash

module load sas/9.4

PROJ=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/sas_data
LOGS=${PROJ}/sas_programs/logs
OUTPUT=${PROJ}/sas_programs/output
TMPDIR=${PROJ}/sas_temp

## fix bed file coordinates
sas -log ${LOGS}/bayesian_flag_sig_parents.log \
    -print ${OUTPUT}/bayesian_flag_sig_parents.prt \
    -work ${TMPDIR} \
    -sysin ${PROJ}/sas_programs/bayesian_flag_sig_results_parents_pdf.sas
