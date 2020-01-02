# Gene ontology enrichment analysis
## 1. Description
We used the [pipeline](https://github.com/trinityrnaseq/trinityrnaseq/wiki/Running-GOSeq) provided by Trinity for GO enrichment analysis. The pipeline used [GOseq](https://genomebiology.biomedcentral.com/articles/10.1186/gb-2010-11-2-r14), which takes the gene length into consideration.

## 2. Prepare files
### 2.1 Extract GO assignment
Annocation results from **Tdu** was used. **Ancestral terms are not included**, which is different from the pipeline, which includes `--include_ancestral_terms`.
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

## 3. GO enrichment analysis
**It is important to change R to version 3.6!**
```
module load gcc/5.2.0
module load trinity/r20180213-2.6.5
module load R/3.6
```

### 3.1 Analysis on DE genes between Tms and Tml
For those 39 DE genes upregulated in Tml
```
${TRINITY_HOME}/Analysis/DifferentialExpression/run_GOseq.pl \
    --genes_single_factor GoSeq_DE_Tml_higher.txt \
    --GO_assignments Tdu_go_annotation.txt \
    --lengths Tdu_supertranscript_length.txt \
    --background Orthologs_TduID_11863.txt
```
Output: `GoSeq_DE_Tml_higher.txt.GOseq.enriched` and `GoSeq_DE_Tml_higher.txt.GOseq.depleted`. The first few lines of enriched file:
```
category	over_represented_pvalue	under_represented_pvalue	numDEInCat	numInCat	term	ontology	over_represented_FDR	go_term	gene_ids
GO:0045490	4.11472657411315e-09	0.999999999942372	6	42	pectin catabolic process	BP	4.35379218806912e-05	BP pectin catabolic process	TRINITY_DN14723_c0_g1, TRINITY_DN17458_c2_g1, TRINITY_DN21504_c0_g1, TRINITY_DN22246_c1_g1, TRINITY_DN4208_c0_g1, TRINITY_DN9625_c0_g1
GO:0045488	1.25382160387178e-08	0.999999999657674	7	88	pectin metabolic process	BP	4.5361374949337e-05	BP pectin metabolic process	TRINITY_DN14723_c0_g1, TRINITY_DN17180_c3_g1, TRINITY_DN17458_c2_g1, TRINITY_DN21504_c0_g1, TRINITY_DN22246_c1_g1, TRINITY_DN4208_c0_g1, TRINITY_DN9625_c0_g1
GO:0010393	1.46758911900281e-08	0.999999999589492	7	90	galacturonan metabolic process	BP	4.5361374949337e-05	BP galacturonan metabolic process	TRINITY_DN14723_c0_g1, TRINITY_DN17180_c3_g1, TRINITY_DN17458_c2_g1, TRINITY_DN21504_c0_g1, TRINITY_DN22246_c1_g1, TRINITY_DN4208_c0_g1, TRINITY_DN9625_c0_g1
GO:0000272	1.71482373875199e-08	0.999999999508106	7	92	polysaccharide catabolic process	BP	4.5361374949337e-05	BP polysaccharide catabolic process	TRINITY_DN14723_c0_g1, TRINITY_DN17458_c2_g1, TRINITY_DN21504_c0_g1, TRINITY_DN22246_c1_g1, TRINITY_DN24596_c3_g2, TRINITY_DN4208_c0_g1, TRINITY_DN9625_c0_g1
```

