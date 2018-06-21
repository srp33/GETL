#install.packages("stringr", repos="http://cran.cnr.berkeley.edu/")
#install.packages("dplyr", repos="http://cran.cnr.berkeley.edu/")
#install.packages("readr", repos="http://cran.cnr.berkeley.edu/")
install.packages("doParallel", repos="http://cran.cnr.berkeley.edu/")

source("http://bioconductor.org/biocLite.R")
#biocLite("SCAN.UPC")
biocLite("pd.hg.u133.plus.2")
stop()

library(SCAN.UPC)

#http://brainarray.mbni.med.umich.edu/Brainarray/Database/CustomCDF/20.0.0/ensg.asp

tmpDir = tempdir()

install <- function(gsm, downloadFilePrefix)
{
  tmpFile <- paste(tmpDir, "/", gsm, ".CEL.gz", sep="")
  download.file(paste("https://www.ncbi.nlm.nih.gov/geo/download/?acc=", gsm, "&format=file&file=", downloadFilePrefix, "%2ECEL%2Egz", sep=""), tmpFile)
  InstallBrainArrayPackage(tmpFile, "20.0.0", "hs", "ensg")
}

#U133 Plus2
install("GSM494556", "GSM494556")

#U133A
install("GSM260728", "GSM260728")

#U133A2
install("GSM506567", "GSM506567")

#U133B
install("GSM97119", "GSM97119")

#Exon ST 1.0
install("GSM1134601", "GSM1134601%5FGBX%2EDISC%2EPCA538")


