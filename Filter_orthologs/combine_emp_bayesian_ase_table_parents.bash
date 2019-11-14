#!/bin/bash - 
#===============================================================================
# 
#   DESCRIPTION: Combine the split files from the ASE table 
# 
#===============================================================================

# Load python

module purge
module load gcc/5.2.0
module load python/2.7.10

# Set Variables
PROJ=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Filter_orthologs
PYGIT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/SLURM


for i in tdu tpr ;
do

    INPUT=${PROJ}/empirical_bayesian_parents_output/split_${i}_ur

    OUTDIR=${PROJ}/empirical_bayesian_parents_output

    # combine table
    python ${PYGIT}/catTable.py -f ${INPUT}/split_*.csv --odir ${OUTDIR} --oname PG_emp_bayesian_results_${i}_parents_UR.csv --header

done
