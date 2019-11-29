#!/bin/bash - 
#===============================================================================
# 
#   DESCRIPTION: Combine the split files from the ASE table 
# 
#===============================================================================

# Load python
module load python/2.7.6

# Set Variables
PROJ=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Polyploid_alignment
PYGIT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/SLURM

for i in Tms_tdu_tpr Tml_tdu_tpr ;
do

    INPUT=$PROJ/empirical_bayesian_hybrids_output/split_${i}

    OUTDIR=$PROJ/empirical_bayesian_hybrids_output

    # combine table
    python $PYGIT/catTable.py -f $INPUT/split_*.csv --odir $OUTDIR --oname PG_emp_bayesian_results_${i}_hybrid.csv --header

done

