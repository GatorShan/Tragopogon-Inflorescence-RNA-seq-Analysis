# Effect of parental gene expression profile on homeolog-specific expression in polyploids

## 1. Introduction:
For those ~5,400 orthologous pairs, which does not show reads mapping bias, how does homeolog-specific expression profile (e.g. none-bias; bias to Tdu subgenome; bias to Tpr subgenome) in polyploids relate to the parental gene expression condition (e.g. no DE; Tdu > Tpr; Tpr > Tdu)?

## 2. Analysis
Scripts `DESeq2_Homeolog-specific-expression_Tms.ipynb` and `DESeq2_Homeolog-specific-expression_Tml.ipynb` were used for analysis in Tms and Tml, respectively.

**For Tms**:

| Diploid expression profile | No homeolog-bias expression | Bias to Tdu | Bias to Tpr |
| -- | -- | -- | -- |
| Tdu = Tpr | 3,192 | 342 | 391 |
| Tdu > Tpr | 333 | 57 | 50 |
| Tdu < Tpr | 370 | 45 | 104 |


**For Tml**:

| Diploid expression profile | No homeolog-bias expression | Bias to Tdu | Bias to Tpr |
| -- | -- | -- | -- |
| Tdu = Tpr | 3,251 | 323 | 373 |
| Tdu > Tpr | 342 | 55 | 46 |
| Tdu < Tpr | 387 | 38 | 96 |

## 3. Comparing the expression patterns (category 1-9 in Figure 2) between Tms and Tml
script `DESeq2_Homeolog-specific-expression_Tms-Tml_Compare.ipynb` was used.
![comp_Tms_Tml](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Differential_expression_analysis/DESeq2_Homeolog-specific-expression/images/Supplimentary_figure_comp_Tms_Tml.png)
