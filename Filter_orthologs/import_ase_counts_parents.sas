
libname trago '/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/sas_data';

%macro import_cnts (reads, rep, ref, alt) ;

proc import OUT=WORK.&reads&rep._2_&ref._&alt 
            DATAFILE="/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Filter_orthologs/Compare_SAM/ase_counts_&reads._&rep._2_&ref._&alt..csv"
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
     GUESSINGROWS=20; 
run;

data ase_&reads&rep._&ref._&alt;
retain fusion_ID rep total_count ase_count ase &ref._count &alt._count ;
set &reads&rep._2_&ref._&alt;
total_count= BOTH_EXACT + BOTH_INEXACT_EQUAL + SAM_A_EXACT_SAM_B_INEXACT +
	SAM_A_INEXACT_BETTER +SAM_A_ONLY_EXACT +SAM_A_ONLY_SINGLE_INEXACT +
	SAM_B_EXACT_SAM_A_INEXACT +SAM_B_INEXACT_BETTER +SAM_B_ONLY_EXACT +SAM_B_ONLY_SINGLE_INEXACT;
&ref._count=SAM_A_EXACT_SAM_B_INEXACT + SAM_A_INEXACT_BETTER +
	SAM_A_ONLY_EXACT +SAM_A_ONLY_SINGLE_INEXACT;
&alt._count=SAM_B_EXACT_SAM_A_INEXACT +SAM_B_INEXACT_BETTER +
	SAM_B_ONLY_EXACT + SAM_B_ONLY_SINGLE_INEXACT;
ase_count=&ref._count+&alt._count;
if ase_count>0 then ase=&ref._count/ase_count;
	else ase=.;
rep=&rep;
hybrid="&reads";
rename fusion_ID = commonID ;
                drop BOTH_EXACT BOTH_INEXACT_EQUAL SAM_A_ONLY_EXACT SAM_B_ONLY_EXACT SAM_A_EXACT_SAM_B_INEXACT SAM_B_EXACT_SAM_A_INEXACT
                SAM_A_ONLY_SINGLE_INEXACT SAM_B_ONLY_SINGLE_INEXACT SAM_A_INEXACT_BETTER SAM_B_INEXACT_BETTER;

	run;

%mend ;

%import_cnts (Tdu, 2613_11, Tdu, Tpr) ;
%import_cnts (Tdu, 2613_12, Tdu, Tpr) ;
%import_cnts (Tdu, 2613_41, Tdu, Tpr) ;

%import_cnts (Tdu, 2886_3, Tdu, Tpr) ;
%import_cnts (Tdu, 2886_5, Tdu, Tpr) ;
%import_cnts (Tdu, 2886_7, Tdu, Tpr) ;

%import_cnts (Tpr, 2608_3, Tdu, Tpr) ;
%import_cnts (Tpr, 2608_21, Tdu, Tpr) ;
%import_cnts (Tpr, 2608_31, Tdu, Tpr) ;

data trago.ase_4_bayes_Tdu_reads_Tdu_Tpr ;
set ase_Tdu2613_11_Tdu_Tpr ase_Tdu2613_12_Tdu_Tpr ase_Tdu2613_41_Tdu_Tpr ase_Tdu2886_3_Tdu_Tpr ase_Tdu2886_5_Tdu_Tpr ase_Tdu2886_7_Tdu_Tpr;
run ;

data trago.ase_4_bayes_Tpr_reads_Tdu_Tpr ;
set ase_Tpr2608_3_Tdu_Tpr ase_Tpr2608_21_Tdu_Tpr ase_Tpr2608_31_Tdu_Tpr;
run ;

