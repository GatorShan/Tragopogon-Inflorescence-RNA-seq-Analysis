#!/bin/bash

#SBATCH --job-name=emp_bayes_machine_hybrids
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=emp_bayes_machine_hybrids_%A_%a.out
#SBATCH --error=emp_bayes_machine_hybrids_%A_%a.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=600mb
#SBATCH --time=1-00:00:00
#SBATCH --qos=soltis
#SBATCH --array=1-500%10

date;hostname;pwd

module purge
module load gcc/5.2.0
module load R/3.2.2

# Set Directories
    PROJ=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Polyploid_alignment
    RPROG=/ufrc/soltis/shan158538/TragFL_NewAnalysis/SLURM/PG_model_empirical_q456_3reps.r

for i in Tms_tdu_tpr Tml_tdu_tpr ;
do
    OUTDIR=$PROJ/empirical_bayesian_hybrids_output/split_${i}
    LOGS=$OUTDIR/logs

# Set Files
    INPUT=$PROJ/empirical_bayesian_hybrids_input/output/split_${i}/split_${SLURM_ARRAY_TASK_ID}.csv
    OUTPUT=$OUTDIR/split_${SLURM_ARRAY_TASK_ID}.csv
    MYLOG=$LOGS/split_${SLURM_ARRAY_TASK_ID}.log

    echo "Running $INPUT ['date']" > $MYLOG
    Rscript $RPROG $INPUT $OUTPUT &>> $MYLOG
done

date