# Trinity assembly of T.dubius (Tdu) and T.pratensis (Tpr) transcriptome
## 1. Description
For T. dubius, there are two populations (each with 3 biolgoical replicates); as the genotype concordance between the two populations are high (see analysis below), reads from these two populations were combined to generated a sigle transcriptome assembly.

  - 2613, Pullman
  - 2886, Moscow

For T. pratensis, there is only one population (3 biological replicates)
  - 2608, Moscow

## 2. Genotype concordance analysis between two Tdu populations
### 2.1 Mapping Tdu and Tpr reads (trimmed) to Tdu ref genome
Method
 - aligner: HISAT2
 - Tdu ref genome was indexed using script `HISAT2_indexing_Tdu_ref_1.0.sh`

Mapping Tpr 2608 to Tdu ref genome
  - Script `HISAT2_mapping_Tpr_crop_1.0.sh` was used
  - Output: `Tpr_2608_crop.bam`; 60.42% overall alignment rate

Mapping Tdu 2613 and Tdu 2886 to Tdu ref genome
  - Script `HISAT2_mapping_Tdu_crop_1.0.sh` was used
  - Output:
    - `Tdu_2613_crop.bam`; 79.47% overall alignment rate
    - `Tdu_2886_crop.bam`; 79.36% overall alignment rate

### 2.2 Sort and mark duplicate of bam files
Method: using samtools

Tdu 2613:
  - script `Samtools_Tdu-2613_1.0.sh` wsa used
  - input: `Tdu_2613_crop.bam`
  - output: `Tdu_2613_crop.markdup.bam`

Tdu 2886:
  - script `Samtools_Tdu-2886_1.0.sh` wsa used
  - input: `Tdu_2886_crop.bam`
  - output: `Tdu_2886_crop.markdup.bam`

Tpr 2608:
  - script `Samtools_Tpr_1.0.sh`
  - input `Tpr_2608_crop.sam`
  - output `Tpr_2608_crop.markdup.bam`

