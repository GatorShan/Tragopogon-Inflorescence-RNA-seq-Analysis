
libname trago '/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/sas_data_poly';

/* 
merge with flag 
export for bayesian
*/
/*
proc contents data = trago.ase_bayes_Cast_sbys_with_flag;run ;
*/
%macro add_flag (reads, alt) ;

proc sort data = trago.Bayes_flag_&reads._reads_tdu_&alt. ;
by commonID ;
proc sort data = trago.Ase_bayes_&reads._rds_tdu_&alt._sbys ;
by commonID ;
run;

data  ase_bayes_&reads._tdu_&alt._flg;
merge trago.Ase_bayes_&reads._rds_tdu_&alt._sbys (in=in1) trago.Bayes_flag_&reads._reads_tdu_&alt. (in=in2);
by commonID ;
if in1;
run ;


%mend ;

%add_flag (Tms, tpr);
%add_flag (Tml, tpr);

/*
proc print data=trago.ase_bayes_Tms_tdu_tpr_flg (obs=10);
run;
*/

%macro clean (reads, repa, repb, repc, alt) ;

data trago.ase_bayes_&reads._tdu_&alt._flag ;
set ase_bayes_&reads._tdu_&alt._flg;
rename
 tdu_count_rep&repa = LINE_TOTAL_1
 tdu_count_rep&repb = LINE_TOTAL_2
 tdu_count_rep&repc = LINE_TOTAL_3
 &alt._count_rep&repa = TESTER_TOTAL_1
 &alt._count_rep&repb = TESTER_TOTAL_2
 &alt._count_rep&repc = TESTER_TOTAL_3 ;

 drop  total_count_rep&repa
       total_count_rep&repb
       total_count_rep&repc ;
 run;

proc export data =trago.ase_bayes_&reads._tdu_&alt._flag 
 outfile="/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Polyploid_alignment/empirical_bayesian_hybrids_input/ase_bayes_&reads._tdu_&alt._flag.csv"
DBMS = csv REPLACE;
run;

%mend ;

%clean (Tms, 1, 2, 3, tpr) ;
%clean (Tml, 1, 2, 3, tpr) ;
