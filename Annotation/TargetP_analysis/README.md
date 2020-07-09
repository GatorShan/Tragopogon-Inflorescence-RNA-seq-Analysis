# TargetP analysis of the 449 loci showing lineage-specific biased homeolog expression toward the maternal parent

[TargetP-2.0](http://www.cbs.dtu.dk/services/TargetP/index.php) tool predicts the presence of N-terminal presequences: signal peptide (SP), mitochondrial transit peptide (mTP), chloroplast transit peptide (cTP) or thylakoid luminal transit peptide (luTP).

## 1. Extract the amino acid sequences
The information of the analyzed loci can be found [here](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/tree/master/Polyploid_alignment/Homeolog-specific-expression_Tms-Tml_Compare)
  - 449 loci with lineage-specific biased homeolog expression toward the maternal parent 
  - 4,975 total loci which were used to compare homeolog-specific expression profiles between the two forms of T. miscellus

The amino acid sequences were extracted from file `SuperTranscript_Tdu.fasta.transdecoder.pep`.

`sed 's/*//' Lineage_specific_maternal_bias.fasta > Lineage_specific_maternal_bias_reformatted.fasta` was used to remove * (terminator) from the fasta file

We have **`Lineage_specific_maternal_bias_reformatted.fasta`** and **`Total_homeolog_compare_loci_reformatted.fasta`**.

## 2. Run TargetP
The results are (tabular file containing 1. the protein prediction SP / mTP/ cTP / luTP / noTP and the associated likelihood probability and 2. the cleavage site position and associated likelihood probability):
  - `Lineage_specific_maternal_bias_reformatted_summary.targetp2`
  - `Total_homeolog_compare_loci_reformatted_summary.targetp2`

## 3. Interpret the result
| Category | Lineage-specific biased homeolog expression toward the maternal parent | Background loci |
| -- | -- | -- |
| Organelle-targeted (mTp + cTP) | 32 (7.1%) | 458 (9.2%) |
| Overall | 449 | 4,975 |

