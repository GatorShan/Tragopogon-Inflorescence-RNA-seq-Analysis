# WU-Blast Analysis
## Description
This analysis is used to find the reciprocal best-hit orthologs following the method from Boatwright et al. (2018). 
## Input
`SuperTranscript_Tdu.fasta`

`SuperTranscript_Tdu.fasta`
## Output
The following scripts were used to perform wu-blast analysis
- `wublast_Tdu_db_Tpr_query_1.0.sh`
  - **`Tdu_DB_Tpr_query.txt`** is the output file, which is 22G
  - xdformat: produce databases for BLAST in XDF (eXtended Database Format) from one or more input files in FASTA format
    - -n: sequence type
    - -o xdbname: "xdbname" is the name of an XDF database
    - SuperTranscript_Tdu.fasta: the single input file
  - warning message is shown in `wublast_Tdu_db_Tpr_query_1.0_41016863.out` and `wublast_Tdu_db_Tpr_query_1.0_41016863.error`
- `wublast_Tpr_db_Tdu_query_1.0.sh`
  - **`Tpr_DB_Tdu_query.txt`** is the output file, which is 26G
  - warning message is shown in `wublast_Tpr_db_Tdu_query_1.0_41106850.out` and `wublast_Tpr_db_Tdu_query_1.0_41106850.error`

## Reformat output files
The single best hit from each wublast result is parsed (no filtering) using script `XY_WU_BP_parser_single_hit_1.0.sh`
- the reformated outputs are:
  - **`Tdu_DB_Tpr_query_parser_single_hit.txt`**
    - TRINITY_DN4621_c0_g1	293	TRINITY_DN19634_c5_g4	4147	1429	8.1e-59	98.6	98.6348122866894	293	293	146	338	-
  - **`Tpr_DB_Tdu_query_parser_single_hit.txt`**
    - TRINITY_DN4621_c0_g1	233	TRINITY_DN11319_c1_g4	1481	136	0.0027	65.3	65.3846153846154	104	136	233	443	542	+
  - header line: **QUERYNAME, QUERYLEN, SUBNAME, SUBLEN, SCORE, PVAL, ID, CONS, ALIG_LEN, QB, QE, SB, SE**
- the shell script contains perl script `XY_WU_BP.shan.v3.pl`:
  - used together with `BPlitenew.pm` and `X_Y.pm`
  - line 73 and 75 have been commented out ==> no filtering
  - line 77 `next QUERY` ==> one hit per query
- A species ID (either Td or Tpr) is added to the name of the supertranscript to distingiush the two, using the script `NameChange_V1.0.py` for file `Tdu_DB_Tpr_query_parser_single_hit.txt` and `NameChange_V2.0.py` for file `Tpr_DB_Tdu_query_parser_single_hit.txt`. Two files were generated:
  - `Tdu_DB_Tpr_query_parser_single_hit_FullName.txt`
    - Tpr_TRINITY_DN4621_c0_g1        293     Tdu_TRINITY_DN19634_c5_g4       4147    1429    8.1e-59 98.6    98.6348122866894        293     293     1       46      338     -
  - `Tpr_DB_Tdu_query_parser_single_hit_FullName.txt`
    - Tdu_TRINITY_DN4621_c0_g1        233     Tpr_TRINITY_DN11319_c1_g4       1481    136     0.0027  65.3    65.3846153846154        104     136     233     443     542     +

### Identify the reciprocal best-hit orthologs
- Input:
  - `Tdu_DB_Tpr_query_parser_single_hit_FullName.txt`
  - `Tpr_DB_Tdu_query_parser_single_hit_FullName.txt`
- Script **`BLAST_COREs.py`** was used to identity the reciprocal best-hit orthologs
- Output:
  - **`reciprocated_blast_hits.txt`**
    - **this file will be used for downstream analysis**
    - **42,595 reciprocal best-hit orthologs were identified**
    - Tpr_TRINITY_DN31201_c0_g1       Tdu_TRINITY_DN10064_c0_g1
      Tpr_TRINITY_DN11072_c2_g4       Tdu_TRINITY_DN7930_c0_g1
      Tpr_TRINITY_DN14318_c0_g1       Tdu_TRINITY_DN17012_c3_g3
      Tpr_TRINITY_DN13887_c2_g2       Tdu_TRINITY_DN23704_c6_g3
  - `Tdu_DB_Tpr_query_parser_single_hit_FullName.txt.filtered_S.bed`
  - `Tdu_DB_Tpr_query_parser_single_hit_FullName.txt.filtered_Q.bed`
  
### Next
The shared orthologs pairs between wu-blast and OrthoFinder will be isolated
