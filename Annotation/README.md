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

### 2.3 Running sequence analysis
**tmHMM** to predict transmembrane regions
```bash
tmhmm --short SuperTranscript_Tdu.fasta.transdecoder.pep > ../tmhmm/Tdu_tmhmm.out
```


**Capturing BLAST Homologies**

Script `Trinotate_Blast_Tdu_3.0.sh` was used (takes 21 h; 16 CPU; 2 Gb mem).
  - Search Trinity transcripts
  - Search Transdecoder-predicted proteins






