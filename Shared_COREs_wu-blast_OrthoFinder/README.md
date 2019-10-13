# Shared COREs (common orthologous regions) between wu-blast and OrthoFinder
## Description
The overlap orthologous pairs between wu-blast and OrthoFinder are isolated
## Input
`reciprocated_blast_hits.txt` from wu-blast results
  - 42595 orthologous pairs

`SingleCopyOrthogroups_parser.tsv` from OrthoFinder results
  - 18,341 orthologous pairs


## Identify COREs
The script `Comparison_V3.0.py` was used. The output file containing shared COREs is `Shared_reciprocated_blast_hits_SingleCopyOrthogroups_parser.txt`.
  - there are 12,900 COREs
  - Tpr_TRINITY_DN14318_c0_g1	Tdu_TRINITY_DN17012_c3_g3
  
    Tpr_TRINITY_DN13887_c2_g3	Tdu_TRINITY_DN23158_c1_g4
    
    Tpr_TRINITY_DN13936_c2_g4	Tdu_TRINITY_DN24503_c1_g1

## Add descritpions for COREs
Script `ExtractInfo_V1.0.py` was used. The description info is extracted from file `Tdu_DB_Tpr_query_parser_single_hit_FullName.txt`. The output file is **`Shared_reciprocated_blast_hits_SingleCopyOrthogroups_parser_FullDescription.txt`**.
  - there are 12,900 COREs
  - Header line: QUERYNAME, QUERYLEN, SUBNAME, SUBLEN, SCORE, PVAL, ID, CONS, ALIG_LEN, QB, QE, SB, SE

## Histogram of 12,900 COREs
The script `Histogram.R` was used to draw several histograms.

<object data="https://drive.google.com/uc?id=1Msb3dlBUbPTOy5foiISwhU6HqEdzWs-i" type="application/pdf" width="700px" height="700px">
    <embed src="https://drive.google.com/uc?id=1Msb3dlBUbPTOy5foiISwhU6HqEdzWs-i">
        <p>This browser does not support PDFs. Please download the PDF to view it: <a href="http://yoursite.com/the.pdf">Download PDF</a>.</p>
    </embed>
</object>



