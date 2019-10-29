#!/bin/bash

#SBATCH --job-name=AbundanceEstimation_Tdu_trinity_norm_concat_denovo_1.0
#SBATCH --mail-user=shan158538@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --output=AbundanceEstimation_Tdu_trinity_norm_concat_denovo_1.0_%j.out
#SBATCH --error=AbundanceEstimation_Tdu_trinity_norm_concat_denovo_1.0_%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5gb
#SBATCH --time=03:00:00
##SBATCH --qos=soltis-b

date;hostname;pwd

IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Trinity/Tdu_trinity_norm_concat_denovo
READ=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/rRNA_Filter/Crop_clean
OUT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/AssemblyAssessment/AbundanceEstimation/Tdu_trinity_norm_concat_denovo

module purge
module load gcc/5.2.0
module load trinity/r20180213-2.6.5
module load kallisto/0.44.0

# prep the reference and run the abundance estimation
# kallisto was used

cd ${READ}

$TRINITY_HOME/util/align_and_estimate_abundance.pl \
	--transcripts ${IN}/Tdu_trinity_norm_concat_denovo.Trinity.fasta \
	--seqType fq \
	--samples_file AbundanceEstimation_Tdu.txt \
	--est_method kallisto \
	--output_dir ${OUT} \
	--thread_count 1 \
	--gene_trans_map ${IN}/Tdu_trinity_norm_concat_denovo.Trinity.fasta.gene_trans_map \
	--prep_reference
echo "abundance estimation has finished"

# move the output files to the ${OUT} directory
mv POP2613_* POP2886_* ${OUT}
echo "files have been transferred to ${OUT}"

# build transcripts and gene expression matrices
cd ${OUT}

$TRINITY_HOME/util/abundance_estimates_to_matrix.pl \
	--est_method kallisto \
	--gene_trans_map 'none' \
	--name_sample_by_basedir \
	${OUT}/POP2613_REP11/abundance.tsv \
	${OUT}/POP2613_REP12/abundance.tsv \
	${OUT}/POP2613_REP41/abundance.tsv \
	${OUT}/POP2886_REP3/abundance.tsv \
	${OUT}/POP2886_REP5/abundance.tsv \
	${OUT}/POP2886_REP7/abundance.tsv
echo "the matrix has been generated"

# generate ExN50 statistics
$TRINITY_HOME/util/misc/contig_ExN50_statistic.pl \
	kallisto.isoform.TMM.EXPR.matrix \
	${IN}/Tdu_trinity_norm_concat_denovo.Trinity.fasta | tee ExN50.stats
echo "ExN50 has been calculated"

# plotting the Ex value (first column) against the ExN50 value
${TRINITY_HOME}/util/misc/plot_ExN50_statistic.Rscript \
	ExN50.stats \
	xpdf ExN50.stats.plot.pdf
echo "ExN50 values have been plotted"

date
