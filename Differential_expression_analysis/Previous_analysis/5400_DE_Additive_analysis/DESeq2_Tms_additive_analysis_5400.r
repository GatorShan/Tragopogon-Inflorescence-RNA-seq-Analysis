library(tidyverse)
library(RColorBrewer)
library(DESeq2)
library(pheatmap)

setwd('/Users/shengchen/OneDrive/2nd_Chapter_TragFL_NewAnalysis/Output/5400_Additive_expression_Tms')

## Loading data
data <- read.table("DESeq2_count_matrix_Tms_additive_5400.csv", sep=",",header = T,row.names=1)
meta <- read.csv("DESeq2_Tms_additive_sample_annotation.tsv", sep = "\t", row.names="sample")
## first column is row names: row.names = 1

head(data)

## match the metadata and counts data
all(colnames(data) %in% rownames(meta))

## Creat DESeq2Dataset object
dds <- DESeqDataSetFromMatrix(countData = data, colData = meta, design = ~ species)
## generate size factors
## By assigning the results back to the dds object we are filling in the slots of the DESeqDataSet object with the appropriate info
dds <- estimateSizeFactors(dds)

head(counts(dds, normalized=TRUE))

## write out the matrix of normalized reads count
Normalized_reads_counts = counts(dds, normalized=TRUE)
write.table(Normalized_reads_counts, file="normalized_counts.txt", sep="\t", quote=F, col.names=NA)

## Transform normalized counts using the rlog transformation
## The rlog transformation of the normalized counts is only necessary for these visualization methods during this quality assessment
## The blind=TRUE argument results in a transformation unbiased to sample condition information
rld <- rlog(dds, blind=TRUE)

## Plot PCA
plotPCA(rld, intgroup="species") + geom_text(aes(label=name),vjust=2)

## Hierarchical clustering
## Extract the rlog matrix from the object
rld_mat <- assay(rld)
## Compute pairwise correlation values
rld_cor <- cor(rld_mat)
## Plot heatmap
pheatmap(rld_cor)

## log2 fold change shrinkage will NOT be performed
## But this will generate the proper resultsNames(dds) results, which will be used for comparing MPV to polyploid
## No shrinkage won't affect the number of DE genes identified

dds <- DESeq(dds, betaPrior = TRUE)

plotDispEsts(dds)

resultsNames(dds)

## Contrast MPV and polyploid; following the method from https://support.bioconductor.org/p/69104/
## cutoff of adjusted p-value (FDR) is set as 0.05
## I think MVP is the baseline for logFC
res_additive_analysis <- results(dds, contrast=list("speciesTms", c("speciesTdu","speciesTpr")), listValues=c(1, -1/2), alpha = 0.05)

plotMA(res_additive_analysis, ylim=c(-2,2))

summary(res_additive_analysis)

## Write out output files for additive analysis
non_additive_loci <- subset(res_additive_analysis, padj < 0.05)
write.table(non_additive_loci, "DESeq2_Tms_nonAdditive_loci_5400.txt", sep="\t", quote=F, row.names = TRUE)

additive_loci <- subset(res_additive_analysis, padj >= 0.05)
write.table(additive_loci, "DESeq2_Tms_Additive_loci_5400.txt", sep="\t", quote=F, row.names = TRUE)

## Diplid DE analysis between Tdu and Tpr
## Tpr is the baseline
res_diploid_DE <- results(dds, contrast=c("species", "Tdu", "Tpr"), alpha=0.05)

plotMA(res_diploid_DE, ylim=c(-2,2))

summary(res_diploid_DE)

## Write out DE and non_DE loci
DE_loci <- subset(res_diploid_DE, padj < 0.05)
write.table(DE_loci, "DESeq2_DE_loci_5400.txt", sep="\t", quote=F, row.names = TRUE)

non_DE_loci <- subset(res_diploid_DE, padj >= 0.05)
write.table(non_DE_loci, "DESeq2_noneDE_loci_5400.txt", sep="\t", quote=F, row.names = TRUE)


