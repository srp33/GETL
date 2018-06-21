inFilePath <- commandArgs()[7]
dataSetID <- commandArgs()[8]

library("doppelgangR")
library(readr)

data <- read_tsv(inFilePath)
data <- as.matrix(data)
rownames(data) <- data[,1]
data <- data[,-1]
data <- t(data)

dataRows <- rownames(data)
data <- apply(data,2,as.numeric)
rownames(data) <- dataRows

exprData <- ExpressionSet(assayData = data)

results <- doppelgangR(exprData, phenoFinder.args = NULL, within.datasets.only = T)

print(dataSetID)
results
summary(results)

