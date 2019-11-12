libname trago '/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/sas_data';

/* Create flag_analyze -- lam (Tdu) has  5 (6) reps and croc (Tpr) has 3 reps */


/* TDU-tdu-tpr reads */
    * A commonID is called analyzable if it has ASE information for at least one rep.;
    proc sort data=trago.ase_4_bayes_tdu_reads_tdu_tpr;
        by  commonID;
        run;

    proc means data=trago.ase_4_bayes_tdu_reads_tdu_tpr noprint;
        by commonID;
        output out=sums sum(ASE_count)=sums;
        run;

    * needed to add _freq_ requirement to ensure that there are 5 (6 for Tdu) reps.;
    data flag_analyze;
        set sums;
        if sums > 0 and _freq_ ge 6 then flag_analyze = 1; else flag_analyze = 0;
        keep commonID flag_analyze;
        run;

/* Make permanent dataset */
    data trago.bayes_flag_tdu_reads_tdu_tpr;
        set flag_analyze;
        run;

            	/*---------------------------------------*/

/* TPR-tdu-tpr reads */
    * A commonID is called analyzable if it has ASE information for at least one rep.;
    proc sort data=trago.ase_4_bayes_tpr_reads_tdu_tpr;
        by  commonID;
        run;

    proc means data=trago.ase_4_bayes_tpr_reads_tdu_tpr noprint;
        by commonID;
        output out=sums sum(ASE_count)=sums;
        run;

    * needed to add _freq_ requirement to ensure that there are 3 reps. (for Tpr);
    data flag_analyze;
        set sums;
        if sums > 0 and _freq_ ge 3 then flag_analyze = 1; else flag_analyze = 0;
        keep commonID flag_analyze;
        run;

/* Make permanent dataset */
    data trago.bayes_flag_tpr_reads_tdu_tpr;
        set flag_analyze;
        run;
