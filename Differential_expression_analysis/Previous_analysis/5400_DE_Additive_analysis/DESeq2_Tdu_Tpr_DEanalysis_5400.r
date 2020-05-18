library(tidyverse)
library(RColorBrewer)
library(DESeq2)
library(pheatmap)

setwd('/Users/shengchen/OneDrive/2nd_Chapter_TragFL_NewAnalysis/Output/5400_DE_Tdu_Tpr')

## Loading data
data <- read.table("DESeq2_count_matrix_Tdu_Tpr_5400.csv", sep=",",header = T,row.names=1)
meta <- read.csv("DESeq2_Tdu_Tpr_sample_annotation.tsv", sep = "\t", row.names="sample")
## first column is row names: row.names = 1

head(data)

meta

## Here showed read counts distribution of sample Tdu_1
ggplot(data) +
  geom_histogram(aes(x = Tdu_1), stat = "bin", bins = 200) +
  xlab("Raw expression counts") +
  ylab("Number of genes")

head(data[, 1:3])
## indicates Tdu_pullman data

mean_counts <- apply(data[, 1:3], 1, mean)
variance_counts <- apply(data[, 1:3], 1, var)
df <- data.frame(mean_counts, variance_counts)
ggplot(df) +
        geom_point(aes(x=mean_counts, y=variance_counts)) + 
        geom_line(aes(x=mean_counts, y=mean_counts, color="red")) +
        scale_y_log10() +
        scale_x_log10()

## match the metadata and counts data
all(colnames(data) %in% rownames(meta))

## Creat DESeq2Dataset object
dds <- DESeqDataSetFromMatrix(countData = data, colData = meta, design = ~ population)

## generate size factors
## By assigning the results back to the dds object we are filling in the slots of the DESeqDataSet object with the appropriate info
dds <- estimateSizeFactors(dds)

sizeFactors(dds)

head(counts(dds, normalized=TRUE))

## Transform normalized counts using the rlog transformation
## The rlog transformation of the normalized counts is only necessary for these visualization methods during this quality assessment
## The blind=TRUE argument results in a transformation unbiased to sample condition information
rld <- rlog(dds, blind=TRUE)

## Plot PCA
plotPCA(rld, intgroup="population") + geom_text(aes(label=name),vjust=2)

## Hierarchical clustering
## Extract the rlog matrix from the object
rld_mat <- assay(rld)
## Compute pairwise correlation values
rld_cor <- cor(rld_mat)
## Plot heatmap
pheatmap(rld_cor)

## Creat DESeq object
## its called dds_new, as design are changed from population to species
dds_new <- DESeqDataSetFromMatrix(countData = data, colData = meta, design = ~ species)

## Run DE analysis
dds_new <- DESeq(dds_new)

plotDispEsts(dds_new)

## Define contrasts, extract results table, and shrink the log2 fold changes
## Tpr (the second element) is the baseline;
## cutoff of adjusted p-value (FDR) is set as 0.05
contrast <- c("species", "Tdu", "Tpr")
res_table_unshrunken <- results(dds_new, contrast=contrast, alpha = 0.05)
res_table <- lfcShrink(dds_new, contrast=contrast, res=res_table_unshrunken)

plotMA(res_table, ylim=c(-2,2))

summary(res_table)

## count the number of NA in column padj
sum(is.na(res_table$padj))

sig <- subset(res_table, padj < 0.05)
write.table(sig, "DESeq2_DE_Tdu_Tpr_5400.txt", sep="\t", quote=F, row.names = TRUE)

## DE genes with higher expression in Tdu
## Tpr is the baseline; log2FoldChange > 0 indicates higher expression in Tdu
sig_Tdu_higher <- subset(res_table, padj < 0.05 & log2FoldChange > 0)
write.table(sig_Tdu_higher, "DESeq2_DE_higher_Tdu_5400.txt", sep="\t", quote=F, row.names = TRUE)

## DE genes with higher expression in Tpr
## Tpr is the baseline; log2FoldChange < 0 indicates higher expression in Tpr
sig_Tpr_higher <- subset(res_table, padj < 0.05 & log2FoldChange < 0)
write.table(sig_Tpr_higher, "DESeq2_DE_higher_Tpr_5400.txt", sep="\t", quote=F, row.names = TRUE)

## non-DE genes
none_sig <- subset(res_table, padj >= 0.05)
write.table(none_sig, "DESeq2_none-DE_Tdu_Tpr_5400.txt", sep="\t", quote=F, row.names = TRUE)


