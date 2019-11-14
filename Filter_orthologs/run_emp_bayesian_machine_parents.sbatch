#!/bin/bash

#SBATCH --job-name=emp_bayes_machine_V1
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=emp_bayes_machine_V1_%A_%a.out
#SBATCH --error=emp_bayes_machine_V1_%A_%a.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=600mb
#SBATCH --time=1-00:00:00
#SBATCH --qos=soltis-b
#SBATCH --array=1-500%10

date;hostname;pwd

module purge
module load gcc/5.2.0
module load R/3.2.2

# Set Directories
    PROJ=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Filter_orthologs
    RPROG1=/ufrc/soltis/shan158538/TragFL_NewAnalysis/SLURM/PG_model_empirical_q456_3reps.r
    RPROG2=/ufrc/soltis/shan158538/TragFL_NewAnalysis/SLURM/PG_model_empirical_q456_6reps.r

## only have Cast
## tdu has 6 replications; tpr has 3 replications

for i in tdu tpr ;
do
    OUTDIR=${PROJ}/empirical_bayesian_parents_output/split_${i}_ur
    LOGS=${OUTDIR}/logs

# Set Files
    INPUT=${PROJ}/empirical_bayesian_parents_input/output/split_${i}_ur/split_${SLURM_ARRAY_TASK_ID}.csv
    OUTPUT=${OUTDIR}/split_${SLURM_ARRAY_TASK_ID}.csv
    MYLOG=${LOGS}/split_${SLURM_ARRAY_TASK_ID}.log

    echo "Running $INPUT ['date']" > $MYLOG
    
    if [ ${i} == tdu ]
    then
    	Rscript $RPROG2 $INPUT $OUTPUT &>> $MYLOG
    else
    	Rscript $RPROG1 $INPUT $OUTPUT &>> $MYLOG
    fi
done

date