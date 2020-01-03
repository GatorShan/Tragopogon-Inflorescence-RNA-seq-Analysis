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

  - Output: we care about the most is `SuperTranscript_Tdu.fasta.transdecoder.pep`


