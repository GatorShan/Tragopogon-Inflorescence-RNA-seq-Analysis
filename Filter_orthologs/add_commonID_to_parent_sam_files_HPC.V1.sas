*libname trago 'S:\UFGI_Trago\sas_data';
libname trago '/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/sas_data';

/*
create list of commonIDs 
import filtered sam files
add commonID to sam file using consensedID

currently commented so only doing Tdu rep3 to TPR

*/

data TDU_ID_tdu_tpr ;
set trago.Tdu_tpr_bed_for_sam_compare ;
consensedID = scan(commonID,2,'|');
drop start end ;
run ;

data TDU_ID_tpr_tdu ;
set trago.Tdu_tpr_bed_for_sam_compare ;
consensedID = scan(commonID,1,'|');
drop start end ;
run ;

data TPR_ID_tpr_tdu ;
set trago.Tpr_tdu_bed_for_sam_compare ;
consensedID = scan(commonID,1,'|');
drop start end ;
run ;

data TPR_ID_tdu_tpr ;
set trago.Tpr_tdu_bed_for_sam_compare ;
consensedID = scan(commonID,2,'|');
drop start end ;
run ;


proc sort data = TDU_ID_tdu_tpr ;
by consensedID ;
proc sort data = TDU_ID_tpr_tdu ;
by consensedID ;
proc sort data = TPR_ID_tpr_tdu;
by consensedID ;
proc sort data = TPR_ID_tdu_tpr;
by consensedID ;
run ;

                                        
%macro add_commonid (reads, rep, ref, hyb, alt);

     data &reads._&rep._2_&ref._for_&hyb._sam    ;
     %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
     infile  "/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Filter_orthologs/Filter_SAM_by_bed/&reads._&rep._uniq_2_&ref._filter_for_&hyb..sam"
 delimiter='09'x MISSOVER DSD lrecl=32767 ;
        informat readID $100. ;
        informat s_VAR2 best32. ;
        informat consensedID $36. ;
        informat pos best32. ;
        informat s_VAR5 best32. ;
        informat s_VAR6 $8. ;
        informat s_VAR7 $1. ;
        informat s_VAR8 best32. ;
        informat s_VAR9 best32. ;
        informat s_VAR10 $100. ;
        informat s_VAR11 $100. ;
        informat s_VAR12 $7. ;
        informat s_VAR13 $8. ;
        format readID $100. ;
        format s_VAR2 best12. ;
        format consensedID $36. ;
        format pos best12. ;
        format s_VAR5 best12. ;
        format s_VAR6 $8. ;
        format s_VAR7 $1. ;
        format s_VAR8 best12. ;
        format s_VAR9 best12. ;
        format s_VAR10 $100. ;
        format s_VAR11 $100. ;
        format s_VAR12 $7. ;
        format s_VAR13 $8. ;
     input
                 readID $
                 s_VAR2
                 consensedID $
                 pos
                 s_VAR5
                 s_VAR6 $
                 s_VAR7 $
                 s_VAR8
                 s_VAR9
                 s_VAR10 $
                 s_VAR11 $
                 s_VAR12 $
                 s_VAR13 $
     ;
     if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
     run;


proc sort data = &reads._&rep._2_&ref._for_&hyb._sam  ;
by consensedID ;
run;

data add_ID missingID other;
merge &reads._ID_&ref._&alt (in=in1) &reads._&rep._2_&ref._for_&hyb._sam  (in=in2);
by consensedID ;
if in1 and in2 then output add_ID ;
else if in2  then output missingID ;
else output other ;
run ;

data trago.&reads._&rep._unq_2_&ref._4_&hyb._ID ;
retain readID s_VAR2 commonID pos s_VAR5-s_VAR13 ;
set add_ID ;
drop consensedID  ;
run;

proc export data = trago.&reads._&rep._unq_2_&ref._4_&hyb._ID 
outfile= "/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Filter_orthologs/Filter_SAM_by_bed/&reads._&rep._unq_2_&ref._4_&hyb._commonID.sam"
dbms=tab replace ; 
putnames = no ;
run;
%mend ;

%add_commonID (Tdu, 2613_11, TDU, Tms, tpr);
%add_commonID (Tdu, 2613_11, TPR, Tms, tdu);
%add_commonID (Tdu, 2613_12, TDU, Tms, tpr);
%add_commonID (Tdu, 2613_12, TPR, Tms, tdu);
%add_commonID (Tdu, 2613_41, TDU, Tms, tpr);
%add_commonID (Tdu, 2613_41, TPR, Tms, tdu);

%add_commonID (Tdu, 2886_3, TDU, Tms, tpr);
%add_commonID (Tdu, 2886_3, TPR, Tms, tdu);
%add_commonID (Tdu, 2886_5, TDU, Tms, tpr);
%add_commonID (Tdu, 2886_5, TPR, Tms, tdu);
%add_commonID (Tdu, 2886_7, TDU, Tms, tpr);
%add_commonID (Tdu, 2886_7, TPR, Tms, tdu);

%add_commonID (Tpr, 2608_3, TDU, Tms, tpr);
%add_commonID (Tpr, 2608_3, TPR, Tms, tdu);
%add_commonID (Tpr, 2608_21, TDU, Tms, tpr);
%add_commonID (Tpr, 2608_21, TPR, Tms, tdu);
%add_commonID (Tpr, 2608_31, TDU, Tms, tpr);
%add_commonID (Tpr, 2608_31, TPR, Tms, tdu);
