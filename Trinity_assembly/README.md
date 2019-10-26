# Trinity assembly of T.dubius (Tdu) and T.pratensis (Tpr) transcriptome
## Description
For T. dubius, there are two populations (each with 3 biolgoical replicates); as the genotype concordance between the two populations are high (see analysis below), reads from these two populations were combined to generated a sigle transcriptome assembly.

  - 2613, Pullman
  - 2886, Moscow

For T. pratensis, there is only one population (3 biological replicates)
  - 2608, Moscow

## Genotype concordance analysis between two Tdu populations
### Mapping Tdu and Tpr reads (trimmed) to Tdu ref genome
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

### Sort and mark duplicate of bam files
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

### Generate VCF files
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

### Filter VCF files
By default, records are output even if they have very low probability of variation, in expectation that the VCF will be filtered

The following bash script was used:
  - `module load vcflib/20150313`
    
    `vcffilter -f "QUAL > 20" Tdu_2613_var.vcf > Tdu_2613_filtered_var.vcf`
  - `vcffilter -f "QUAL > 20" Tdu_2886_var.vcf > Tdu_2886_filtered_var.vcf`
  - `vcffilter -f "QUAL > 20" Tpr_2608_var.vcf > Tpr_2608_filtered_var.vcf`

### Calculate genotype concordance
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
  

