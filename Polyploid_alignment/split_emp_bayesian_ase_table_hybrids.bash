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
PROJ=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Polyploid_alignment
PYGIT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/SLURM

for i in Tms_tdu_tpr Tml_tdu_tpr;
do
 
    INPUT=${PROJ}/empirical_bayesian_hybrids_input/ase_bayes_${i}_flag.csv
    OUTDIR=${PROJ}/empirical_bayesian_hybrids_input/output/split_${i}

    # Split table
    python ${PYGIT}/splitTable.py -f $INPUT -o $OUTDIR --prefix split --header --nfiles 500
done

