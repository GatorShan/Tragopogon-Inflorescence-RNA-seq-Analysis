![Sampling](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Images/Sampling_pics-1.png)

## Assemblies
  - 11,863 orthologous pairs are identified between diploid T. dubius and T. pratensis
  - T. dubius fasta file of the 11,863 orthologous pairs can be found [here](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Shared_COREs_wu-blast_OrthoFinder/SuperTranscript_Tdu_11863.fasta.gz)
  - T. pratensis fasta file of the 11,863 orthologous pairs can be found [here](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Shared_COREs_wu-blast_OrthoFinder/SuperTranscript_Tpr_11863.fasta.gz)
  - The pairing information of the orthologous pairs could be found [here](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Shared_COREs_wu-blast_OrthoFinder/Shared_reciprocated_blast_hits_SingleCopyOrthogroups_parser_FullDescription_filtered_2.0.txt)

## Annotation
  - Annotation of the Supertranscripts from T. dubius can be found [here](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Annotation/Trinotate_Functional_Annotation/Tdu_trinotate_annotation_report.xls.gz)
  - Annotation of the Supertranscripts from T. pratensis can be found [here](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Annotation/Trinotate_Functional_Annotation/Tpr_trinotate_annotation_report.xls.gz)

## The process of data analysis
### 1. Reads trimming
The process of reads trimming can be found in the directory [Reads_Trimming](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/tree/master/Reads_Trimming)
### 2. De novo assembly
The process of Trinity de novo assembly can be found in the directory [Trinity_assembly](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/tree/master/Trinity_assembly). The output are SuperTranscripts.
### 3. Identify orthologous pairs between T. dubius and T. pratensis
The process of identifying reciprocal best-hits can be found in the directory [WU-Blast_Analysis](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/tree/master/WU-Blast_Analysis). The process of performing OrthoFinder analysis can be found in the directory [OrthoFinder_Analysis](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/tree/master/OrthoFinder_Analysis). 11,863 overlapped orthologous pairs derived from the previous two approaches are found through the process described in the directory [Shared_COREs_wu-blast_OrthoFinder](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/tree/master/Shared_COREs_wu-blast_OrthoFinder).
### 4. Identify orthologous bias without mapping bias
5,400 orthologous pairs without mapping bias are found through the process described in the directory [Filter_orthologs](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/tree/master/Filter_orthologs). These loci are used in the homeolog-specific expression analysis.
### 5. Homeolog-specific expression analysis
Directory [Polyploid_alignment](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/tree/master/Polyploid_alignment) describes the process of homeolog-specific expression analysis.
### 6. Differential gene expression analysis
Directory [Differential_expression_analysis](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/tree/master/Differential_expression_analysis) includes the process of the following analysis:
  - DE analysis between any two species
  - Effect of paretal expression level on homeolog-specific expression
  - Nonadditive expression analysis: expression level dominance and transgressive expression
### 7. Annotation
The process of GO enrichement analysis can be found in the directory [Annotation](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/tree/master/Annotation).
### 8. Statistics
Fisher's exact test and chi-square goodness-of-fit test are performed in the directory [Statistics](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/tree/master/Statistics).
