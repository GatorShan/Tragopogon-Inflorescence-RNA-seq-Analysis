
module load sas/9.4

PROJ=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/sas_data_poly
LOGS=${PROJ}/sas_programs/logs
OUTPUT=${PROJ}/sas_programs/output
TMPDIR=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/sas_data_poly/sas_temp

## fix bed file coordinates
sas -log ${LOGS}/import_ase_counts_hybrid.log \
    -print ${OUTPUT}/import_ase_counts_hybrid.prt \
    -work ${TMPDIR} \
    -sysin ${PROJ}/sas_programs/import_ase_counts_hybrid.sas

