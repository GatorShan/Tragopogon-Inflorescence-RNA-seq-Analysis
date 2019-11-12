#!/bin/bash

IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Filter_orthologs/Compare_SAM
OUT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Filter_orthologs/Compare_SAM/ase_counts_rename

cp ${IN}/ase_counts_Tdu_2613_11_2_Tdu_Tpr.csv ${OUT}/ase_counts_Tdu_1_2_Tdu_Tpr.csv
cp ${IN}/ase_counts_Tdu_2613_12_2_Tdu_Tpr.csv ${OUT}/ase_counts_Tdu_2_2_Tdu_Tpr.csv
cp ${IN}/ase_counts_Tdu_2613_41_2_Tdu_Tpr.csv ${OUT}/ase_counts_Tdu_3_2_Tdu_Tpr.csv

cp ${IN}/ase_counts_Tdu_2886_3_2_Tdu_Tpr.csv ${OUT}/ase_counts_Tdu_4_2_Tdu_Tpr.csv
cp ${IN}/ase_counts_Tdu_2886_5_2_Tdu_Tpr.csv ${OUT}/ase_counts_Tdu_5_2_Tdu_Tpr.csv
cp ${IN}/ase_counts_Tdu_2886_7_2_Tdu_Tpr.csv ${OUT}/ase_counts_Tdu_6_2_Tdu_Tpr.csv

cp ${IN}/ase_counts_Tpr_2608_3_2_Tdu_Tpr.csv ${OUT}/ase_counts_Tpr_1_2_Tdu_Tpr.csv
cp ${IN}/ase_counts_Tpr_2608_21_2_Tdu_Tpr.csv ${OUT}/ase_counts_Tpr_2_2_Tdu_Tpr.csv
cp ${IN}/ase_counts_Tpr_2608_31_2_Tdu_Tpr.csv ${OUT}/ase_counts_Tpr_3_2_Tdu_Tpr.csv