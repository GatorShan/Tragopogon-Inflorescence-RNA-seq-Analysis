#!/bin/bash

module load sas/9.4

PROJ=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/sas_data
LOGS=${PROJ}/sas_programs/logs
OUTPUT=${PROJ}/sas_programs/output
TMPDIR=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/sas_data/sas_temp

# :<<'END'
## fix bed file coordinates
sas -log ${LOGS}/import_bed_fix_coord_for_sam_compare_HPC.log \
    -print ${OUTPUT}/import_bed_fix_coord_for_sam_compare_HPC.prt \
    -work $TMPDIR \
    -sysin ${PROJ}/sas_programs/import_bed_fix_coord_for_sam_compare_HPC.sas

## add commonID to hybrid sam files
#sas -log ${LOGS}/add_commonID_to_sam_files_HPC.log \
#    -print ${OUTPUT}/add_commonID_to_sam_files_HPC.prt \
#    -work $TMPDIR \
#    -sysin ${PROJ}/sas_programs/add_commonID_to_sam_files_HPC.sas

