# Find orthologs using OrthoFinder
## Description
Single-copy orthogroups were considered as orthologs, and will be used for downstream gene expression analysis
### Input files
The following two amino acid FASTA files were used as input files for orthofinder analysis
`Tdu_SuperTranscript_transdecoder.fasta`
`Tpr_SuperTranscript_transdecoder.fasta`
### Script
`OrthoFinder_1.0.sh`
- place all FASTA files all in a single directory
- -f: fasta_file_directory
- -t: number_of_threads
- -S: Sequence search program
- logfile: OrthoFinder_1.0_41636356.out
- results are in folder `Results_Sep22_1`

### Output
| Overall (T. dubius + T. pratensis) | Number |
| --- | --- |
| Number of protein sequences predicted by TransDecoder | 86,325 |
| Number of protein sequences in orthogroups | 53,911 (62.5%) |
| Number of orthogroups with both species present | 22,268 |
| Number of single-copy orthogroups (1 protein sequence/species) | 18,341 |
| Mean orthogroup size | 2.4 |

| | T. dubius | T. pratensis |
| --- | --- | --- |
| Number of SuperTranscripts | 126,278 | 99,228 |
| Number of protein sequences predicted by TransDecoder | 45,039 | 41,286 |
| Number of protein sequences in orthogroups | 27,203 (60.4%) | 26,708 (64.7%) |

- `Orthogroups.tsv` contains all orthogroups and its content;

  - Header: Orthogroup; Tdu_SuperTranscript_transdecoder; Tpr_SuperTranscript_transdecoder
- `Orthogroups_SingleCopyOrthologues.txt` contains the ID of all single-copy orthogroups

Python script `ExtracFiles.py` was used to extract the contents of those single-copy orthogroups; a new file is generated **`SingleCopyOrthogroups.tsv`**.
- **18,341 single-copy orthogroups** were found
- Header: Orthogroup; Tdu_SuperTranscript_transdecoder; Tpr_SuperTranscript_transdecoder
- `OG0003939       TRINITY_DN10011_c0_g1.p1 GENE.TRINITY_DN10011_c0_g1~~TRINITY_DN10011_c0_g1.p1  ORF type_complete len_200 _+__score=42.84 TRINITY_DN10011_c0_g1_173-772_+_       TRINITY_DN11857_c2_g6.p1 GENE.TRINITY_DN11857_c2_g6~~TRINITY_DN11857_c2_g6.p1  ORF type_complete len_200 _+__score=44.52 TRINITY_DN11857_c2_g6_271-870_+_`

### Extracting SuperTranscripts from orthogroups
`Parser_V1.0.py` was used to reformat file `SingleCopyOrthogroups.tsv`, and generated new file **`SingleCopyOrthogroups_parser.tsv`**. Therefore, each line contains the SuperTranscripts from Tdu and Tpr, from which the peptide sequences derived.
- `SingleCopyOrthogroups_parser.tsv`
  - **18,341 orthogroups**
  - `Tpr_TRINITY_DN11857_c2_g6	Tdu_TRINITY_DN10011_c0_g1`
  - This file is not unique and in a one to one format; there might have redundancies since one SuperTranscirpt might resulted in multiple peptides; one Tdu_SuperTranscript might corresponde to multiple Tpr_SuperTranscripts
