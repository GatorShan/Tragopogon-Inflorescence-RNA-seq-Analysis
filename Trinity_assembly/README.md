# Trinity assembly of T.dubius(Tdu) and T.pratensis(Tpr) transcriptome
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
    
  

