# Do DE genes between Tms and Tml belong to single copy gene group?

## 1. Extract SuperTranscript fasta files (from Tdu) for those 41 DE loci between Tms and Tml

Script `Extract_fasta_seq_V3.ipynb` was used. Output: `DESeq2_Tms_Tml.fasta`.

## 2. Generate a fasta file containing 959 conserved single copy genes

[Duarte et al., 2010](https://link.springer.com/article/10.1186/1471-2148-10-61#Sec18) identified 959 single copy genes found in various plant species.

Based on the gene ID from Arabidopsis, a fasta file `959_single_copy_gene_At.fasta` was generated.
