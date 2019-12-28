# Compare Homeolog-specific expression profiles between Tms (short-liguled T. miscellus) and Tml (long-liguled T. miscellus)

The are ~5,400 orthologous pairs that have been analized for homeolog-specific expression in polyploids. How are the expression profiles compared between two forms of T. miscellus?

Script for this analysis can be find in Jupyter notebook `Homeolog-specific-expression_Tms-Tml_Compare.ipynb`.

| | Tml, non-bias | Tml, bias Tdu | Tml, bias Tpr |
| -- | -- | -- | -- |
|Tms, non-bias | 3,551 | 185 | 222 |
|Tms, bias Tdu | 217 | 232 | 1 |
|Tms, bias Tpr | 263 | 1 | 303 |

Summary:
  - 82.1% loci (4,086 out of 4,975) showed the same homeolog-specific expression profiles between Tms and Tml.
  - When homeolog-specific expression profiles are different, in most cases, there is no bias in one polyploid, but biased in the other polyploid.
  - In very rare cases (2), the biasd subgenome is flipped over between Tms and Tml.
  
