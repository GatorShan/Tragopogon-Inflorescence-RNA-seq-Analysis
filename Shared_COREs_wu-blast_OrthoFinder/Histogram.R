# direct to the "XXX" directory
setwd("/Users/shengchen/OneDrive/2nd_Chapter_TragFL_NewAnalysis/Histogram")
getwd()

# list the content in current directory
list.files(path=".")

# import my data to mydf; tab deliminated file
mydf <- read.csv('Shared_reciprocated_blast_hits_SingleCopyOrthogroups_parser_FullDescription.txt', sep = '\t', header = F)

# show the first 10 lines of mydf
head(mydf, n=10)

hist(mydf$V2)
hist(mydf$V4, 
     main="Histogram for Subject Length", 
     xlab="Subject length", 
     border="blue", 
     col="green",
     xlim=c(0,10000),
     las=1, 
     breaks=20)



