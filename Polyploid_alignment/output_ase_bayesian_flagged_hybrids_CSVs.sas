
libname trago "/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/sas_data_poly";

/* 
output ASE results
*/


/* Hybrids */
proc export data = trago.bayes_flag_sig_Tms_tdu_tpr
outfile='/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Polyploid_alignment/empirical_bayesian_hybrids_output/bayes_flag_sig_Tms_for_UR.csv'
dbms=csv replace ;
run;

proc export data = trago.bayes_flag_sig_Tml_tdu_tpr
outfile='/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Polyploid_alignment/empirical_bayesian_hybrids_output/bayes_flag_sig_Tml_for_UR.csv'
dbms=csv replace ;
run;
