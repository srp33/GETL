suppressPackageStartupMessages(library(SCAN.UPC))

sampleID = commandArgs()[7]
inputFilePath = commandArgs()[8]
outputFilePath = commandArgs()[9]

platform = cleancdfname(read.celfile.header(inputFilePath, info = "full")$cdfName)
platform = sub("cdf", "", platform)
platform = sub("stv1", "st", platform)
platform = sub("stv2", "st", platform)

probeBrainArrayPackage = paste(platform, "hsensgprobe", sep="")

scanOutput = exprs(SCAN(inputFilePath, probeSummaryPackage = probeBrainArrayPackage))

scanRowsToRemove = grepl("AFFX", rownames(scanOutput))
scanOutput = scanOutput[which(!scanRowsToRemove),,drop=FALSE]

colnames(scanOutput) = sampleID
rownames(scanOutput) = gsub("_at", "", rownames(scanOutput))

write.table(scanOutput, outputFilePath, sep = '\t', quote = FALSE, row.names = TRUE, col.names = NA)
