# TargetP analysis of the 449 loci showing lineage-specific biased homeolog expression toward the maternal parent

TargetP-2.0 tool predicts the presence of N-terminal presequences: signal peptide (SP), mitochondrial transit peptide (mTP), chloroplast transit peptide (cTP) or thylakoid luminal transit peptide (luTP).

## 1. Extract the amino acid sequences
The information of the analyzed loci can be found [here](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/tree/master/Polyploid_alignment/Homeolog-specific-expression_Tms-Tml_Compare)
  - 449 loci with lineage-specific biased homeolog expression toward the maternal parent 
  - 4,975 total loci which were used to compare homeolog-specific expression profiles between the two forms of T. miscellus

The amino acid sequences were extracted from file `SuperTranscript_Tdu.fasta.transdecoder.pep`.

`sed 's/*//' Lineage_specific_maternal_bias.fasta > Lineage_specific_maternal_bias_reformatted.fasta` was used to remove * (terminator) from the fasta file

We have **`Lineage_specific_maternal_bias_reformatted.fasta`** and **`Total_homeolog_compare_loci_reformatted.fasta`**.

