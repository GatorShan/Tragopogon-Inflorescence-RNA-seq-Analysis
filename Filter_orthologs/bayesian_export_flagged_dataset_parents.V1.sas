libname trago '/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/sas_data';

/* 
merge with flag 
export for bayesian
*/
/* proc contents data = trago.ase_bayesian_Tm_sbys_with_flag;run ; */

%macro add_flag (reads, alt) ;

proc sort data = trago.Bayes_flag_&reads._reads_tdu_&alt. ;
by commonID ;
proc sort data = trago.Ase_bayes_&reads._rds_tdu_&alt._sbys ;
by commonID ;
run;

data ase_bayes_&reads._tdu_&alt._flg;
merge trago.Ase_bayes_&reads._rds_tdu_&alt._sbys (in=in1) trago.Bayes_flag_&reads._reads_tdu_&alt. (in=in2);
by commonID ;
if in1;
run ;


%mend ;

%add_flag (tdu, tpr);
%add_flag (tpr, tpr);


data trago.ase_bayes_tdu_tdu_tpr_flag ;
set ase_bayes_tdu_tdu_tpr_flg;
rename
 tdu_count_rep1 = LINE_TOTAL_1
 tdu_count_rep2 = LINE_TOTAL_2
 tdu_count_rep3 = LINE_TOTAL_3
 tdu_count_rep4 = LINE_TOTAL_4
 tdu_count_rep5 = LINE_TOTAL_5
 tdu_count_rep6 = LINE_TOTAL_6
 tpr_count_rep1 = TESTER_TOTAL_1
 tpr_count_rep2 = TESTER_TOTAL_2
 tpr_count_rep3 = TESTER_TOTAL_3
 tpr_count_rep4 = TESTER_TOTAL_4
 tpr_count_rep5 = TESTER_TOTAL_5
 tpr_count_rep6 = TESTER_TOTAL_6 ;

 drop  total_count_rep1
           total_count_rep2
           total_count_rep3
           total_count_rep4
           total_count_rep5
           total_count_rep6 ;
 run;



data trago.ase_bayes_tpr_tdu_tpr_flag ;
set ase_bayes_tpr_tdu_tpr_flg;
rename
 tdu_count_rep1 = LINE_TOTAL_1
 tdu_count_rep2 = LINE_TOTAL_2
 tdu_count_rep3 = LINE_TOTAL_3
 tpr_count_rep1 = TESTER_TOTAL_1
 tpr_count_rep2 = TESTER_TOTAL_2
 tpr_count_rep3 = TESTER_TOTAL_3 ;

 drop  total_count_rep1
           total_count_rep2
           total_count_rep3 ;
 run;


proc export data =trago.ase_bayes_tdu_tdu_tpr_flag
 outfile="/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Filter_orthologs/empirical_bayesian_parents_input/ase_bayes_tdu_tdu_tpr_flag.csv"
DBMS = csv REPLACE;
run;

proc export data =trago.ase_bayes_tpr_tdu_tpr_flag
 outfile="/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Filter_orthologs/empirical_bayesian_parents_input/ase_bayes_tpr_tdu_tpr_flag.csv"
DBMS = csv REPLACE;
run;

