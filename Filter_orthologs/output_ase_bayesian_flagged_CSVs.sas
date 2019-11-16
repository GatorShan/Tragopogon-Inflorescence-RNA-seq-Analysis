
libname trago "/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/sas_data";

/* 
output ASE results
*/


/* All parents */
proc export data = trago.bayes_flag_sig_tdu_for_tdu_tpr
outfile='/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Filter_orthologs/empirical_bayesian_parents_output/bayes_flag_sig_TDU_for_UR.csv'
dbms=csv replace ;
run;

proc export data = trago.bayes_flag_sig_tpr_for_tdu_tpr
outfile='/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Filter_orthologs/empirical_bayesian_parents_output/bayes_flag_sig_TPR_for_UR.csv'
dbms=csv replace ;
run;
