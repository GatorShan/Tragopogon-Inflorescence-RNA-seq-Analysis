#!/bin/bash

#SBATCH --job-name=AbundanceEstimation_Tpr_trinity_denovo_2.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=AbundanceEstimation_Tpr_trinity_denovo_2.0_%j.out
#SBATCH --error=AbundanceEstimation_Tpr_trinity_denovo_2.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=5gb
#SBATCH --time=02:00:00
##SBATCH --qos=soltis-b

date;hostname;pwd

IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Trinity/Tpr_trinity_crop_separately_norm_1
READ=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/rRNA_Filter/Crop_clean
OUT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/AssemblyAssessment/AbundanceEstimation/Tpr_trinity_denovo

#cd ${READ}

module purge
module load gcc/5.2.0
module load trinity/r20180213-2.6.5
module load kallisto/0.44.0

# prep the reference and run the abundance estimation
# kallisto was used
#$TRINITY_HOME/util/align_and_estimate_abundance.pl \
#	--transcripts ${IN}/Tpr_trinity_crop_separately_norm_1.Trinity.fasta \
#	--seqType fq \
#	--samples_file AbundanceEstimation_Tpr.txt \
#	--est_method kallisto \
#	--output_dir ${OUT} \
#	--thread_count 4 \
#	--gene_trans_map ${IN}/Tpr_trinity_crop_separately_norm_1.Trinity.fasta.gene_trans_map \
#	--prep_reference

# move the output files to the $OUT directory
# mv REP3 REP21 REP31 ${OUT}

# build transcripts and gene expression matrices

cd ${OUT}

$TRINITY_HOME/util/abundance_estimates_to_matrix.pl \
	--est_method kallisto \
	--gene_trans_map 'none' \
	--name_sample_by_basedir \
	${OUT}/REP3/abundance.tsv \
	${OUT}/REP21/abundance.tsv \
	${OUT}/REP31/abundance.tsv

date
