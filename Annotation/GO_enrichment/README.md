# Gene ontology enrichment analysis
## 1. Description
We used the [pipeline](https://github.com/trinityrnaseq/trinityrnaseq/wiki/Running-GOSeq) provided by Trinity for GO enrichment analysis. The pipeline used [GOseq](https://genomebiology.biomedcentral.com/articles/10.1186/gb-2010-11-2-r14), which takes gene length into consideration.

**It is important to change R to version 3.6** before performing GO enrichment analysis.
```
module load gcc/5.2.0
module load trinity/r20180213-2.6.5
module load R/3.6
```

## 2. Prepare files
### 2.1 Extract GO assignment
Annocation results from **Tdu** was used. **Ancestral terms (which introduces lots of redundancy) are not included** -- this is different from the pipeline, which includes `--include_ancestral_terms`.
```bash
module load gcc/5.2.0
module load trinity/r20180213-2.6.5

$HPC_TRINOTATE_DIR/util/extract_GO_assignments_from_Trinotate_xls.pl \
  --Trinotate_xls Tdu_trinotate_annotation_report.xls \
  -G \
  > Tdu_go_annotation_no_ancestral.txt &
```

Output: `Tdu_go_annotation_no_ancestral.txt`
```
TRINITY_DN10002_c0_g1   GO:0004352,GO:0004353,GO:0005507,GO:0005524,GO:0005739,GO:0005774,GO:0006520,GO:0008270,GO:0009651,GO:0016491,GO:0046686,GO:0050897,GO:0055114
TRINITY_DN10007_c0_g2   GO:0000943,GO:0003676,GO:0003964,GO:0004190,GO:0004519,GO:0006310,GO:0015074,GO:0046872
TRINITY_DN10011_c0_g1   GO:0005509,GO:0010091
```

### 2.2 Create a 'gene lengths' file
This step is a little bit different from Trinity pipeline, in which 'gene lengths' file is the expression-weighted average of transcript isoform lengths. But in our case, we used Supertranscript to represent the 'genes', and therefore the length of supertranscript is equal to gene length.
```bash
module load gcc/5.2.0
module load trinity/r20180213-2.6.5

${TRINITY_HOME}/util/misc/fasta_seq_length.pl SuperTranscript_Tdu.fasta > Tdu_supertranscript_length.txt
```

Output `Tdu_supertranscript_length.txt`
```
gene_id length
TRINITY_DN4621_c0_g1    233
TRINITY_DN31201_c0_g1   314
TRINITY_DN42844_c0_g1   221
TRINITY_DN25100_c0_g3   2440
TRINITY_DN21974_c1_g1   2322
```
### 2.3 Generate background gene list
`Orthologs_TduID_11863.txt`, which contains 11,863 orthologous pairs is used as background gene list for differential expression analysis.
```
Orthologs_TduID
TRINITY_DN17012_c3_g3
TRINITY_DN23158_c1_g4
TRINITY_DN24503_c1_g1
TRINITY_DN22881_c5_g1
TRINITY_DN20656_c5_g1
```

`Orthologs_TduID_5400.txt`, which contains 5,400 orthologous pairs is used as background gene list for homeolog-specific expression analysis.

## 3. GO enrichment analysis on differentially expressed (DE) genes
### 3.1 Analysis on DE genes between Tms and Tml
**For those 39 DE genes up-regulated in Tml**
```
${TRINITY_HOME}/Analysis/DifferentialExpression/run_GOseq.pl \
    --genes_single_factor GoSeq_DE_Tml_higher.txt \
    --GO_assignments Tdu_go_annotation_no_ancestral.txt \
    --lengths Tdu_supertranscript_length.txt \
    --background Orthologs_TduID_11863.txt
```
Output: `GoSeq_DE_Tml_higher.txt.GOseq.enriched` and `GoSeq_DE_Tml_higher.txt.GOseq.depleted`. The first few lines of enriched file:
```
category        over_represented_pvalue under_represented_pvalue        numDEInCat      numInCat        term    ontology        over_represented_FDR    go_term gene_ids
GO:0045490      4.11472657411315e-09    0.999999999942372       6       42      pectin catabolic process        BP      2.9638375513337e-05     BP pectin catabolic process TRINITY_DN14723_c0_g1, TRINITY_DN17458_c2_g1, TRINITY_DN21504_c0_g1, TRINITY_DN22246_c1_g1, TRINITY_DN4208_c0_g1, TRINITY_DN9625_c0_g1
GO:0030599      1.94019972469179e-06    0.999999972429355       4       28      pectinesterase activity MF      0.00349381465423874     MF pectinesterase activity      TRINITY_DN14723_c0_g1, TRINITY_DN17458_c2_g1, TRINITY_DN4208_c0_g1, TRINITY_DN9625_c0_g1
GO:0042545      1.94019972469179e-06    0.999999972429355       4       28      cell wall modification  BP      0.00349381465423874     BP cell wall modification       TRINITY_DN14723_c0_g1, TRINITY_DN17458_c2_g1, TRINITY_DN4208_c0_g1, TRINITY_DN9625_c0_g1
GO:0045330      1.94019972469179e-06    0.999999972429355       4       28      aspartyl esterase activity      MF      0.00349381465423874     MF aspartyl esterase activity   TRINITY_DN14723_c0_g1, TRINITY_DN17458_c2_g1, TRINITY_DN4208_c0_g1, TRINITY_DN9625_c0_g1
GO:0004857      0.000339941580386272    0.999990001835974       3       42      enzyme inhibitor activity       MF      0.381650622185932       MF enzyme inhibitor activity    TRINITY_DN14723_c0_g1, TRINITY_DN17458_c2_g1, TRINITY_DN4208_c0_g1
```

**For those 2 DE genes up-regulated in Tms**
```
${TRINITY_HOME}/Analysis/DifferentialExpression/run_GOseq.pl \
> --genes_single_factor GoSeq_DE_Tms_higher.txt \
> --GO_assignments Tdu_go_annotation_no_ancestral.txt \
> --lengths Tdu_supertranscript_length.txt \
> --background Orthologs_TduID_11863.txt
```

Output `GoSeq_DE_Tms_higher.txt.GOseq.enriched` and `GoSeq_DE_Tms_higher.txt.GOseq.depleted`.

### 3.2 Analysis on DE genes between Tdu and Tpr
**For those 987 DE genes up-regulated in Tdu**
```
${TRINITY_HOME}/Analysis/DifferentialExpression/run_GOseq.pl \
> --genes_single_factor GOSeq_DE_Tdu_higher.txt \
> --GO_assignments ../Tdu_go_annotation_no_ancestral.txt \
> --lengths ../Tdu_supertranscript_length.txt \
> --background ../Orthologs_TduID_11863.txt
```
Output `GOSeq_DE_Tdu_higher.txt.GOseq.enriched` and `GOSeq_DE_Tdu_higher.txt.GOseq.depleted`.

**For those 1,030 DE genes up-regulated in Tpr**
```
DE_Tdu_Tpr_analysis]$ ${TRINITY_HOME}/Analysis/DifferentialExpression/run_GOseq.pl \
> --genes_single_factor GOSeq_DE_Tpr_higher.txt \
> --GO_assignments ../Tdu_go_annotation_no_ancestral.txt \
> --lengths ../Tdu_supertranscript_length.txt \
> --background ../Orthologs_TduID_11863.txt
```

Output `GOSeq_DE_Tpr_higher.txt.GOseq.enriched` and `GOSeq_DE_Tpr_higher.txt.GOseq.depleted`.

## 4. GO enrichment analysis on homeolog-specific expression genes
The following scripts were used in terminal:
```bash
${TRINITY_HOME}/Analysis/DifferentialExpression/run_GOseq.pl --genes_single_factor GOSeq_Tml-homeolog_biasTdu.txt --GO_assignments ../Tdu_go_annotation_no_ancestral.txt --lengths ../Tdu_supertranscript_length.txt --background ../Orthologs_TduID_5400.txt

${TRINITY_HOME}/Analysis/DifferentialExpression/run_GOseq.pl --genes_single_factor GOSeq_Tml-homeolog_biasTpr.txt --GO_assignments ../Tdu_go_annotation_no_ancestral.txt --lengths ../Tdu_supertranscript_length.txt --background ../Orthologs_TduID_5400.txt

${TRINITY_HOME}/Analysis/DifferentialExpression/run_GOseq.pl --genes_single_factor GOSeq_Tms-homeolog_biasTdu.txt --GO_assignments ../Tdu_go_annotation_no_ancestral.txt --lengths ../Tdu_supertranscript_length.txt --background ../Orthologs_TduID_5400.txt

${TRINITY_HOME}/Analysis/DifferentialExpression/run_GOseq.pl --genes_single_factor GOSeq_Tms-homeolog_biasTpr.txt --GO_assignments ../Tdu_go_annotation_no_ancestral.txt --lengths ../Tdu_supertranscript_length.txt --background ../Orthologs_TduID_5400.txt
```

Output:
  - Tms
    - `GOSeq_Tms-homeolog_biasTdu.txt.GOseq.enriched`
    - `GOSeq_Tms-homeolog_biasTpr.txt.GOseq.enriched`
    - `Simplified_1e-2_GOSeq_Tms-homeolog_biasTdu.txt.GOseq.enriched`
    - `Simplified_1e-2_GOSeq_Tms-homeolog_biasTpr.txt.GOseq.enriched`
  - Tml
    - `GOSeq_Tml-homeolog_biasTdu.txt.GOseq.enriched`
    - `GOSeq_Tml-homeolog_biasTpr.txt.GOseq.enriched`
    - `Simplified_1e-2_GOSeq_Tml-homeolog_biasTdu.txt.GOseq.enriched`
    - `Simplified_1e-2_GOSeq_Tml-homeolog_biasTpr.txt.GOseq.enriched`

## 5. GO enrichment analysis on transgressive express genes
### 5.1 In short-liguled T.miscellus
The following scripts were used in terminal:
```
${TRINITY_HOME}/Analysis/DifferentialExpression/run_GOseq.pl --genes_single_factor GOSeq_Tms_transgressive_lower.txt --GO_assignments ../Tdu_go_annotation_no_ancestral.txt --lengths ../Tdu_supertranscript_length.txt --background ../Orthologs_TduID_11863.txt 

${TRINITY_HOME}/Analysis/DifferentialExpression/run_GOseq.pl --genes_single_factor GOSeq_Tms_transgressive_higher.txt --GO_assignments ../Tdu_go_annotation_no_ancestral.txt --lengths ../Tdu_supertranscript_length.txt --background ../Orthologs_TduID_11863.txt
```

Output:
  - `GOSeq_Tms_transgressive_lower.txt.GOseq.enriched`
  - `GOSeq_Tms_transgressive_lower.txt.GOseq.depleted`
  - `GOSeq_Tms_transgressive_higher.txt.GOseq.enriched`
  - `GOSeq_Tms_transgressive_higher.txt.GOseq.depleted`

### 5.2 In long-liguled T. miscellus
Output:
  - `GOSeq_Tml_transgressive_lower.txt.GOseq.enriched`
  - `GOSeq_Tml_transgressive_lower.txt.GOseq.depleted`
  - `GOSeq_Tml_transgressive_higher.txt.GOseq.enriched`
  - `GOSeq_Tml_transgressive_higher.txt.GOseq.depleted`

## 6. GO enrichment analysis on the 12 categories of loci
The loci could be found at `/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/DE_analysis/12_possible_differential_exp_states`.

### 6.1 Transgressive expression
**Tms:**

The following code were used:
```
${TRINITY_HOME}/Analysis/DifferentialExpression/run_GOseq.pl --genes_single_factor Tms_trans-down_loci.txt --GO_assignments ../Tdu_go_annotation_no_ancestral.txt --lengths ../Tdu_supertranscript_length.txt --background ../Orthologs_TduID_11863.txt

${TRINITY_HOME}/Analysis/DifferentialExpression/run_GOseq.pl --genes_single_factor Tms_trans-up_loci.txt --GO_assignments ../Tdu_go_annotation_no_ancestral.txt --lengths ../Tdu_supertranscript_length.txt --background ../Orthologs_TduID_11863.txt
```

```
cut -f 1,2,6,7 Tms_trans-down_loci.txt.GOseq.enriched | awk '$2<1e-2' > simplified_1e-2_Tms_trans-down_loci.txt.GOseq.enriched

cut -f 1,2,6,7 Tms_trans-up_loci.txt.GOseq.enriched | awk '$2<1e-2' > simplified_1e-2_Tms_trans-up_loci.txt.GOseq.enriched
```

**Tml:**

The following code were used:
```
${TRINITY_HOME}/Analysis/DifferentialExpression/run_GOseq.pl --genes_single_factor Tml_trans-down_loci.txt --GO_assignments ../Tdu_go_annotation_no_ancestral.txt --lengths ../Tdu_supertranscript_length.txt --background ../Orthologs_TduID_11863.txt

${TRINITY_HOME}/Analysis/DifferentialExpression/run_GOseq.pl --genes_single_factor Tml_trans-up_loci.txt --GO_assignments ../Tdu_go_annotation_no_ancestral.txt --lengths ../Tdu_supertranscript_length.txt --background ../Orthologs_TduID_11863.txt
```

```
cut -f 1,2,6,7 Tml_trans-down_loci.txt.GOseq.enriched | awk '$2<1e-2' > simplified_1e-2_Tml_trans-down_loci.txt.GOseq.enriched

cut -f 1,2,6,7 Tml_trans-up_loci.txt.GOseq.enriched | awk '$2<1e-2' > simplified_1e-2_Tml_trans-up_loci.txt.GOseq.enriched
```
