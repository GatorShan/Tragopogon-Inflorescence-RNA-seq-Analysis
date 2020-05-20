# Transcriptome Functional Annotation and Analysis
## 1. Description
[Trinotate](https://github.com/Trinotate/Trinotate.github.io/wiki) was used for functional annotation. GOseq was used for GO enrichment analysis.

## 2. Functional annotation by Trinotate
The following procedures use T. dubius (Tdu) as example; the analysis for Tpr is the same as Tdu.
### 2.1 Identification of likely protein-coding regions in transcripts
[Transdecoder](https://github.com/TransDecoder/TransDecoder/wiki) was used in this step.

**Step 1** Extract the long open reading frames (at least 100 amino acids long, by default)
  ```bash
  module load transdecoder/5.5.0
  
    TransDecoder.LongOrfs \ 
    -t SuperTranscript_Tdu.fasta \
    -O . &
  ```
  
  - `-O` indicates the output directory
  - Output: `longest_orfs.pep`

**Step 2** Predict the likely coding regions
```bash
TransDecoder.Predict \
  -t ../../SuperTranscript/SuperTranscript_Tdu.fasta \
  -O .
```

  - Output: we care about the most is **`SuperTranscript_Tdu.fasta.transdecoder.pep`**

### 2.2 Obtain protein database files
This step will download several data resources including the latest version of swissprot, pfam, and other companion resources.
```
module load trinotate/3.0.1
$HPC_TRINOTATE_DIR/admin/Build_Trinotate_Boilerplate_SQLite_db.pl  Trinotate &
```
  - Output: `Trinotate.sqlite`, `uniprot_sprot.pep`, and `Pfam-A.hmm.gz`

The release hisotry of [UniProt](ftp://ftp.uniprot.org/pub/databases/uniprot/previous_releases) and [Pfam](ftp://ftp.ebi.ac.uk/pub/databases/Pfam/releases/).

### 2.3 Running sequence analysis
**Running tmHMM to predict transmembrane regions**
```bash
tmhmm --short SuperTranscript_Tdu.fasta.transdecoder.pep > ../tmhmm/Tdu_tmhmm.out
```

**Capturing BLAST Homologies**
  - Script `Trinotate_Blast_Tdu_3.0.sh` was used (takes 21 h; 16 CPU; 2 Gb mem).
    - Database `uniprot_sprot.pep`
    - Search Trinity transcripts
    - Search Transdecoder-predicted proteins

**Running signalP to predict signal peptides**
  - Script `Trinotate_SignalP_Tdu_1.0.sh` was used (takes 1.5 h; 1 CPU; 3 Gb mem).

**Running HMMER to identify protein domains**
  - Script `Trinotate_HMMER_Tdu_1.0.sh` was used (takes 9 h; 12 CPU).
    - Database `Pfam-A.hmm`

**Running RNAMMER to identify rRNA transcripts**
  - Script `Trinotate_RNAmmer_Tdu_1.0.sh` was used (takes 0.5 h; require 10 CPU).

### 2.4 Loading generated results into a Trinotate SQLite Database
Generate gene_trans_map file using script `ExtractHeader.py`.

```bash
module load trinotate/3.0.1

## Initial import of transcirptome and protein data
Trinotate Trinotate.sqlite init \
  --gene_trans_map SuperTranscript_Tdu.gene_trans_map \
  --transcript_fasta SuperTranscript_Tdu.fasta \
  --transdecoder_pep SuperTranscript_Tdu.fasta.transdecoder.pep

## Loading BLAST homologies
Trinotate Trinotate.sqlite LOAD_swissprot_blastp ../Blast/Tdu_blastp.outfmt6
Trinotate Trinotate.sqlite LOAD_swissprot_blastx ../Blast/Tdu_blastx.outfmt6

## Load Pfam domain entries, transmembrane domains, signal peptide predictions
Trinotate Trinotate.sqlite LOAD_pfam ../HMMER/Tdu_TrinotatePFAM.out
Trinotate Trinotate.sqlite LOAD_tmhmm ../tmhmm/Tdu_tmhmm.out
Trinotate Trinotate.sqlite LOAD_signalp ../SignalP/SuperTranscript_Tdu.fasta.transdecoder_summary.signalp5

## Output an Annotation Report
## default threshold: 1e-5
Trinotate Trinotate.sqlite report > Tdu_trinotate_annotation_report.xls
```


