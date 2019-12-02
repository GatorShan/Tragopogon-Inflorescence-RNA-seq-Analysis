# Shared orthologous paris between wu-blast and OrthoFinder
## 1. Description
The overlap orthologous pairs between wu-blast and OrthoFinder are isolated
## 2. Input
`reciprocated_blast_hits.txt` from wu-blast results
  - 42595 orthologous pairs

`SingleCopyOrthogroups_parser.tsv` from OrthoFinder results
  - 18,341 orthologous pairs


## 3. Identify shared/overlapping orthologous pairs
The script `Comparison_V3.0.py` was used. The output file containing shared orthologous pairs is `Shared_reciprocated_blast_hits_SingleCopyOrthogroups_parser.txt`.
  - there are 12,900 overlapping orthologous pairs
  - Tpr_TRINITY_DN14318_c0_g1	Tdu_TRINITY_DN17012_c3_g3
  
    Tpr_TRINITY_DN13887_c2_g3	Tdu_TRINITY_DN23158_c1_g4
    
    Tpr_TRINITY_DN13936_c2_g4	Tdu_TRINITY_DN24503_c1_g1

## 4. Add descritpions for those shared orthologous pairs
Script `ExtractInfo_V1.0.py` was used. The description info is extracted from file `Tdu_DB_Tpr_query_parser_single_hit_FullName.txt`. The output file is **`Shared_reciprocated_blast_hits_SingleCopyOrthogroups_parser_FullDescription.txt`**.
  - there are 12,900 shared orthologous pairs
  - Header line: QUERYNAME, QUERYLEN, SUBNAME, SUBLEN, SCORE, PVAL, ID, CONS, ALIG_LEN, QB, QE, SB, SE

## 5. Histogram of 12,900 shared orthologous pairs
The script `Histogram.R` was used to draw several histograms.

![Query Length](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Shared_COREs_wu-blast_OrthoFinder/Images/Query_length.png)

![Subject Length](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Shared_COREs_wu-blast_OrthoFinder/Images/Sub_length.png)

![p-value](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Shared_COREs_wu-blast_OrthoFinder/Images/p-value.png)

![Identity](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Shared_COREs_wu-blast_OrthoFinder/Images/Identity.png)

![Alignment Length](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Shared_COREs_wu-blast_OrthoFinder/Images/Alignment_length.png)

## 6. Filternation shared orthologous pairs
The script `Filter_V1.0.py` is used, and generate a file **`Shared_reciprocated_blast_hits_SingleCopyOrthogroups_parser_FullDescription_filtered.txt`**
  - **11,968 shared orthologous pairs**
  - **P_VAL <= 1e-5 and Identity >= 0.8**

The script `Filter_V2.0.py` is used, and generate a file
**`Shared_reciprocated_blast_hits_SingleCopyOrthogroups_parser_FullDescription_filtered_2.0.txt`**
  - **11,863 shared orthologous pairs**
  - **P_VAL <= 1e-10 and Identity >= 0.8 and AlignmentLength >= 200**










