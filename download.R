GSMID <- commandArgs()[7]
downloadDir <- commandArgs()[8]
outFilePath <- commandArgs()[9]

suppressPackageStartupMessages(library(GEOquery))
  
print(GSMID)
downloaded <- getGEOSuppFiles(GSMID, makeDirectory=FALSE, baseDir=downloadDir)
stop("got here")
#celIndex <- which(grepl("CEL\\.", rownames(downloaded), ignore.case=TRUE))
celIndex <- which(grepl("\\.CEL", rownames(downloaded), ignore.case=TRUE))

if (any(celIndex))
{
  downloadedFilePath <- rownames(downloaded)[min(celIndex)]
  success <- file.rename(downloadedFilePath, outFilePath)
}
