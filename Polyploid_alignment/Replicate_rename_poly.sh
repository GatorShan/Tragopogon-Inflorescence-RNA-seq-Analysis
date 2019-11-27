#!/bin/bash

IN=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Polyploid_alignment/Compare_SAM
OUT=/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Polyploid_alignment/Compare_SAM/ase_counts_rename

cp ${IN}/ase_counts_Tms_2604_24_2_tdu_tpr.csv ${OUT}/ase_counts_Tms_1_2_tdu_tpr.csv
cp ${IN}/ase_counts_Tms_2604_43_2_tdu_tpr.csv ${OUT}/ase_counts_Tms_2_2_tdu_tpr.csv
cp ${IN}/ase_counts_Tms_2604_48_2_tdu_tpr.csv ${OUT}/ase_counts_Tms_3_2_tdu_tpr.csv

cp ${IN}/ase_counts_Tml_2605_9_2_tdu_tpr.csv ${OUT}/ase_counts_Tml_1_2_tdu_tpr.csv
cp ${IN}/ase_counts_Tml_2605_24_2_tdu_tpr.csv ${OUT}/ase_counts_Tml_2_2_tdu_tpr.csv
cp ${IN}/ase_counts_Tml_2605_42_2_tdu_tpr.csv ${OUT}/ase_counts_Tml_3_2_tdu_tpr.csv
