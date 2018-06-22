GSMID <- commandArgs()[7]
downloadDir <- commandArgs()[8]
outFilePath <- commandArgs()[9]

suppressPackageStartupMessages(library(GEOquery))
  
downloaded <- getGEOSuppFiles(GSMID, makeDirectory=FALSE, baseDir=downloadDir)
celIndex <- min(which(grepl("CEL\\.", rownames(downloaded), ignore.case=TRUE)))
downloadedFilePath <- rownames(downloaded)[celIndex]
success <- file.rename(downloadedFilePath, outFilePath)
