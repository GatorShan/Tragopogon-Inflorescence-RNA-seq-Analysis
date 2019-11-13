#!/bin/bash - 
#===============================================================================
# 
#   DESCRIPTION: Split the ASE table into chunks of rows for faster processing
#   in the Bayesian machine.
# 
#===============================================================================

# Load python
module load python/2.7.6

# Set Variables
PROJ=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Filter_orthologs
PYGIT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/SLURM

for i in tdu tpr;
do

    INPUT=${PROJ}/empirical_bayesian_parents_input/ase_bayes_${i}_tdu_tpr_flag.csv
    OUTDIR=${PROJ}/empirical_bayesian_parents_input/output/split_${i}_ur

    # Split table
    python ${PYGIT}/splitTable.py -f $INPUT -o $OUTDIR --prefix split --header --nfiles 500
done