### 2.3 Generate VCF files
Method: [freebayes](https://github.com/ekg/freebayes)
  - freebayes is a Bayesian genetic variant detector designed to find small polymorphisms, specifically SNPs, indels, MNPs, and complex events (composite insertion and substitution events) smaller than the length of a short-read sequencing alignment.

Tdu 2613
  - script: `freebayes_Tdu-2613_2.0.sh`
  - input: `Tdu_2613_crop.markdup.bam`
  - output: `Tdu_2613_var.vcf`

Tdu 2886
  - script:`freebayes_Tdu-2886_1.0.sh`
  - input: `Tdu_2886_crop.markdup.bam`
  - output: `Tdu_2886_var.vcf`

Tpr 2608
  - script: `freebayes_Tpr-2608_1.0.sh`
  - input: `Tpr_2608_crop.markdup.bam`
  - output: `Tpr_2608_var.vcf`

### 2.4 Filter VCF files
By default, records are output even if they have very low probability of variation, in expectation that the VCF will be filtered

The following bash script was used:
  - `module load vcflib/20150313`
    
    `vcffilter -f "QUAL > 20" Tdu_2613_var.vcf > Tdu_2613_filtered_var.vcf`
  - `vcffilter -f "QUAL > 20" Tdu_2886_var.vcf > Tdu_2886_filtered_var.vcf`
  - `vcffilter -f "QUAL > 20" Tpr_2608_var.vcf > Tpr_2608_filtered_var.vcf`

### 2.5 Calculate genotype concordance
Between Tdu_2613 and Tdu_2886
  - method: picard; performed under the bash window
  - module load picard/2.19.1
  
    java -jar $HPC_PICARD_DIR/picard.jar GenotypeConcordance \
    
	CALL_VCF=Tdu_2613_filtered_var.vcf \
    
	OUTPUT=Tdu_two_pop_compare \
    
	TRUTH_VCF=Tdu_2886_filtered_var.vcf
  - Output:
    - /ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/freebayes
    - Tdu_two_pop_compare.genotype_concordance_contingency_metrics
    - Tdu_two_pop_compare.genotype_concordance_detail_metrics
    - Tdu_two_pop_compare.genotype_concordance_summary_metrics
  - **Genotype concordance**:
    - **SNP: 0.810602**
    - **INDEL: 0.715642**

| Variant Type | Genotype Cocordance (a/b) | Number of times the two populations' variant states match eactly (a) |  All variant states combinations between the two populations (b) |
| -- | -- | -- | -- |
| SNP | 81.1% | 94,701 | 116,828 |
| Indel | 71.6% | 9,420 | 13,163 |
  

Between Tdu_2886 and Tpr_2608
  - module load picard/2.19.1
  
    java -jar $HPC_PICARD_DIR/picard.jar GenotypeConcordance \
	
    CALL_VCF=Tpr_2608_filtered_var.vcf \
	
    OUTPUT=Tdu-2886_Tpr-2608_compare \
	
    TRUTH_VCF=Tdu_2886_filtered_var.vcf
  - Output:
    - Tdu-2886_Tpr-2608_compare.genotype_concordance_contingency_metrics
    - Tdu-2886_Tpr-2608_compare.genotype_concordance_detail_metrics
    - Tdu-2886_Tpr-2608_compare.genotype_concordance_summary_metrics
  - **Genotype concordance**:
    - **SNP: 0.402842**
    - **INDEL: 0.362677**

### 2.6 Conclusion

Since the genotype concordance between the two T.dubius populations is high, we combined reads of two Tdu populations for Trinity assembly

## 3. Trinity assembly
### 3.1 Tdu transcriptome assembly
#### 3.1.1 Read normalization
Reads from two Tdu populations were normalized and then combined for transcriptome assembly; in this case, the source of the reads was taken into account

Method: `insilico_read_normalization.pl` from Trinity; max_cov: 50; min_cov: 2

Tdu_2613 reads normalization:
  - script: `Trinity_normalization_Tdu_2613_1.0.sh`
  - input: `Tdu_2613_R1_crop_clean_cat.fastq`; `Tdu_2613_R2_crop_clean_cat.fastq`
  - output: `Tdu_2613_R1_crop_clean_cat.fastq.normalized_K25_maxC50_minC2_pctSD10000.fq` and `Tdu_2613_R2_crop_clean_cat.fastq.normalized_K25_maxC50_minC2_pctSD10000.fq`

Tdu_2886 reads normalization:
  - script: `Trinity_normalization_Tdu_2886_1.0.sh`
  - input: `Tdu_2886_R1_crop_clean_cat.fastq` and `Tdu_2886_R2_crop_clean_cat.fastq`
  - output: `Tdu_2886_R1_crop_clean_cat.fastq.normalized_K25_maxC50_minC2_pctSD10000.fq` and `Tdu_2886_R2_crop_clean_cat.fastq.normalized_K25_maxC50_minC2_pctSD10000.fq`

#### 3.1.2 combine normalized reads from two Tdu populations
Script `CatFiles_4.0.sh` was used; the output files are:
  - `Tdu_R1_clean_K25_maxC50_minC2_pctSD10000_concatenated.fq`
  - `Tdu_R2_clean_K25_maxC50_minC2_pctSD10000_concatenated.fq`

#### 3.1.3 Runing de novo Trinity assembly
Script `Trinity_Tdu_norm_concat_denovo_1.0.sh` was used; the output files are:
  - **`Tdu_trinity_norm_concat_denovo.Trinity.fasta`**
  - Basic statistics:
    - `TrinityStats.pl Tdu_trinity_norm_concat_denovo.Trinity.fasta > Tdu_trinity_norm_concat_denovo.Trinity.fasta.statistics.txt`
    - Total trinity 'genes':	126278
    - Total trinity transcripts:	302750
    - Percent GC: 38.74
    - Contig N50: 1583 (based on all transcripts)
    - Contig N50: 1347 (based on longest isoform per 'gene')

#### 3.1.4 Assembly evaluation -- BUSCO analysis (using all transcripts)
Description of this analysis is described [here](https://busco.ezlab.org/). Script `BUSCO_ALL_Tdu_norm_concat_denovo_1.0.sh` was used; the output results are:
  - **C:95.3%[S:29.2%,D:66.1%],F:3.4%,M:1.3%,n:1375**
    - 1311	Complete BUSCOs (C)
    - 402 Complete and single-copy BUSCOs (S)
	- 909 Complete and duplicated BUSCOs (D)
	- 47 Fragmented BUSCOs (F)
	- 17 Missing BUSCOs (M)
	- 1375 Total BUSCO groups searched

#### 3.1.5 Assembly evaluation -- Read representation
Description of this analysis can be found [here](https://github.com/trinityrnaseq/trinityrnaseq/wiki/RNA-Seq-Read-Representation-by-Trinity-Assembly). Script `ReadRepresent_Tdu_norm_concat_denovo_1.0.sh` was used; the output results are:
  - **96.78% overall alignment rate**
  - more info: align_stats.txt

#### 3.1.6 Assembly evaluation -- ExN50 analysis
[Here](https://github.com/trinityrnaseq/trinityrnaseq/wiki/Transcriptome-Contig-Nx-and-ExN50-stats) is the description of the analysis. Script `AbundanceEstimation_Tdu_trinity_norm_concat_denovo_1.0.sh` was used; results:
  - **E90N50: 1802**
  - **Tdu_norm_concat_denovo_ExN50.stats**
  - kallisto.isoform.TMM.EXPR.matrix
  - ExN50.stats
  - ExN50.stats.plot.pdf
  - ![ExN50](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Trinity_assembly/Images/Tdu_norm_concat_denovo_ExN50.stats.plot-1.png)

### 3.2 Tpr transcriptome assembly
#### 3.2.1 Read normalization
Script `Trinity_normalization_Tpr_crop_2.0.sh` was used.
  - input: `Tpr_2608_R1_crop_clean_cat.fastq` and `Tpr_2608_R2_crop_clean_cat.fastq`
  - output: `Tpr_2608_R1_crop_clean_cat.fastq.normalized_K25_maxC50_minC2_pctSD10000.fq` and `Tpr_2608_R2_crop_clean_cat.fastq.normalized_K25_maxC50_minC2_pctSD10000.fq`
  
#### 3.2.2 Runing de novo Trinity assembly
Script `Trinity_Tpr_crop_separately_norm_2.0.sh` was used. Outputs are:
  - **`Tpr_trinity_crop_separately_norm_1.Trinity.fasta`**
  - Basic statistics:
    - `TrinityStats.pl Tpr_trinity_crop_separately_norm_1.Trinity.fasta > Tpr_trinity_crop_separately_norm_1.Trinity.fasta.statistics.txt`
    - Total trinity 'genes': 99228
    - Total trinity transcripts: 239956
    - Percent GC: 38.98
    - Contig N50: 1481 (based on all transcripts)
    - Contig N50: 1389 (based on longest isoform per 'gene')

#### 3.2.3 Assembly evaluation -- BUSCO analysis (using all transcripts)
Description of this analysis is described [here](https://busco.ezlab.org/). Script `BUSCO_Tpr_crop_trinity_separatly_norm_1.0.sh` was used; results:
  - **C:92.5%[S:34.5%,D:58.0%],F:6.0%,M:1.5%,n:1375**
    - 1272 Complete BUSCOs (C)
    - 474 Complete and single-copy BUSCOs (S)
    - 798 Complete and duplicated BUSCOs (D)
    - 83 Fragmented BUSCOs (F)
    - 20 Missing BUSCOs (M)
    - 1375 Total BUSCO groups searched

#### 3.2.4 Assembly evaluation -- Read representation
Description of this analysis can be found [here](https://github.com/trinityrnaseq/trinityrnaseq/wiki/RNA-Seq-Read-Representation-by-Trinity-Assembly). Script `ReadRepresent_Tpr_crop_trinity_separately_norm_1.0.sh` was used; **96.80%** overall alignment rate

#### 3.2.5 Assembly evaluation -- ExN50 analysis
[Here](https://github.com/trinityrnaseq/trinityrnaseq/wiki/Transcriptome-Contig-Nx-and-ExN50-stats) is the description of the analysis. Script `AbundanceEstimation_Tpr_trinity_denovo_2.0.sh` was used; results:
  - **E90N50: 1663 bp**
  - ![Tpr ExN50](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Trinity_assembly/Images/Tpr_denovo_ExN50.stats.plot-1.png)

## 4. Comparing different Trinity assembly approaches
### 4.1 Tdu assembly
**The best assembly results have been shown in Step 3**. Different assembly methods have been tested, including in the presence of Tdu draft reference genome, and PacBio long reads. The table summrized the results:
![Tdu_diff_assembly](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Trinity_assembly/Images/Assembly_compare_Tdu-1.png)

### 4.2 Tpr assembly
**The best assembly results have been shown in Step 3**.
![Tpr_diff_assembly](https://github.com/GatorShan/Tragopogon-Inflorescence-RNA-seq-Analysis/blob/master/Trinity_assembly/Images/Assembly_compare_Tpr-1.png)

### 4.3 PacBio long reads have been well-represented by Trinity de novo assemblies
  - Tdu:
    - 74.6% of PacBio long reads are represented in Trinity assemblies
    - 175,986 out of 235,890 PacBio long reads are represented
  - Tpr:
    - 81.8% of PacBio long reads are represented in Trinity assemblies
    - 84,670 out of 103,460 PacBio long reads are represented
  - Method:
    - Blastn was used
    - Database: PacBio long reads from leaf transcriptome
    - Query: Trinity de novo assemblies
    - Parameter:
      - 85% identity; 
      - E-value: 1E-10;
      - At least 50% of the query sequence has to align against the PacBio long reads

## 5. Remove redundancy of Trinity de novo assembly
"A SuperTranscript is constructed by collapsing unique and common sequence regions among splicing isoforms into a single linear sequence." This function is provided in the Trinity toolkit. More information could be found [here](https://github.com/trinityrnaseq/trinityrnaseq/wiki/SuperTranscripts). [Lace](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-017-1284-1) is the software used in this step.

Inputs are de novo Trinity assemblies for Tdu and Tpr from step 3.
  - For Tdu: `Tdu_trinity_norm_concat_denovo.Trinity.fasta`
  - For Tpr: `Tpr_trinity_crop_separately_norm_1.Trinity.fasta`

Scripts used are listed below:
  - `SuperTranscript_Tdu_2.0.sh`
  - `SuperTranscript_Tpr_1.0.sh`

Output:
  - **`SuperTranscript_Tdu.fasta`**
  - `SuperTranscript_Tdu.gtf`
  - `SuperTranscript_Tdu.malign`
  - **`SuperTranscript_Tpr.fasta`**
  - `SuperTranscript_Tpr.gtf`
  - `SuperTranscript_Tpr.malign`

Statistics of the Supertranscripts were evaluated using `bbmap` and script `AverageLengthMinLength.py`.

Example:
```bash
module load bbmap/38.44
stats.sh in=SuperTranscript_Tdu.fasta > SuperTranscript_Tdu.fasta.statistics
```
```bash
module load python3
python AverageLengthMinLength.py SuperTranscript_Tdu.fasta >SuperTranscript_Tdu.fasta.statistics2
```

**Statistics of the SuperTranscripts**

| Species | Count | N50 | Mean length | Max contig length | Min contig length |
| -- | -- | -- | -- | -- | -- |
| Tdu | 126,278 | 1,904 bp | 921.8 bp | 15.517 Kb | 201 bp |
| Tpr | 99,228 | 1,954 bp | 981.7 bp | 24.325 kb | 201 bp |






